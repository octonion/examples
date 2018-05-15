#!/usr/bin/env python

from ctypes import *
import os

lib = cdll.LoadLibrary(os.path.abspath("libadd.so"))
lib.add.argtypes = [c_int, c_int]
lib.add.restype = c_int

print(lib.add(2,2))
