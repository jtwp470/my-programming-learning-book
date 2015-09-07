(* 上級編 *)
type exp =
    Var of string
  | Int of int
  | Add of exp * exp
  | Mul of exp * exp;;

(* 2-a *)
(* 2つの単項式の積を返す *)
let rec mul_mono (x, xlst) (y, ylst) =
  match (xlst, ylst) with
    ([], [])   -> (x*y, [])
  | (xlst, []) -> (x*y, xlst)
  | ([], ylst) -> (x*y, ylst)
  (* List.map2はf [a, b] [c, d] -> [f a c, f b d] のようなことをしてくれる *)
  | (xlst, ylst) -> (x * y, List.map2 (fun x -> fun y -> x + y) xlst ylst);;
         
(* 2-b *)
(* 単項式と多項式の積を返す *)
let rec mul_mono_poly mul poly =
  List.map (mul_mono mul) poly;;  

(* 多項式をリストで表現するときに係数を無視した単項式の順番を比較し小さい順に並べる関数 *)
let rec mono_le m1 m2 =
  match (m1, m2) with
    ([], []) -> true
  | (n1::m1', n2::m2') -> n1 < n2 || (n1 = n2 && mono_le m1' m2')
  | _ -> false;;

(* 2-c *)
(* 2つのこの順序で並べられた多項式の和を返す関数 *)
let rec add_poly m1 m2 =
  match (m1, m2) with
    ([], []) -> []
  | (m1, []) -> m1
  | ([], m2) -> m2
  | ((x, xl)::restx, (y, yl)::resty) ->
     if xl = yl then (x + y, xl) :: add_poly restx resty
     else
       if mono_le xl yl then
         (x, xl) :: add_poly restx m2
       else
         (y, yl) :: add_poly m1 resty;;

(* 2-d *)
(* 2つの多項式の積を返す関数 *)
let rec mul_poly m1 m2 =
  match (m1, m2) with
    (m1, []) -> []
  | ([], m2) -> []
  | (x::restx, m2) ->
     (* 単項式と多項式の積と残りの多項式同士の積を足せば良い *)
     add_poly (mul_mono_poly x m2) (mul_poly restx m2);;

(* 2-e *)
(* 
 *  課題1の型expで表された式を展開し多項式に変換する関数exp2poly exp xs
 *  xsは式expに現れる変数をリストとして並べたものである
 *)
let rec initialize_list n =
  match n with
    0 -> []
  | n -> 0 :: initialize_list (n - 1);;

(* var2poly "x" ["x"; "y"; "z"] - : int list = [1; 0; 0] *)
let rec var2mono v xs =
  match (v, xs) with
    (v, []) -> []
  | (v, x::rest) ->
     if (List.mem v [x]) then 1:: initialize_list (List.length rest)
     else 0::var2mono v rest;;

let rec exp2poly exp xs =
  match exp with
    Int x -> [(x, initialize_list (List.length xs))]
  | Var x -> [(1, var2mono x xs)]
  | Add (x, y) -> add_poly (exp2poly x xs) (exp2poly y xs)
  | Mul (x, y) -> mul_poly (exp2poly x xs) (exp2poly y xs);;
