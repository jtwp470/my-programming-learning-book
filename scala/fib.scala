// n番目のフィボナッチ数
// 特に何も考えないで定義する
object fib {
  def fib1(n:Int):Int = {
    n match {
      case 0 => 0
      case 1 => 1
      case _ => fib1(n-1) + fib1(n-2)
    }
  }

  // sumと同じようなパクリ実装
  def fib2(n:Int) = {
    def fib(i:Int, x1:Int, x2:Int):Int = if (i == n) x1 else fib(i+1, x1 + x2, x1)
    fib(0, 0, 1)
  }

  // OCamlで過去に書いたコードをScalaにしたもの
  // https://github.com/jtwp470/my-programming-learning-book/blob/85be8bafdbf9e7cc31b12e89569c0fa48c88df25/ocaml/coins-the-art-of-programming/03/kadai34.ml
  def fib3(n:Int):Int = {
    def fib(n:Int):(Int, Int) = {
      if (n == 0) (0, 1)
      else {
        val (a, b) = fib(n-1)
        (b, a + b)
      }
    }
    fib(n)._1
  }
  def main(args:Array[String]) = {
    println(fib1(20))
    println(fib2(20))
    println(fib3(20))
  }
}
