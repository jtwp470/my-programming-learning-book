(* 二分木のデータ型 *)
type 'a btree =
  Lf
  | Br of 'a * 'a btree * 'a btree;;


(* 二分探索木に新しい要素を挿入する *)
let rec add x tr =
  match tr with
    Lf -> Br (x, Lf, Lf)
  | Br (v, left, right) -> if v > x then Br (v, add x left, right) else Br (v, left, add x right);;


(* 二分探索木の中の最小の要素を返す関数 *)
let rec min_elt tr =
  match tr with
    Lf -> raise (Failure "min_elt")
  | Br (v, left, right) -> if left = Lf then v else min_elt left;;


(* 二分探索木の要素を削除する*)
let rec remove n tr =
  match tr with
    Lf -> Lf
  | Br (v, left, right) ->
     if n < v then Br (v, remove n left, right)      (* 左の子へ進む *)
     else if n > v then Br (v, left, remove n right) (* 右の子へ進む *)
     else
       if left = Lf then right
       else if right = Lf then left
       else let min = min_elt right in
            let rec remove_min ts =
              match ts with
                Lf -> Lf
              | Br (v, Lf, right) -> right
              | Br (v, left, right) -> Br (v, remove_min left, right) in
            Br (min, left, remove_min right);;
    Br (v, left, right) -> if left = Lf then v else min_elt left;;
