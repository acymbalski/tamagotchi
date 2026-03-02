import sys
import os
import json
import subprocess
import time
import memory_config
from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, 
                             QLabel, QLineEdit, QComboBox, QTextEdit, QPushButton, QScrollArea, QFileDialog,
                             QCheckBox)
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
        self.resize(1000, 750)
        
        self.snapshots = []
        self.current_index = -1
        self.annotations = {}
        self.pre_populated_values = {}
        self.sim_process = None
        self.live_sim_process = None
        
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
        
        self.context_label = QLabel("No snapshot selected")
        self.context_label.setStyleSheet("font-weight: bold; color: #555;")
        left_panel.addWidget(self.context_label)
        
        self.image_label = QLabel("No snapshot selected")
        self.image_label.setFixedSize(640, 440)
        self.image_label.setStyleSheet("border: 1px solid black; background: #eee;")
        self.image_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        left_panel.addWidget(self.image_label)
        
        controls_layout = QHBoxLayout()
        
        self.btn_start = QPushButton("<<")
        self.btn_start.clicked.connect(lambda: self.set_snapshot(0))
        self.btn_prev_100 = QPushButton("-100")
        self.btn_prev_100.clicked.connect(lambda: self.skip_snapshot(-100))
        self.btn_prev_10 = QPushButton("-10")
        self.btn_prev_10.clicked.connect(lambda: self.skip_snapshot(-10))
        self.btn_prev = QPushButton("<")
        self.btn_prev.clicked.connect(self.prev_snapshot)
        
        self.btn_next = QPushButton(">")
        self.btn_next.clicked.connect(self.next_snapshot)
        self.btn_next_10 = QPushButton("+10")
        self.btn_next_10.clicked.connect(lambda: self.skip_snapshot(10))
        self.btn_next_100 = QPushButton("+100")
        self.btn_next_100.clicked.connect(lambda: self.skip_snapshot(100))
        self.btn_end = QPushButton(">>")
        self.btn_end.clicked.connect(lambda: self.set_snapshot(len(self.snapshots) - 1))

        controls_layout.addWidget(self.btn_start)
        controls_layout.addWidget(self.btn_prev_100)
        controls_layout.addWidget(self.btn_prev_10)
        controls_layout.addWidget(self.btn_prev)
        controls_layout.addWidget(self.btn_next)
        controls_layout.addWidget(self.btn_next_10)
        controls_layout.addWidget(self.btn_next_100)
        controls_layout.addWidget(self.btn_end)
        
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
        
        self.btn_rebuild = QPushButton("Rebuild Assumptions (All)")
        self.btn_rebuild.clicked.connect(self.rebuild_all_assumptions)
        self.btn_rebuild.setStyleSheet("background-color: #444; color: white;")
        right_panel.addWidget(self.btn_rebuild)

        form_layout = QVBoxLayout()
        
        # Helper to add field with checkbox
        def add_confirmable_field(label_text, widget):
            row = QHBoxLayout()
            label = QLabel(label_text)
            label.setFixedWidth(120)
            row.addWidget(label)
            row.addWidget(widget)
            cb = QCheckBox("Confirm")
            cb.setFixedWidth(80)
            row.addWidget(cb)
            form_layout.addLayout(row)
            return cb

        # New Stage field
        self.combo_stage = QComboBox()
        self.combo_stage.addItems(["Unknown", "Egg", "Baby", "Child", "Teen", "Adult", "Special", "Dead"])
        self.cb_stage = add_confirmable_field("Stage:", self.combo_stage)

        # Character field (replaces old Stage)
        self.combo_character = QComboBox()
        self.combo_character.addItems([
            "Unknown", "Egg (New)", "Egg (Init)", "Babitchi (Baby)", "Marutchi (Child)", 
            "Tamatchi (Teen)", "KuchiTamatchi (Teen)", "Mametchi (Adult)", "Ginjirotchi (Adult)", 
            "Maskutchi (Adult)", "Kuchipatchi (Adult)", "Nyorotchi (Adult)", "Tarakotchi (Adult)", 
            "Oyajitchi (Senior)", "Bill [Gaijintchi] (Senior)", "Bill [Ketotchi] (Senior)", 
            "Bill [Unknown] (Senior)", "Angel (Dead)"
        ])
        self.cb_character = add_confirmable_field("Character:", self.combo_character)

        self.edit_age = QLineEdit()
        self.cb_age = add_confirmable_field("Age (years):", self.edit_age)

        self.edit_weight = QLineEdit()
        self.cb_weight = add_confirmable_field("Weight (oz):", self.edit_weight)

        self.edit_discipline = QLineEdit()
        self.cb_discipline = add_confirmable_field("Discipline (0-4):", self.edit_discipline)
        
        self.edit_hunger = QLineEdit()
        self.cb_hunger = add_confirmable_field("Hunger (0-4):", self.edit_hunger)
        
        self.edit_happy = QLineEdit()
        self.cb_happy = add_confirmable_field("Happiness (0-4):", self.edit_happy)

        self.combo_attention = QComboBox()
        self.combo_attention.addItems(["Unsure", "No", "Yes"])
        self.cb_attention = add_confirmable_field("Needs Attn:", self.combo_attention)
        
        self.edit_poop = QLineEdit()
        self.cb_poop = add_confirmable_field("Poop (0-4):", self.edit_poop)
        
        self.combo_sick = QComboBox()
        self.combo_sick.addItems(["Unsure", "No", "Yes"])
        self.cb_sick = add_confirmable_field("Sick:", self.combo_sick)

        self.combo_sleeping = QComboBox()
        self.combo_sleeping.addItems(["Unsure", "No", "Yes"])
        self.cb_sleeping = add_confirmable_field("Sleeping:", self.combo_sleeping)

        time_layout = QHBoxLayout()
        label_time = QLabel("Time:")
        label_time.setFixedWidth(120)
        time_layout.addWidget(label_time)
        self.edit_time_h = QLineEdit(); self.edit_time_h.setPlaceholderText("HH")
        self.edit_time_m = QLineEdit(); self.edit_time_m.setPlaceholderText("MM")
        self.edit_time_s = QLineEdit(); self.edit_time_s.setPlaceholderText("SS")
        self.combo_ampm = QComboBox(); self.combo_ampm.addItems(["AM", "PM"])
        time_layout.addWidget(self.edit_time_h)
        time_layout.addWidget(self.edit_time_m)
        time_layout.addWidget(self.edit_time_s)
        time_layout.addWidget(self.combo_ampm)
        self.cb_time = QCheckBox("Confirm")
        self.cb_time.setFixedWidth(80)
        time_layout.addWidget(self.cb_time)
        form_layout.addLayout(time_layout)

        self.combo_screen = QComboBox()
        self.combo_screen.addItems(["Main", "Feeding", "Gaming", "Stats", "Angel", "Clock", "Other"])
        self.cb_screen = add_confirmable_field("Screen:", self.combo_screen)

        form_layout.addWidget(QLabel("Notes:"))
        self.text_notes = QTextEdit()
        form_layout.addWidget(self.text_notes)
        
        right_panel.addLayout(form_layout)
        
        self.btn_save = QPushButton("Save & Next")
        self.btn_save.clicked.connect(self.save_and_next)
        self.btn_save.setStyleSheet("background-color: #282; color: white; height: 40px; font-weight: bold;")
        right_panel.addWidget(self.btn_save)
        
        main_layout.addLayout(right_panel, stretch=1)

        # Bottom Status Bar
        self.status_bar = self.statusBar()
        self.capture_count_label = QLabel("Captures: 0")
        self.status_bar.addPermanentWidget(self.capture_count_label)

        # Connect signals for real-time highlighting
        for edit in [self.edit_age, self.edit_weight, self.edit_discipline, self.edit_hunger, self.edit_happy, self.edit_poop]:
            edit.textChanged.connect(self.highlight_discrepancies)
        for combo in [self.combo_attention, self.combo_sick, self.combo_sleeping, self.combo_stage, self.combo_character]:
            combo.currentIndexChanged.connect(self.highlight_discrepancies)

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
        files.sort()
        
        new_snapshots = [f.replace(".bmp", "") for f in files]
        if new_snapshots != self.snapshots:
            self.snapshots = new_snapshots
            
            annotated_count = sum(1 for s in self.snapshots if s in self.annotations and self.annotations[s].get("truth"))
            
            if self.current_index == -1 and self.snapshots:
                target_index = 0
                for i, name in enumerate(self.snapshots):
                    if name not in self.annotations or not self.annotations[name].get("truth"):
                        target_index = i
                        break
                self.set_snapshot(target_index)
            
            count_text = f"Captures: {len(self.snapshots)} (Annotated: {annotated_count})"
            self.status_label.setText(count_text)
            self.capture_count_label.setText(count_text)

    def set_snapshot(self, index):
        if 0 <= index < len(self.snapshots):
            if self.current_index != -1:
                self.save_current_annotation()
            
            self.current_index = index
            name = self.snapshots[index]
            bmp_path = os.path.join(CAPTURES_DIR, name + ".bmp")
            
            is_done = name in self.annotations and self.annotations[name].get("truth")
            status_tag = " <font color='green'>[ANNOTATED]</font>" if is_done else ""
            
            context_text = f"Viewing capture {index + 1}/{len(self.snapshots)}: {name}{status_tag}"
            self.context_label.setText(context_text)
            
            pixmap = QPixmap(bmp_path)
            self.image_label.setPixmap(pixmap.scaled(self.image_label.size(), Qt.AspectRatioMode.KeepAspectRatio))
            
            self.load_snapshot_data(name)

    def highlight_discrepancies(self):
        pre = self.pre_populated_values
        if not pre: return

        def set_style(widget, key, current_val):
            guess = pre.get(key)
            if current_val != guess:
                widget.setStyleSheet("border: 2px solid red; background-color: #fff0f0;")
            else:
                widget.setStyleSheet("")

        set_style(self.edit_age, "age", int(self.edit_age.text()) if self.edit_age.text().isdigit() else None)
        set_style(self.edit_weight, "weight", int(self.edit_weight.text()) if self.edit_weight.text().isdigit() else None)
        set_style(self.edit_discipline, "discipline", int(self.edit_discipline.text()) if self.edit_discipline.text().isdigit() else None)
        set_style(self.edit_hunger, "hunger", int(self.edit_hunger.text()) if self.edit_hunger.text().isdigit() else None)
        set_style(self.edit_happy, "happy", int(self.edit_happy.text()) if self.edit_happy.text().isdigit() else None)
        set_style(self.edit_poop, "poop", int(self.edit_poop.text()) if self.edit_poop.text().isdigit() else None)
        set_style(self.combo_attention, "attention", self.combo_attention.currentText() == "Yes")
        set_style(self.combo_sick, "sick", self.combo_sick.currentText() == "Yes")
        set_style(self.combo_sleeping, "sleeping", self.combo_sleeping.currentText() == "Yes")
        set_style(self.combo_stage, "stage", self.combo_stage.currentText())

    def load_snapshot_data(self, name):
        # Reset fields
        self.combo_stage.setCurrentIndex(0)
        self.combo_character.setCurrentIndex(0)
        self.edit_hunger.clear()
        self.edit_happy.clear()
        self.edit_discipline.clear()
        self.combo_attention.setCurrentIndex(0)
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
        
        # Reset Checkboxes
        conf_widgets = [self.cb_stage, self.cb_character, self.cb_hunger, self.cb_happy, self.cb_discipline, 
                        self.cb_poop, self.cb_sick, self.cb_sleeping, self.cb_attention, 
                        self.cb_time, self.cb_screen, self.cb_weight, self.cb_age]
        for cb in conf_widgets:
            cb.setChecked(False)

        self.pre_populated_values = {}
        
        bin_path = os.path.join(CAPTURES_DIR, name + ".bin")
        self.pre_populate(bin_path)

        if name in self.annotations:
            entry = self.annotations[name]
            truth = entry.get("truth", {})
            mod = entry.get("mod", [])
            
            if "stage" in truth: 
                self.combo_stage.setCurrentText(truth["stage"])
                self.cb_stage.setChecked("stage" not in mod)

            if "character" in truth:
                self.combo_character.setCurrentText(truth["character"])
                self.cb_character.setChecked("character" not in mod)
            
            if "hunger" in truth: 
                self.edit_hunger.setText(str(truth["hunger"]))
                self.cb_hunger.setChecked("hunger" not in mod)
            
            if "happy" in truth: 
                self.edit_happy.setText(str(truth["happy"]))
                self.cb_happy.setChecked("happy" not in mod)
            
            if "discipline" in truth: 
                self.edit_discipline.setText(str(truth["discipline"]))
                self.cb_discipline.setChecked("discipline" not in mod)

            if "attention" in truth:
                self.combo_attention.setCurrentText("Yes" if truth["attention"] else "No")
                self.cb_attention.setChecked("attention" not in mod)
            
            if "poop" in truth: 
                self.edit_poop.setText(str(truth["poop"]))
                self.cb_poop.setChecked("poop" not in mod)
            
            if "sick" in truth: 
                self.combo_sick.setCurrentText("Yes" if truth["sick"] else "No")
                self.cb_sick.setChecked("sick" not in mod)
            
            if "sleeping" in truth: 
                self.combo_sleeping.setCurrentText("Yes" if truth["sleeping"] else "No")
                self.cb_sleeping.setChecked("sleeping" not in mod)
            
            if "time" in truth:
                try:
                    parts = truth["time"].split(" ")
                    hms = parts[0].split(":")
                    self.edit_time_h.setText(hms[0])
                    self.edit_time_m.setText(hms[1])
                    self.edit_time_s.setText(hms[2])
                    self.combo_ampm.setCurrentText(parts[1])
                    self.cb_time.setChecked("time" not in mod)
                except: pass
            
            if "screen" in truth: 
                self.combo_screen.setCurrentText(truth["screen"])
                self.cb_screen.setChecked("screen" not in mod)
            
            if "weight" in truth: 
                self.edit_weight.setText(str(truth["weight"]))
                self.cb_weight.setChecked("weight" not in mod)
            
            if "age" in truth: 
                self.edit_age.setText(str(truth["age"]))
                self.cb_age.setChecked("age" not in mod)
            
            self.text_notes.setPlainText(entry.get("notes", ""))
        
        self.highlight_discrepancies()

    def save_and_next(self):
        if self.live_sim_process:
            self.live_sim_process.terminate()
            self.live_sim_process = None
        
        if self.sim_process:
            self.sim_process.terminate()
            self.sim_process = None
            
        self.save_current_annotation()
        self.next_snapshot()

    def rebuild_all_assumptions(self):
        for name in self.snapshots:
            bin_path = os.path.join(CAPTURES_DIR, name + ".bin")
            if os.path.exists(bin_path):
                try:
                    with open(bin_path, 'rb') as f:
                        content = f.read()
                        mem = content[-MEMORY_SIZE_BYTES:]
                        
                        pre = {
                            "hunger": memory_config.get_value(mem, "hunger"),
                            "happy": memory_config.get_value(mem, "happy"),
                            "discipline": memory_config.get_value(mem, "discipline"),
                            "attention": memory_config.get_value(mem, "attention"),
                            "poop": memory_config.get_value(mem, "poop"),
                            "sick": memory_config.get_value(mem, "sick"),
                            "sleeping": memory_config.get_value(mem, "sleeping"),
                            "age": memory_config.get_value(mem, "age"),
                            "weight": memory_config.get_value(mem, "weight"),
                            "stage": memory_config.get_value(mem, "lifecycle")
                        }
                        
                        # Time
                        sec_ones = memory_config.decode_nibble(mem, 0x10)
                        sec_tens = memory_config.decode_nibble(mem, 0x11)
                        min_ones = memory_config.decode_nibble(mem, 0x12)
                        min_tens = memory_config.decode_nibble(mem, 0x13)
                        h_ones = memory_config.decode_nibble(mem, 0x14)
                        h_tens = memory_config.decode_nibble(mem, 0x15)
                        sec = sec_tens * 10 + sec_ones
                        m = min_tens * 10 + min_ones
                        h24 = (h_tens << 4) | h_ones
                        ampm = "AM"
                        h12 = h24
                        if h24 == 0: h12 = 12
                        elif h24 == 12: ampm = "PM"
                        elif h24 > 12: h12 = h24 - 12; ampm = "PM"
                        pre["time"] = {"h": h12, "m": m, "s": sec, "ampm": ampm}
                        pre["screen"] = "Main"

                        if name not in self.annotations:
                            self.annotations[name] = {"pre_populated": pre}
                        else:
                            self.annotations[name]["pre_populated"] = pre
                except: pass
        self.save_annotations()
        self.status_label.setText("Assumptions rebuilt!")

    def pre_populate(self, bin_path):
        if not os.path.exists(bin_path): return
        
        try:
            with open(bin_path, 'rb') as f:
                content = f.read()
                mem = content[-MEMORY_SIZE_BYTES:]
                
                hunger = memory_config.get_value(mem, "hunger")
                self.edit_hunger.setText(str(hunger))
                
                happy = memory_config.get_value(mem, "happy")
                self.edit_happy.setText(str(happy))

                disc = memory_config.get_value(mem, "discipline")
                self.edit_discipline.setText(str(disc))

                attn = memory_config.get_value(mem, "attention")
                self.combo_attention.setCurrentText("Yes" if attn else "No")
                
                poop = memory_config.get_value(mem, "poop")
                self.edit_poop.setText(str(poop))
                
                sick = memory_config.get_value(mem, "sick")
                self.combo_sick.setCurrentText("Yes" if sick else "No")

                sleep = memory_config.get_value(mem, "sleeping")
                self.combo_sleeping.setCurrentText("Yes" if sleep else "No")

                age = memory_config.get_value(mem, "age")
                self.edit_age.setText(str(age))

                weight = memory_config.get_value(mem, "weight")
                self.edit_weight.setText(str(weight))

                lifecycle = memory_config.get_value(mem, "lifecycle")
                self.combo_stage.setCurrentText(lifecycle if lifecycle else "Unknown")

                # Time
                sec_ones = memory_config.decode_nibble(mem, 0x10)
                sec_tens = memory_config.decode_nibble(mem, 0x11)
                min_ones = memory_config.decode_nibble(mem, 0x12)
                min_tens = memory_config.decode_nibble(mem, 0x13)
                h_ones = memory_config.decode_nibble(mem, 0x14)
                h_tens = memory_config.decode_nibble(mem, 0x15)
                sec = sec_tens * 10 + sec_ones
                m = min_tens * 10 + min_ones
                h24 = (h_tens << 4) | h_ones
                ampm = "AM"
                h12 = h24
                if h24 == 0: h12 = 12
                elif h24 == 12: ampm = "PM"
                elif h24 > 12: h12 = h24 - 12; ampm = "PM"
                self.edit_time_h.setText(str(h12))
                self.edit_time_m.setText(f"{m:02d}")
                self.edit_time_s.setText(f"{sec:02d}")
                self.combo_ampm.setCurrentText(ampm)

                self.combo_screen.setCurrentText("Main")

                self.pre_populated_values = {
                    "hunger": hunger, "happy": happy, "discipline": disc,
                    "attention": attn, "poop": poop, "sick": sick,
                    "sleeping": sleep, "age": age, "weight": weight,
                    "stage": self.combo_stage.currentText(),
                    "time": {"h": h12, "m": m, "s": sec, "ampm": ampm},
                    "screen": self.combo_screen.currentText()
                }
        except Exception as e:
            print(f"Error pre-populating: {e}")

    def save_current_annotation(self):
        if self.current_index == -1: return
        name = self.snapshots[self.current_index]
        
        truth = {}
        modified = []
        pre = self.pre_populated_values
        
        def is_mod(val, key):
            return pre and val != pre.get(key)

        cur = {
            "stage": self.combo_stage.currentText(),
            "character": self.combo_character.currentText(),
            "age": int(self.edit_age.text()) if self.edit_age.text().isdigit() else None,
            "weight": int(self.edit_weight.text()) if self.edit_weight.text().isdigit() else None,
            "discipline": int(self.edit_discipline.text()) if self.edit_discipline.text().isdigit() else None,
            "hunger": int(self.edit_hunger.text()) if self.edit_hunger.text().isdigit() else None,
            "happy": int(self.edit_happy.text()) if self.edit_happy.text().isdigit() else None,
            "attention": True if self.combo_attention.currentText() == "Yes" else (False if self.combo_attention.currentText() == "No" else None),
            "poop": int(self.edit_poop.text()) if self.edit_poop.text().isdigit() else None,
            "sick": True if self.combo_sick.currentText() == "Yes" else (False if self.combo_sick.currentText() == "No" else None),
            "sleeping": True if self.combo_sleeping.currentText() == "Yes" else (False if self.combo_sleeping.currentText() == "No" else None),
            "screen": self.combo_screen.currentText(),
            "time": f"{self.edit_time_h.text()}:{self.edit_time_m.text()}:{self.edit_time_s.text()} {self.combo_ampm.currentText()}"
        }

        fields = ["stage", "character", "age", "weight", "discipline", "hunger", "happy", "attention", "poop", "sick", "sleeping", "screen"]
        for f in fields:
            if is_mod(cur[f], f):
                modified.append(f)

        if pre and "time" in pre:
            pt = pre["time"]
            cur_t_str = f"{pt['h']}:{pt['m']:02d}:{pt['s']:02d} {pt['ampm']}"
            if cur["time"] != cur_t_str:
                modified.append("time")

        conf_map = {
            "stage": self.cb_stage, "character": self.cb_character, "age": self.cb_age, "weight": self.cb_weight,
            "discipline": self.cb_discipline, "hunger": self.cb_hunger, "happy": self.cb_happy,
            "attention": self.cb_attention, "poop": self.cb_poop, "sick": self.cb_sick,
            "sleeping": self.cb_sleeping, "screen": self.cb_screen, "time": self.cb_time
        }

        for f, cb in conf_map.items():
            if cb.isChecked() or f in modified:
                truth[f] = cur[f]

        guesses = {}
        if pre:
            g_map = {"hunger":"h", "happy":"ha", "discipline":"d", "attention":"at", "poop":"p", "sick":"s", "sleeping":"sl", "age":"a", "weight":"w", "stage":"st"}
            for k, short in g_map.items():
                guesses[short] = pre.get(k)
            if "time" in pre:
                pt = pre["time"]
                guesses["t"] = f"{pt['h']}:{pt['m']:02d}:{pt['s']:02d} {pt['ampm']}"

        if not truth and not modified and not self.text_notes.toPlainText():
            if name in self.annotations:
                del self.annotations[name]
        else:
            self.annotations[name] = {
                "truth": truth,
                "guesses": guesses,
                "mod": modified,
                "notes": self.text_notes.toPlainText()
            }
        self.save_annotations()

    def prev_snapshot(self):
        if self.current_index > 0:
            self.set_snapshot(self.current_index - 1)

    def next_snapshot(self):
        if self.current_index < len(self.snapshots) - 1:
            self.set_snapshot(self.current_index + 1)

    def skip_snapshot(self, offset):
        new_index = self.current_index + offset
        if new_index < 0: new_index = 0
        if new_index >= len(self.snapshots): new_index = len(self.snapshots) - 1
        
        if new_index != self.current_index:
            self.set_snapshot(new_index)

    def start_turbo_sim(self):
        if self.sim_process:
            self.sim_process.terminate()
        cmd = [SIM_EXE, "--turbo", "--auto-snapshot", "5", "--no-ntp"]
        self.sim_process = subprocess.Popen(cmd)
        self.status_label.setText("Sim running (Turbo)...")

    def start_live_sim(self):
        if self.current_index == -1: return
        if self.live_sim_process:
            self.live_sim_process.terminate()
        name = self.snapshots[self.current_index]
        bin_path = os.path.join(CAPTURES_DIR, name + ".bin")
        cmd = [SIM_EXE, "--load-state", bin_path, "--babysitter", "off", "--no-ntp"]
        self.live_sim_process = subprocess.Popen(cmd)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = Investigator()
    window.show()
    sys.exit(app.exec())
