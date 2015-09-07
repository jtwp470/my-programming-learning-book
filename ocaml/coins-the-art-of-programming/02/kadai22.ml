(* リストの先頭n個の要素を取り除いたリストを返す *)
let rec drop (lst, n) =
  match lst with
    [] -> []
  | x :: rest -> if n = 0 then lst else drop(rest, n-1);;
