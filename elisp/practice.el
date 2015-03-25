;;; practice.el --- Practice using Emacs Lisp
;;; Commentary:
;;; Code:
;;; (1) リストの先頭n個の要素からなるリストを返す関数take(lst n)
(defun take (lst n)
  (let ((res) (i 0))
    (while (< i n)
      (setq i (+ 1 i))
      (setq res (cons (car lst) res))
      (setq lst (cdr lst)))
    (nreverse res)))

(take '(1 2 3 4 5) 0)                   ; => nil
(take '(1 2 3 4 5) 1)                   ; => (1)
(take '(1 2 3 4 5) 5)                   ; => (1 2 3 4 5)
(take '(1 2 3 4 5) 9)                   ; => (1 2 3 4 5 nil nil nil nil)

;; (2) リストを非負の要素と負の要素に分割する関数 split_intlist
;;; practice.el ends here
