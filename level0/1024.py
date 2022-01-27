#!/usr/bin/python3
"""Module: level0 hodor
program that votes 1024 times for my id
using post method from request module
"""
import requests



url = "http://158.69.76.135/level0.php"
data = {"id": "3922", "holdthedoor": "Submit"}



if __name__ == "__main__":

    i = 0

    while True:
        i += 1
        post(url, data=data)
        if i == 100:
            break

print("sucesfull voting")
