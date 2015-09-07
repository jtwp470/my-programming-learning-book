(* 課題1.1  2次方程式の実数解の個数を返す *)
let numRoots (a, b, c) =
  let d = ((b *. b) -. (4.0 *. a *. c)) in
  if d > 0.0 then 2
  else if d = 0.0 then 1 
  else 0;;
