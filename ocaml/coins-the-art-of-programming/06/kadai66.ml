(* 命題論理の論理式のデータ型 *)
type prop = Atom of string
          | Neg of prop         (* 否定 *)
          | Conj of prop * prop (* And *)
          | Disj of prop * prop (* OR *)
;;

(* union を計算する関数 *)
let rec union xs ys =
  match xs with
    [] -> ys
  | z::zs -> if List.mem z ys then union zs ys
             else z::union zs ys;;

(* 論理式の中に含まれるアトムの集合をリストとして返す *)
let rec atoms pr =
  match pr with
    Atom str -> [str]
  | Neg v -> atoms v
  | Conj (v1, v2) -> union (atoms v1) (atoms v2)
  | Disj (v1, v2) -> union (atoms v1) (atoms v2);;

(* 真のアトムのリストと論理式が与えられたとき論理式の真偽を返す関数 *)
let rec prop lst pr =
  match pr with
    Atom x -> if List.mem x lst then true else false
  | Neg (x) -> if (prop lst x) then false else true
  | Conj (x, y) -> if (prop lst x && prop lst y) then true else false
  | Disj (x, y) -> if (prop lst x || prop lst y) then true else false;;

(* 論理式が充足可能であるかを調べる関数 *)
let rec satisfiable pr =
  let rec powset lst =
  match lst with
    [] ->  [[]]
  | [x] -> [[x]] @ [[]]
  | x::rest -> lst :: [x] :: powset rest in
  List.exists (fun x -> prop x pr) (powset (atoms pr));;
