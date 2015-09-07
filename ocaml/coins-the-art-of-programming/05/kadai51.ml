(* 関数f, 整数mに対してi=0からmのf(i)の総和を求める *)
let summation f m =
  let rec sums f m  =
    if m = 0 then f m else f m + sums f (m -1) in
  sums f m;;
  
(* 上の関数を用いて関数g, 整数m, nを計算する関数をかけ *)
let summation2 f (m, n) =
  summation (fun x -> summation (fun y -> f (x, y)) m) n;;
