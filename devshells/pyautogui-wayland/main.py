import pyautogui
import subprocess
import time

pyautogui.PAUSE = 0

time.sleep(0.5)
pyautogui.press('down')
pyautogui.press('enter')

pyautogui.press('shift')

pyautogui.keyDown('w')
time.sleep(2)

screen_width, screen_height = pyautogui.size()

# Move to center first
pyautogui.moveTo(screen_width // 2, screen_height // 2, duration=0.1)

# Flick left holding left click
pyautogui.mouseDown()
pyautogui.moveRel(-screen_width // 2, 0, duration=0.5)
pyautogui.mouseUp()
pyautogui.press('space')

time.sleep(0.3)

# Sweep right holding left click
pyautogui.mouseDown()
pyautogui.moveRel(screen_width, 0, duration=0.5)
pyautogui.mouseUp()
pyautogui.press('space')

time.sleep(5 - 2 - 0.3)
pyautogui.keyUp('w')

pyautogui.press('shift')

pyautogui.press('/')
time.sleep(0.05)
subprocess.run(['wl-copy', 'pyautogui ran again'])
time.sleep(0.2)
pyautogui.hotkey('ctrl', 'v')
pyautogui.press('enter')
