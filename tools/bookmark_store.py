"""JSON-backed bookmark store for .tamstream files.

Bookmarks are stored in a sidecar file (<stream>.bookmarks.json) alongside
the .tamstream binary. The binary is never modified.
"""

import json
import os


class BookmarkStore:
    """Persistent bookmark storage backed by a sidecar JSON file."""

    def __init__(self, stream_filepath):
        self._stream_filepath = stream_filepath
        self._sidecar = stream_filepath + ".bookmarks.json"
        self._ticks = []  # sorted list of tick values
        self.reload()

    @property
    def sidecar_path(self):
        return self._sidecar

    @property
    def ticks(self):
        """Sorted list of bookmarked ticks."""
        return list(self._ticks)

    def add(self, tick):
        """Add bookmark. Returns True if it was new."""
        import bisect
        idx = bisect.bisect_left(self._ticks, tick)
        if idx < len(self._ticks) and self._ticks[idx] == tick:
            return False
        bisect.insort(self._ticks, tick)
        self.save()
        return True

    def remove(self, tick):
        """Remove bookmark. Returns True if it existed."""
        import bisect
        idx = bisect.bisect_left(self._ticks, tick)
        if idx < len(self._ticks) and self._ticks[idx] == tick:
            self._ticks.pop(idx)
            self.save()
            return True
        return False

    def toggle(self, tick):
        """Toggle bookmark at tick. Returns True if now bookmarked."""
        import bisect
        idx = bisect.bisect_left(self._ticks, tick)
        if idx < len(self._ticks) and self._ticks[idx] == tick:
            self._ticks.pop(idx)
            self.save()
            return False
        bisect.insort(self._ticks, tick)
        self.save()
        return True

    def save(self):
        data = {
            "version": 1,
            "stream_file": os.path.basename(self._stream_filepath),
            "bookmarks": self._ticks,
        }
        with open(self._sidecar, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2)

    def reload(self):
        if os.path.exists(self._sidecar):
            with open(self._sidecar, "r", encoding="utf-8") as f:
                data = json.load(f)
            self._ticks = sorted(data.get("bookmarks", []))
        else:
            self._ticks = []
