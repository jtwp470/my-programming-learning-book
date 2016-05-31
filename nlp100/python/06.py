#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 06. 集合
def ngram(input, n):
    last = len(input) - n + 1
    return [input[i:i+n] for i in range(last)]


X = set(ngram("paraparaparadise", 2))
Y = set(ngram("paragraph", 2))

print(X)
print(Y)
print(X | Y)  # 和集合
print(X - Y)  # 差集合
print(X & Y)  # 積集合
print("se" in X)
print("se" in Y)
