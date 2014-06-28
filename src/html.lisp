(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :wax.emitter :wax.utils))
(in-package :wax.html)

(defbackend :html
  ;;; Basic formatting
  (defrule b () (&rest text) (print-tree text)))
