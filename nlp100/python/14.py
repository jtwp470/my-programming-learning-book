#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 14. 先頭からN行を出力
import sys

if len(sys.argv) != 3:
    print("Usage: python {} filename [num]".format(sys.argv[0]))
    sys.exit()


with open(sys.argv[1]) as f:
    print("".join(f.readlines()[:int(sys.argv[2])]))
