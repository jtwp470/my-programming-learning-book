(* リストの偶数番目と奇数番目の要素に分割する *)
let rec split_even_odd lst =
  match lst with
    []  -> ([], [])
  | [m] -> ([m], [])
  | m :: n :: rest ->
     let (even, odd) = split_even_odd rest in
     (m :: even, n :: odd);;
