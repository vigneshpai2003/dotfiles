import argparse
import getpass
import keyring
import time
import logging
import subprocess
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException, WebDriverException

service = "iiserpune-login-daemon"

def notify(success="Successful.", failure="Failure."):
    def wrapper(foo):
        def foo_notify(*args, **kwargs):
            notify_successful = kwargs.pop("notify_successful", False)
            notify_unsuccessful = kwargs.pop("notify_unsuccessful", False)
            
            status = foo(*args, **kwargs)
            
            if notify_successful and not status:
                subprocess.run(["notify-send", "IISER Pune Login", success])
            elif notify_unsuccessful and status:
                subprocess.run(["notify-send", "IISER Pune Login", failure])

            return status

        return foo_notify
    return wrapper

@notify(success="Login successful.", failure="Could not login ;(")
def login():
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.set_page_load_timeout(5)

    logging.info("Chrome was successfuly loaded.")

    try:
        driver.get("http://10.111.1.1:8090/httpclient.html")
    except WebDriverException:
        logging.warning("Your network connection is too weak or is dead.")
        return 1

    credentials = keyring.get_credential(service, None)
    logging.info("Keyring was successfuly accessed.")

    if not credentials:
        logging.warning("No credentials found. Please set your credentials.")
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
        logging.error("Login failed, likely incorrect credentials.")
        return 1
    else:
        print("Login successful.")
    finally:
        driver.close()

    return 0


def remove_credentials():
    try:
        keyring.delete_password(service, None)
        print("Credentials deleted.")
    except keyring.errors.PasswordDeleteError:
        print("No credentials found to delete.")


def set_credentials():
    print("Deleting existing credentials ...")
    remove_credentials()
    print("Please set your new credentials ...")
    keyring.set_password(service, input("Username: "), getpass.getpass())
    print("Credentials successfuly saved.")


def main():
    parser = argparse.ArgumentParser(
        prog="iiserpune-login-daemon",
        description="Login to IISER Pune network using Selenium. Notifications require `notify-send` to be installed.",
    )
    parser.add_argument("--log", action="store_true", help="enable logging")
    parser.add_argument(
        "-l", "--login", action="store_true", help="run login script without daemon"
    )
    parser.add_argument(
        "-d",
        "--daemon",
        action="store_true",
        help="run login script as a daemon that uses Dbus and NetworkManager to check for IISER Pune LAN activation",
    )
    parser.add_argument(
        "-s",
        "--set-credentials",
        action="store_true",
        help="set/reset network credentials",
    )
    parser.add_argument(
        "-r",
        "--remove-credentials",
        action="store_true",
        help="remove network credentials",
    )
    parser.add_argument(
        "-n",
        "--notify-successful",
        action="store_true",
        help="send a notification after successful login",
    )
    parser.add_argument(
        "-u",
        "--notify-unsuccessful",
        action="store_true",
        help="send a notification after unsuccessful login, ignored in daemon mode",
    )

    args = parser.parse_args()

    if args.log:
        logging.basicConfig(level=logging.INFO)

    if args.remove_credentials:
        remove_credentials()
        exit(0)

    if args.set_credentials:
        set_credentials()
        exit(0)

    if args.login:
        exit(login(notify_successful=args.notify_successful, notify_unsuccessful=args.notify_unsuccessful))

    if args.daemon:
        try:
            import daemon

            daemon.Daemon(lambda: login(notify_successful=args.notify_successful))
            exit(0)
        except ImportError:
            logging.info("Dependencies haven't been installed to use the daemon.")
            exit(1)

    parser.print_help()


if __name__ == "__main__":
    main()
