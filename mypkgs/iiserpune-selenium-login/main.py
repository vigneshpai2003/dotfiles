import argparse
import getpass
import keyring
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException, WebDriverException

service = "iiserpune-selenium-login"

def login():
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    try:
        driver.get("http://10.111.1.1:8090/httpclient.html")
    except WebDriverException:
        print("You are not connect to the LAN.")
        exit(1)

    credentials = keyring.get_credential(service, None)
    
    if not credentials:
        print("No credentials found. Please set your credentials.")
        exit(1)

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
        exit(1)
    else:
        print("Login successful.")
    finally:
        driver.close()


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
    parser.add_argument('-s', '--set-credentials', action='store_true', help='set/reset network credentials')
    parser.add_argument('-d', '--delete-credentials', action='store_true', help='delete network credentials')
    
    args = parser.parse_args()
    
    if args.delete_credentials:
        delete_credentials()
        exit(0)
            
    if args.set_credentials:
        set_credentials()
        exit(0)

    if args.login:
        login()
        exit(0)

    parser.print_help()

if __name__ == "__main__":
    main()