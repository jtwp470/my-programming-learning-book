#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import random


# Is lst sorted?
def is_sorted(lst):
    for i in range(len(lst)-1):
        if lst[i] > lst[i+1]:
            return False
    return True


def bogoSort(l):
    """Bogo Sort (also stupid sort, slow sort, random sort, shotgun sort or monkey sort)

    Average case performance: O(n!)
    Worst case performance  : Infinity
    Best case performance   : O(n) [Faster than quick sort!!]
    """
    while is_sorted(l) is False:
        random.shuffle(l)
    return l


if __name__ == "__main__":
    l = [i for i in range(10, 0, -1)]
    print(l)
    print(bogoSort(l))
