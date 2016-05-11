#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 08. 暗号文
def crypt(plain):
    return "".join([chr(219 - ord(p)) if 'a' <= p <= 'z' else p for p in plain])


def decrypt(cipher):
    return crypt(cipher)


assert("this is A pen" == decrypt(crypt("this is A pen")))
assert("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" ==
       decrypt(crypt("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")))
