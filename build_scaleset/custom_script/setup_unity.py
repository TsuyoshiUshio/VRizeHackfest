from pywinauto import Application, Desktop
from pywinauto.keyboard import SendKeys

import time
# Run a target application


app = Application(backend="uia").start("C:\\Program Files\\Unity\\Editor\\Unity.exe")

time.sleep(3)
dlg = Desktop(backend="uia").Unity
print("-----first screen identifier-----")
dlg.print_control_identifiers()
SendKeys('<YOUR E-MAIL ADDRESS>')
SendKeys('{TAB}')
SendKeys('<YOUR PASSWORD>')
SendKeys('{TAB}')
SendKeys('{TAB}')
SendKeys('{ENTER}')
time.sleep(3)

dlg = Desktop(backend="uia").Unity
dlg.print_control_identifiers()

print("-----print identifier-----")
dlg.Custom1.print_control_identifiers()
print("-----run click-----")
dlg.Custom1.click()

time.sleep(1)
