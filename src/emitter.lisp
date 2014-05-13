(in-package :cl-user)
(defpackage wax.emitter
  (:use :cl)
  (:export :+default-output-type+
           :emit))
(in-package :wax.emitter)

(defparameter +default-output-type+ :html)

(defun emit (tree &optional (output-type +default-output-type+))
  (cond
    ((eq output-type :html)
     (wax.html:emit tree))
    (t nil)))
