import argparse
import getpass
import keyring
import time
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException, WebDriverException

service = "iiserpune-selenium-login"


def login():
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.set_page_load_timeout(5)

    logging.info("Chrome was successfuly loaded.")

    try:
        driver.get("http://10.111.1.1:8090/httpclient.html")
    except WebDriverException:
        logging.warn("Your network connection is too weak or is dead.")
        return 1

    credentials = keyring.get_credential(service, None)
    logging.info("Keyring was successfuly accessed.")

    if not credentials:
        logging.warn("No credentials found. Please set your credentials.")
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
        prog="iiserpune-selenium-login",
        description="Login to IISER Pune network using Selenium.",
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
        exit(login())

    if args.daemon:
        try:
            import daemon

            daemon.Daemon(login)
            exit(0)
        except ImportError:
            logging.info("Dependencies haven't been installed to use the daemon.")
            exit(1)

    parser.print_help()


if __name__ == "__main__":
    main()
