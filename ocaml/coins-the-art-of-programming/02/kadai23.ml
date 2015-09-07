(* 整数のリストが与えられたとき,非負の要素と負の要素に分割する *)
let rec split_intlist lst =
  match lst with
    [] -> ([], [])
  | x :: rest ->
     let (gtez, ltz) = split_intlist rest in
     if x < 0 then (gtez, x :: ltz)
     else (x :: gtez, ltz);;
