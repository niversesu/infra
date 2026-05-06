import pyautogui

print("Mouse position:", pyautogui.position())
pyautogui.moveTo(500, 500, duration=0.5)
pyautogui.click()
pyautogui.write("hello world", interval=0.05)
