(in-package :cl-user)
(defpackage wax.utils
  (:use :cl)
  (:export :print-tree
           :cat))
(in-package :wax.utils)

(defun print-tree (tree)
  (format nil "~{~A~#[~:; ~]~}" tree))

(defun cat (&rest strings)
  (apply #'concatenate (cons 'string strings)))
