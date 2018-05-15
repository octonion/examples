: star
  42 emit ;
  
: stars
  0 ?do
    star
  loop ;

: tower
  0 do
    i stars cr
  loop ;

10 tower
bye
