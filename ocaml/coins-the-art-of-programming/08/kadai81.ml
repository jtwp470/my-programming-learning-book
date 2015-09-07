type primop = PLUSop | MULop;;

type exp = INTexp of int
         | FLOATexp of float
         | VARexp of string
         | LETexp of string * exp * exp
         | PRIMexp of primop * exp * exp;;

(* 上のデータ構造で表されたプログラムを文字列に変換する *)
let rec exp2string exp =
  match exp with
    INTexp x -> string_of_int x
  | FLOATexp x -> string_of_float x
  | VARexp x -> x
  | PRIMexp (primop, exp1, exp2) ->
     if primop = PLUSop then
       "(" ^ exp2string exp1 ^ "+" ^ exp2string exp2 ^ ")"
     else
       "(" ^ exp2string exp1 ^ "*" ^ exp2string exp2 ^ ")"
  | LETexp (str, exp1, exp2) ->
     "let " ^ str ^ "=" ^ exp2string exp1 ^ " in " ^ exp2string exp2;;

  
(* 
 * 上のデータ構造で与えられたプログラムを評価するインタープリタ 
 *  データ型valueで示し 整数と実数の演算時は整数を実数に変換して計算する
 *)
type value = INTval of int | FLOATval of float;;

let extend env (x, v) = (x, v)::env;;

let rec lookup l x =
  match l with
    (y, v)::rest -> if x = y then v else lookup rest x;;

let plusop exp1 exp2 =
  match (exp1, exp2) with
    (INTval x, INTval y) -> INTval (x + y)
  | (INTval x, FLOATval y) -> FLOATval (float_of_int x +. y)
  | (FLOATval x, INTval y) -> FLOATval (x +. float_of_int y)
  | (FLOATval x, FLOATval y) -> FLOATval (x +. y);;

let multiop exp1 exp2 =
  match (exp1, exp2) with
    (INTval x, INTval y) -> INTval (x * y)
  | (INTval x, FLOATval y) -> FLOATval (float_of_int x *. y)
  | (FLOATval x, INTval y) -> FLOATval (x *. float_of_int y)
  | (FLOATval x, FLOATval y) -> FLOATval (x *. y);;


let rec eval env exp =
  match exp with
    INTexp n -> INTval n
  | FLOATexp n -> FLOATval n
  | VARexp n -> lookup env n
  | LETexp (x, exp1, exp2) ->
     let v1 = eval env exp1 in eval (extend env (x, v1)) exp2
  | PRIMexp (primop, exp1, exp2) ->
     if primop = PLUSop then
       plusop (eval env exp1) (eval env exp2)
     else
       multiop (eval env exp1) (eval env exp2);;
