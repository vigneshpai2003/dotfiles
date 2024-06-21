import argparse
import getpass
import keyring
import time
from pydbus import SystemBus
from gi.repository import GLib
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException, WebDriverException

service = "iiserpune-selenium-login"


class Daemon:
    def __init__(self) -> None:
        self.system_bus = SystemBus()
        self.nm = self.system_bus.get('.NetworkManager')

        self.devices = []
        self.deviceNames = []
        
        for device in self.nm.AllDevices:
            self.addDevice(device)
            self.onStateChanged(self.devices[-1])()

        self.nm.onDeviceAdded = lambda device: self.addDevice(device)
        self.nm.onDeviceRemoved = lambda device: self.removeDevice(device)
        
        loop = GLib.MainLoop()
        loop.run()

    def addDevice(self, deviceName):
        self.deviceNames.append(deviceName)
        self.devices.append(self.system_bus.get('.NetworkManager', deviceName))
        self.devices[-1].onStateChanged = self.onStateChanged(self.devices[-1])
        daemon_log(f"Added New Device: {self.devices[-1].Interface}")

    def removeDevice(self, deviceName):
        self.devices.pop(self.deviceNames.index(deviceName))
        self.deviceNames.remove(deviceName)
        daemon_log(f"Removed Device: {deviceName}")

    def onStateChanged(self, device):
        def callback(*args):
            activeConnection = device.ActiveConnection
            
            if activeConnection != '/':
                daemon_log(f"Device({device.Interface})", f"Checking Connection: {activeConnection}")
                
                try:
                    connection = self.system_bus.get('.NetworkManager', activeConnection)
                except:
                    daemon_log(f"Device({device.Interface})", "Connection aborted.")
                    return
                
                ip4Config = connection.Ip4Config
            
                if ip4Config != '/':
                    daemon_log(f"Device({device.Interface})", f"Connection({connection.Id})", f"Checking IP4 Address: {ip4Config}")
                    
                    try:
                        ip = self.system_bus.get('.NetworkManager', ip4Config)
                    except:
                        daemon_log(f"Device({device.Interface})", f"Connection({connection.Id})", "Could not get IP address.")
                        return
                    
                    try:
                        daemon_log(f"Device({device.Interface})", f"Connection({connection.Id})", f"Domains: {ip.Domains}")
                        if 'iiserpune.ac.in' in ip.Domains:
                            daemon_log("IISER Pune detected.")
                            login()
                    except:
                        daemon_log("Could not get domains.")
                        return
                else:
                    daemon_log(f"Device({device.Interface})", f"Connection({connection.Id})", "Invalid IP4Config.")

        return callback


LOGGING = False


def daemon_log(*args, **kwargs):
    if LOGGING:
        print(*args, **kwargs)


def login():
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.set_page_load_timeout(5)
    
    try:
        driver.get("http://10.111.1.1:8090/httpclient.html")
    except WebDriverException:
        print("You LAN connection is too weak or is dead.")
        return 1
    
    credentials = keyring.get_credential(service, None)
    
    if not credentials:
        print("No credentials found. Please set your credentials.")
        return 1

    username = driver.find_element(By.ID, "username")
    password = driver.find_element(By.ID, "password")

    username.send_keys(credentials.username)
    password.send_keys(credentials.password)

    driver.execute_script("submitRequest()")
    
    time.sleep(0.5)
    
    try:
        driver.find_element(By.CSS_SELECTOR, "#credentials.loggedin")
    except NoSuchElementException:
        print("Login failed, likely incorrect credentials.")
        return 1
    else:
        print("Login successful.")
    finally:
        driver.close()

    return 0


def delete_credentials():
    try:
        keyring.delete_password(service, None)
        print("Credentials deleted.")
    except keyring.errors.PasswordDeleteError:
        print("No credentials found to delete.")


def set_credentials():
    print("Deleting existing credentials ...")
    delete_credentials()
    print("Please set your new credentials ...")
    keyring.set_password(service, input("Username: "), getpass.getpass())


def main():
    parser = argparse.ArgumentParser(prog='iiserpune-selenium-login', description='Login to IISER Pune network using Selenium.')
    parser.add_argument('-l', '--login', action='store_true', help='run login script')
    parser.add_argument('-d', '--daemon', action='store_true', help='run login script as a daemon that uses DBUS and NetworkManager to check for IISER Pune LAN activation')
    parser.add_argument('-s', '--set-credentials', action='store_true', help='set/reset network credentials')
    parser.add_argument('-r', '--remove-credentials', action='store_true', help='remove network credentials')
    
    args = parser.parse_args()
    
    if args.remove_credentials:
        delete_credentials()
        exit(0)
            
    if args.set_credentials:
        set_credentials()
        exit(0)

    if args.login:
        exit(login())
        
    if args.daemon:
        Daemon()
        exit(0)

    parser.print_help()


if __name__ == "__main__":
    main()
