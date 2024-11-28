from threading import Thread
from uploader_menu.monitor import system_usage
from uploader_menu.main_menu import menu as main_menu

Thread(target=system_usage).start()
Thread(target=main_menu).start()
