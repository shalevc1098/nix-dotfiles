#!__AUTOCLICKER_PYTHON__
import os
import sys
import socket
import subprocess
import threading
import time

from PyQt6.QtCore import Qt, QTimer, pyqtSignal
from PyQt6.QtGui import QCursor
from PyQt6.QtWidgets import (
    QApplication,
    QButtonGroup,
    QDialog,
    QFormLayout,
    QGridLayout,
    QGroupBox,
    QHBoxLayout,
    QLabel,
    QLineEdit,
    QMainWindow,
    QMessageBox,
    QPushButton,
    QRadioButton,
    QVBoxLayout,
    QWidget,
    QComboBox,
)

try:
    import evdev
    from evdev import ecodes
except Exception:
    evdev = None

COMMAND_SOCKET_PATH = os.path.expanduser("~/.cache/autoclicker.sock")
DEFAULTS = {
    "hours": 0,
    "minutes": 0,
    "seconds": 0,
    "milliseconds": 100,
    "mouse_button": "Left",
    "click_type": "Single",
    "repeat_mode": "until_stopped",
    "repeat_count": 1,
    "position_mode": "current",
    "fixed_x": 0,
    "fixed_y": 0,
    "hotkey": "f6",
}

def safe_int(value, fallback=0):
    try:
        parsed = int(value)
        return max(parsed, 0)
    except Exception:
        return fallback

def ydotool_click_code(button):
    if button == "Right":
        return "0xC1"
    if button == "Middle":
        return "0xC2"
    return "0xC0"

class PickLocationOverlay(QWidget):
    def __init__(self, on_pick):
        super().__init__()
        self.on_pick = on_pick
        self.setObjectName("autoclicker-pick")
        self.setWindowTitle("autoclicker-pick")
        self.setCursor(QCursor(Qt.CursorShape.CrossCursor))
        self.setWindowFlags(
            Qt.WindowType.FramelessWindowHint
            | Qt.WindowType.Tool
            | Qt.WindowType.WindowStaysOnTopHint
        )
        self.setAttribute(Qt.WidgetAttribute.WA_TranslucentBackground, True)
        self.setWindowState(Qt.WindowState.WindowFullScreen)
        self.setStyleSheet("background: rgba(0, 0, 0, 0);")

        label = QLabel("Click anywhere to set fixed cursor location", self)
        label.setStyleSheet(
            "background: rgba(17, 17, 17, 220); color: white; padding: 10px; border-radius: 6px;"
        )
        label.adjustSize()
        label.move(20, 20)

    def mousePressEvent(self, event):
        pos = event.globalPosition().toPoint()
        self.on_pick(pos.x(), pos.y())
        self.close()

    def keyPressEvent(self, event):
        if event.key() == Qt.Key.Key_Escape:
            self.close()
        else:
            super().keyPressEvent(event)

class AutoClickerUI(QMainWindow):
    command_received = pyqtSignal(str)

    def __init__(self):
        super().__init__()
        self.setWindowTitle("OP Auto Clicker")
        self.setFixedSize(540, 390)

        self.stop_event = threading.Event()
        self.worker = None
        self.hotkey_listener = None
        self.pick_overlay = None
        self.command_server_socket = None

        self.settings = self.load_settings()

        self.start_command_server()
        self.build_ui()
        self.register_hotkey()
        self.command_received.connect(self.handle_command)

    def load_settings(self):
        return dict(DEFAULTS)

    def save_settings(self):
        self.settings = {
            "hours": safe_int(self.hours_edit.text(), 0),
            "minutes": safe_int(self.minutes_edit.text(), 0),
            "seconds": safe_int(self.seconds_edit.text(), 0),
            "milliseconds": safe_int(self.milliseconds_edit.text(), 100),
            "mouse_button": self.mouse_button_combo.currentText(),
            "click_type": self.click_type_combo.currentText(),
            "repeat_mode": "repeat_n"
            if self.repeat_n_radio.isChecked()
            else "until_stopped",
            "repeat_count": max(1, safe_int(self.repeat_count_edit.text(), 1)),
            "position_mode": "fixed"
            if self.position_fixed_radio.isChecked()
            else "current",
            "fixed_x": safe_int(self.fixed_x_edit.text(), 0),
            "fixed_y": safe_int(self.fixed_y_edit.text(), 0),
            "hotkey": self.hotkey.upper().lower(),
        }

    def build_ui(self):
        central = QWidget()
        self.setCentralWidget(central)
        top = QVBoxLayout(central)
        top.setContentsMargins(10, 10, 10, 10)
        top.setSpacing(8)

        interval_box = QGroupBox("Click interval")
        interval_layout = QHBoxLayout(interval_box)
        self.hours_edit = self._num_edit(self.settings["hours"], 5)
        self.minutes_edit = self._num_edit(self.settings["minutes"], 5)
        self.seconds_edit = self._num_edit(self.settings["seconds"], 5)
        self.milliseconds_edit = self._num_edit(self.settings["milliseconds"], 8)
        interval_layout.addWidget(self.hours_edit)
        interval_layout.addWidget(QLabel("hours"))
        interval_layout.addWidget(self.minutes_edit)
        interval_layout.addWidget(QLabel("mins"))
        interval_layout.addWidget(self.seconds_edit)
        interval_layout.addWidget(QLabel("secs"))
        interval_layout.addWidget(self.milliseconds_edit)
        interval_layout.addWidget(QLabel("milliseconds"))
        interval_layout.addStretch(1)
        top.addWidget(interval_box)

        row2 = QHBoxLayout()
        click_options = QGroupBox("Click options")
        click_form = QFormLayout(click_options)
        self.mouse_button_combo = QComboBox()
        self.mouse_button_combo.addItems(["Left", "Right", "Middle"])
        self.mouse_button_combo.setCurrentText(self.settings["mouse_button"])
        self.click_type_combo = QComboBox()
        self.click_type_combo.addItems(["Single", "Double", "Triple"])
        self.click_type_combo.setCurrentText(self.settings["click_type"])
        click_form.addRow("Mouse button:", self.mouse_button_combo)
        click_form.addRow("Click type:", self.click_type_combo)

        click_repeat = QGroupBox("Click repeat")
        repeat_layout = QVBoxLayout(click_repeat)
        repeat_line = QHBoxLayout()
        self.repeat_n_radio = QRadioButton("Repeat")
        self.repeat_count_edit = self._num_edit(self.settings["repeat_count"], 5)
        repeat_line.addWidget(self.repeat_n_radio)
        repeat_line.addWidget(self.repeat_count_edit)
        repeat_line.addWidget(QLabel("times"))
        repeat_line.addStretch(1)
        self.repeat_until_radio = QRadioButton("Repeat until stopped")
        repeat_layout.addLayout(repeat_line)
        repeat_layout.addWidget(self.repeat_until_radio)

        repeat_group = QButtonGroup(self)
        repeat_group.addButton(self.repeat_n_radio)
        repeat_group.addButton(self.repeat_until_radio)
        if self.settings["repeat_mode"] == "repeat_n":
            self.repeat_n_radio.setChecked(True)
        else:
            self.repeat_until_radio.setChecked(True)

        row2.addWidget(click_options)
        row2.addWidget(click_repeat)
        top.addLayout(row2)

        cursor_box = QGroupBox("Cursor position")
        cursor_layout = QGridLayout(cursor_box)
        self.position_current_radio = QRadioButton("Current location")
        self.position_fixed_radio = QRadioButton("Pick location")
        position_group = QButtonGroup(self)
        position_group.addButton(self.position_current_radio)
        position_group.addButton(self.position_fixed_radio)
        if self.settings["position_mode"] == "fixed":
            self.position_fixed_radio.setChecked(True)
        else:
            self.position_current_radio.setChecked(True)

        pick_btn = QPushButton("Pick location")
        pick_btn.clicked.connect(self.pick_location)
        self.fixed_x_edit = self._num_edit(self.settings["fixed_x"], 6)
        self.fixed_y_edit = self._num_edit(self.settings["fixed_y"], 6)

        cursor_layout.addWidget(self.position_current_radio, 0, 0)
        cursor_layout.addWidget(self.position_fixed_radio, 0, 1)
        cursor_layout.addWidget(pick_btn, 0, 2)
        cursor_layout.addWidget(QLabel("X"), 0, 3)
        cursor_layout.addWidget(self.fixed_x_edit, 0, 4)
        cursor_layout.addWidget(QLabel("Y"), 0, 5)
        cursor_layout.addWidget(self.fixed_y_edit, 0, 6)
        cursor_layout.setColumnStretch(7, 1)
        top.addWidget(cursor_box)

        controls = QGridLayout()
        self.start_btn = QPushButton("Start (F6)")
        self.stop_btn = QPushButton("Stop (F6)")
        hotkey_btn = QPushButton("Hotkey setting")
        help_btn = QPushButton("Help >>")
        self.start_btn.clicked.connect(self.start_clicking)
        self.stop_btn.clicked.connect(self.stop_clicking)
        hotkey_btn.clicked.connect(self.hotkey_dialog)
        help_btn.clicked.connect(self.help_dialog)
        controls.addWidget(self.start_btn, 0, 0)
        controls.addWidget(self.stop_btn, 0, 1)
        controls.addWidget(hotkey_btn, 1, 0)
        controls.addWidget(help_btn, 1, 1)
        top.addLayout(controls)

        status_row = QHBoxLayout()
        status_row.addWidget(QLabel("Status:"))
        self.status_label = QLabel("Idle")
        status_row.addWidget(self.status_label)
        status_row.addStretch(1)
        top.addLayout(status_row)

        self.hotkey = self.settings.get("hotkey", "f6").upper()
        self.sync_buttons()

    def _num_edit(self, value, width):
        edit = QLineEdit(str(value))
        edit.setFixedWidth(width * 10)
        return edit

    def click_interval_seconds(self):
        total_ms = (
            safe_int(self.hours_edit.text(), 0) * 3600000
            + safe_int(self.minutes_edit.text(), 0) * 60000
            + safe_int(self.seconds_edit.text(), 0) * 1000
            + safe_int(self.milliseconds_edit.text(), 0)
        )
        return max(total_ms / 1000.0, 0.001)

    def click_multiplier(self):
        value = self.click_type_combo.currentText()
        if value == "Double":
            return 2
        if value == "Triple":
            return 3
        return 1

    def perform_click(self):
        code = ydotool_click_code(self.mouse_button_combo.currentText())

        if self.position_fixed_radio.isChecked():
            x = safe_int(self.fixed_x_edit.text(), 0)
            y = safe_int(self.fixed_y_edit.text(), 0)
            subprocess.run(
                ["ydotool", "mousemove", "-a", "-x", str(x), "-y", str(y)],
                check=False,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )

        for _ in range(self.click_multiplier()):
            subprocess.run(
                ["ydotool", "click", code],
                check=False,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            time.sleep(0.03)

    def click_worker(self):
        mode = "repeat_n" if self.repeat_n_radio.isChecked() else "until_stopped"
        interval = self.click_interval_seconds()
        repeat_limit = max(1, safe_int(self.repeat_count_edit.text(), 1))

        if mode == "repeat_n":
            clicks_remaining = max(0, repeat_limit - 1)
            while clicks_remaining > 0 and not self.stop_event.is_set():
                if self.stop_event.wait(interval):
                    break
                self.perform_click()
                clicks_remaining -= 1
        else:
            while not self.stop_event.wait(interval):
                self.perform_click()

        QTimer.singleShot(0, self.on_worker_finished)

    def on_worker_finished(self):
        self.stop_event.set()
        self.worker = None
        self.status_label.setText("Stopped")
        self.sync_buttons()

    def sync_buttons(self):
        running = self.worker is not None and self.worker.is_alive()
        self.start_btn.setEnabled(not running)
        self.stop_btn.setEnabled(running)

    def start_clicking(self):
        if self.worker is not None and self.worker.is_alive():
            return
        self.save_settings()
        self.stop_event.clear()
        self.status_label.setText("Running")
        self.perform_click()

        if (
            self.repeat_n_radio.isChecked()
            and max(1, safe_int(self.repeat_count_edit.text(), 1)) == 1
        ):
            self.status_label.setText("Stopped")
            self.sync_buttons()
            return

        self.worker = threading.Thread(target=self.click_worker, daemon=True)
        self.worker.start()
        self.sync_buttons()

    def stop_clicking(self):
        self.stop_event.set()
        self.status_label.setText("Stopping...")
        self.start_btn.setEnabled(True)
        self.stop_btn.setEnabled(False)

    def start_command_server(self):
        os.makedirs(os.path.dirname(COMMAND_SOCKET_PATH), exist_ok=True)
        try:
            os.unlink(COMMAND_SOCKET_PATH)
        except FileNotFoundError:
            pass
        except Exception:
            pass

        server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.command_server_socket = server

        try:
            server.bind(COMMAND_SOCKET_PATH)
            os.chmod(COMMAND_SOCKET_PATH, 0o600)
            server.listen(1)
        except Exception:
            try:
                server.close()
            except Exception:
                pass
            self.command_server_socket = None
            raise

        self.command_server_thread = threading.Thread(
            target=self.command_server, daemon=True
        )
        self.command_server_thread.start()

    def pick_location(self):
        self.position_fixed_radio.setChecked(True)

        if self.pick_overlay is not None:
            self.status_label.setText("Pick mode already active")
            return

        self.status_label.setText("Pick mode: click anywhere to set location")
        self.pick_overlay = PickLocationOverlay(self.on_pick_location)
        self.pick_overlay.show()

    def on_pick_location(self, x, y):
        self.fixed_x_edit.setText(str(int(x)))
        self.fixed_y_edit.setText(str(int(y)))
        self.status_label.setText(f"Picked X={int(x)} Y={int(y)}")
        self.pick_overlay = None
        self.show()
        self.raise_()
        self.activateWindow()

    def help_dialog(self):
        lines = [
            "F6 (default) toggles Start/Stop.",
            "Pick location captures a fixed X/Y coordinate.",
            "Repeat runs N click cycles (single/double/triple per cycle).",
            "Repeat until stopped runs forever.",
        ]
        QMessageBox.information(self, "Help", "\n".join(lines))

    def hotkey_dialog(self):
        dialog = QDialog(self)
        dialog.setWindowTitle("Hotkey setting")
        layout = QVBoxLayout(dialog)
        layout.addWidget(QLabel("Select a function key (F1-F12) and click Save."))

        combo = QComboBox()
        combo.addItems([f"F{i}" for i in range(1, 13)])
        combo.setCurrentText(self.hotkey)
        layout.addWidget(combo)

        buttons = QHBoxLayout()
        save_btn = QPushButton("Save")
        cancel_btn = QPushButton("Cancel")
        buttons.addWidget(save_btn)
        buttons.addWidget(cancel_btn)
        layout.addLayout(buttons)

        def save_hotkey():
            self.hotkey = combo.currentText().upper()
            self.save_settings()
            self.register_hotkey()
            self.start_btn.setText(f"Start ({self.hotkey})")
            self.stop_btn.setText(f"Stop ({self.hotkey})")
            dialog.accept()

        save_btn.clicked.connect(save_hotkey)
        cancel_btn.clicked.connect(dialog.reject)
        dialog.exec()

    def register_hotkey(self):
        if self.hotkey_listener is not None:
            try:
                self.hotkey_listener.set()
            except Exception:
                pass
            self.hotkey_listener = None

        if evdev is None:
            self.status_label.setText("Hotkey backend missing (install evdev)")
            return

        stop = threading.Event()
        self.hotkey_listener = stop

        target_code = getattr(ecodes, f"KEY_{self.hotkey.upper()}", None)
        if target_code is None:
            self.status_label.setText(f"Unknown hotkey: {self.hotkey}")
            return

        def listener():
            while not stop.is_set():
                devices = [evdev.InputDevice(p) for p in evdev.list_devices()]
                keyboards = [d for d in devices if ecodes.EV_KEY in d.capabilities()]
                if not keyboards:
                    stop.wait(2)
                    continue
                import select

                fds = {d.fd: d for d in keyboards}
                while not stop.is_set():
                    r, _, _ = select.select(fds.keys(), [], [], 0.5)
                    for fd in r:
                        try:
                            for event in fds[fd].read():
                                if (
                                    event.type == ecodes.EV_KEY
                                    and event.code == target_code
                                    and event.value == 1
                                ):
                                    QTimer.singleShot(0, self.toggle_start_stop)
                        except Exception:
                            break
                    else:
                        continue
                    break  # re-enumerate devices on error

        t = threading.Thread(target=listener, daemon=True)
        t.start()

    def command_server(self):
        server = self.command_server_socket
        if server is None:
            return

        try:
            while not self.stop_event.is_set():
                try:
                    conn, _ = server.accept()
                except OSError:
                    break

                with conn:
                    try:
                        command = conn.recv(64).decode("utf-8", errors="ignore").strip()
                    except Exception:
                        continue

                    if command:
                        self.command_received.emit(command)
        finally:
            try:
                server.close()
            except Exception:
                pass

    def handle_command(self, command):
        if command == "toggle":
            self.toggle_start_stop()

    def toggle_start_stop(self):
        running = self.worker is not None and self.worker.is_alive()
        if running:
            self.stop_clicking()
        else:
            self.start_clicking()

    def closeEvent(self, event):
        self.save_settings()
        self.stop_event.set()
        if self.hotkey_listener is not None:
            try:
                self.hotkey_listener.set()
            except Exception:
                pass
        if self.pick_overlay is not None:
            try:
                self.pick_overlay.close()
            except Exception:
                pass
        if self.command_server_socket is not None:
            try:
                self.command_server_socket.close()
            except Exception:
                pass
        try:
            os.unlink(COMMAND_SOCKET_PATH)
        except Exception:
            pass
        super().closeEvent(event)

    def keyPressEvent(self, event):
        if event.key() == Qt.Key.Key_F6 and self.hotkey == "F6":
            self.toggle_start_stop()
            event.accept()
            return
        super().keyPressEvent(event)

    def run(self):
        self.start_btn.setText(f"Start ({self.hotkey})")
        self.stop_btn.setText(f"Stop ({self.hotkey})")
        self.show()

if __name__ == "__main__":
    try:
        client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        client.connect(COMMAND_SOCKET_PATH)
        client.sendall(b"toggle")
        client.close()
        raise SystemExit(0)
    except OSError:
        pass

    qt_app = QApplication([])
    qt_app.setDesktopFileName("autoclicker")
    window = AutoClickerUI()
    window.run()
    qt_app.exec()