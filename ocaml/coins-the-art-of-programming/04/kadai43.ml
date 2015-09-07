(* 木の定義 *)
type 'a tree =
  Lf
  | Br of 'a * 'a tree * 'a tree;;

(* 木の例 *)
let tree2= Br ("A", Br ("B", Br ("C", Lf, Lf),
                        Br ("D", Br ("E", Lf, Lf),
                            Lf)),
               Br ("F", Lf, Lf));;  

(* 木を中順で走査しリストとして返す *)
let rec inorder t =
  match t with
    Lf -> []
  | Br (v, t1, t2) -> inorder t1 @ [v] @ inorder t2;;

(* 木を後順で走査しリストとして返す *)
let rec postorder t =
  match t with
    Lf -> []
  | Br (v, t1, t2) -> postorder t1 @ postorder t2 @ [v];;
