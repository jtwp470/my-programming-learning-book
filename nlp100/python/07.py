#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 07. テンプレートによる文生成
import sys


def template(x, y, z):
    return "%s時の%sは%s" % (x, y, z)


def main():
    if len(sys.argv) != 4:
        print("Usage python 07.py x y z")
        sys.exit(1)

    print(template(sys.argv[1], sys.argv[2], sys.argv[3]))


if __name__ == "__main__":
    main()
