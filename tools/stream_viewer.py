#!/usr/bin/env python3
"""Timeline viewer for .tamstream files with scrubber, stats, hex grid, and LCD display."""

import sys
import os
import bisect

sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from stream_reader import (
    TamStream, CachedStateTracker,
    REC_ANNOTATION, REC_BUTTON_EVENT, REC_TICK_MARKER,
    BUTTON_NAMES, BUTTON_STATES,
)
from annotation_store import AnnotationStore
import memory_config

from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QLabel, QSlider, QPushButton, QScrollArea, QFrame, QMessageBox,
    QLineEdit, QSplitter, QToolTip, QMenu, QProgressDialog,
)
from PyQt6.QtGui import QPainter, QColor, QPen, QFont, QFontMetrics
from PyQt6.QtCore import Qt, QTimer, QPoint

TICK_FREQUENCY = 32768

# ---------------------------------------------------------------------------
# Field-to-color mapping from memory_config.MAP
# ---------------------------------------------------------------------------

FIELD_COLORS = {
    "hunger":        QColor(255, 80, 80),
    "happy":         QColor(80, 200, 80),
    "discipline":    QColor(230, 200, 50),
    "weight":        QColor(180, 100, 220),
    "age":           QColor(220, 220, 220),
    "sick":          QColor(255, 150, 50),
    "sick_flag2":    QColor(255, 130, 30),
    "sick_level":    QColor(255, 160, 70),
    "sick_severity": QColor(255, 110, 20),
    "sleeping":      QColor(100, 150, 255),
    "poop":          QColor(80, 220, 220),
    "attention":     QColor(100, 180, 255),
    "lifecycle":     QColor(255, 255, 100),
    "character":     QColor(255, 150, 200),
}

def _build_addr_color_map():
    """Build {nibble_addr: (field_name, QColor)} from memory_config.MAP."""
    result = {}
    for name, cfg in memory_config.MAP.items():
        addr = cfg.get("addr")
        if addr is None:
            continue
        color = FIELD_COLORS.get(name, QColor(120, 120, 120))
        result[addr] = (name, color)
        if cfg.get("type") == "bcd":
            result[addr + 1] = (name, color)
    return result

ADDR_COLOR_MAP = _build_addr_color_map()

# Danger zone: 0x060-0x07F is CPU call stack / runtime state — writing here corrupts ROM
DANGER_RANGE = range(0x060, 0x080)


# ===========================================================================
# LcdWidget
# ===========================================================================

class LcdWidget(QWidget):
    """Renders LCD pixel matrix (32x16) and 8 icons from frame data.

    Frame data layout (v2, 72 bytes):
        bytes 0-63:  matrix_buffer[16][4] — packed pixels, MSB=leftmost
        bytes 64-71: icon_buffer[8] — one byte per icon (0=off, nonzero=on)

    v1 frames (50 bytes) or all-zero frames show a placeholder message.
    """

    LCD_W, LCD_H = 32, 16
    ICON_NUM = 8
    ICON_LABELS = ["FOOD", "LGHT", "GAME", "MED", "BATH", "STAT", "DISC", "ATTN"]

    def __init__(self, parent=None):
        super().__init__(parent)
        self.frame_data = None
        self.setFixedSize(256, 160)  # 128 for pixels + 32 for icons

    def set_frame(self, data):
        self.frame_data = data
        self.update()

    def _has_matrix_data(self):
        """Check if frame has real pixel data (not all zeros in matrix region)."""
        if self.frame_data is None:
            return False
        matrix = self.frame_data[:64] if len(self.frame_data) >= 64 else self.frame_data
        return not all(b == 0 for b in matrix)

    def paintEvent(self, event):
        painter = QPainter(self)
        bg = QColor(200, 210, 200)
        painter.fillRect(self.rect(), bg)

        pixel_area_h = 128  # 16 rows * 8px each
        icon_area_y = pixel_area_h + 2

        if not self._has_matrix_data():
            painter.setPen(QColor(100, 100, 100))
            painter.drawText(0, 0, self.width(), pixel_area_h,
                             Qt.AlignmentFlag.AlignCenter,
                             "No LCD data\n(v1 stream or not yet captured)")
            painter.end()
            return

        # --- Pixel matrix (32x16) ---
        pixel_w = self.width() // self.LCD_W
        pixel_h = pixel_area_h // self.LCD_H

        for y in range(self.LCD_H):
            for x in range(self.LCD_W):
                byte_idx = y * 4 + x // 8
                bit_idx = 7 - (x % 8)
                if byte_idx < len(self.frame_data):
                    on = (self.frame_data[byte_idx] >> bit_idx) & 1
                else:
                    on = 0
                color = QColor(20, 20, 100) if on else bg
                painter.fillRect(x * pixel_w, y * pixel_h,
                                 pixel_w - 1, pixel_h - 1, color)

        # --- Icons (below pixel matrix) ---
        if len(self.frame_data) >= 72:
            icon_data = self.frame_data[64:72]
            slot_w = self.width() // self.ICON_NUM
            font = QFont("Consolas", 7)
            font.setStyleHint(QFont.StyleHint.Monospace)
            painter.setFont(font)

            for i in range(self.ICON_NUM):
                on = icon_data[i] != 0
                ix = i * slot_w
                if on:
                    painter.fillRect(ix + 2, icon_area_y, slot_w - 4, 12,
                                     QColor(20, 20, 100))
                    painter.setPen(QColor(200, 210, 200))
                else:
                    painter.setPen(QColor(140, 150, 140))
                label = self.ICON_LABELS[i] if i < len(self.ICON_LABELS) else f"I{i}"
                painter.drawText(ix, icon_area_y, slot_w, 14,
                                 Qt.AlignmentFlag.AlignCenter, label)

        painter.end()


# ===========================================================================
# MemoryGridWidget
# ===========================================================================

class MemoryGridWidget(QWidget):
    """Hex grid displaying raw nibble values with field color-coding and diff highlighting.

    32 nibbles per row. Default range 0x020-0x09F (4 rows of 32).
    """

    DEFAULT_START = 0x020
    COLS = 32
    DEFAULT_ROWS = 4    # 4 rows of 32 nibbles = 128 nibbles (0x020..0x09F)
    MAX_ROWS = 20       # 640 nibbles / 32 per row

    def __init__(self, parent=None):
        super().__init__(parent)
        self._ram = bytes(320)
        self._diff = {}
        self._start_addr = self.DEFAULT_START
        self._num_rows = self.DEFAULT_ROWS
        self._font = QFont("Consolas", 9)
        self._font.setStyleHint(QFont.StyleHint.Monospace)
        self._cell_w = 16
        self._cell_h = 16
        self._addr_w = 48
        self._update_size()
        self.setMouseTracking(True)

    def _update_size(self):
        # header + data rows + diff summary + legend (2 lines)
        total_h = self._cell_h * (self._num_rows + 1) + 20 + 36
        total_w = self._addr_w + self.COLS * self._cell_w + 8
        self.setMinimumSize(total_w, total_h)
        self.setFixedHeight(total_h)

    def set_state(self, ram, diff=None):
        self._ram = ram
        self._diff = diff or {}
        self.update()

    def set_visible_rows(self, n):
        self._num_rows = max(1, min(n, self.MAX_ROWS))
        self._update_size()
        self.update()

    def expand_one(self):
        self.set_visible_rows(self._num_rows + 1)

    def collapse_one(self):
        self.set_visible_rows(self._num_rows - 1)

    def show_all(self):
        self._start_addr = 0x000
        self.set_visible_rows(self.MAX_ROWS)

    def show_default(self):
        self._start_addr = self.DEFAULT_START
        self.set_visible_rows(self.DEFAULT_ROWS)

    @property
    def visible_rows(self):
        return self._num_rows

    def _read_nibble(self, addr):
        byte_idx = addr >> 1
        if byte_idx >= len(self._ram):
            return 0
        val = self._ram[byte_idx]
        return ((val & 0xF0) >> 4) if (addr & 1) == 0 else (val & 0x0F)

    def _addr_at_pos(self, x, y):
        """Return nibble address at pixel position, or None."""
        col = (x - self._addr_w) // self._cell_w
        row = (y // self._cell_h) - 1  # -1 for header
        if 0 <= col < self.COLS and 0 <= row < self._num_rows:
            addr = self._start_addr + row * self.COLS + col
            if addr < 640:
                return addr
        return None

    def mouseMoveEvent(self, event):
        addr = self._addr_at_pos(int(event.position().x()), int(event.position().y()))
        if addr is not None:
            nibble_val = self._read_nibble(addr)
            field = ADDR_COLOR_MAP.get(addr)
            tip = f"0x{addr:03X} = 0x{nibble_val:X} ({nibble_val})"
            if field:
                tip += f"\nField: {field[0]}"
            if addr in DANGER_RANGE:
                tip += "\n[!] Danger zone: CPU stack / runtime state"
            if addr in self._diff:
                old_v, new_v = self._diff[addr]
                tip += f"\nChanged: {old_v:X} -> {new_v:X}"
            QToolTip.showText(event.globalPosition().toPoint(), tip, self)
        else:
            QToolTip.hideText()

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.setFont(self._font)
        fm = QFontMetrics(self._font)
        bg_color = QColor(30, 30, 30)
        painter.fillRect(self.rect(), bg_color)

        # Header row: column indices in hex
        painter.setPen(QColor(100, 100, 100))
        for col in range(self.COLS):
            x = self._addr_w + col * self._cell_w
            painter.drawText(x, 0, self._cell_w, self._cell_h,
                             Qt.AlignmentFlag.AlignCenter, f"{col:X}")

        # Data rows
        for row in range(self._num_rows):
            row_addr = self._start_addr + row * self.COLS
            y = (row + 1) * self._cell_h

            # Row address label
            painter.setPen(QColor(100, 100, 100))
            painter.drawText(0, y, self._addr_w - 2, self._cell_h,
                             Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter,
                             f"{row_addr:03X}:")

            for col in range(self.COLS):
                addr = row_addr + col
                if addr >= 640:
                    continue
                nibble_val = self._read_nibble(addr)
                x = self._addr_w + col * self._cell_w

                # Background: diff > field color > danger dim > neutral
                if addr in self._diff:
                    cell_bg = QColor(255, 215, 0)
                    text_color = QColor(0, 0, 0)
                elif addr in ADDR_COLOR_MAP:
                    _, field_color = ADDR_COLOR_MAP[addr]
                    cell_bg = QColor(field_color.red() // 3,
                                     field_color.green() // 3,
                                     field_color.blue() // 3)
                    text_color = field_color
                elif addr in DANGER_RANGE:
                    cell_bg = QColor(50, 20, 20)
                    text_color = QColor(160, 80, 80)
                else:
                    cell_bg = bg_color
                    text_color = QColor(140, 140, 140)

                painter.fillRect(x, y, self._cell_w - 1, self._cell_h - 1, cell_bg)

                # Danger zone subtle border
                if addr in DANGER_RANGE:
                    painter.setPen(QPen(QColor(120, 30, 30), 1))
                    painter.drawRect(x, y, self._cell_w - 2, self._cell_h - 2)

                painter.setPen(text_color)
                painter.drawText(x, y, self._cell_w, self._cell_h,
                                 Qt.AlignmentFlag.AlignCenter, f"{nibble_val:X}")

        # Diff summary line
        y_diff = (self._num_rows + 1) * self._cell_h + 2
        if self._diff:
            parts = []
            for addr in sorted(self._diff.keys())[:8]:
                old_v, new_v = self._diff[addr]
                field_info = ADDR_COLOR_MAP.get(addr)
                if field_info:
                    parts.append(f"0x{addr:03X}/{field_info[0]} ({old_v:X}\u2192{new_v:X})")
                else:
                    parts.append(f"0x{addr:03X} ({old_v:X}\u2192{new_v:X})")
            summary = f"{len(self._diff)} changed: {', '.join(parts)}"
            if len(self._diff) > 8:
                summary += f" +{len(self._diff) - 8} more"
            painter.setPen(QColor(255, 215, 0))
            painter.drawText(4, y_diff, self.width() - 8, self._cell_h,
                             Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter,
                             summary)
        y_diff += self._cell_h + 2

        # Legend
        y_legend = y_diff
        lx = 4
        known_fields = [n for n, cfg in memory_config.MAP.items() if cfg.get("addr") is not None]
        for name in known_fields:
            color = FIELD_COLORS.get(name, QColor(120, 120, 120))
            painter.fillRect(lx, y_legend + 3, 8, 8, color)
            lx += 10
            painter.setPen(QColor(160, 160, 160))
            tw = fm.horizontalAdvance(name) + 6
            painter.drawText(lx, y_legend, tw, self._cell_h,
                             Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter, name)
            lx += tw
            if lx > self.width() - 80:
                lx = 4
                y_legend += self._cell_h

        painter.end()


# ===========================================================================
# TimelineWidget
# ===========================================================================

class TimelineWidget(QWidget):
    """Timeline with markers, hover info, and click-to-jump."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setFixedHeight(40)
        self.setMouseTracking(True)
        self.min_tick = 0
        self.max_tick = 1
        self.markers = []
        self.current_tick = 0
        self._on_tick_clicked = None

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

    def set_click_callback(self, callback):
        self._on_tick_clicked = callback

    def tick_from_x(self, x):
        span = self.max_tick - self.min_tick
        if span <= 0 or self.width() <= 0:
            return self.min_tick
        return int(self.min_tick + (x / self.width()) * span)

    def mousePressEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton and self._on_tick_clicked:
            tick = self.tick_from_x(event.position().x())
            self._on_tick_clicked(tick)

    def mouseMoveEvent(self, event):
        tick = self.tick_from_x(event.position().x())
        emu_time = (tick - self.min_tick) / TICK_FREQUENCY
        QToolTip.showText(
            event.globalPosition().toPoint(),
            f"Tick: {tick:,}\nTime: {emu_time:.2f}s",
            self,
        )

    def paintEvent(self, event):
        painter = QPainter(self)
        w = self.width()
        h = self.height()
        painter.fillRect(0, 0, w, h, QColor(40, 40, 40))

        span = self.max_tick - self.min_tick
        if span <= 0:
            painter.end()
            return

        for marker in self.markers:
            tick = marker[0]
            color = marker[1]
            style = marker[3] if len(marker) > 3 else "line"
            x = int((tick - self.min_tick) / span * w)

            if style == "triangle_up":
                painter.setPen(Qt.PenStyle.NoPen)
                painter.setBrush(color)
                painter.drawPolygon([QPoint(x - 3, h), QPoint(x + 3, h), QPoint(x, h - 8)])
            elif style == "triangle_down":
                painter.setPen(Qt.PenStyle.NoPen)
                painter.setBrush(color)
                painter.drawPolygon([QPoint(x - 3, 0), QPoint(x + 3, 0), QPoint(x, 8)])
            else:
                line_h = h if style == "tall_line" else h // 2
                painter.setPen(QPen(color, 1 if style != "tall_line" else 2))
                painter.drawLine(x, h - line_h, x, h)

        # Current position
        cx = int((self.current_tick - self.min_tick) / span * w)
        painter.setPen(QPen(QColor(255, 255, 0), 2))
        painter.drawLine(cx, 0, cx, h)

        painter.end()


# ===========================================================================
# HelpOverlay
# ===========================================================================

class HelpOverlay(QWidget):
    """Semi-transparent overlay showing keyboard shortcuts."""

    HELP_TEXT = """\
         Keyboard Shortcuts

  Navigation
    Left / Right         Step +/-1 write
    Shift+Left / Right   Step +/-10 writes
    Ctrl+Left / Right    Step +/-1 emu-second
    Home / End           Jump to start / end
    Space                Play / Pause auto-step

  Tools
    A                    Annotate current tick
    L                    Launch sim here
    ? / F1               Toggle this help

  Memory Grid
    M                    Toggle expand / collapse
    + / =                Show one more row
    - / _                Show one fewer row

  Hex Grid Hover
    Hover any nibble for address, field name, value
    Red-bordered cells = danger zone (CPU stack)

              Press ? to close"""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setVisible(False)

    def toggle(self):
        self.setVisible(not self.isVisible())
        if self.isVisible():
            self.raise_()
            self.update()

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.fillRect(self.rect(), QColor(0, 0, 0, 200))

        font = QFont("Consolas", 11)
        font.setStyleHint(QFont.StyleHint.Monospace)
        painter.setFont(font)

        fm = QFontMetrics(font)
        lines = self.HELP_TEXT.split("\n")
        line_h = fm.height() + 2
        total_h = len(lines) * line_h
        max_w = max(fm.horizontalAdvance(line) for line in lines) + 40

        box_x = (self.width() - max_w) // 2
        box_y = (self.height() - total_h) // 2

        painter.setPen(QPen(QColor(100, 180, 255), 2))
        painter.drawRect(box_x - 10, box_y - 15, max_w + 20, total_h + 30)

        painter.setPen(QColor(220, 220, 220))
        for i, line in enumerate(lines):
            painter.drawText(box_x, box_y + i * line_h, max_w, line_h,
                             Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter, line)

        painter.end()

    def resizeEvent(self, event):
        self.update()


# ===========================================================================
# NavigationBar
# ===========================================================================

class NavigationBar(QWidget):
    """Navigation controls with buttons, slider, and status line."""

    def __init__(self, parent=None):
        super().__init__(parent)
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)

        btn_row = QHBoxLayout()
        self.btn_home = QPushButton("|<")
        self.btn_back_1s = QPushButton("<<")
        self.btn_back_10 = QPushButton("<10")
        self.btn_back_1 = QPushButton("<")
        self.slider = QSlider(Qt.Orientation.Horizontal)
        self.btn_fwd_1 = QPushButton(">")
        self.btn_fwd_10 = QPushButton("10>")
        self.btn_fwd_1s = QPushButton(">>")
        self.btn_end = QPushButton(">|")
        self.btn_play = QPushButton("Play")

        for btn in [self.btn_home, self.btn_back_1s, self.btn_back_10, self.btn_back_1]:
            btn.setFixedWidth(36)
            btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
            btn_row.addWidget(btn)
        self.slider.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        btn_row.addWidget(self.slider, stretch=1)
        for btn in [self.btn_fwd_1, self.btn_fwd_10, self.btn_fwd_1s, self.btn_end]:
            btn.setFixedWidth(36)
            btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
            btn_row.addWidget(btn)
        self.btn_play.setFixedWidth(50)
        self.btn_play.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        btn_row.addWidget(self.btn_play)
        layout.addLayout(btn_row)

        self.status_label = QLabel("Tick: 0 | Time: 0.0s | Step: 0 of 0")
        self.status_label.setStyleSheet("color: #aaa; font-size: 11px;")
        layout.addWidget(self.status_label)

    def update_status(self, tick, min_tick, cursor, total, diff_count):
        emu_time = (tick - min_tick) / TICK_FREQUENCY
        self.status_label.setText(
            f"Tick: {tick:,} | Time: {emu_time:.1f}s | "
            f"Step: write #{cursor:,} of {total:,} | "
            f"Writes at tick: {diff_count}"
        )


# ===========================================================================
# StreamViewer (main window)
# ===========================================================================

class StreamViewer(QMainWindow):
    def __init__(self, filepath, app=None):
        super().__init__()
        self.setWindowTitle(f"Stream Viewer - {os.path.basename(filepath)}")
        self.resize(1100, 750)

        # --- Progress dialog for loading ---
        progress = None
        if app:
            progress = QProgressDialog("Loading stream...", None, 0, 100)
            progress.setWindowTitle("Loading")
            progress.setMinimumDuration(0)
            progress.setValue(0)
            app.processEvents()

        def stream_progress(pct, msg):
            if progress:
                if pct is not None:
                    progress.setValue(pct)
                progress.setLabelText(msg)
                app.processEvents()

        stream_progress(0, "Parsing stream file...")
        self.stream = TamStream(filepath, progress_callback=stream_progress)

        stream_progress(50, "Building write index...")
        self.tracker = CachedStateTracker(self.stream, progress_callback=stream_progress)
        self.annotation_store = AnnotationStore(filepath)

        self.min_tick, self.max_tick = self.stream.tick_range
        if self.min_tick is None:
            self.min_tick = 0
            self.max_tick = 0
        self.current_tick = self.min_tick

        # Auto-play timer
        self._playing = False
        self._play_timer = QTimer()
        self._play_timer.setInterval(100)
        self._play_timer.timeout.connect(self._auto_step)

        # Build markers from pre-indexed data (no extra file scan)
        stream_progress(95, "Building UI...")
        self.annotation_markers = []
        self.button_markers = []
        self._load_markers_from_index()

        self._tick_positions = [self.min_tick]
        self._tick_positions.extend(self.stream._tick_marker_ticks)
        if self.max_tick not in self._tick_positions:
            self._tick_positions.append(self.max_tick)
        self._tick_positions.sort()

        self._init_ui()

        # Initial seek
        self.tracker.seek(self.min_tick)
        self._update_display()

        if progress:
            progress.close()

    def _load_markers_from_index(self):
        """Build markers from pre-indexed data — no file rescan."""
        for tick, text in self.stream._annotation_records:
            self.annotation_markers.append(
                (tick, QColor(255, 100, 100), text, "tall_line"))
        for tick, button_id, state in self.stream._button_records:
            style = "triangle_up" if state == 1 else "triangle_down"
            self.button_markers.append(
                (tick, QColor(100, 200, 100),
                 f"{BUTTON_NAMES.get(button_id, '?')} {BUTTON_STATES.get(state, '?')}",
                 style))

    def _get_all_markers(self):
        """Combine in-stream markers + sidecar annotation markers."""
        markers = list(self.annotation_markers) + list(self.button_markers)
        for ann in self.annotation_store.all():
            markers.append((ann["tick"], QColor(100, 150, 255), ann["text"], "tall_line"))
        return markers

    def _init_ui(self):
        central = QWidget()
        self.setCentralWidget(central)
        main_layout = QVBoxLayout(central)
        main_layout.setContentsMargins(4, 4, 4, 4)
        main_layout.setSpacing(4)

        # Top area: splitter with stats | hex grid
        splitter = QSplitter(Qt.Orientation.Horizontal)

        # --- Left panel: stats + LCD + annotations ---
        left_widget = QWidget()
        left_layout = QVBoxLayout(left_widget)
        left_layout.setContentsMargins(4, 4, 4, 4)
        left_layout.setSpacing(2)

        self.tick_label = QLabel("Tick: 0")
        self.tick_label.setStyleSheet("font-weight: bold;")
        left_layout.addWidget(self.tick_label)

        self.time_label = QLabel("Time: 0.0s")
        left_layout.addWidget(self.time_label)

        # LCD in the left panel (small)
        self.lcd_widget = LcdWidget()
        left_layout.addWidget(self.lcd_widget)

        self.stats_labels = {}
        stat_names = ["hunger", "happy", "discipline", "weight", "age", "sick",
                      "sleeping", "poop", "attention", "lifecycle", "character"]
        for name in stat_names:
            lbl = QLabel(f"{name}: --")
            left_layout.addWidget(lbl)
            self.stats_labels[name] = lbl

        # Annotation list
        self.annotation_list_label = QLabel("Nearby annotations:")
        self.annotation_list_label.setStyleSheet("font-weight: bold; font-size: 11px;")
        left_layout.addWidget(self.annotation_list_label)
        self.annotation_list = QLabel("")
        self.annotation_list.setWordWrap(True)
        self.annotation_list.setStyleSheet("font-size: 10px; color: #aac;")
        left_layout.addWidget(self.annotation_list)

        left_layout.addStretch()

        self.launch_btn = QPushButton("Launch Sim Here (L)")
        self.launch_btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        self.launch_btn.clicked.connect(self._launch_sim)
        left_layout.addWidget(self.launch_btn)

        scroll = QScrollArea()
        scroll.setWidget(left_widget)
        scroll.setWidgetResizable(True)
        scroll.setMinimumWidth(200)
        scroll.setMaximumWidth(260)
        splitter.addWidget(scroll)

        # --- Center panel: hex grid (fills remaining space) ---
        center_widget = QWidget()
        center_widget.setStyleSheet("background-color: #1e1e1e;")
        center_layout = QVBoxLayout(center_widget)
        center_layout.setContentsMargins(4, 4, 4, 4)
        center_layout.setSpacing(2)

        # Hex grid header with buttons
        hex_header = QHBoxLayout()
        hex_label = QLabel("Memory Hex Grid")
        hex_label.setStyleSheet("color: #ccc; font-weight: bold;")
        hex_header.addWidget(hex_label)
        hex_header.addStretch()
        for text, handler in [("+ Row", self._hex_expand),
                              ("- Row", self._hex_collapse),
                              ("Show all", self._hex_show_all),
                              ("Default", self._hex_show_default)]:
            btn = QPushButton(text)
            btn.setFixedWidth(60)
            btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
            btn.clicked.connect(handler)
            hex_header.addWidget(btn)
        center_layout.addLayout(hex_header)

        self.hex_grid = MemoryGridWidget()
        center_layout.addWidget(self.hex_grid)
        center_layout.addStretch()

        splitter.addWidget(center_widget)
        splitter.setStretchFactor(1, 1)
        main_layout.addWidget(splitter, stretch=1)

        # --- Annotation input ---
        ann_row = QHBoxLayout()
        lbl = QLabel("Annotate:")
        lbl.setFixedWidth(60)
        ann_row.addWidget(lbl)
        self.annotation_input = QLineEdit()
        self.annotation_input.setPlaceholderText("Type annotation for current tick, press Enter (A to focus)")
        self.annotation_input.returnPressed.connect(self._save_annotation)
        self.annotation_input.setFocusPolicy(Qt.FocusPolicy.ClickFocus)
        ann_row.addWidget(self.annotation_input, stretch=1)
        main_layout.addLayout(ann_row)

        # --- Timeline ---
        self.timeline_widget = TimelineWidget()
        self.timeline_widget.set_range(self.min_tick, self.max_tick)
        self.timeline_widget.set_markers(self._get_all_markers())
        self.timeline_widget.set_click_callback(self._on_timeline_click)
        main_layout.addWidget(self.timeline_widget)

        # --- Navigation bar ---
        self.nav_bar = NavigationBar()
        self.nav_bar.slider.setMinimum(0)
        self.nav_bar.slider.setMaximum(max(len(self._tick_positions) - 1, 0))
        self.nav_bar.slider.valueChanged.connect(self._on_slider_changed)

        self.nav_bar.btn_home.clicked.connect(self._nav_home)
        self.nav_bar.btn_end.clicked.connect(self._nav_end)
        self.nav_bar.btn_back_1.clicked.connect(lambda: self._nav_step(-1))
        self.nav_bar.btn_fwd_1.clicked.connect(lambda: self._nav_step(1))
        self.nav_bar.btn_back_10.clicked.connect(lambda: self._nav_step(-10))
        self.nav_bar.btn_fwd_10.clicked.connect(lambda: self._nav_step(10))
        self.nav_bar.btn_back_1s.clicked.connect(lambda: self._nav_step_time(-1))
        self.nav_bar.btn_fwd_1s.clicked.connect(lambda: self._nav_step_time(1))
        self.nav_bar.btn_play.clicked.connect(self._toggle_play)

        main_layout.addWidget(self.nav_bar)

        # --- Help overlay ---
        self.help_overlay = HelpOverlay(central)
        self.help_overlay.setGeometry(central.rect())

        # Ensure main window gets keyboard focus
        self.setFocusPolicy(Qt.FocusPolicy.StrongFocus)
        self.setFocus()

    # --- Navigation methods ---

    def _nav_step(self, n):
        self._stop_play()
        if n > 0:
            self.tracker.step_forward(n)
        elif n < 0:
            self.tracker.step_backward(-n)
        self.current_tick = self.tracker.current_tick
        self._update_display()

    def _nav_step_time(self, seconds):
        self._stop_play()
        target = self.current_tick + int(seconds * TICK_FREQUENCY)
        target = max(self.min_tick, min(target, self.max_tick))
        self.tracker.step_to_tick(target)
        self.current_tick = self.tracker.current_tick
        self._update_display()

    def _nav_home(self):
        self._stop_play()
        self.tracker.seek(self.min_tick)
        self.current_tick = self.min_tick
        self._update_display()

    def _nav_end(self):
        self._stop_play()
        self.tracker.seek(self.max_tick)
        self.current_tick = self.max_tick
        self._update_display()

    def _on_slider_changed(self, index):
        if 0 <= index < len(self._tick_positions):
            tick = self._tick_positions[index]
            self._stop_play()
            self.tracker.seek(tick)
            self.current_tick = tick
            self._update_display()

    def _on_timeline_click(self, tick):
        self._stop_play()
        tick = max(self.min_tick, min(tick, self.max_tick))
        self.tracker.seek(tick)
        self.current_tick = tick
        self._update_display()

    def _toggle_play(self):
        if self._playing:
            self._stop_play()
        else:
            self._playing = True
            self.nav_bar.btn_play.setText("Pause")
            self._play_timer.start()

    def _stop_play(self):
        self._playing = False
        self._play_timer.stop()
        self.nav_bar.btn_play.setText("Play")

    def _auto_step(self):
        n = self.tracker.step_forward(1)
        if n == 0:
            self._stop_play()
            return
        self.current_tick = self.tracker.current_tick
        self._update_display()

    # --- Hex grid controls ---

    def _hex_expand(self):
        self.hex_grid.expand_one()

    def _hex_collapse(self):
        self.hex_grid.collapse_one()

    def _hex_show_all(self):
        self.hex_grid.show_all()

    def _hex_show_default(self):
        self.hex_grid.show_default()

    # --- Annotation ---

    def _save_annotation(self):
        text = self.annotation_input.text().strip()
        if text:
            self.annotation_store.add(self.current_tick, text)
            self.annotation_input.clear()
            self.annotation_input.clearFocus()
            self.setFocus()
            self.timeline_widget.set_markers(self._get_all_markers())
            self._update_annotation_list()

    def _update_annotation_list(self):
        """Show annotations near the current tick."""
        window = TICK_FREQUENCY * 10
        nearby = self.annotation_store.get_in_range(
            self.current_tick - window, self.current_tick + window)
        lines = []
        for ann in nearby[:10]:
            offset = ann["tick"] - self.current_tick
            prefix = f"[+{offset:,}]" if offset >= 0 else f"[{offset:,}]"
            lines.append(f"{prefix} {ann['text']}")
        self.annotation_list.setText("\n".join(lines) if lines else "(none)")

    # --- Display update ---

    def _update_display(self):
        self.tick_label.setText(f"Tick: {self.current_tick:,}")
        emu_time = (self.current_tick - self.min_tick) / TICK_FREQUENCY
        self.time_label.setText(f"Time: {emu_time:.1f}s")

        self.timeline_widget.set_current_tick(self.current_tick)

        # Sync slider (no signal)
        idx = bisect.bisect_left(self._tick_positions, self.current_tick)
        if idx >= len(self._tick_positions):
            idx = len(self._tick_positions) - 1
        self.nav_bar.slider.blockSignals(True)
        self.nav_bar.slider.setValue(idx)
        self.nav_bar.slider.blockSignals(False)

        # Stats from tracker RAM (already computed, no file I/O)
        ram = self.tracker.ram
        try:
            result = {}
            for name in memory_config.MAP:
                val = memory_config.get_value(ram, name)
                if val is not None:
                    result[name] = val
            for name, lbl in self.stats_labels.items():
                val = result.get(name, "--")
                lbl.setText(f"{name}: {val}")
        except Exception as e:
            for lbl in self.stats_labels.values():
                lbl.setText(f"Error: {e}")

        # Hex grid with diff
        self.hex_grid.set_state(ram, self.tracker.last_diff)

        # LCD (indexed lookup, O(log n))
        frame = self.stream.nearest_lcd_frame(self.current_tick)
        if frame:
            self.lcd_widget.set_frame(frame[1])
        else:
            self.lcd_widget.set_frame(None)

        # Nav status
        self.nav_bar.update_status(
            self.current_tick, self.min_tick,
            self.tracker.write_cursor, self.tracker.total_writes,
            len(self.tracker.last_diff),
        )

        self._update_annotation_list()

    def _launch_sim(self):
        QMessageBox.information(self, "Not Yet Implemented",
                                "Launch Sim Here requires savestate binary layout knowledge.\n"
                                "This feature will be implemented in a future ticket.")

    # --- Keyboard handling ---

    def keyPressEvent(self, event):
        key = event.key()
        mods = event.modifiers()

        if key == Qt.Key.Key_Question or key == Qt.Key.Key_F1:
            self.help_overlay.toggle()
            return

        if self.help_overlay.isVisible():
            if key == Qt.Key.Key_Escape:
                self.help_overlay.setVisible(False)
            return

        if self.annotation_input.hasFocus():
            if key == Qt.Key.Key_Escape:
                self.annotation_input.clear()
                self.annotation_input.clearFocus()
                self.setFocus()
                return
            super().keyPressEvent(event)
            return

        if key == Qt.Key.Key_Left:
            if mods & Qt.KeyboardModifier.ControlModifier:
                self._nav_step_time(-1)
            elif mods & Qt.KeyboardModifier.ShiftModifier:
                self._nav_step(-10)
            else:
                self._nav_step(-1)
        elif key == Qt.Key.Key_Right:
            if mods & Qt.KeyboardModifier.ControlModifier:
                self._nav_step_time(1)
            elif mods & Qt.KeyboardModifier.ShiftModifier:
                self._nav_step(10)
            else:
                self._nav_step(1)
        elif key == Qt.Key.Key_Home:
            self._nav_home()
        elif key == Qt.Key.Key_End:
            self._nav_end()
        elif key == Qt.Key.Key_Space:
            self._toggle_play()
        elif key == Qt.Key.Key_A:
            self.annotation_input.setFocus()
            self.annotation_input.setFocusPolicy(Qt.FocusPolicy.StrongFocus)
        elif key == Qt.Key.Key_L:
            self._launch_sim()
        elif key == Qt.Key.Key_M:
            if self.hex_grid.visible_rows == MemoryGridWidget.DEFAULT_ROWS:
                self.hex_grid.show_all()
            else:
                self.hex_grid.show_default()
        elif key in (Qt.Key.Key_Plus, Qt.Key.Key_Equal):
            self.hex_grid.expand_one()
        elif key in (Qt.Key.Key_Minus, Qt.Key.Key_Underscore):
            self.hex_grid.collapse_one()
        else:
            super().keyPressEvent(event)

    def resizeEvent(self, event):
        super().resizeEvent(event)
        if hasattr(self, 'help_overlay'):
            self.help_overlay.setGeometry(self.centralWidget().rect())


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <tamstream_file>")
        sys.exit(1)

    filepath = sys.argv[1]
    if not os.path.exists(filepath):
        print(f"Error: File not found: {filepath}")
        sys.exit(1)

    app = QApplication(sys.argv)
    viewer = StreamViewer(filepath, app=app)
    viewer.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
