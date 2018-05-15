#from ctypes import *
#import os

from cffi import FFI

ffi = FFI()

lib = ffi.dlopen('./libunit.so')

ffi.cdef('''
  int add(int x, int y);
''')

#lib = cdll.LoadLibrary(os.path.abspath("libunit.so"))
#lib.add.argtypes = [c_int, c_int]
#lib.add.restype = c_int

print("2+2 = ",lib.add(2,2))
