(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :wax.emitter :wax.utils))
(in-package :wax.html)

(defmacro print-tag (stream tag tree)
  `(progn
     (format ,stream "<~A>" ,tag)
     (emit ,tree)
     (format ,stream "</~A>" ,tag)))

(defbackend :html
  ;;; Basic formatting
  (defrule b () (s a tree) (print-tag s "strong" tree))
  (defrule i () (s a tree) (print-tag s "em" tree)))
