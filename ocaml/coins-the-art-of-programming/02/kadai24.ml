(* リストのリスト[[]]を連結する *)
let rec flatten lst =
  match lst with
    [] -> []
  | x :: rest -> x @ flatten rest;;
