#!/usr/bin/env python3
"""Python wrapper for driving the headless tamagotchi_pc.exe simulator."""

import subprocess
import threading
import queue
import time
import os
import sys
import re

DEFAULT_EXE = os.path.join(os.path.dirname(__file__), "..", "pc", "build", "tamagotchi_pc.exe")


class HeadlessRunner:
    """Manages a headless tamagotchi_pc.exe subprocess."""

    def __init__(self, exe_path=None, speed="turbo", babysitter="PROACTIVE",
                 stream=True, duration=None, load_state=None, save_state=None):
        self.exe_path = exe_path or DEFAULT_EXE
        self.speed = speed
        self.babysitter = babysitter
        self.stream = stream
        self.duration = duration
        self.load_state = load_state
        self.save_state = save_state

        self._proc = None
        self._output_queue = queue.Queue()
        self._reader_thread = None
        self._stream_file = None
        self._last_status = None

    def start(self):
        """Launch the headless simulator."""
        args = [self.exe_path, "--headless", "--speed", self.speed,
                "--babysitter", self.babysitter]
        if self.stream:
            args.append("--stream")
        if self.duration:
            args.extend(["--duration", str(self.duration)])
        if self.load_state:
            args.extend(["--load-state", self.load_state])
        if self.save_state:
            args.extend(["--save", self.save_state])

        self._proc = subprocess.Popen(
            args, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True, bufsize=1
        )

        # Reader thread to avoid blocking on stdout
        self._reader_thread = threading.Thread(target=self._read_output, daemon=True)
        self._reader_thread.start()

        # Wait for [ready]
        self._wait_for_line("[ready]", timeout=10)

    def _read_output(self):
        """Background thread reading stdout lines."""
        try:
            for line in self._proc.stdout:
                line = line.rstrip("\n\r")
                self._output_queue.put(line)

                # Parse known lines
                if line.startswith("[stream] started "):
                    self._stream_file = line.split(" ", 2)[2]
                elif line.startswith("[status]"):
                    self._last_status = self._parse_status(line)
        except Exception:
            pass

    def _wait_for_line(self, prefix, timeout=30):
        """Block until a line starting with prefix appears."""
        deadline = time.time() + timeout
        while time.time() < deadline:
            try:
                line = self._output_queue.get(timeout=0.1)
                if line.startswith(prefix):
                    return line
            except queue.Empty:
                continue
        raise TimeoutError(f"Timed out waiting for '{prefix}'")

    def _parse_status(self, line):
        """Parse [status] tick=N hunger=H ... into a dict."""
        result = {}
        for part in line.split()[1:]:  # skip "[status]"
            if "=" in part:
                k, v = part.split("=", 1)
                try:
                    result[k] = int(v)
                except ValueError:
                    result[k] = v
        return result

    def send_command(self, cmd):
        """Send a command to the simulator's stdin."""
        if self._proc and self._proc.stdin:
            self._proc.stdin.write(cmd + "\n")
            self._proc.stdin.flush()

    def get_status(self):
        """Send STATUS command and return parsed dict."""
        self.send_command("STATUS")
        line = self._wait_for_line("[status]", timeout=5)
        return self._parse_status(line)

    def annotate(self, text):
        """Add an annotation to the stream."""
        self.send_command(f"ANNOTATE {text}")

    def press(self, button):
        """Press a button (LEFT, MIDDLE, RIGHT)."""
        self.send_command(f"PRESS {button}")

    def release(self, button):
        """Release a button."""
        self.send_command(f"RELEASE {button}")

    def snapshot(self):
        """Take a snapshot."""
        self.send_command("SNAPSHOT")

    def save(self, path):
        """Save state to a file."""
        self.send_command(f"SAVE {path}")

    def load(self, path):
        """Load state from a file."""
        self.send_command(f"LOAD {path}")

    def breakpoint(self, msg=""):
        """Pause sim and launch interactive GUI. Not yet implemented."""
        print(f"[breakpoint] not yet implemented: {msg}")
        return None

    def wait_emu_seconds(self, n):
        """Wait for approximately n emulated seconds (based on status lines)."""
        status = self.get_status()
        start_tick = status.get("tick", 0)
        target_tick = start_tick + n * 32768

        while True:
            try:
                line = self._output_queue.get(timeout=1)
                if line.startswith("[status]"):
                    s = self._parse_status(line)
                    self._last_status = s
                    if s.get("tick", 0) >= target_tick:
                        return s
                elif line.startswith("[exit]"):
                    return self._last_status
            except queue.Empty:
                if self._proc.poll() is not None:
                    return self._last_status

    def stop(self):
        """Send QUIT and wait for process to exit."""
        if self._proc:
            try:
                self.send_command("QUIT")
                self._proc.wait(timeout=10)
            except Exception:
                self._proc.kill()
            self._proc = None

    @property
    def stream_file(self):
        return self._stream_file

    @property
    def last_status(self):
        return self._last_status

    @property
    def running(self):
        return self._proc is not None and self._proc.poll() is None

    def drain_output(self):
        """Return all queued output lines."""
        lines = []
        while True:
            try:
                lines.append(self._output_queue.get_nowait())
            except queue.Empty:
                break
        return lines

    def __enter__(self):
        self.start()
        return self

    def __exit__(self, *args):
        self.stop()


if __name__ == "__main__":
    # Quick self-test: run headless for 5 emu-seconds
    print("Starting headless runner test...")
    runner = HeadlessRunner(duration=5, stream=True, speed="turbo")
    runner.start()
    print(f"Stream file: {runner.stream_file}")

    # Wait for it to finish
    while runner.running:
        time.sleep(0.5)
        lines = runner.drain_output()
        for l in lines:
            if "[exit]" in l:
                print(l)

    runner.stop()
    print("Done.")
