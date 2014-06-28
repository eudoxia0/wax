(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :wax.emitter :wax.utils))
(in-package :wax.html)

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (print-tree tree) tag))

(defbackend :html
  ;;; Basic formatting
  (defrule b () (&rest text) (print-tag "strong" text)))
