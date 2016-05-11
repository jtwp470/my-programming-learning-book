#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 02. 文字列を交互に呼び出して結合する
p = "パトカー"
t = "タクシー"
print("".join([a + b for a, b in zip(p, t)]))
