(* 円,正方形,長方形の図形を定義する *)
type figure =
  | Circle of float
  | Square of float
  | Rectangle of float * float;;

let area figure =
  match figure with
  | Circle (r) -> r *. r *. (4.0 *. atan 1.0)
  | Square (x) -> x *. x
  | Rectangle(x, y) -> x *. y;;
