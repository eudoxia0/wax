(in-package :cl-user)
(defpackage wax.math
  (:use :cl :plump :wax.emitter :wax.utils))
(in-package :wax.math)

(with-backend :html
  ;; TeX Math
  (defrule tex () (a tree)
    (declare (ignore a))
    (format nil "\\(~A\\)" (serialize-to-string tree)))
  (defrule texb () (a tree)
    (declare (ignore a))
    (format nil "\\[~A\\]" (serialize-to-string tree)))
  ;; texgen math
  (defrule m () (a tree)
    (declare (ignore a))
    (format nil "\\(~A\\)"
            (eval (read-string-preserving-case
                   (format nil "(TEXGEN:EMIT '~A)" (emit tree)))))))
