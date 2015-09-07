(* 変数, 整数, 加算, 乗算から構成された式を定義 *)
type exp =
  Var of string       (* 変数 *)
  | Int of int        (* 整数 *)
  | Add of exp * exp  (* 加算 *)
  | Mul of exp * exp  (* 乗算 *)
  | Exp of exp * int  (* 冪乗 *)
;;


(* c *)
let rec deriv f v =
  match f with
    Int n -> Int 0
  | Var x -> if x = v then Int 1 else Int 0
  | Add (x1, x2) -> Add (deriv x1 v,  deriv x2 v)
  | Mul (x1, x2) -> Add (Mul (x1, deriv x2 v), Mul (x2, deriv x1 v))
  | Exp (x,  n)  -> Mul (Int n, Mul (Exp (x, n-1), deriv x v))
;;
