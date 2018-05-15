variable d

: test recursive

  d !

  ." d" d ?

  d @ 1 > if
    ." exiting" cr
    exit
  then

  3 0 do
    i .
    d @
    d @ 1 +
    test
    d !
  loop

;

0 test

bye
