;;; introduction.el --- The practice and introduction for Emacs Lisp
;;; Commentary:
;;; Code:
;;; Print code
(princ "Hello, World\n")                ;; => "Hello, World\n"
(format "%s" "foo" )                    ;; => "foo"
;; 右寄せ 左寄せ ゼロ詰め
(format "[%2d] [%-2d] [%02d]" 3 3 3)    ;; => "[ 3] [3 ] [03]"

;;;;;;;;;;;;;;;;;;;;
;;;; 比較
;;;;;;;;;;;;;;;;;;;;
;; 等しい
(= 10 10)                               ; => t
(= 10 20)                               ; => nil
(= 10 10.0)                             ; => t
;; 等しくない != ではなく /=
(/= 10 9)                               ; => t
(/= 10 10)                              ; => nil
;; 大小比較はC言語などと同じなので省略

;;;;;;;;;;;;;;;;;;;;
;; 変数代入(束縛)
;;;;;;;;;;;;;;;;;;;;
;; a に 1 を代入
(setq a 1)                              ; => 1
a                                       ; => 1
;; 一度に複数の代入
(setq a "foo"                           ; => "foo"
      b 0)                              ; => 0


;;;;;;;;;;;;;;;;;;;;
;; ローカル変数
;;;;;;;;;;;;;;;;;;;;
(setq x 1)                              ; => 1
;; letは同時に代入する
(let ((x 2)
      null)
  x                                     ; => 2
  null                                  ; => nil
  ;; let の入れ子
  (let ((x 3)) x))                      ; => 3
;; let を抜けたので x の値は 1
x                                       ; => 1

;; let*はletの亜種. ローカル変数が順番に代入される
(let* ((x (+ 5 5))
       (y x))
  x                                     ; => 10
  y)                                    ; => 10

;; 入れ子のlet
(setq x 1)
(let ((x 2))
  x                                     ; => 2
  (let ((x 3))
    x                                   ; => 3
    (let ((x 4))
      x                                 ; => 4
      (setq x 9999))
    x                                   ; => 3
    )
  x                                     ; => 2
  )
x                                       ; => 1

;;; letとlet*の違い
(setq x 1)
(let ((x 3) (y (1+ x)))
  (+ x y))                              ; => 5
(let* ((x 3) (y (1+ x)))
  (+ x y))                              ; => 7

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; コンスセル,リスト,ベクタ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; コンスセル (var1 . var2)
'(10 . "ten")                            ; => (10 . "ten")
(cons 10 "ten")                          ; => (10 . "ten")
;; ドットで書くのとconsで書くのとの違いは評価
'((+ 1 2) . 3)                          ; => ((+ 1 2) . 3)
(cons (+ 1 2)  3)                      ; => (3 . 3)
;; carで左側を得る
(car (cons 10 20))                      ; => 10
;; cdrで右側
(cdr (cons 10 20))                      ; => 20
;; リスト
(cons 1 (cons 2 (cons 3 nil)))           ; => (1 2 3)
(list 1 2 3)                             ; => (1 2 3)
'(1 2 3)                                 ; => (1 2 3)
;; リストに要素を追加(前から追加)
(setq l (cons 3 nil))                    ; => (3)
(setq l (cons 2 l))                      ; => (2 3)
(setq l (cons 1 l))                      ; => (1 2 3)
;; リストにおけるcarはリストの先頭, cdrは残りすべてを返す
(car l)                                 ; => 1
(cdr l)                                 ; => (2 3)
;; nth 関数でリストのN番目の要素を得る
(nth 1 l)                               ; => 2
;; elt 関数は引数の順序が nth 関数と逆
(elt l 1)                               ; => 2

;;;;;;;;;;;;;;;;;;;
;; 同値性と同一性
;;;;;;;;;;;;;;;;;;;
;; 同地比較にはequal, 同一比較にはeqを用いる

;;;;;;;;;;;;;;;;;;;
;; 条件分岐
;;;;;;;;;;;;;;;;;;;
;; elispにおいての偽はnilのみ.0や空文字列は真(t) 真偽を反転させるときはnot
(not t)                                 ; => nil
(not 0)                                 ; => nil
;; nil が t
(not nil)                               ; => t
;; 条件付き実行
;; whenは条件式が真のときに評価する.unlessは逆
(let (msg)
  (when (= 0 (% 6 2))
    ;; ここには複数のフォームが書ける
    (setq msg "6は偶数です"))
  msg)                                   ; => "6は偶数です"
;; whenの中が実行されない
(let (msg)
  (when (= 1 (% 6 2))
    (setq msg "6は奇数です"))
  msg)                                  ; => nil

;; 条件分岐
;; 単純なif
(if (zerop (% 6 2))
    "6は偶数"
  ;; 条件を満たさない場合は複数かける
  "6は奇数")                            ; => "6は偶数"
;; 偽フォームは省略可能
(if (= 1 (% 6 2))
    "6は偶数")                          ; => nil
;; ネストしたif
(if (zerop (% 10 4))
    "10は4の倍数"
  (if (zerop (% 10 2))
      "10は偶数"
    "10は奇数"))                      ; => "10は偶数"
;; ifで条件を満たすとき評価されるフォームはひとつしか書けない.複数書きたいときはprognを使うとよい.
(progn
  1
  2)                                    ; => 2
;; ifとの連携
(let (a b)
  (if (= 1 1)
      (progn  ;; この部分が評価されている
        (setq a 2)
        (setq b 3))
    (setq a 10)
    (setq b 20))
  (list a b))                           ; => (2 3)

;; 見づらいのでcondを用いる
(let (a b)
  (cond ((= 1 1)
         (setq a 2)
         (setq b 3))
        (t
         (setq a 10)
         (setq b 20)))
  (list a b))                           ; => (2 3)

;; cond は多重条件分岐で最後に真になった部分のフォームを評価していく
;; すべてが偽である場合nilを返す
;; ネストしたifをcondで書き換え
(if (zerop (% 10 4))
    "10は4の倍数"
  (if (zerop (% 10 2))
      "10は偶数"
    "10は奇数"))                      ; => "10は偶数"
;; cond
(cond ((zerop (% 10 4))
       "10は4の倍数")
      ((zerop (% 10 2))
       "10は偶数")
      (t
       "10は奇数"))                     ; => "10は偶数"
;; 論理式 and or not

;;;;;;;;;;;;;;;;;;;;;;;;;
;; ループ
;;;;;;;;;;;;;;;;;;;;;;;;;
;; while 条件式がtのとき繰り返す
;; 0 ~ 2 のループ
(let ((i 0) result)
     (while (< i 3)
       (setq result (cons i result))
       (setq i (1+ i)))
     result)                            ; => (2 1 0)
;; 条件によるループ
(let ((lst '(1 2 3)) result)
  (while (car lst)
    (setq result (cons (car lst) result))
    (setq lst (cdr lst)))
  result)                               ; => (3 2 1)
;; リストの各要素に対して行うループ
;; (dolist (ループ変数 リスト式)) or (dolist (ループ変数 リスト 返り値指定フォーム))
(let (result)
  (dolist (x '(1 2 3))
    (setq result (cons x result)))      ; => nil
  (cons 'finished result))              ; => (finished 3 2 1)
;; dolistの返り値を指定する
(let (result)
  (dolist (x '(1 2 3) (cons 'finished result))
    (setq result (cons x result))))     ; => (finished 3 2 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 関数定義
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun 関数名 (引数リスト) 関数の中身)
;; 省略可能引数を定義 &optional
(defun optional-arg (a &optional b c)
  (setq c (or c 20))                    ; デフォルト引数もどき
  (list a b c))

(optional-arg 1)                        ; => (1 nil 20)
(optional-arg 1 2)                      ; => (1 2 20)
(optional-arg 1 2 3)                    ; => (1 2 3)
;; 可変長引数 &rest
;; aは必須,bは省略可能引数, cは可変長引数
(defun rest-arg (a &optional b &rest c)
  (list a b c))

(rest-arg 1)                            ; => (1 nil nil)
(rest-arg 1 2)                          ; => (1 2 nil)
(rest-arg 1 2 3)                        ; => (1 2 (3))
(rest-arg 1 2 3 4)                      ; => (1 2 (3 4))
;; lambda 関数 defun 関数名 を lambda に変えたもの
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 練習
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (1) fizzbuzz
(defun fizzbuzz (num)
  (let (result)
    "Fizzbuzz in Emacs Lisp"
    (cond ((and (zerop (% num 3)) (zerop (% num 5)))
           (setq result "FizzBuzz"))
          ((zerop (% num 3))
           (setq result "Fizz"))
          ((zerop (% num 5))
           (setq result "Buzz"))
          (t
           (setq result num)))
    result))
(fizzbuzz 15)                           ; => "FizzBuzz"
(fizzbuzz 3)                            ; => "Fizz"
(fizzbuzz 5)                            ; => "Buzz"

(let (res (n 1))
  (while (<= n 100)
    (append res (list (fizzbuzz n)))    ; => (1), (2), ("Fizz"), (4), ("Buzz"), ("Fizz"), (7), (8), ("Fizz"), ("Buzz"), (11), ("Fizz"), (13), (14), ("FizzBuzz"), (16), (17), ("Fizz"), (19), ("Buzz"), ("Fizz"), (22), (23), ("Fizz"), ("Buzz"), (26), ("Fizz"), (28), (29), ("FizzBuzz"), (31), (32), ("Fizz"), (34), ("Buzz"), ("Fizz"), (37), (38), ("Fizz"), ("Buzz"), (41), ("Fizz"), (43), (44), ("FizzBuzz"), (46), (47), ("Fizz"), (49), ("Buzz"), ("Fizz"), (52), (53), ("Fizz"), ("Buzz"), (56), ("Fizz"), (58), (59), ("FizzBuzz"), (61), (62), ("Fizz"), (64), ("Buzz"), ("Fizz"), (67), (68), ("Fizz"), ("Buzz"), (71), ("Fizz"), (73), (74), ("FizzBuzz"), (76), (77), ("Fizz"), (79), ("Buzz"), ("Fizz"), (82), (83), ("Fizz"), ("Buzz"), (86), ("Fizz"), (88), (89), ("FizzBuzz"), (91), (92), ("Fizz"), (94), ("Buzz"), ("Fizz"), (97), (98), ("Fizz"), ("Buzz")
    (setq n (1+ n)))
  res)                               ; => nil

;; (2)引数に1を加えて返す関数incと引数から1を引いて返す関数dec
(defun inc (x)
  (+ 1 x))
(inc 3)                                 ; => 4

(defun dec (x) (- x 1))
(dec 3)                                 ; => 2

;; (3) 試験の点数に応じてA~Dの成績を返す関数
(defun hyouka (x)
  (let (score)
    (cond ((>= x 80)
           (setq score "A"))
          ((<= 60 x 79)
           (setq score "B"))
          ((<= 40 x 59)
           (setq score "C"))
          (t
           (setq score "D")))
    (message score)))
(hyouka 90)                             ; => "A"
(hyouka 70)                             ; => "B"
(hyouka 50)                             ; => "C"
(hyouka 10)                             ; => "D"

;; (4) 再帰関数(階乗を求める関数fact)
(defun fact (n)
  (if (= n 1)
      1
    (* n (fact (- n 1)))))
(fact 5)                                ; => 120

;; funcall
;; 無名関数を呼び出すときなどに利用
;; Syntax: (funcall 関数 &rest 引数)
;; 変数に登録
(setq twice (lambda (x) (* x 2)))       ; => (lambda (x) (* x 2))
(funcall twice 10)                      ; => 20

;; リストの各要素を関数の引数にする
;; Syntax: (apply 関数 &rest 引数) 最後に渡される引数はリストでなければならない
(apply '+ '(1 2 3 4 5))                 ; => 15

;; リストの各々の要素を処理する
;; Syntax: (mapcar マップ関数 シーケンス)
;; 各要素に1を加える
(let (l)
  (dolist (x '(3 4 5))
    (setq l (cons (1+ x) l)))
  (nreverse l))                         ; => (4 5 6)

(mapcar '1+ '(3 4 5))                    ; => (4 5 6)
;; 返り値を扱わない場合はmapcを用いたほうが良い

;; リストのうち偶数のみを10倍する
(delq nil (mapcar (lambda (x)
                    (when (= 0 (% x 2))
                      (* x 10)))
                  '(1 2 3 4 5)))        ; => (20 40)

;; リストの各要素をつなげた文字列を作成する mapconcat
;; Syntax: (mapconcat マップ関数 シーケンス セパレータ)
;; identityは引数をそのまま返す関数
(mapconcat 'identity '("foo" "bar" "baz") "/") ; => "foo/bar/baz"
(mapconcat 'identity '("foo" "bar" "baz") "")  ; => "foobarbaz"
(apply 'concat '("foo" "bar" "baz"))           ; => "foobarbaz"
;;; introduction.el ends here
