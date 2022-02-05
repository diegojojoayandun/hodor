#!/usr/bin/python3
"""Module proxy - gets a list of proxy
servers from a particular url
"""

import requests
import re


class Proxy:
    """Proxy Class to retieves a list of
    proxies from a partiuclar Url"""

    regex = ("^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]"
             "{1,2})(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{"
             "1,2})){3}(:((6553[0-5])|(655[0-2][0-9])|(65[0-4]"
             "[0-9]{2})|(6[0-4][0-9]{3})|([1-5][0-9]{4})|([0-5]"
             "{1,5})|([0-9]{1,4})))?$|^$")

    def __init__(self, url='http://spys.me/proxy.txt') -> None:
        self.url = url

    def GetProxies(self):
        """Proxy Class to retieves a list
        of proxies from a partiuclar Url"""

        pl = set()
        s = requests.Session()
        response = s.get(self.__url)
        HTML = response.text.split()

        i = 0
        for IP in (HTML):
            if ":" in IP:
                if (re.search(Proxy.regex, IP)):
                    pl.add(IP)

        return pl

    @property
    def url(self):
        """gets the width"""
        return self.__url

    @url.setter
    def url(self, url):
        """Sets the url
        url: value of the url
        """

        self.__url = url
