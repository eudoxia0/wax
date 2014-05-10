(in-package :cl-user)
(defpackage wax.parser
  (:use :cl :esrap)
  (:export :parse))
(in-package :wax.parser)

(defrule whitespace (+ (or #\space #\tab #\newline))
  (:constant nil))

(defrule valid-char (not (or whitespace #\( #\))))

(defrule atom (+ valid-char)
  (:lambda (list)
    (coerce list 'string)))

(defrule sexp (and (? whitespace) (or list atom))
  (:destructure (w s &bounds start end)
    (declare (ignore w))
    (list s)))

(defrule list (and #\( sexp (* sexp) (? whitespace) #\))
  (:destructure (p1 car cdr w p2)
    (declare (ignore p1 p2 w))
    (cons car cdr)))
