(* 型'a -> boolの関数として表された条件を満たす要素がリストに存在するかどうかを調べる関数 *)
(* リストのリストを連結する関数をfold_rightを用いて書け *)
let rec flatten l =
  match l with
    [] -> []
  | x::rest -> List.fold_right (fun x y -> x @ y) x (flatten rest);;            

let rec exists f lst = List.fold_left (fun x y -> x || f y) false lst;;
     
(* リストのリストを連結する関数をfold_rightを用いて書け *)
let flatten lst = List.fold_right (fun x y -> x @ y) lst [] ;;            
