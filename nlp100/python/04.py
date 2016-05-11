#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 04. 元素記号
sentence = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
sentence = sentence.split()

element = {}
for i, e in enumerate(sentence, 1):
    l = 1 if i in (1, 5, 6, 7, 8, 9, 15, 16, 19) else 2
    element.update({e[:l]: l})

print(element)
