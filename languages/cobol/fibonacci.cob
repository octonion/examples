      >>source free 
identification division.
program-id. fibonacci-main.
     
data division.
working-storage section.
01         num                                 pic 9(6) comp-5.
01         fib-num                             pic 9(6) comp-5.
           
procedure division.
accept num
call "fibonacci" using content num returning fib-num
display fib-num
.
end program fibonacci-main.
 
identification division.
program-id. fibonacci recursive.

data division.
local-storage section.
01  1-before                            pic 9(6) comp-5.
01  2-before                            pic 9(6) comp-5.
 
linkage section.
01  num     pic 9(6) comp-5.
01  fib-num pic 9(6) comp-5 based.
 
procedure division using num returning fib-num.
	allocate fib-num
	evaluate num
    when 0
         move 0 to fib-num
    when 1
      	 move 1 to fib-num
    when other
       	 subtract 1 from num
       	 call "fibonacci" using content num returning 1-before
       	 subtract 1 from num
       	 call "fibonacci" using content num returning 2-before
       	 add 1-before to 2-before giving fib-num
    end-evaluate
    .
end   program fibonacci.
