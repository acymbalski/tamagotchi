"""JSON-backed annotation store for .tamstream files.

Annotations are stored in a sidecar file (<stream>.annotations.json) alongside
the .tamstream binary. The binary is never modified.
"""

import json
import os
from datetime import datetime


class AnnotationStore:
    """Persistent annotation storage backed by a sidecar JSON file."""

    def __init__(self, stream_filepath):
        """Derives sidecar path from stream path. Loads if exists."""
        self._stream_filepath = stream_filepath
        self._sidecar = stream_filepath + ".annotations.json"
        self._annotations = []
        self._version = 1
        self.reload()

    def add(self, tick, text, tags=None):
        """Add annotation at tick. Returns the annotation dict. Auto-saves."""
        annotation = {
            "tick": tick,
            "text": text,
            "created": datetime.now().isoformat(timespec="seconds"),
            "tags": tags or [],
        }
        self._annotations.append(annotation)
        self._annotations.sort(key=lambda a: a["tick"])
        self.save()
        return annotation

    def remove(self, tick, text=None):
        """Remove annotation(s) at tick. If text given, only remove that one.
        Returns True if anything was removed. Auto-saves."""
        before = len(self._annotations)
        if text is not None:
            self._annotations = [
                a for a in self._annotations
                if not (a["tick"] == tick and a["text"] == text)
            ]
        else:
            self._annotations = [
                a for a in self._annotations if a["tick"] != tick
            ]
        removed = len(self._annotations) < before
        if removed:
            self.save()
        return removed

    def update(self, tick, old_text, new_text):
        """Update annotation text. Auto-saves."""
        for a in self._annotations:
            if a["tick"] == tick and a["text"] == old_text:
                a["text"] = new_text
                self.save()
                return True
        return False

    def get_at_tick(self, tick):
        """All annotations at exactly this tick."""
        return [a for a in self._annotations if a["tick"] == tick]

    def get_in_range(self, start_tick, end_tick):
        """All annotations in tick range (inclusive)."""
        return [a for a in self._annotations if start_tick <= a["tick"] <= end_tick]

    def all(self):
        """All annotations sorted by tick."""
        return list(self._annotations)

    @property
    def sidecar_path(self):
        """Path to the JSON file."""
        return self._sidecar

    def save(self):
        """Write to disk. Called automatically by add/remove/update."""
        data = {
            "version": self._version,
            "stream_file": os.path.basename(self._stream_filepath),
            "annotations": self._annotations,
        }
        with open(self._sidecar, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2, sort_keys=True)

    def reload(self):
        """Re-read from disk (for external edits)."""
        if os.path.exists(self._sidecar):
            with open(self._sidecar, "r", encoding="utf-8") as f:
                data = json.load(f)
            self._version = data.get("version", 1)
            self._annotations = data.get("annotations", [])
        else:
            self._annotations = []
