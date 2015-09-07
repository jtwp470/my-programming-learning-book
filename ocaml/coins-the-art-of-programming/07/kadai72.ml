(* 例外の定義 *)
exception Zero;;

(* 整数リストの積を求める ただし0を見つけたら例外を発生させる *)
let rec preprod lst =
  match lst with
    [] -> 1
  | x::rest -> if x = 0 then raise Zero else x * preprod rest;;

(* 上の関数を用いて整数リストに積を求める関数 *)
let prod lst = try preprod lst with Zero -> 0;;    
