#!/usr/bin/env python3
"""Timeline viewer for .tamstream files with scrubber, stats, and LCD display."""

import sys
import os

sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from stream_reader import TamStream, REC_ANNOTATION, REC_BUTTON_EVENT, REC_TICK_MARKER

from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
                             QLabel, QSlider, QPushButton, QScrollArea, QFrame, QMessageBox)
from PyQt6.QtGui import QImage, QPixmap, QPainter, QColor, QPen
from PyQt6.QtCore import Qt, QTimer

TICK_FREQUENCY = 32768


class LcdWidget(QWidget):
    """Renders LCD frame data as a pixel grid."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.frame_data = None
        self.setFixedSize(256, 128)

    def set_frame(self, data):
        self.frame_data = data
        self.update()

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.fillRect(self.rect(), QColor(200, 210, 200))

        if self.frame_data is None or all(b == 0 for b in self.frame_data):
            painter.setPen(QColor(100, 100, 100))
            painter.drawText(self.rect(), Qt.AlignmentFlag.AlignCenter, "No LCD data")
            painter.end()
            return

        # Render 32x16 pixel grid from frame data
        # Frame data layout: 50 bytes, representing two 0x28-nibble display segments
        pixel_w = self.width() // 32
        pixel_h = self.height() // 16

        for y in range(16):
            for x in range(32):
                byte_idx = (y * 32 + x) // 8
                bit_idx = 7 - (x % 8)
                if byte_idx < len(self.frame_data):
                    on = (self.frame_data[byte_idx] >> bit_idx) & 1
                else:
                    on = 0
                color = QColor(0, 0, 140) if on else QColor(200, 210, 200)
                painter.fillRect(x * pixel_w, y * pixel_h, pixel_w - 1, pixel_h - 1, color)

        painter.end()


class TimelineWidget(QWidget):
    """Custom widget showing annotation and button event markers on a timeline."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setFixedHeight(30)
        self.min_tick = 0
        self.max_tick = 1
        self.markers = []  # (tick, color, label)
        self.current_tick = 0

    def set_range(self, min_tick, max_tick):
        self.min_tick = min_tick
        self.max_tick = max(max_tick, min_tick + 1)
        self.update()

    def set_markers(self, markers):
        self.markers = markers
        self.update()

    def set_current_tick(self, tick):
        self.current_tick = tick
        self.update()

    def paintEvent(self, event):
        painter = QPainter(self)
        w = self.width()
        h = self.height()

        # Background
        painter.fillRect(0, 0, w, h, QColor(40, 40, 40))

        # Markers
        span = self.max_tick - self.min_tick
        for tick, color, label in self.markers:
            x = int((tick - self.min_tick) / span * w)
            painter.setPen(QPen(color, 2))
            painter.drawLine(x, 0, x, h)

        # Current position
        cx = int((self.current_tick - self.min_tick) / span * w)
        painter.setPen(QPen(QColor(255, 255, 0), 2))
        painter.drawLine(cx, 0, cx, h)

        painter.end()


class StreamViewer(QMainWindow):
    def __init__(self, filepath):
        super().__init__()
        self.setWindowTitle(f"Stream Viewer - {os.path.basename(filepath)}")
        self.resize(800, 600)

        self.stream = TamStream(filepath)
        self.min_tick, self.max_tick = self.stream.tick_range
        if self.min_tick is None:
            self.min_tick = 0
            self.max_tick = 0
        self.current_tick = self.min_tick

        # Pre-load annotation and button markers
        self.annotation_markers = []
        self.button_markers = []
        self._load_markers()

        self._init_ui()
        self._update_display()

    def _load_markers(self):
        for rec_type, tick, data in self.stream.records():
            if rec_type == REC_ANNOTATION:
                self.annotation_markers.append((tick, QColor(255, 100, 100), data.get("text", "")))
            elif rec_type == REC_BUTTON_EVENT:
                self.button_markers.append((tick, QColor(100, 200, 100), "btn"))

    def _init_ui(self):
        central = QWidget()
        self.setCentralWidget(central)
        main_layout = QHBoxLayout(central)

        # Left panel: stats
        left = QVBoxLayout()
        self.stats_frame = QFrame()
        self.stats_frame.setFrameShape(QFrame.Shape.StyledPanel)
        self.stats_layout = QVBoxLayout(self.stats_frame)

        self.tick_label = QLabel("Tick: 0")
        self.tick_label.setStyleSheet("font-weight: bold;")
        self.stats_layout.addWidget(self.tick_label)

        self.time_label = QLabel("Time: 0.0s")
        self.stats_layout.addWidget(self.time_label)

        self.stats_labels = {}
        stat_names = ["hunger", "happy", "discipline", "weight", "age", "sick",
                      "sleeping", "poop", "attention", "lifecycle", "character"]
        for name in stat_names:
            lbl = QLabel(f"{name}: --")
            self.stats_layout.addWidget(lbl)
            self.stats_labels[name] = lbl

        self.stats_layout.addStretch()

        # Launch sim button
        self.launch_btn = QPushButton("Launch Sim Here")
        self.launch_btn.clicked.connect(self._launch_sim)
        self.stats_layout.addWidget(self.launch_btn)

        scroll = QScrollArea()
        scroll.setWidget(self.stats_frame)
        scroll.setWidgetResizable(True)
        scroll.setFixedWidth(200)
        left.addWidget(scroll)

        main_layout.addLayout(left)

        # Center: LCD + timeline
        center = QVBoxLayout()

        self.lcd_widget = LcdWidget()
        center.addWidget(self.lcd_widget, alignment=Qt.AlignmentFlag.AlignCenter)

        center.addStretch()

        # Timeline markers
        self.timeline_widget = TimelineWidget()
        all_markers = self.annotation_markers + self.button_markers
        self.timeline_widget.set_range(self.min_tick, self.max_tick)
        self.timeline_widget.set_markers(all_markers)
        center.addWidget(self.timeline_widget)

        # Slider
        self.slider = QSlider(Qt.Orientation.Horizontal)
        self.slider.setMinimum(0)
        # Use tick markers as snap points for coarse granularity
        self._tick_positions = [self.min_tick]
        for rec_type, tick, data in self.stream.records():
            if rec_type == REC_TICK_MARKER:
                self._tick_positions.append(tick)
        if self.max_tick not in self._tick_positions:
            self._tick_positions.append(self.max_tick)
        self._tick_positions.sort()

        self.slider.setMaximum(max(len(self._tick_positions) - 1, 0))
        self.slider.valueChanged.connect(self._on_slider_changed)
        center.addWidget(self.slider)

        main_layout.addLayout(center, stretch=1)

    def _on_slider_changed(self, index):
        if 0 <= index < len(self._tick_positions):
            self.current_tick = self._tick_positions[index]
            self._update_display()

    def _update_display(self):
        self.tick_label.setText(f"Tick: {self.current_tick:,}")
        emu_time = (self.current_tick - self.min_tick) / TICK_FREQUENCY
        self.time_label.setText(f"Time: {emu_time:.1f}s")

        self.timeline_widget.set_current_tick(self.current_tick)

        # Update stats
        try:
            stats = self.stream.stats_at_tick(self.current_tick)
            for name, lbl in self.stats_labels.items():
                val = stats.get(name, "--")
                lbl.setText(f"{name}: {val}")
        except Exception as e:
            for lbl in self.stats_labels.values():
                lbl.setText(f"Error: {e}")

        # Update LCD
        frame = self.stream.nearest_lcd_frame(self.current_tick)
        if frame:
            self.lcd_widget.set_frame(frame[1])
        else:
            self.lcd_widget.set_frame(None)

    def _launch_sim(self):
        QMessageBox.information(self, "Not Yet Implemented",
                                "Launch Sim Here requires savestate binary layout knowledge.\n"
                                "This feature will be implemented in a future ticket.")


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <tamstream_file>")
        sys.exit(1)

    filepath = sys.argv[1]
    if not os.path.exists(filepath):
        print(f"Error: File not found: {filepath}")
        sys.exit(1)

    app = QApplication(sys.argv)
    viewer = StreamViewer(filepath)
    viewer.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
