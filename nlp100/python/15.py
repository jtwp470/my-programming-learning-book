#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 15. 末尾からN行を出力
import sys

if len(sys.argv) != 3:
    print("Usage: python {} filename [num]".format(sys.argv[0]))
    sys.exit()


with open(sys.argv[1]) as f:
    txt = f.readlines()
    last = len(txt) - int(sys.argv[2])
    print("".join(txt[last:]))
