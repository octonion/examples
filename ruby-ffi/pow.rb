require 'ffi'

module FfiMathTest
  extend FFI::Library
  ffi_lib 'c'
  ffi_lib 'm'
  attach_function :pow, [ :double, :double ], :double
end
puts FfiMathTest.pow(2.2, 10)
