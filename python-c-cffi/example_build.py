# file "example_build.py"

# Note: we instantiate the same 'cffi.FFI' class as in the previous
# example, but call the result 'ffibuilder' now instead of 'ffi';
# this is to avoid confusion with the other 'ffi' object you get below

from cffi import FFI
ffibuilder = FFI()

ffibuilder.set_source("_example",
     r""" // passed to the real C compiler,
        // contains implementation of things declared in cdef()
        #include <sys/types.h>
        #include <pwd.h>

        struct passwd *get_pw_for_root(void) {
            return getpwuid(0);
        }
    """,
    libraries=[])   # or a list of libraries to link with
    # (more arguments like setup.py's Extension class:
    # include_dirs=[..], extra_objects=[..], and so on)

ffibuilder.cdef("""
    // declarations that are shared between Python and C
    struct passwd {
        char *pw_name;
        ...;     // literally dot-dot-dot
    };
    struct passwd *getpwuid(int uid);     // defined in <pwd.h>
    struct passwd *get_pw_for_root(void); // defined in set_source()
""")

if __name__ == "__main__":
    ffibuilder.compile(verbose=True)
