: fac recursive
  dup 1 > if
    dup 1 - fac *
  else
    drop 1
  then ;
 
: lp
  swap 1 + swap
  do
    i . i ." ! = " i fac . cr
  loop ;
 
20 0 lp

bye

