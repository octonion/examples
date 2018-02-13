from ctypes import *
import os

lib = cdll.LoadLibrary(os.path.abspath("libadd.so"))
lib.add_.argtypes = [POINTER(c_int), POINTER(c_int)]
lib.add_.restype = c_int

for i in range(0, 10):
    for j in range(0, 10):
        r = lib.add_(byref(c_int(i)),byref(c_int(j)))
        print(i,'+',j,'=',r)
