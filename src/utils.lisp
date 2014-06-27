(in-package :cl-user)
(defpackage wax.utils
  (:use :cl)
  (:export :print-tree))
(in-package :wax.utils)

(defun print-tree (tree)
  (format nil "~{~A~#[~:; ~]~}" tree))
