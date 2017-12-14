// Recursive

def fib(i:Int):Int = i match{
    case 0 => 0
    case 1 => 1
    case _ => fib(i-1) + fib(i-2)
}

// Lazy sequence

lazy val fib: Stream[Int] = 0 #:: 1 #:: fib.zip(fib.tail).map{case (a,b) => a + b}

// Tail recursive

def fib(x:Int, prev: BigInt = 0, next: BigInt = 1):BigInt = x match {
    case 0 => prev
    case 1 => next
    case _ => fib(x-1, next, (next + prev))
}

// foldLeft

// Fibonacci using BigInt with Stream.foldLeft optimized for GC (Scala v2.9 and above)
// Does not run out of memory for very large Fibonacci numbers 

def fib(n:Int) = {
 
  def series(i:BigInt,j:BigInt):Stream[BigInt] = i #:: series(j, i+j)
 
  series(1,0).take(n).foldLeft(BigInt("0"))(_+_)
}
 
// Small test
(0 to 13) foreach {n => print(fib(n).toString + " ")}
 
// result: 0 1 1 2 3 5 8 13 21 34 55 89 144 233 

// Iterator
val it = Iterator.iterate((0,1)){case (a,b) => (b,a+b)}.map(_._1)

// Example:
println(it.take(13).mkString(",")) //prints: 0,1,1,2,3,5,8,13,21,34,55,89,144
