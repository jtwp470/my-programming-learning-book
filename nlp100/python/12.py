#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 12. 1列目をcol1.txt に 2列目をcol2.txtに保存する
import sys

if len(sys.argv) != 2:
    print("Usage: python {} filename".format(sys.argv[0]))
    sys.exit()

r = open(sys.argv[1]).readlines()
with open("col1.txt", "w") as f1, open("col2.txt", "w") as f2:
    for line in r:
        s = line.split('\t')
        f1.write(s[0]+'\n')
        f2.write(s[1]+'\n')

r.close()
