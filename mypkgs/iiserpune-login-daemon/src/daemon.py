import logging
from pydbus import SystemBus
from gi.repository import GLib


class Daemon:
    def __init__(self, login_script) -> None:
        self.login = login_script

        self.system_bus = SystemBus()
        self.nm = self.system_bus.get(".NetworkManager")

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
        self.devices.append(self.system_bus.get(".NetworkManager", deviceName))
        self.devices[-1].onStateChanged = self.onStateChanged(self.devices[-1])
        logging.info(f"Added New Device: {self.devices[-1].Interface}")

    def removeDevice(self, deviceName):
        self.devices.pop(self.deviceNames.index(deviceName))
        self.deviceNames.remove(deviceName)
        logging.info(f"Removed Device: {deviceName}")

    def onStateChanged(self, device):
        def callback(*args):
            try:
                activeConnection = device.ActiveConnection
            except:
                logging.warning(f"Device no longer exists!")
                return

            if activeConnection != "/":
                logging.info(
                    f"Device({device.Interface}): Checking Connection {activeConnection}",
                )

                try:
                    connection = self.system_bus.get(
                        ".NetworkManager", activeConnection
                    )
                except:
                    logging.warning(f"Device({device.Interface}): Connection aborted.")
                    return

                prefix = f"Device({device.Interface}), Connection({connection.Id})"

                ip4Config = connection.Ip4Config

                if ip4Config != "/":
                    logging.info(f"{prefix}: Checking IP4 Address: {ip4Config}")

                    try:
                        ip = self.system_bus.get(".NetworkManager", ip4Config)
                    except:
                        logging.warning(f"{prefix}: Could not get IP4 address.")
                        return

                    try:
                        logging.info(f"{prefix}: Domains found: {ip.Domains}")
                        if "iiserpune.ac.in" in ip.Domains:
                            logging.info(
                                "IISER Pune domain detected, attempting login."
                            )
                            try:
                                self.login()
                            except:
                                logging.warning("Could not login, try running `iiserpune-login-daemon -l`.")
                                return
                    except:
                        logging.warning("Could not get domains.")
                        return
                else:
                    logging.warning(f"{prefix}: Invalid IP4.")

        return callback
