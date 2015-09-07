(* 実数のリストの要素の和を計算する関数 *)
let rec list_sums lst =
  match lst with
    [] -> 0.
  | x :: rest -> x +. list_sums rest;;

(* リストの長さを返す *)
let rec length lst =
  match lst with
    [] -> 0
  | _ :: rest -> 1 + length rest;;
 
(* 実数のリストの要素の平均値を返す *)
let rec average lst =
  let sum = list_sums lst in
  sum /. float_of_int (length lst);;
