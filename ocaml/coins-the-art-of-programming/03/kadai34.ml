(* フィボナッチ数列の改善 *)
let fib n =
  let rec iterfib (i, acc1, acc2) =
    if i = n then acc1
    else iterfib (i+1, acc1+acc2, acc1) in
  iterfib (0, 0, 1);;

let rec fib2 n =
  if n = 0 then (0, 1)
  else let (a, b) = fib2 (n-1) in (b, a + b);;		    
