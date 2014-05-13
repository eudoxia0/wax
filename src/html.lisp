(in-package :cl-user)
(defpackage wax.html
  (:use :cl)
  (:export :emit))
(in-package :wax.html)

(defun emit (tree)
  tree)
