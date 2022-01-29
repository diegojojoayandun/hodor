#!/usr/bin/python3
"""votes 1024 times for my Holberton Id.
requierements:
    - tesseract OCR recognition
    - bs4[BeautifulSoup]]
"""


from os import remove
from requests import session
from bs4 import BeautifulSoup

Url = "http://158.69.76.135/level3.php"
captcha_url = "http://158.69.76.135/captcha.php"
user_agent = ("Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) "
              "Gecko/20100101 Firefox/47.0")

header = {"User-Agent": user_agent, "referer": Url}

body = {"id": "3922", "holdthedoor": "submit", "key": "", "captcha": ''}


def get_key(html):
    """Gets the randomic security key"""

    soup = BeautifulSoup(page.text, "html.parser")

    hidden_value = soup.find("form", {"method": "post"})
    hidden_value = hidden_value.find("input", {"type": "hidden"})
    return hidden_value["value"]


def save_captcha(content):
    """Writes the captcha png file to tmp directory"""

    captcha_img = open("/tmp/captcha.png", "wb")
    captcha_img.write(content)
    captcha_img.close()


def read_captcha():
    """Reads from txt captcha file for the captcha text"""

    captcha_text = open("/tmp/captcha.txt", 'r')
    captcha_php = captcha_text.read().replace('\n', '')
    captcha_text.close()
    return captcha_php


def OCR_recognition():
    """Executes tesseract OCR recognition application"""

    exec('import subprocess; subprocess.call(["/usr/bin/tesseract", \
        "/tmp/captcha.png", "/tmp/captcha"])')


if __name__ == "__main__":

    for i in range(1, 20):
        hodor_session = session()

        page = hodor_session.get(url=Url, headers=header)
        body["key"] = get_key(page)

        save_captcha(hodor_session.get(captcha_url).content)
        OCR_recognition()
        remove("/tmp/captcha.png")

        body["captcha"] = read_captcha()

        session_response = hodor_session.post(Url, headers=header, data=body)

        print('Sending vote {}'.format(i))
    print("Hodor Successful voting")
