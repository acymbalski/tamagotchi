import sys
import os
import json
import subprocess
import time
from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, 
                             QLabel, QLineEdit, QComboBox, QTextEdit, QPushButton, QScrollArea, QFileDialog)
from PyQt6.QtGui import QPixmap, QImage
from PyQt6.QtCore import Qt, QTimer, QFileSystemWatcher

# Constants based on the plan and C++ code
SIM_EXE = os.path.join("pc", "build", "tamagotchi_pc.exe")
CAPTURES_DIR = "captures"
ANNOTATIONS_FILE = "annotations.json"
MEMORY_SIZE_BYTES = 0x140

class Investigator(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Tamagotchi Investigation Lab")
        self.resize(1000, 700)
        
        self.snapshots = []
        self.current_index = -1
        self.annotations = {}
        self.pre_populated_values = {}
        self.sim_process = None
        
        self.init_ui()
        self.load_annotations()
        self.refresh_snapshots()
        
        # Watch for new snapshots
        self.watcher = QFileSystemWatcher()
        if not os.path.exists(CAPTURES_DIR):
            os.makedirs(CAPTURES_DIR)
        self.watcher.addPath(CAPTURES_DIR)
        self.watcher.directoryChanged.connect(self.refresh_snapshots)

    def init_ui(self):
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QHBoxLayout(central_widget)

        # Left side: Snapshot view and list
        left_panel = QVBoxLayout()
        
        self.status_label = QLabel("Ready")
        left_panel.addWidget(self.status_label)
        
        self.image_label = QLabel("No snapshot selected")
        self.image_label.setFixedSize(640, 320)
        self.image_label.setStyleSheet("border: 1px solid black; background: #eee;")
        self.image_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        left_panel.addWidget(self.image_label)
        
        controls_layout = QHBoxLayout()
        self.btn_prev = QPushButton("Previous")
        self.btn_prev.clicked.connect(self.prev_snapshot)
        self.btn_next = QPushButton("Next")
        self.btn_next.clicked.connect(self.next_snapshot)
        controls_layout.addWidget(self.btn_prev)
        controls_layout.addWidget(self.btn_next)
        left_panel.addLayout(controls_layout)

        self.btn_turbo = QPushButton("Start Turbo Sim (Collect)")
        self.btn_turbo.clicked.connect(self.start_turbo_sim)
        left_panel.addWidget(self.btn_turbo)

        self.btn_live = QPushButton("Investigate Live (1x)")
        self.btn_live.clicked.connect(self.start_live_sim)
        left_panel.addWidget(self.btn_live)

        main_layout.addLayout(left_panel, stretch=2)

        # Right side: Annotation form
        right_panel = QVBoxLayout()
        
        form_layout = QVBoxLayout()
        
        form_layout.addWidget(QLabel("Stage:"))
        self.combo_stage = QComboBox()
        self.combo_stage.addItems(["Unknown", "Egg", "Baby", "Child", "Teen", "Adult", "Senior", "Angel"])
        form_layout.addWidget(self.combo_stage)
        
        form_layout.addWidget(QLabel("Hunger (0-4):"))
        self.edit_hunger = QLineEdit()
        form_layout.addWidget(self.edit_hunger)
        
        form_layout.addWidget(QLabel("Happiness (0-4):"))
        self.edit_happy = QLineEdit()
        form_layout.addWidget(self.edit_happy)

        form_layout.addWidget(QLabel("Discipline:"))
        self.edit_discipline = QLineEdit()
        form_layout.addWidget(self.edit_discipline)
        
        form_layout.addWidget(QLabel("Poop (0-4):"))
        self.edit_poop = QLineEdit()
        form_layout.addWidget(self.edit_poop)
        
        form_layout.addWidget(QLabel("Sick:"))
        self.combo_sick = QComboBox()
        self.combo_sick.addItems(["Unsure", "No", "Yes"])
        form_layout.addWidget(self.combo_sick)

        form_layout.addWidget(QLabel("Sleeping:"))
        self.combo_sleeping = QComboBox()
        self.combo_sleeping.addItems(["Unsure", "No", "Yes"])
        form_layout.addWidget(self.combo_sleeping)

        form_layout.addWidget(QLabel("Time (HH:MM:SS AM/PM):"))
        time_layout = QHBoxLayout()
        self.edit_time_h = QLineEdit(); self.edit_time_h.setPlaceholderText("HH")
        self.edit_time_m = QLineEdit(); self.edit_time_m.setPlaceholderText("MM")
        self.edit_time_s = QLineEdit(); self.edit_time_s.setPlaceholderText("SS")
        self.combo_ampm = QComboBox(); self.combo_ampm.addItems(["AM", "PM"])
        time_layout.addWidget(self.edit_time_h)
        time_layout.addWidget(self.edit_time_m)
        time_layout.addWidget(self.edit_time_s)
        time_layout.addWidget(self.combo_ampm)
        form_layout.addLayout(time_layout)

        form_layout.addWidget(QLabel("Screen:"))
        self.combo_screen = QComboBox()
        self.combo_screen.addItems(["Main", "Feeding", "Gaming", "Stats", "Angel", "Clock", "Other"])
        form_layout.addWidget(self.combo_screen)

        form_layout.addWidget(QLabel("Weight (oz):"))
        self.edit_weight = QLineEdit()
        form_layout.addWidget(self.edit_weight)

        form_layout.addWidget(QLabel("Age (years):"))
        self.edit_age = QLineEdit()
        form_layout.addWidget(self.edit_age)

        form_layout.addWidget(QLabel("Notes:"))
        self.text_notes = QTextEdit()
        form_layout.addWidget(self.text_notes)
        
        right_panel.addLayout(form_layout)
        
        self.btn_save = QPushButton("Save Annotation")
        self.btn_save.clicked.connect(self.save_current_annotation)
        right_panel.addWidget(self.btn_save)
        
        main_layout.addLayout(right_panel, stretch=1)

        # Bottom Status Bar
        self.status_bar = self.statusBar()
        self.capture_count_label = QLabel("Captures: 0")
        self.status_bar.addPermanentWidget(self.capture_count_label)

    def load_annotations(self):
        if os.path.exists(ANNOTATIONS_FILE):
            try:
                with open(ANNOTATIONS_FILE, 'r') as f:
                    self.annotations = json.load(f)
            except:
                self.annotations = {}

    def save_annotations(self):
        with open(ANNOTATIONS_FILE, 'w') as f:
            json.dump(self.annotations, f, indent=2)

    def refresh_snapshots(self):
        files = [f for f in os.listdir(CAPTURES_DIR) if f.endswith(".bmp")]
        # Sort by timestamp in filename
        files.sort()
        
        new_snapshots = [f.replace(".bmp", "") for f in files]
        if new_snapshots != self.snapshots:
            self.snapshots = new_snapshots
            if self.current_index == -1 and self.snapshots:
                self.set_snapshot(0)
            
            count_text = f"Captures: {len(self.snapshots)}/100"
            self.status_label.setText(count_text)
            self.capture_count_label.setText(count_text)
            
            # Auto-pause sim if we hit 100
            if len(self.snapshots) >= 100 and self.sim_process:
                self.sim_process.terminate()
                self.sim_process = None
                self.status_label.setText("Snapshots: 100/100 (PAUSED)")

    def set_snapshot(self, index):
        if 0 <= index < len(self.snapshots):
            # Save current before moving
            if self.current_index != -1:
                self.save_current_annotation()
            
            self.current_index = index
            name = self.snapshots[index]
            bmp_path = os.path.join(CAPTURES_DIR, name + ".bmp")
            
            pixmap = QPixmap(bmp_path)
            self.image_label.setPixmap(pixmap.scaled(self.image_label.size(), Qt.AspectRatioMode.KeepAspectRatio))
            
            self.load_snapshot_data(name)

    def load_snapshot_data(self, name):
        # Reset fields
        self.combo_stage.setCurrentIndex(0)
        self.edit_hunger.clear()
        self.edit_happy.clear()
        self.edit_discipline.clear()
        self.edit_poop.clear()
        self.combo_sick.setCurrentIndex(0)
        self.combo_sleeping.setCurrentIndex(0)
        self.edit_time_h.clear()
        self.edit_time_m.clear()
        self.edit_time_s.clear()
        self.combo_ampm.setCurrentIndex(0)
        self.combo_screen.setCurrentIndex(0)
        self.edit_weight.clear()
        self.edit_age.clear()
        self.text_notes.clear()
        
        self.pre_populated_values = {}

        if name in self.annotations:
            data = self.annotations[name]
            self.combo_stage.setCurrentText(data.get("stage", "Unknown"))
            self.edit_hunger.setText(str(data.get("hunger", "")))
            self.edit_happy.setText(str(data.get("happy", "")))
            self.edit_discipline.setText(str(data.get("discipline", "")))
            self.edit_poop.setText(str(data.get("poop", "")))
            self.combo_sick.setCurrentText("Yes" if data.get("sick") else ("No" if data.get("sick") == False else "Unsure"))
            self.combo_sleeping.setCurrentText("Yes" if data.get("sleeping") else ("No" if data.get("sleeping") == False else "Unsure"))
            
            time_data = data.get("time", {})
            self.edit_time_h.setText(str(time_data.get("h", "")))
            self.edit_time_m.setText(str(time_data.get("m", "")))
            self.edit_time_s.setText(str(time_data.get("s", "")))
            self.combo_ampm.setCurrentText(time_data.get("ampm", "AM"))
            
            self.combo_screen.setCurrentText(data.get("screen", "Main"))
            self.edit_weight.setText(str(data.get("weight", "")))
            self.edit_age.setText(str(data.get("age", "")))
            self.text_notes.setPlainText(data.get("notes", ""))
            
            # If there's a stored pre-population for this snapshot, load it for comparison
            self.pre_populated_values = data.get("pre_populated", {})
        else:
            # Pre-populate from binary
            bin_path = os.path.join(CAPTURES_DIR, name + ".bin")
            self.pre_populate(bin_path)

    def read_memory_nibble(self, mem_bytes, addr):
        byte_idx = addr >> 1
        if byte_idx >= len(mem_bytes): return 0
        val = mem_bytes[byte_idx]
        if (addr & 1) == 0:
            return (val & 0xF0) >> 4
        else:
            return val & 0x0F

    def read_memory_bcd(self, mem_bytes, addr_ones, addr_tens):
        ones = self.read_memory_nibble(mem_bytes, addr_ones)
        tens = self.read_memory_nibble(mem_bytes, addr_tens)
        return tens * 10 + ones

    def pre_populate(self, bin_path):
        if not os.path.exists(bin_path): return
        
        try:
            with open(bin_path, 'rb') as f:
                content = f.read()
                # Memory is the last 0x140 bytes
                mem = content[-MEMORY_SIZE_BYTES:]
                
                # Using guesses from babysitter.h
                h_val = self.read_memory_nibble(mem, 0x40)
                hunger = 4 if h_val == 0xF else h_val // 4
                self.edit_hunger.setText(str(hunger))
                
                ha_val = self.read_memory_nibble(mem, 0x41)
                happy = 4 if ha_val == 0xF else ha_val // 4
                self.edit_happy.setText(str(happy))

                disc = self.read_memory_nibble(mem, 0x43)
                self.edit_discipline.setText(str(disc))
                
                poop = self.read_memory_nibble(mem, 0x4D)
                self.edit_poop.setText(str(poop))
                
                sick_val = self.read_memory_nibble(mem, 0x48)
                self.combo_sick.setCurrentText("Yes" if sick_val >= 8 else "No")

                # Sleeping Guess: 0x4A (8-F is sleeping)
                sleep_val = self.read_memory_nibble(mem, 0x4A)
                is_sleeping = (sleep_val >= 8 and sleep_val <= 15)
                self.combo_sleeping.setCurrentText("Yes" if is_sleeping else "No")

                # Age Guess: 0x42
                age = self.read_memory_nibble(mem, 0x42)
                self.edit_age.setText(str(age))

                # Weight Guess: 0x38 (ones) 0x39 (tens) - BCD
                weight = self.read_memory_bcd(mem, 0x38, 0x39)
                self.edit_weight.setText(str(weight))

                # Time: 0x10-0x15
                sec = self.read_memory_bcd(mem, 0x10, 0x11)
                min = self.read_memory_bcd(mem, 0x12, 0x13)
                h_ones = self.read_memory_nibble(mem, 0x14)
                h_tens = self.read_memory_nibble(mem, 0x15)
                h24 = (h_tens << 4) | h_ones
                
                ampm = "AM"
                h12 = h24
                if h24 == 0: h12 = 12
                elif h24 == 12: ampm = "PM"
                elif h24 > 12:
                    h12 = h24 - 12
                    ampm = "PM"
                
                self.edit_time_h.setText(str(h12))
                self.edit_time_m.setText(f"{min:02d}")
                self.edit_time_s.setText(f"{sec:02d}")
                self.combo_ampm.setCurrentText(ampm)

                # Store pre-populated for later comparison
                self.pre_populated_values = {
                    "hunger": hunger,
                    "happy": happy,
                    "discipline": disc,
                    "poop": poop,
                    "sick": sick_val >= 8,
                    "sleeping": is_sleeping,
                    "age": age,
                    "weight": weight,
                    "time": {"h": h12, "m": min, "s": sec, "ampm": ampm}
                }

                # Egg check
                if self.read_memory_nibble(mem, 0x5D) == 0:
                    self.combo_stage.setCurrentText("Egg")
        except Exception as e:
            print(f"Error pre-populating: {e}")

    def save_current_annotation(self):
        if self.current_index == -1: return
        name = self.snapshots[self.current_index]
        
        current_data = {
            "stage": self.combo_stage.currentText(),
            "hunger": int(self.edit_hunger.text()) if self.edit_hunger.text().isdigit() else None,
            "happy": int(self.edit_happy.text()) if self.edit_happy.text().isdigit() else None,
            "discipline": int(self.edit_discipline.text()) if self.edit_discipline.text().isdigit() else None,
            "poop": int(self.edit_poop.text()) if self.edit_poop.text().isdigit() else None,
            "sick": True if self.combo_sick.currentText() == "Yes" else (False if self.combo_sick.currentText() == "No" else None),
            "sleeping": True if self.combo_sleeping.currentText() == "Yes" else (False if self.combo_sleeping.currentText() == "No" else None),
            "time": {
                "h": int(self.edit_time_h.text()) if self.edit_time_h.text().isdigit() else None,
                "m": int(self.edit_time_m.text()) if self.edit_time_m.text().isdigit() else None,
                "s": int(self.edit_time_s.text()) if self.edit_time_s.text().isdigit() else None,
                "ampm": self.combo_ampm.currentText()
            },
            "screen": self.combo_screen.currentText(),
            "weight": int(self.edit_weight.text()) if self.edit_weight.text().isdigit() else None,
            "age": int(self.edit_age.text()) if self.edit_age.text().isdigit() else None,
            "notes": self.text_notes.toPlainText(),
            "investigated": True,
            "pre_populated": self.pre_populated_values
        }

        # Detect modifications
        modified = []
        pre = self.pre_populated_values
        if pre:
            if current_data["hunger"] != pre.get("hunger"): modified.append("hunger")
            if current_data["happy"] != pre.get("happy"): modified.append("happy")
            if current_data["discipline"] != pre.get("discipline"): modified.append("discipline")
            if current_data["poop"] != pre.get("poop"): modified.append("poop")
            if current_data["sick"] != pre.get("sick"): modified.append("sick")
            if current_data["sleeping"] != pre.get("sleeping"): modified.append("sleeping")
            if current_data["age"] != pre.get("age"): modified.append("age")
            if current_data["weight"] != pre.get("weight"): modified.append("weight")
            
            # Time check
            cur_t = current_data["time"]
            pre_t = pre.get("time", {})
            if (cur_t["h"] != pre_t.get("h") or cur_t["m"] != pre_t.get("m") or 
                cur_t["s"] != pre_t.get("s") or cur_t["ampm"] != pre_t.get("ampm")):
                modified.append("time")

        current_data["modified_fields"] = modified
        
        self.annotations[name] = current_data
        self.save_annotations()

    def prev_snapshot(self):
        if self.current_index > 0:
            self.set_snapshot(self.current_index - 1)

    def next_snapshot(self):
        if self.current_index < len(self.snapshots) - 1:
            self.set_snapshot(self.current_index + 1)

    def start_turbo_sim(self):
        if self.sim_process:
            self.sim_process.terminate()
        
        # Start sim in turbo mode with auto-snapshotting every 5 min, NTP off
        cmd = [SIM_EXE, "--turbo", "--auto-snapshot", "5", "--no-ntp"]
        self.sim_process = subprocess.Popen(cmd)
        self.status_label.setText("Sim running (Turbo)...")

    def start_live_sim(self):
        if self.current_index == -1: return
        name = self.snapshots[self.current_index]
        bin_path = os.path.join(CAPTURES_DIR, name + ".bin")
        
        # Start sim at 1x speed loading this state, babysitter off, NTP off
        cmd = [SIM_EXE, "--load-state", bin_path, "--babysitter", "off", "--no-ntp"]
        subprocess.Popen(cmd)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = Investigator()
    window.show()
    sys.exit(app.exec())
