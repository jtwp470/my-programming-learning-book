(* 有限分岐の木の定義 *)
type 'a ftree = FBr of 'a * 'a ftree list;;

(* 有限分岐の木に対して木の深さを返す関数 *)
let rec fdepth ftree =
  match ftree with
    FBr (v, []) -> 1
  | FBr (v, ts) -> (List.fold_left (fun x y -> max x (fdepth y)) 0 ts) + 1;;

(* 有限分岐の木を先順で走査する関数 *)
let rec fpreorder ftree =
  match ftree with
    FBr (v, []) -> [v]
  | FBr (v, ts) -> List.fold_left (fun x y -> x @ fpreorder y) [v] ts;;
