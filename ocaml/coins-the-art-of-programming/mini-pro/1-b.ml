(* 変数, 整数, 加算, 乗算から構成された式を定義 *)
type exp =
  Var of string       (* 変数 *)
  | Int of int        (* 整数 *)
  | Add of exp * exp  (* 加算 *)
  | Mul of exp * exp  (* 乗算 *)
;;


(* 単純化した加算の式を返す *)
let add (x, y) =
  match (x, y) with
    (x, Int 0) -> x
  | (Int 0, y) -> y
  | (x, y) -> Add (x, y);;

(* 単純化した乗算の式を返す *)
let mul (x, y) =
  match (x, y) with
    (x, Int 0) -> Int 0
  | (Int 0, y) -> Int 0
  | (x, Int 1) -> x
  | (Int 1, y) -> y
  | (x, y) -> Mul (x, y);;

(* b *)
let rec deriv f v =
  match f with
    Int n -> Int 0
  | Var x -> if x = v then Int 1 else Int 0
  | Add (x1, x2) -> add (deriv x1 v,  deriv x2 v)
  | Mul (x1, x2) -> add (mul (x1, deriv x2 v), mul (x2, deriv x1 v));;
