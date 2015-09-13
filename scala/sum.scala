// Scalaで総和を求める問題
// use for loop
object sum {
  def sum1(num:Int):Int = {
    var sum = 0
    for (i <- 1 to num) {
      sum += i
    }
    sum
  }

  // Recursive, Like functional programming style
  def sum2(num:Int):Int = {
    def sum_l(x:List[Int]):Int = if (x.isEmpty) 0 else x.head + sum_l(x.tail)
    sum_l((1 to num).toList)
  }

  // Use match expression
  def sum3(num:Int):Int = {
    val l = (1 to num).toList
    def sum(xs:List[Int], s:Int):Int = {
      xs match {
        case Nil => s
        case x :: rest => sum(rest, s + x)
      }
    }
    sum(l, 0)
  }

  // one-liner
  // _ + _ equals the expression of '(x, y) => x + y'
  // Difference between fold and reduce in Scala, ref to below
  // http://stackoverflow.com/questions/7764197/difference-between-foldleft-and-reduceleft-in-scala
  def sum4(num:Int) = (1 to num).reduceLeft(_ + _)

  def main(args:Array[String]) {
    println(sum1(100))
    println(sum2(100))
    println(sum3(100))
    println(sum4(100))
  }
}
