(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :wax.emitter :wax.utils))
(in-package :wax.html)

(defun print-tag (stream tag children)
  (format stream "<~A>~A</~A>" tag (emit children) tag))

(defbackend :html
  ;;; Basic formatting
  (defrule b () (&rest text) (print-tag "strong" text))
  (defrule i () (&rest text) (print-tag "em" text)))
