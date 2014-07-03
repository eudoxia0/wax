(in-package :cl-user)
(defpackage wax.utils
  (:use :cl :plump)
  (:export :print-tree
           :cat
           :cat-list
           :pop-by-name
           :pop-all-by-name))
(in-package :wax.utils)

(defun print-tree (tree)
  (format nil "~{~A~#[~:; ~]~}" tree))

(defun cat (&rest strings)
  (apply #'concatenate (cons 'string strings)))

(defun cat-list (list-of-strings)
  (apply #'cat list-of-strings))

(defun pop-by-name (vector elem-name)
  (delete-if #'(lambda (elem)
                 (when (element-p elem)
                   (equal (tag-name elem) elem-name)))
             vector :count 1))

(defun pop-all-by-name (vector elem-name)
  (loop for elem = (pop-by-name vector elem-name)
        while elem collecting elem))
