from _example import ffi, lib

p = lib.getpwuid(0)
assert ffi.string(p.pw_name) == b'root'
p = lib.get_pw_for_root()
assert ffi.string(p.pw_name) == b'root'
