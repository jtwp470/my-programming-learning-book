(* 実数float上の関数fを数値的に微分する関数 *)
let deriv f x s = (f (x +. s) -. f x) /. s;;

(* 関数f, 整数nに対してfをn回適用する関数*)
let rec applyn f n x =
  if n = 0 then x else if n = 1 then f x
  else applyn f (n -1) (f x);;
