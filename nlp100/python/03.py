#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 03. 円周率
sentence = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
print([len(c.strip(",.")) for c in sentence.split()])
