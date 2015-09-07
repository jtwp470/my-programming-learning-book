(* クイックソートのプログラムの要素の順序を決める関数を引数として取るようにする *)
let rec qsort le l =
  match l with
    [] -> []
  | b::rest ->
     let rec split le l =
       match l with
         [] -> ([], [])
       | x::rest ->
          let (l1, l2) = split le rest in
          if le x b then (x::l1, l2) else (l1, x::l2) in
     let (l1, l2) = split le rest in
     qsort le l1 @ (b::qsort le l2);;
