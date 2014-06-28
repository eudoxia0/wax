(in-package :cl-user)
(defpackage wax.parser
  (:use :cl :esrap)
  (:import-from :ppcre
                :regex-replace-all)
  (:export :parse-string))
(in-package :wax.parser)

(defun preprocess (text)
  "Prettify the text"
  (let ((out (regex-replace-all "--" text "–")))
    (setf out (regex-replace-all "---" out "—"))
    (setf out (regex-replace-all "\\.\\.\\." out "…"))
    out))

(defrule whitespace (+ (or #\space #\tab #\newline))
  (:constant nil))

(defrule valid-char (not (or whitespace #\( #\))))

(defrule atom (+ valid-char)
  (:lambda (list)
    (preprocess (text list))))

(defrule sexp (and (? whitespace) (or verbatim list atom))
  (:destructure (w s &bounds start end)
    (declare (ignore w))
    (first (list s))))

(defrule list (and #\( sexp (* sexp) (? whitespace) #\))
  (:destructure (p1 car cdr w p2)
    (declare (ignore p1 p2 w))
    (cons car cdr)))

(defrule verb-char (not ">>>"))

(defrule verbatim (and "<<<" (* verb-char) ">>>")
  (:destructure (open text close)
   (declare (ignore open close))
   (text text)))

(defun parse-string (string)
  (parse 'sexp string))
