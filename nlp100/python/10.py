#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 10. 行数のカウント
import sys

if len(sys.argv) != 2:
    print("Usage: python {} filename".format(sys.argv[0]))
    sys.exit()

with open(sys.argv[1]) as f:
    print(len(f.readlines()))
