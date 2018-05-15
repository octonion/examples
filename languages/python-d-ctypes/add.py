from ctypes import *
import os

lib = cdll.LoadLibrary(os.path.abspath("libadd.so"))
lib.add.argtypes = [c_int, c_int]
lib.add.restype = c_int

for i in range(0, 10):
    for j in range(0, 10):
        r = lib.add(c_int(i), c_int(j))
        print(i,'+',j,'=',r)
