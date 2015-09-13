object tarai {
  // enable lazy evaluation
  def tarai(x: => Int, y: => Int, z: => Int):Int = {
    if (x <= y) y
    else {
      tarai(tarai(x-1, y, z), tarai(y-1, z, x), tarai(z-1, x, y))
    }
  }
  def main(args:Array[String]) = {
    println(tarai(20, 10, 0))
  }
}
