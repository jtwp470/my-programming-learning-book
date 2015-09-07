(* 整数リストが与えられ負の要素の和と正の要素の和の組を求める *)
let sum_pair' lst =
  let rec sums (lst, ltz, gtz) = 
    match lst with
      [] -> (ltz, gtz)
    | x :: rest ->
       if x > 0 then sums (rest, ltz, x + gtz) else sums (rest, x + ltz, gtz) in
  sums (lst, 0, 0);;
