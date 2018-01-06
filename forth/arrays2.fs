\ ----------------------------------- Arrays -----------------------------------

\ Creating arrays is similar to variables, except we need to allocate more
\ memory to them.

\ You can use `2 cells allot` to create an array that's 3 cells long:
variable mynumbers 2 cells allot    \ ok

\ Initialize all the values to 0
mynumbers 3 cells erase    \ ok

\ Alternatively we could use `fill`:
mynumbers 3 cells 0 fill

\ or we can just skip all the above and initialize with specific values:
create mynumbers 64 , 9001 , 1337 , \ ok (the last `,` is important!)

\ ...which is equivalent to:

\ Manually writing values to each index:
64 mynumbers 0 cells + !      \ ok
9001 mynumbers 1 cells + !    \ ok
1337 mynumbers 2 cells + !    \ ok

\ Reading values at certain array indexes:
0 cells mynumbers + ?    \ 64 ok
1 cells mynumbers + ?    \ 9001 ok

\ We can simplify it a little by making a helper word for manipulating arrays:
: of-arr ( n n -- n ) cells + ;    \ ok
mynumbers 2 of-arr ?               \ 1337 ok

\ Which we can use for writing too:
20 mynumbers 1 of-arr !    \ ok
mynumbers 1 of-arr ?       \ 20 ok

bye
