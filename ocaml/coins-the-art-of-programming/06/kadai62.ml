(* 'a -> bool の関数として表された条件を満たす要素と満たさない要素に分割する *)
let rec split f lst =
  match lst with
    [] -> ([], [])
  | x::rest ->
     let (l1, l2) = split f rest in
     if f x then (x::l1, l2) else (l1, x::l2);;


(* 関数のリスト[f0; f1; f2;...fn]と値vに対しリスト[f0 v; f1 v;...]を返す *)
let rec apply_list fl v =
  match fl with
    [] -> []
  | f::rest -> [f v]  @ apply_list rest v;;
