(* 課題1.4 累乗の計算 *)
(* 方針1 *)
let rec power1 (x, k) =
  if k = 0 then 1
  else if k = 1 then x
  else x * power1(x, k-1);;

(* 方針2 *)
let rec power2 (x, k) =
  if k = 0 then 1
  else if  k mod 2 = 0 then power2(x * x, k / 2)
  else x * power2(x * x, k / 2);;
