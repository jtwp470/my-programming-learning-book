(* オプション課題 *)
(* クロージャ *)
(* 以下の2つのデータ型で表される *)
type primop = PLUSop | MINUSop;;

type exp =
  | INTexp of int
  | VARexp of string
  | FNexp of string * exp
  | PRIMexp of primop * exp * exp
  | IFZEROexp of exp * exp * exp
  | APPexp of exp * exp;;

(* 値はこのデータ型で表す*)
type value = INTval of int | CLOSUREval of string * exp * (string * value) list;;

let extend env (x, v) = (x, v)::env;;

let rec lookup l x =
  match l with
    (y, v)::rest -> if x = y then v else lookup rest x;;

let rec eval env exp =
  match exp with
    INTexp x -> INTval x
  | VARexp x -> lookup env x
  | FNexp (str, exp) -> CLOSUREval (str, exp, env)
  | IFZEROexp (exp1, exp2, exp3) -> 
     if (eval env exp1) = INTval 0 then (eval env exp2) else (eval env exp3)
  | PRIMexp (primop, exp1, exp2) ->
     let calc x y =
       match (x, y) with
         (INTval a, INTval b) ->
         if primop = PLUSop then INTval (a + b) else INTval (a - b)
     in calc (eval env exp1) (eval env exp2)
  | APPexp (exp1, exp2) ->
     match (eval env exp1) with
       CLOSUREval (m, n, a) -> let arg = (eval env exp2) in eval (extend a (m, arg)) n;;

(* サンプル実行 *)
let exp1 = 
  APPexp (APPexp (FNexp ("x", 
                             FNexp ("y", PRIMexp (PLUSop, VARexp "x", VARexp  "y"))),
                         INTexp 1),
         INTexp 2);;

let fixsub = FNexp ("x", APPexp (VARexp "f", 
                                 FNexp ("y", 
                                        APPexp (APPexp (VARexp "x", VARexp "x"),
                                                VARexp "y"))));;

let fix = FNexp ("f", APPexp (fixsub, fixsub));;

let sum = 
  FNexp ("g", FNexp ("x", IFZEROexp (VARexp "x",
                                     INTexp 0,
                                     PRIMexp (PLUSop,
                                              VARexp "x",
                                              APPexp (VARexp "g",
                                                      PRIMexp (MINUSop,
                                                               VARexp "x",
                                                               INTexp 1))))));;

let sum n = APPexp (APPexp (fix, sum), INTexp n);;

  eval [] exp1;;
  eval [] (sum 4);;
