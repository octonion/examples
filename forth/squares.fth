: squared ( n -- nsquared ) dup *  ;
: sum-of-squares ( a b -- c ) squared swap squared + ;

3 squared . cr
3 4 sum-of-squares . cr

bye

