GCobol*>>SOURCE FORMAT IS FIXED
      *> ***************************************************************
      *> Author:    Brian Tiffin
      *> Date:      20110701
      *> Purpose:   Try C library formatted printing, and CALL exception
      *> Tectonics: cobc -x callon.cob
      *>        or  cobc -x callon.cob CBL_OC_DUMP.cob
      *> ***************************************************************
       identification division.
       program-id. callon.

       data division.
       working-storage section.
       01 result      usage binary-long.

       01 pie         usage float-short.
       01 stuff       pic x(12) value 'abcdefghijkl'.

      *> ***************************************************************
       procedure division.
       move 3.141592654 to pie

      *> Get a dump of the memory at pie, but don't stop if not linked
       call "CBL_OC_DUMP" using pie 4 on exception continue end-call

      *> Call C's printf, abort if not available
       call static "printf" using
           "float-short: %10.8f" & x"0a00"
           by value pie
           returning result
       end-call
       display pie space length of pie space result

      *> Get a dump of the memory used by stuff, don't stop if no link
       call "CBL_OC_DUMP" using stuff 12 on exception continue end-call

      *> Get a dump of the memory used by stuff, abort if not linked <*
       call "CBL_OC_DUMP" using stuff 12 end-call

       goback.
       end program callon.
