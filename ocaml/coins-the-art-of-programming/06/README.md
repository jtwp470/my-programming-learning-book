# 課題6.3
```fold_left```と```fold_right```の動き.


型```'a -> bool```の関数として表された条件を満たす要素がリストに存在するか調べる関数fold_leftまたはfold_rightを用いて書け.

コード例:

```
let rec exists f lst = List.fold_left (fun x y -> x || f y) false lst;;
```

動作例
```exists (fun x -> x > 1) [0; 3];;```

まずxにfalse, yにlstの先頭要素が入る.この場合は0 これらを評価するとf yはFalseなのでFalse or False -> Falseとなる.次に前の評価,この場合はFalseがxにyにはlstの次の要素である3が代入されf yはTrueとなるのでFalse or True -> Trueを返す.

fold_leftは基本的にリストの先頭から走査していくため考えるのは楽である.
