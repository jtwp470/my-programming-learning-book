#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 05. n-gram
def ngram(input, n):
    last = len(input) - n + 1
    return [input[i:i+n] for i in range(last)]


if __name__ == "__main__":
    sentence = "I am an NLPer"
    print(ngram(sentence.split(), 2))  # 単語bi-gram
    print(ngram(sentence, 2))          # 文字bi-gram
