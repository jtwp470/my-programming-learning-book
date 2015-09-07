(* リストのリストの各リストの先頭に要素を加える関数 *)
let addelm v lst = List.map (fun y -> [v] @ y)  lst;;

(* リストとして表された集合に対してべき集合を計算する関数 *)  
let rec powset lst =
  match lst with
    [] ->  [[]]
  | [x] -> [[x]] @ [[]]
  | x::rest -> lst :: [x] :: powset rest;;
