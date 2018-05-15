// Simple Solution
 
// we rely on implicit conversion from Int to BigInt.
// BigInt is preferable since the numbers get very big, very fast.
// (though for a small example of the first few numbers it's not needed)
def fibStream(init: BigInt*): Stream[BigInt] = {
  def inner(prev: Vector[BigInt]): Stream[BigInt] = prev.head #:: inner(prev.tail :+ prev.sum)
  inner(init.toVector)
}
 
// Optimizing
 
// in the optimized version we don't compute values until it's needed.
// the unoptimized version, computed k elements ahead, where k being 
// the number of elements to sum (fibonacci: k=2, tribonacci: k=3, ...).
def fibStream(init: BigInt*): Stream[BigInt] = {
  def inner(prev: Vector[BigInt]): Stream[BigInt] = {
    val sum = prev.sum
    sum #:: inner(prev.tail :+ sum)
  }
  init.toStream #::: inner(init.toVector)
}
 
// Optimizing Further
 
//instead of summing k elements each phase, we exploit the fact
//that the last element is already the sum of all k preceding elements
def fib2Stream(init: BigInt*): Stream[BigInt] = {
  def inner(prev: Vector[BigInt]): Stream[BigInt] = {
    val n = prev.last * 2 - prev.head
    n #:: inner(prev.tail :+ n)
  }
  //last element must be the sum of k preceding elements, vector size should be k+1
  val v = init.toVector :+ init.sum
  v.toStream #::: inner(v)
}
