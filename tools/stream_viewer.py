#!/usr/bin/env python3
"""Timeline viewer for .tamstream files with scrubber, stats, hex grid, and LCD display."""

import sys
import os
import bisect
import struct
import tempfile
import subprocess

sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from stream_reader import (
    TamStream, SegmentedTamStream, CachedStateTracker, open_stream,
    REC_ANNOTATION, REC_BUTTON_EVENT, REC_TICK_MARKER,
    BUTTON_NAMES, BUTTON_STATES,
)
from annotation_store import AnnotationStore
from bookmark_store import BookmarkStore
import memory_config

from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QLabel, QSlider, QPushButton, QScrollArea, QFrame, QMessageBox,
    QLineEdit, QSplitter, QToolTip, QMenu, QProgressDialog, QFileDialog,
    QInputDialog,
)
from PyQt6.QtGui import QPainter, QColor, QPen, QFont, QFontMetrics
from PyQt6.QtCore import Qt, QTimer, QPoint, QThread, pyqtSignal

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

        icon_row_h = max(14, self.height() // 10)  # ~10% of height for icons
        pixel_area_h = self.height() - icon_row_h - 2
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
            font_size = max(5, min(7, icon_row_h // 2))
            font = QFont("Consolas", font_size)
            font.setStyleHint(QFont.StyleHint.Monospace)
            painter.setFont(font)

            for i in range(self.ICON_NUM):
                on = icon_data[i] != 0
                ix = i * slot_w
                if on:
                    painter.fillRect(ix + 2, icon_area_y, slot_w - 4, icon_row_h - 2,
                                     QColor(20, 20, 100))
                    painter.setPen(QColor(200, 210, 200))
                else:
                    painter.setPen(QColor(140, 150, 140))
                label = self.ICON_LABELS[i] if i < len(self.ICON_LABELS) else f"I{i}"
                painter.drawText(ix, icon_area_y, slot_w, icon_row_h,
                                 Qt.AlignmentFlag.AlignCenter, label)

        painter.end()


# ===========================================================================
# LcdPopupWidget
# ===========================================================================

class LcdPopupWidget(QWidget):
    """Small floating popup showing LCD preview at a timeline tick."""

    def __init__(self, parent=None):
        super().__init__(parent, Qt.WindowType.ToolTip)
        layout = QVBoxLayout(self)
        layout.setContentsMargins(4, 4, 4, 4)
        layout.setSpacing(2)
        self._lcd = LcdWidget()
        self._lcd.setFixedSize(128, 80)
        layout.addWidget(self._lcd)
        self._tick_label = QLabel("")
        self._tick_label.setStyleSheet("font-size: 10px; color: #666;")
        layout.addWidget(self._tick_label)
        self.setFixedSize(136, 100)

    def update_frame(self, tick, frame_data, min_tick=0):
        if frame_data is not None:
            self._lcd.set_frame(frame_data)
            emu_time = (tick - min_tick) / TICK_FREQUENCY
            self._tick_label.setText(f"Tick {tick:,} ({emu_time:.1f}s)")
        else:
            self._lcd.set_frame(None)
            self._tick_label.setText("No LCD data")


# ===========================================================================
# MemoryGridWidget
# ===========================================================================

class MemoryGridWidget(QWidget):
    """Hex grid displaying raw nibble values with field color-coding and diff highlighting.

    32 nibbles per row. Default range 0x020-0x09F (4 rows of 32).
    """

    DEFAULT_START = 0x000
    COLS = 32
    DEFAULT_ROWS = 20   # Start fully expanded (all 640 nibbles)
    MAX_ROWS = 20       # 640 nibbles / 32 per row
    COMPACT_ROWS = 4    # Compact view: 4 rows at 0x020

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
        self._selected_addrs: set[int] = set()
        self._drag_start_addr: int | None = None
        self._dragging = False
        self._update_size()
        self.setMouseTracking(True)
        self.setStyleSheet("QToolTip { background-color: white; color: black; border: 1px solid #999; padding: 4px; }")

    def _update_size(self):
        # header + data rows + legend (2 lines)
        total_h = self._cell_h * (self._num_rows + 1) + 4 + 36
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
        self._start_addr = 0x020
        self.set_visible_rows(self.COMPACT_ROWS)

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

    def selected_addresses(self) -> set[int]:
        """Return the current set of selected nibble addresses."""
        return set(self._selected_addrs)

    def clear_selection(self):
        """Clear all selected addresses."""
        self._selected_addrs.clear()
        self.update()

    def _addr_range(self, a, b):
        """Return set of addresses in rectangular region between addr a and b."""
        if a is None or b is None:
            return set()
        row_a, col_a = divmod(a - self._start_addr, self.COLS)
        row_b, col_b = divmod(b - self._start_addr, self.COLS)
        r0, r1 = sorted((row_a, row_b))
        c0, c1 = sorted((col_a, col_b))
        result = set()
        for r in range(r0, r1 + 1):
            for c in range(c0, c1 + 1):
                addr = self._start_addr + r * self.COLS + c
                if 0 <= addr < 640:
                    result.add(addr)
        return result

    def mousePressEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            addr = self._addr_at_pos(int(event.position().x()), int(event.position().y()))
            self._drag_start_addr = addr
            self._dragging = False
            if addr is not None:
                # Every click toggles the address
                if addr in self._selected_addrs:
                    self._selected_addrs.discard(addr)
                else:
                    self._selected_addrs.add(addr)
                self.update()

    def mouseMoveEvent(self, event):
        if event.buttons() & Qt.MouseButton.LeftButton and self._drag_start_addr is not None:
            addr = self._addr_at_pos(int(event.position().x()), int(event.position().y()))
            if addr is not None and addr != self._drag_start_addr:
                self._dragging = True
                self._selected_addrs = self._addr_range(self._drag_start_addr, addr)
                self.update()
            return

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

    def mouseReleaseEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            self._drag_start_addr = None
            self._dragging = False

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

                # Selection border
                if addr in self._selected_addrs:
                    painter.setPen(QPen(QColor(0, 220, 255), 2))
                    painter.drawRect(x, y, self._cell_w - 2, self._cell_h - 2)

                painter.setPen(text_color)
                painter.drawText(x, y, self._cell_w, self._cell_h,
                                 Qt.AlignmentFlag.AlignCenter, f"{nibble_val:X}")

        # Legend
        y_legend = (self._num_rows + 1) * self._cell_h + 4
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
        self._stream = None
        self._lcd_popup = None
        self._last_popup_tick = None
        # Segment load state: list of (start_tick, end_tick, is_loaded)
        self._segments = []
        # Callbacks for right-click load/unload (set by StreamViewer)
        self._on_load_segment = None
        self._on_unload_segment = None

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

    def set_segments(self, segments):
        """segments: list of (start_tick, end_tick, is_loaded) tuples."""
        self._segments = list(segments)
        self.update()

    def update_segment_loaded(self, index, loaded):
        if 0 <= index < len(self._segments):
            s, e, _ = self._segments[index]
            self._segments[index] = (s, e, loaded)
            self.update()

    def tick_from_x(self, x):
        span = self.max_tick - self.min_tick
        if span <= 0 or self.width() <= 0:
            return self.min_tick
        return int(self.min_tick + (x / self.width()) * span)

    def _seg_index_at_tick(self, tick):
        """Return segment index whose range contains tick, or None."""
        for i, (s, e, _loaded) in enumerate(self._segments):
            if s <= tick <= e:
                return i
        return None

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
        # LCD popup — only show if tick's segment is loaded
        if self._stream and self._lcd_popup:
            if self._last_popup_tick is None or abs(tick - self._last_popup_tick) > 500:
                seg_idx = self._seg_index_at_tick(tick)
                if self._segments and seg_idx is not None and not self._segments[seg_idx][2]:
                    # Unloaded segment
                    self._lcd_popup.update_frame(tick, None, self.min_tick)
                    self._lcd_popup._tick_label.setText("Segment not loaded")
                else:
                    frame = self._stream.nearest_lcd_frame(tick)
                    if frame:
                        self._lcd_popup.update_frame(frame[0], frame[1], self.min_tick)
                    else:
                        self._lcd_popup.update_frame(tick, None, self.min_tick)
                self._last_popup_tick = tick
            gpos = event.globalPosition().toPoint()
            self._lcd_popup.move(gpos.x() + 10, gpos.y() - self._lcd_popup.height() - 5)
            self._lcd_popup.show()

    def leaveEvent(self, event):
        if self._lcd_popup:
            self._lcd_popup.hide()
            self._last_popup_tick = None

    def contextMenuEvent(self, event):
        if not self._segments:
            return
        tick = self.tick_from_x(event.pos().x())
        seg_idx = self._seg_index_at_tick(tick)
        if seg_idx is None:
            return
        _s, _e, is_loaded = self._segments[seg_idx]
        menu = QMenu(self)
        if is_loaded:
            action = menu.addAction(f"Unload segment {seg_idx}")
            action.triggered.connect(lambda: self._on_unload_segment and self._on_unload_segment(seg_idx))
        else:
            action = menu.addAction(f"Load segment {seg_idx}")
            action.triggered.connect(lambda: self._on_load_segment and self._on_load_segment(seg_idx))
        menu.exec(event.globalPos())

    def paintEvent(self, event):
        painter = QPainter(self)
        w = self.width()
        h = self.height()
        painter.fillRect(0, 0, w, h, QColor(40, 40, 40))

        span = self.max_tick - self.min_tick
        if span <= 0:
            painter.end()
            return

        # --- 1. Segment rectangles ---
        for start_t, end_t, is_loaded in self._segments:
            x0 = int((start_t - self.min_tick) / span * w)
            x1 = int((end_t - self.min_tick) / span * w)
            seg_w = max(1, x1 - x0)
            if is_loaded:
                painter.fillRect(x0, 0, seg_w, h, QColor(40, 80, 140, 255))
            else:
                painter.fillRect(x0, 0, seg_w, h, QColor(40, 80, 140, 60))

        # --- 2. Segment boundary lines ---
        if self._segments:
            painter.setPen(QPen(QColor(80, 80, 80), 1))
            for start_t, end_t, _ in self._segments:
                for t in (start_t, end_t):
                    x = int((t - self.min_tick) / span * w)
                    painter.drawLine(x, 0, x, h)

        # --- 3. Markers: buttons (subtle) first, then annotations/bookmarks on top ---
        button_markers = []
        other_markers = []
        for marker in self.markers:
            style = marker[3] if len(marker) > 3 else "line"
            if style in ("triangle_up", "triangle_down"):
                button_markers.append(marker)
            else:
                other_markers.append(marker)

        for tick, color, label, style in button_markers:
            x = int((tick - self.min_tick) / span * w)
            muted = QColor(color.red(), color.green(), color.blue(), 100)
            painter.setPen(QPen(muted, 1))
            if style == "triangle_up":
                painter.drawLine(x, h, x, h - 5)
            else:
                painter.drawLine(x, 0, x, 5)

        for marker in other_markers:
            tick = marker[0]
            color = marker[1]
            style = marker[3] if len(marker) > 3 else "line"
            x = int((tick - self.min_tick) / span * w)
            line_h = h if style == "tall_line" else h // 2
            painter.setPen(QPen(color, 1 if style != "tall_line" else 2))
            painter.drawLine(x, h - line_h, x, h)

        # --- 4. Current position cursor ---
        cx = int((self.current_tick - self.min_tick) / span * w)
        painter.setPen(QPen(QColor(255, 255, 0), 2))
        painter.drawLine(cx, 0, cx, h)

        # --- 5. Legend ---
        font = QFont("Consolas", 7)
        font.setStyleHint(QFont.StyleHint.Monospace)
        painter.setFont(font)
        painter.setPen(QColor(120, 120, 120))
        legend = "Timeline — yellow: cursor | pink: bookmarks | red: annotations | green: buttons"
        if self._segments:
            legend += " | blue: loaded segs"
        painter.drawText(4, 2, w - 8, 12, Qt.AlignmentFlag.AlignLeft, legend)

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
    Ctrl+Left / Right    Cycle bookmarks (or +/-1s)
    [ / ]                Prev / Next screen change
    Home / End           Jump to start / end
    Space                Play / Pause auto-step

  Buttons (Nav bar)
    <1s / 1s>            Jump ±1 second
    <1m / 1m>            Jump ±1 minute
    <5m / 5m>            Jump ±5 minutes
    <LCD / LCD>          Prev / Next LCD screen change
    <Sel / Sel>          Prev / Next write to selected addrs
    Right-click timeline Load / Unload segment

  Tools
    A                    Annotate current tick
    B                    Toggle bookmark
    L                    Launch sim here
    T                    Open in TamaTool  (non-Windows only)
    ? / F1               Toggle this help
    Escape               Clear hex grid selection

  Memory Grid
    M                    Toggle expand / collapse
    + / =                Show one more row
    - / _                Show one fewer row
    Alt+Left / Right     Prev/Next write to selected addrs

  Hex Grid
    Click                Select address
    Drag                 Select rectangular region
    Hover                Show address, field name, value
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
    """Navigation controls with buttons, slider, and status line.

    Layout:
      Row 1: slider (full width)
      Row 2: [|<] [Play] [>|] | [<1] [1>] [<10] [10>] | [<1s] [1s>] [<1m] [1m>] [<5m] [5m>]
              | [<LCD] [LCD>] | [<Sel] [Sel>] | [+Bk] [<Bk] [Bk>]  (stretch)
      Row 3: status label
    """

    def __init__(self, parent=None):
        super().__init__(parent)
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(2)

        # --- Row 1: slider ---
        self.slider = QSlider(Qt.Orientation.Horizontal)
        self.slider.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        self.slider.setToolTip("Scrub through tick markers")
        layout.addWidget(self.slider)

        # --- Row 2: button groups ---
        btn_row = QHBoxLayout()
        btn_row.setSpacing(2)

        def _btn(label, tip, width=36):
            b = QPushButton(label)
            b.setToolTip(tip)
            b.setFixedWidth(width)
            b.setFocusPolicy(Qt.FocusPolicy.NoFocus)
            return b

        def _separator():
            sep = QFrame()
            sep.setFrameShape(QFrame.Shape.VLine)
            sep.setFrameShadow(QFrame.Shadow.Sunken)
            sep.setFixedWidth(6)
            return sep

        # Group 1: transport
        self.btn_home = _btn("|<", "Jump to start  [Home]")
        self.btn_play = _btn("Play", "Play / Pause auto-step  [Space]", width=44)
        self.btn_end  = _btn(">|", "Jump to end  [End]")
        for w in [self.btn_home, self.btn_play, self.btn_end, _separator()]:
            btn_row.addWidget(w)

        # Group 2: write steps
        self.btn_back_1  = _btn("<",   "Back 1 write  [Left]")
        self.btn_fwd_1   = _btn(">",   "Forward 1 write  [Right]")
        self.btn_back_10 = _btn("<10", "Back 10 writes  [Shift+Left]")
        self.btn_fwd_10  = _btn("10>", "Forward 10 writes  [Shift+Right]")
        for w in [self.btn_back_1, self.btn_fwd_1, self.btn_back_10, self.btn_fwd_10, _separator()]:
            btn_row.addWidget(w)

        # Group 3: time steps (1s, 1m, 5m)
        self.btn_back_1s = _btn("<1s",  "Back 1 second  [Ctrl+Left]")
        self.btn_fwd_1s  = _btn("1s>",  "Forward 1 second  [Ctrl+Right]")
        self.btn_back_1m = _btn("<1m",  "Back 1 minute")
        self.btn_fwd_1m  = _btn("1m>",  "Forward 1 minute")
        self.btn_back_5m = _btn("<5m",  "Back 5 minutes")
        self.btn_fwd_5m  = _btn("5m>",  "Forward 5 minutes")
        for w in [self.btn_back_1s, self.btn_fwd_1s,
                  self.btn_back_1m, self.btn_fwd_1m,
                  self.btn_back_5m, self.btn_fwd_5m, _separator()]:
            btn_row.addWidget(w)

        # Group 4: LCD change navigation
        self.btn_prev_lcd = _btn("<LCD", "Previous LCD screen change  [[]", width=44)
        self.btn_next_lcd = _btn("LCD>", "Next LCD screen change  []]",    width=44)
        for w in [self.btn_prev_lcd, self.btn_next_lcd, _separator()]:
            btn_row.addWidget(w)

        # Group 5: selected address navigation
        self.btn_prev_sel = _btn("<Sel", "Previous write to selected address(es)  [Alt+Left]",  width=42)
        self.btn_next_sel = _btn("Sel>", "Next write to selected address(es)  [Alt+Right]", width=42)
        for w in [self.btn_prev_sel, self.btn_next_sel, _separator()]:
            btn_row.addWidget(w)

        # Group 6: bookmarks
        self.btn_add_bookmark  = _btn("+Bk", "Add/remove bookmark at current tick  [B]")
        self.btn_prev_bookmark = _btn("<Bk", "Previous bookmark  [Ctrl+Left]")
        self.btn_next_bookmark = _btn("Bk>", "Next bookmark  [Ctrl+Right]")
        for w in [self.btn_add_bookmark, self.btn_prev_bookmark, self.btn_next_bookmark]:
            btn_row.addWidget(w)

        btn_row.addStretch()
        layout.addLayout(btn_row)

        # --- Row 3: status ---
        self.status_label = QLabel("Tick: 0 | Time: 0.0s | Step: 0 of 0")
        self.status_label.setStyleSheet("color: #aaa; font-size: 11px;")
        layout.addWidget(self.status_label)

    def update_status(self, tick, min_tick, cursor, total, diff_count,
                      segment_index=None, loaded_count=None, total_segments=None,
                      memory_mb=None):
        elapsed = tick - min_tick
        total_secs = elapsed / TICK_FREQUENCY
        if total_secs >= 3600:
            h = int(total_secs // 3600)
            m = int((total_secs % 3600) // 60)
            s = total_secs % 60
            time_str = f"{h}h {m:02d}m {s:04.1f}s"
        elif total_secs >= 60:
            m = int(total_secs // 60)
            s = total_secs % 60
            time_str = f"{m}m {s:04.1f}s"
        else:
            time_str = f"{total_secs:.1f}s"

        parts = [
            f"Tick: {tick:,}",
            f"Time: {time_str}",
            f"Write: #{cursor:,}/{total:,}",
            f"Diff: {diff_count}",
        ]
        if segment_index is not None and total_segments is not None:
            parts.append(f"Seg: {segment_index}/{total_segments-1} ({loaded_count} loaded)")
        if memory_mb is not None:
            parts.append(f"Mem: {memory_mb:.0f}MB")
        self.status_label.setText(" | ".join(parts))


# ===========================================================================
# SegmentLoadWorker
# ===========================================================================

class SegmentLoadWorker(QThread):
    """Background thread to load a single segment without blocking the UI."""
    finished = pyqtSignal(int)   # emits segment_index on completion
    progress = pyqtSignal(int, str)

    def __init__(self, stream, segment_index, parent=None):
        super().__init__(parent)
        self._stream = stream
        self._segment_index = segment_index

    def run(self):
        def prog(pct, msg):
            self.progress.emit(pct or 0, msg)
        self._stream.load_segment(self._segment_index, prog)
        self.finished.emit(self._segment_index)


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

        # Load bookmark store first so we can pre-load bookmark segments
        self.annotation_store = AnnotationStore(filepath)
        self.bookmark_store = BookmarkStore(filepath)

        stream_progress(0, "Parsing stream file...")
        self.stream = open_stream(filepath, progress_callback=stream_progress,
                                  bookmark_ticks=self.bookmark_store.ticks or None)

        stream_progress(50, "Building write index...")
        self.tracker = CachedStateTracker(self.stream, progress_callback=stream_progress)

        # Tick marking state
        self._marked_ticks = self.bookmark_store.ticks  # sorted list, loaded from disk
        self._mark_cursor = -1    # cycling index
        self._bookmark_ram_cache = {}  # tick -> bytes(320) RAM snapshot

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

        # Pre-populate RAM cache for bookmarks loaded from disk
        if self._marked_ticks:
            stream_progress(98, f"Caching {len(self._marked_ticks)} bookmarks...")
            for tick in self._marked_ticks:
                self.tracker.seek(tick)
                self._bookmark_ram_cache[tick] = self.tracker.ram
            self.tracker.seek(self.min_tick)

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
        """Combine in-stream markers + sidecar annotation markers + bookmarks."""
        markers = list(self.annotation_markers) + list(self.button_markers)
        for ann in self.annotation_store.all():
            markers.append((ann["tick"], QColor(100, 150, 255), ann["text"], "tall_line"))
        for tick in self._marked_ticks:
            markers.append((tick, QColor(255, 0, 255), "Bookmark", "tall_line"))
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
        self.launch_btn.setToolTip("Launch PC simulator at current tick  [L]")
        self.launch_btn.clicked.connect(self._launch_sim)
        left_layout.addWidget(self.launch_btn)

        self.tamatool_btn = QPushButton("Open in TamaTool (T)")
        self.tamatool_btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        self.tamatool_btn.setToolTip("Load current memory state into TamaTool live editor  [T]")
        self.tamatool_btn.clicked.connect(self._launch_tamatool)
        if sys.platform == "win32":
            self.tamatool_btn.setVisible(False)
        left_layout.addWidget(self.tamatool_btn)

        self.export_tt_btn = QPushButton("Export TamaTool Save")
        self.export_tt_btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        self.export_tt_btn.setToolTip(
            "Export current RAM as a TamaTool-compatible save file (.bin)\n"
            "CPU registers will be zeroed; RAM will reflect the current tick."
        )
        self.export_tt_btn.clicked.connect(self._export_tamatool_save)
        left_layout.addWidget(self.export_tt_btn)

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
        white_btn_style = "background-color: white; color: black; border: 1px solid #999; padding: 2px 6px;"
        hex_btn_tooltips = {
            "+ Row": "Show one more row of memory  [+/=]",
            "- Row": "Show one fewer row of memory  [-/_]",
            "Show all": "Show all 640 nibbles  [M]",
            "Default": "Show compact 4-row view  [M]",
        }
        for text, handler in [("+ Row", self._hex_expand),
                              ("- Row", self._hex_collapse),
                              ("Show all", self._hex_show_all),
                              ("Default", self._hex_show_default)]:
            btn = QPushButton(text)
            btn.setFixedWidth(60)
            btn.setFocusPolicy(Qt.FocusPolicy.NoFocus)
            btn.setStyleSheet(white_btn_style)
            btn.setToolTip(hex_btn_tooltips[text])
            btn.clicked.connect(handler)
            hex_header.addWidget(btn)
        self.btn_clear_selection = QPushButton("Clear Sel")
        self.btn_clear_selection.setFixedWidth(70)
        self.btn_clear_selection.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        self.btn_clear_selection.setStyleSheet(white_btn_style)
        self.btn_clear_selection.setToolTip("Clear all selected addresses  [Escape]")
        self.btn_clear_selection.clicked.connect(self._hex_clear_selection)
        hex_header.addWidget(self.btn_clear_selection)
        center_layout.addLayout(hex_header)

        # Hex grid + diff column side by side
        hex_row = QHBoxLayout()
        self.hex_grid = MemoryGridWidget()
        hex_row.addWidget(self.hex_grid)

        # Diff column (right side, scrollable vertical list of changed addresses)
        self.diff_column = QLabel("")
        self.diff_column.setWordWrap(False)
        self.diff_column.setAlignment(Qt.AlignmentFlag.AlignTop | Qt.AlignmentFlag.AlignLeft)
        self.diff_column.setStyleSheet(
            "color: #ffd700; font-family: Consolas; font-size: 11px; "
            "background-color: #1e1e1e; padding: 4px;"
        )
        diff_scroll = QScrollArea()
        diff_scroll.setWidget(self.diff_column)
        diff_scroll.setWidgetResizable(True)
        diff_scroll.setMinimumWidth(190)
        diff_scroll.setMaximumWidth(260)
        diff_scroll.setStyleSheet("QScrollArea { background-color: #1e1e1e; border: none; }")
        hex_row.addWidget(diff_scroll)

        center_layout.addLayout(hex_row)
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
        self._lcd_popup = LcdPopupWidget()
        self.timeline_widget._stream = self.stream
        self.timeline_widget._lcd_popup = self._lcd_popup
        # Populate segment info for segmented streams
        if isinstance(self.stream, SegmentedTamStream):
            segs = [(s.start_tick, s.end_tick, s.loaded) for s in self.stream.segments]
            self.timeline_widget.set_segments(segs)
            self.timeline_widget._on_load_segment = self._on_load_segment
            self.timeline_widget._on_unload_segment = self._on_unload_segment
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
        self.nav_bar.btn_back_1m.clicked.connect(lambda: self._nav_step_time(-60))
        self.nav_bar.btn_fwd_1m.clicked.connect(lambda: self._nav_step_time(60))
        self.nav_bar.btn_back_5m.clicked.connect(lambda: self._nav_step_time(-300))
        self.nav_bar.btn_fwd_5m.clicked.connect(lambda: self._nav_step_time(300))
        self.nav_bar.btn_play.clicked.connect(self._toggle_play)
        self.nav_bar.btn_prev_lcd.clicked.connect(self._nav_prev_lcd_change)
        self.nav_bar.btn_next_lcd.clicked.connect(self._nav_next_lcd_change)
        self.nav_bar.btn_prev_sel.clicked.connect(self._nav_prev_selected_change)
        self.nav_bar.btn_next_sel.clicked.connect(self._nav_next_selected_change)
        self.nav_bar.btn_add_bookmark.clicked.connect(self._toggle_mark)
        self.nav_bar.btn_prev_bookmark.clicked.connect(lambda: self._cycle_marks(-1))
        self.nav_bar.btn_next_bookmark.clicked.connect(lambda: self._cycle_marks(1))

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

    def _nav_prev_lcd_change(self):
        self._stop_play()
        tick = self.stream.prev_lcd_change(self.current_tick)
        if tick is not None:
            ram_before = self.tracker.ram
            self.tracker.seek(tick)
            self.current_tick = tick
            custom_diff = self._compute_ram_diff(ram_before, self.tracker.ram)
            self._update_display(custom_diff=custom_diff)

    def _nav_next_lcd_change(self):
        self._stop_play()
        tick = self.stream.next_lcd_change(self.current_tick)
        if tick is not None:
            ram_before = self.tracker.ram
            self.tracker.seek(tick)
            self.current_tick = tick
            custom_diff = self._compute_ram_diff(ram_before, self.tracker.ram)
            self._update_display(custom_diff=custom_diff)

    def _nav_prev_selected_change(self):
        """Jump to previous write affecting any selected address."""
        self._stop_play()
        addrs = self.hex_grid.selected_addresses()
        if not addrs:
            self.nav_bar.status_label.setText("No addresses selected — click hex grid cells first")
            return
        tick = self.tracker.prev_write_to_addrs(addrs)
        if tick is not None:
            ram_before = self.tracker.ram
            self.tracker.seek(tick)
            self.current_tick = tick
            custom_diff = self._compute_ram_diff(ram_before, self.tracker.ram)
            self._update_display(custom_diff=custom_diff)

    def _nav_next_selected_change(self):
        """Jump to next write affecting any selected address."""
        self._stop_play()
        addrs = self.hex_grid.selected_addresses()
        if not addrs:
            self.nav_bar.status_label.setText("No addresses selected — click hex grid cells first")
            return
        tick = self.tracker.next_write_to_addrs(addrs)
        if tick is not None:
            ram_before = self.tracker.ram
            self.tracker.seek(tick)
            self.current_tick = tick
            custom_diff = self._compute_ram_diff(ram_before, self.tracker.ram)
            self._update_display(custom_diff=custom_diff)

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

    def _hex_clear_selection(self):
        self.hex_grid.clear_selection()

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

    def _update_display(self, custom_diff=None):
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
        diff = custom_diff if custom_diff is not None else self.tracker.last_diff
        self.hex_grid.set_state(ram, diff)

        # Diff column (vertical list, one per line)
        if diff:
            lines = []
            for addr in sorted(diff.keys()):
                old_v, new_v = diff[addr]
                field_info = ADDR_COLOR_MAP.get(addr)
                if field_info:
                    lines.append(f"0x{addr:03X} {field_info[0]}  {old_v:X}\u2192{new_v:X}")
                else:
                    lines.append(f"0x{addr:03X}  {old_v:X}\u2192{new_v:X}")
            self.diff_column.setText(f"{len(diff)} changed:\n" + "\n".join(lines))
        else:
            self.diff_column.setText("")

        # LCD — use tracker's segment index for correct wraparound-aware lookup
        seg_idx = self.tracker.current_segment_idx
        if isinstance(self.stream, SegmentedTamStream):
            frame = self.stream.nearest_lcd_frame(self.current_tick, seg_idx=seg_idx)
        else:
            frame = self.stream.nearest_lcd_frame(self.current_tick)
        if frame:
            self.lcd_widget.set_frame(frame[1])
        else:
            self.lcd_widget.set_frame(None)

        # Nav status — include segment info for segmented streams
        seg_kwargs = {}
        if isinstance(self.stream, SegmentedTamStream) and self.stream.segments:
            # Use tracker's cursor-based segment index (correct for wrapped ticks)
            if seg_idx is None:
                seg_idx = self.stream.segment_for_tick(self.current_tick)
            seg_kwargs = {
                "segment_index": seg_idx,
                "loaded_count": self.stream.loaded_segment_count,
                "total_segments": len(self.stream.segments),
                "memory_mb": self.stream.estimated_memory_bytes / (1024 * 1024),
            }
        self.nav_bar.update_status(
            self.current_tick, self.min_tick,
            self.tracker.write_cursor, self.tracker.total_writes,
            len(self.tracker.last_diff),
            **seg_kwargs,
        )

        self._update_annotation_list()

    # --- Segment load / unload (right-click from timeline) ---

    def _on_load_segment(self, seg_index):
        """Spawn a background worker to load a segment; update UI on completion."""
        if not isinstance(self.stream, SegmentedTamStream):
            return
        if self.stream.is_segment_loaded(seg_index):
            return
        worker = SegmentLoadWorker(self.stream, seg_index, self)
        worker.finished.connect(self._on_segment_load_finished)
        worker.progress.connect(lambda pct, msg: self.nav_bar.status_label.setText(
            f"Loading seg {seg_index}: {msg}"))
        worker.start()
        # Keep reference to prevent GC
        if not hasattr(self, '_segment_workers'):
            self._segment_workers = []
        self._segment_workers.append(worker)

    def _on_segment_load_finished(self, seg_index):
        """Called when a segment finishes loading."""
        self.tracker.add_segment_writes(seg_index)
        # Update timeline
        self.timeline_widget.update_segment_loaded(seg_index, True)
        self._update_display()

    def _on_unload_segment(self, seg_index):
        """Unload a segment — refuse if it contains bookmarks."""
        if not isinstance(self.stream, SegmentedTamStream):
            return
        seg = self.stream.segments[seg_index]
        # Check for bookmarks in this segment
        for tick in self._marked_ticks:
            if seg.start_tick <= tick <= seg.end_tick:
                QMessageBox.warning(self, "Cannot Unload",
                                    f"Segment {seg_index} contains a bookmark at tick {tick:,}.\n"
                                    f"Remove the bookmark first.")
                return
        self.tracker.remove_segment_writes(seg_index)
        self.stream.unload_segment(seg_index)
        self.timeline_widget.update_segment_loaded(seg_index, False)
        self._update_display()

    @staticmethod
    def _compute_ram_diff(ram_a, ram_b):
        """Compare two 320-byte RAMs, return {nibble_addr: (old_val, new_val)} for differences."""
        diff = {}
        for byte_idx in range(min(len(ram_a), len(ram_b))):
            if ram_a[byte_idx] != ram_b[byte_idx]:
                # High nibble (even address)
                addr_hi = byte_idx * 2
                old_hi = (ram_a[byte_idx] & 0xF0) >> 4
                new_hi = (ram_b[byte_idx] & 0xF0) >> 4
                if old_hi != new_hi:
                    diff[addr_hi] = (old_hi, new_hi)
                # Low nibble (odd address)
                addr_lo = byte_idx * 2 + 1
                old_lo = ram_a[byte_idx] & 0x0F
                new_lo = ram_b[byte_idx] & 0x0F
                if old_lo != new_lo:
                    diff[addr_lo] = (old_lo, new_lo)
        return diff

    def _toggle_mark(self):
        """Toggle a bookmark at the current tick."""
        tick = self.current_tick
        now_bookmarked = self.bookmark_store.toggle(tick)
        if now_bookmarked:
            bisect.insort(self._marked_ticks, tick)
            # Cache RAM at this tick
            self._bookmark_ram_cache[tick] = self.tracker.ram
        else:
            idx = bisect.bisect_left(self._marked_ticks, tick)
            if idx < len(self._marked_ticks) and self._marked_ticks[idx] == tick:
                self._marked_ticks.pop(idx)
            self._bookmark_ram_cache.pop(tick, None)
            # Adjust cursor
            if self._mark_cursor >= len(self._marked_ticks):
                self._mark_cursor = len(self._marked_ticks) - 1
        self._refresh_markers()

    def _refresh_markers(self):
        """Rebuild timeline markers including bookmarks."""
        self.timeline_widget.set_markers(self._get_all_markers())

    def _cycle_marks(self, direction):
        """Cycle through bookmarks. direction: +1 or -1."""
        if not self._marked_ticks:
            # Fall back to ±1 second
            self._nav_step_time(direction)
            return

        self._stop_play()
        ram_before = self.tracker.ram

        self._mark_cursor += direction
        # Wrap
        if self._mark_cursor >= len(self._marked_ticks):
            self._mark_cursor = 0
        elif self._mark_cursor < 0:
            self._mark_cursor = len(self._marked_ticks) - 1

        target_tick = self._marked_ticks[self._mark_cursor]

        # Use cached RAM if available (instant), otherwise seek (slow)
        if target_tick in self._bookmark_ram_cache:
            self.tracker._ram = bytearray(self._bookmark_ram_cache[target_tick])
            self.tracker._current_tick = target_tick
            # Sync write cursor via binary search
            import bisect as _bisect
            self.tracker._write_cursor = _bisect.bisect_right(
                self.tracker._write_ticks, target_tick)
            self.tracker._last_diff = {}
        else:
            self.tracker.seek(target_tick)
            # Cache it now for next time
            self._bookmark_ram_cache[target_tick] = self.tracker.ram

        self.current_tick = target_tick
        ram_after = self.tracker.ram
        custom_diff = self._compute_ram_diff(ram_before, ram_after)
        self._update_display(custom_diff=custom_diff)

    @staticmethod
    def _build_savestate_bytes(ram_320, tick):
        """Build a 385-byte savestate: 1 byte magic + 64 bytes cpu_state_t + 320 bytes RAM."""
        magic = b'\x12'
        # cpu_state_t is 64 bytes, mostly zeros
        # Offset 12: tick_counter (uint32)
        # Offset 16: clk_timer_timestamp (uint32)
        # Offset 20: prog_timer_timestamp (uint32)
        cpu_state = bytearray(64)
        struct.pack_into("<I", cpu_state, 12, tick)
        struct.pack_into("<I", cpu_state, 16, tick)
        struct.pack_into("<I", cpu_state, 20, tick)
        return magic + bytes(cpu_state) + bytes(ram_320)

    def _launch_sim(self):
        ram = self.tracker.ram
        tick = self.current_tick
        savestate = self._build_savestate_bytes(ram, tick)

        # Find the exe relative to project root
        project_root = os.path.normpath(os.path.join(os.path.dirname(__file__), ".."))
        exe_path = os.path.join(project_root, "pc", "build", "tamagotchi_pc.exe")
        if not os.path.exists(exe_path):
            QMessageBox.warning(self, "Sim Not Found",
                                f"Could not find:\n{exe_path}\n\nBuild the PC simulator first.")
            return

        try:
            tmp = tempfile.NamedTemporaryFile(suffix=".bin", delete=False, prefix="tama_launch_")
            tmp.write(savestate)
            tmp.close()
            subprocess.Popen([exe_path, "--load-state", tmp.name])
        except Exception as e:
            QMessageBox.warning(self, "Launch Failed", f"Error launching sim:\n{e}")

    # --- TamaTool integration ---

    _SETTINGS_FILE = os.path.join(os.path.dirname(__file__), "viewer_settings.json")

    def _load_tamatool_path(self):
        """Return saved TamaTool exe path, or None."""
        try:
            import json
            with open(self._SETTINGS_FILE, "r") as f:
                return json.load(f).get("tamatool_exe")
        except Exception:
            return None

    def _save_tamatool_path(self, path):
        import json
        settings = {}
        try:
            with open(self._SETTINGS_FILE, "r") as f:
                settings = json.load(f)
        except Exception:
            pass
        settings["tamatool_exe"] = path
        with open(self._SETTINGS_FILE, "w") as f:
            json.dump(settings, f, indent=2)

    def _launch_tamatool(self):
        """Write raw RAM to a temp file and launch TamaTool with it."""
        exe_path = self._load_tamatool_path()

        # Locate exe if not saved or missing
        if not exe_path or not os.path.exists(exe_path):
            exe_path, _ = QFileDialog.getOpenFileName(
                self, "Locate TamaTool Executable", "",
                "Executables (*.exe);;All files (*)"
            )
            if not exe_path:
                return
            self._save_tamatool_path(exe_path)

        # Write raw 320-byte RAM to temp file
        ram = self.tracker.ram
        try:
            tmp = tempfile.NamedTemporaryFile(
                suffix=".bin", delete=False, prefix="tama_tt_ram_")
            tmp.write(ram)
            tmp.close()
            subprocess.Popen([exe_path, tmp.name])
        except Exception as e:
            QMessageBox.warning(self, "TamaTool Launch Failed",
                                f"Error launching TamaTool:\n{e}\n\n"
                                f"Exe: {exe_path}\n"
                                f"Raw 320-byte RAM written to: {tmp.name}")

    @staticmethod
    def _build_tamatool_savestate(ram_320: bytes, tick: int) -> bytes:
        """Build a TamaTool-compatible save state binary (4140 bytes).

        Format (reverse-engineered from save0.bin):
          Bytes  0- 1: pc        (u16 LE) — zeroed (reset-like state)
          Bytes  2- 3: x         (u16 LE) — zeroed
          Bytes  4- 5: y         (u16 LE) — zeroed
          Byte   6   : a         (u8)     — zeroed
          Byte   7   : b         (u8)     — zeroed
          Byte   8   : np        (u8)     — zeroed
          Byte   9   : sp        (u8)     — 0xFC (typical init)
          Byte  10   : flags     (u8)     — zeroed
          Bytes 11-14: tick_counter (u32 LE) — set to captured tick
          Bytes 15-18: prog_timer_timestamp (u32 LE) — zeroed
          Byte  19   : prog_timer_enabled (u8) — 0
          Byte  20   : prog_timer_data    (u8) — 0
          Byte  21   : prog_timer_rld     (u8) — 0
          Bytes 22-25: call_depth (u32 LE) — zeroed
          Bytes 26-43: 6 interrupt slots × 3 bytes (factor, mask, triggered) — zeroed
          Bytes 44-4139: 4096 nibble bytes (1 nibble per byte, 0-15)
            nibble[0x000..0x27F] = unpacked from ram_320 (640 nibbles)
            nibble[0x280..0xFFF] = 0x00 (unused/IO region)
        """
        import struct

        out = bytearray(4140)
        # CPU registers
        struct.pack_into('<H', out, 0, 0)       # pc = 0
        struct.pack_into('<H', out, 2, 0)       # x = 0
        struct.pack_into('<H', out, 4, 0)       # y = 0
        out[6] = 0                              # a
        out[7] = 0                              # b
        out[8] = 0                              # np
        out[9] = 0xFC                           # sp (typical initial value)
        out[10] = 0                             # flags
        # Timers
        struct.pack_into('<I', out, 11, tick & 0xFFFFFFFF)  # tick_counter
        struct.pack_into('<I', out, 15, 0)      # prog_timer_timestamp
        out[19] = 0                             # prog_timer_enabled
        out[20] = 0                             # prog_timer_data
        out[21] = 0                             # prog_timer_rld
        struct.pack_into('<I', out, 22, 0)      # call_depth
        # Interrupts (bytes 26-43): all zero
        # Memory dump: 4096 nibble-bytes starting at offset 44
        for addr in range(640):                 # RAM nibbles 0x000-0x27F
            byte_idx = addr >> 1
            if byte_idx < len(ram_320):
                if (addr & 1) == 0:
                    nibble = (ram_320[byte_idx] >> 4) & 0x0F
                else:
                    nibble = ram_320[byte_idx] & 0x0F
            else:
                nibble = 0
            out[44 + addr] = nibble
        # Addresses 0x280-0xFFF remain zero (already zeroed)
        return bytes(out)

    def _export_tamatool_save(self):
        """Export current state as a TamaTool-compatible save file."""
        ram = self.tracker.ram
        tick = self.current_tick
        data = self._build_tamatool_savestate(ram, tick)

        default_name = f"save_tick{tick}.bin"
        path, _ = QFileDialog.getSaveFileName(
            self, "Export TamaTool Save", default_name,
            "Binary files (*.bin);;All files (*)"
        )
        if not path:
            return
        try:
            with open(path, "wb") as f:
                f.write(data)
        except Exception as e:
            QMessageBox.warning(self, "Export Failed", f"Could not write file:\n{e}")

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

        if key == Qt.Key.Key_Escape:
            self.hex_grid.clear_selection()
            return

        if key == Qt.Key.Key_Left:
            if mods & Qt.KeyboardModifier.AltModifier:
                self._nav_prev_selected_change()
            elif mods & Qt.KeyboardModifier.ControlModifier:
                self._cycle_marks(-1)
            elif mods & Qt.KeyboardModifier.ShiftModifier:
                self._nav_step(-10)
            else:
                self._nav_step(-1)
        elif key == Qt.Key.Key_Right:
            if mods & Qt.KeyboardModifier.AltModifier:
                self._nav_next_selected_change()
            elif mods & Qt.KeyboardModifier.ControlModifier:
                self._cycle_marks(1)
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
        elif key == Qt.Key.Key_T and sys.platform != "win32":
            self._launch_tamatool()
        elif key == Qt.Key.Key_B:
            self._toggle_mark()
        elif key == Qt.Key.Key_M:
            if self.hex_grid.visible_rows == MemoryGridWidget.MAX_ROWS:
                self.hex_grid.show_default()
            else:
                self.hex_grid.show_all()
        elif key in (Qt.Key.Key_Plus, Qt.Key.Key_Equal):
            self.hex_grid.expand_one()
        elif key in (Qt.Key.Key_Minus, Qt.Key.Key_Underscore):
            self.hex_grid.collapse_one()
        elif key == Qt.Key.Key_BracketLeft:
            self._nav_prev_lcd_change()
        elif key == Qt.Key.Key_BracketRight:
            self._nav_next_lcd_change()
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
    app.setStyleSheet("QToolTip { background-color: white; color: black; border: 1px solid #999; padding: 4px; }")
    viewer = StreamViewer(filepath, app=app)
    viewer.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
