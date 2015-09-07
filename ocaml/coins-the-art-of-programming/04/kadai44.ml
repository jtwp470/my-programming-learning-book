(* 有限分岐の木の定義 *)
type 'a ftree = FBr of 'a * 'a ftree list;;

(* 有限分岐の木の例 *)
let ftree = (FBr (1, [FBr (2,[]) ;FBr (3, [FBr (4, [])]); FBr (5, [])]));;

(* 有限分岐の木に対して木の深さを返す *)
let rec fdepth t =
  match t with
    FBr (v, ts) -> fdepth_ts ts
  and fdepth_ts ts =
    match ts with
      [] -> 0
    | t::ts' -> fdepth t + fdepth_ts ts' + 1;;

(* 有限分岐の木を先順で走査する関数 *)	      
let rec fpreorder t =
  match t with
    FBr (v, ts) -> [v] @ fpreorder_ts ts
and fpreorder_ts ts =
  match ts with
    [] -> []
  | x::rest -> fpreorder x @ fpreorder_ts rest;;
		  
