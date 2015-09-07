(* マージソート *)
(* リストの偶数番目と奇数番目の要素に分割する *)
let rec split_even_odd lst =
  match lst with
    []  -> ([], [])
  | [m] -> ([m], [])
  | m :: n :: rest ->
     let (even, odd) = split_even_odd rest in
     (m :: even, n :: odd);;

let rec merge (xl, yl) =
  match (xl, yl) with
    ([], _) -> yl
  | (_, []) -> xl
  | (x::restx, y::resty) -> 
     if x < y then x::merge (restx, yl) 
     else y::merge (xl, resty);;

let rec msort lst =
  let (lst1, lst2) = split_even_odd lst in
  match (lst1, lst2) with
    ([], []) -> []
  | (l1 :: [], []) -> merge (lst1, lst2)
  | ([], l2 :: []) -> merge (lst1, lst2)
  | (l1 :: rest1, []) -> merge ((msort lst1), lst2)
  | ([], l2 :: rest2) -> merge (lst1, (msort lst2))
  | (l1 :: rest1, l2 :: rest2) -> merge ((msort lst1), (msort lst2));;
