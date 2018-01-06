package recursion

import scala.annotation.tailrec

/**
 * Different ways to calculate the sum of a list using 
 * recursive Scala methods.
 */
object Sum extends App {

  val list = List.range(1, 100)
  println(sum(list))
  println(sum2(list))
  println(sum3(list))
 // println(sumWithReduce(list))
  
  // (1) yields a "java.lang.StackOverflowError" with large lists
  def sum(ints: List[Int]): Int = ints match { 
    case Nil => 0
    case x :: tail => x + sum(tail)
  }

  // (2) tail-recursive solution
  def sum2(ints: List[Int]): Int = {
    @tailrec
    def sumAccumulator(ints: List[Int], accum: Int): Int = {
      ints match {
        case Nil => accum
        case x :: tail => sumAccumulator(tail, accum + x)
      }
    }
    sumAccumulator(ints, 0)
  }
  
  // (3) good descriptions of recursion here:
  // stackoverflow.com/questions/12496959/summing-values-in-a-list
  // this example is from that page:
  def sum3(xs: List[Int]): Int = {
    if (xs.isEmpty) 0
    else xs.head + sum3(xs.tail)
  }
  
}
