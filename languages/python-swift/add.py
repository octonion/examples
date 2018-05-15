#!/usr/bin/env python

from ctypes import *
import os

lib = cdll.LoadLibrary(os.path.abspath("libadd.so"))
lib._T03addAAS2i1x_Si1ytF.argtypes = [c_int, c_int]
lib._T03addAAS2i1x_Si1ytF.restype = c_int

deck = ([4]*9)
deck.append(16)

sum = lib._T03addAAS2i1x_Si1ytF(2,2)
print "2 + 2 =",sum
