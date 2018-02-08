from ctypes import *
import os
    
def main():
    #test_lib = CDLL('median_test')
    test_lib = cdll.LoadLibrary(os.path.abspath("libmedian_test.so"))
    
    # Function parameter types
    test_lib.median.argtypes = [POINTER(c_double), c_int]
    
    # Function return types
    test_lib.median.restype = c_double
    
    # Calc some numbers
    nums = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
    nums_arr = (c_double * len(nums))()
    for i,v in enumerate(nums):
        nums_arr[i] = c_double(v)
    
    med_res = test_lib.median(nums_arr, c_int(len(nums_arr)))
    print('The median of %s is: %f'%(nums, med_res))
    
if __name__ == '__main__':
    main()
