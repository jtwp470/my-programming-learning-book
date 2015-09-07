(* リストを集合とし考えた時に集合の交わりを計算する *)
let rec inter l1 l2 =
  match l1 with
    [] -> []
  | x1::rest ->
     let rec filter pred l =
       match l with
         [] -> []
       | x::rest ->
          if pred x then x::filter pred rest
          else filter pred rest in
     filter (fun x -> x = x1) l2 @ inter rest l2;;
    
(* 集合の全ての要素をある値と対にする関数 *)
let rec pair v lst =
  match lst with
    [] -> []
  | x::rest ->
     let rec map f l =
       match l with
         [] -> []
       | x::rest -> f x :: map f rest in
     map (fun x -> (v, x)) lst;;

(* 2つの集合がリストで与えられたとき直積集合を計算する *)
let rec prod lst1 lst2 =
  match lst1 with
    [] -> []
  | x::rest -> pair x lst2 @ prod rest lst2;;
