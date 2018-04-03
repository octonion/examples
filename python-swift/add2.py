#!/usr/bin/env python

from ctypes import *
import os

lib = cdll.LoadLibrary(os.path.abspath("libadd2.so"))
lib.add.argtypes = [c_int, c_int]
lib.add.restype = c_int

deck = ([4]*9)
deck.append(16)

sum = lib.add(2,2)
print "2 + 2 =",sum
