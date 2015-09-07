(* リストに値xが何個含まれているかを返す関数 *)
let rec num_of (lst, x) =
  match lst with
    [] -> 0
  | n :: rest -> 
	if n = x then 1 + num_of (rest, x)
	else num_of (rest, x);;

let num_of' (lst, x) =
  let rec num (lst, acc) =
    match lst with
      [] -> acc
    | n :: rest -> 
       if n = x then num(rest, acc + 1)
       else num (rest, acc) in
  num (lst, 0);;
