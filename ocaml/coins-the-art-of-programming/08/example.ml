(* インタープリタ *)
(* 
  (string * value) list は [(x1, v1); (x2, v2); ...] でxiをviに対応させる部分関数
  環境envをxからvに対応させる部分関数
 *)
let extend env (x, v) = (x, v)::env;;

(* lookup env xはxに対応する値を返す関数 *)
(* このような使い方を連想リストという *)
let rec lookup l x =
  match l with
    (y, v)::rest -> if x = y then v else lookup rest x;;

type exp =
  | INTexp of int
  | VARexp of string
  | LETexp of string * exp * exp
  | PLUSexp of exp * exp;;

(* インタープリタ:抽象構文木を再帰的に処理 *)
let rec eval env exp =
  match exp with
    INTexp n -> n
  | VARexp x -> lookup env x
  | LETexp (x, exp1, exp2) ->
     let v1 = eval env exp1 in
     eval (extend env (x, v1)) exp2
  | PLUSexp (exp1, exp2) ->
     eval env exp1 + eval env exp2;;

  
