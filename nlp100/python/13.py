#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 13. col1.txt と col2.txtをマージ
f1 = open("col1.txt").readlines()
f2 = open("col2.txt").readlines()

with open("out.txt", "w") as f:
    for x, y in zip(f1, f2):
        f.write(x.strip() + "\t" + y.strip() + "\n")
