(in-package :cl-user)
(defpackage wax.emitter
  (:use :cl)
  (:export :emit))
(in-package :wax.emitter)

(defparameter +default-output-type+ :html)

(defun emit (tree output-type)
  (cond
    ((eq output-type :html)
     (wax.html:emit tree))
    (t nil)))
