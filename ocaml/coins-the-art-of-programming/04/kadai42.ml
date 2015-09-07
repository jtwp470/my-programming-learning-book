(* 木の定義 *)
type 'a tree =
  Lf
  | Br of 'a * 'a tree * 'a tree;;

(* 木の例 *)
let tree2= Br ("A", Br ("B", Br ("C", Lf, Lf),
                        Br ("D", Br ("E", Lf, Lf),
                            Lf)),
               Br ("F", Lf, Lf));;  
(* 木の深さを計算する *)
let rec depth t =
  match t with
    Lf -> 0
  | Br (v, t1, t2) -> 1 + max (depth t1) (depth t2)

(* 深さがnですべてのノードのラベルがxの完全2分木を作る関数 *)
let rec comptree (n, x) =
  match n with
    0 -> Lf
  | _ -> Br (x, comptree(n-1, x), comptree(n-1, x));;
