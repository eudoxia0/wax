(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :plump :wax.emitter :wax.utils))
(in-package :wax.html)

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (emit tree) tag))

(defparameter *links* (make-hash-table :test #'equal))

(defbackend :html
  ;;; Basic formatting
  (defrule b () (a tree) (print-tag "strong" tree))
  (defrule i () (a tree) (print-tag "em" tree)))
