(in-package :cl-user)
(defpackage wax.utils
  (:use :cl :plump)
  (:export :print-tree
           :cat
           :cat-list
           :pop-by-name
           :pop-all-by-name
           :read-string-preserving-case
           :serialize-to-string))
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

(defun read-string-preserving-case (string)
  (let ((cur-case (readtable-case *readtable*)))
    (setf (readtable-case *readtable*) :preserve)
    (prog1
        (read-from-string string)
      (setf (readtable-case *readtable*) cur-case))))

(defun serialize-to-string (node)
  (with-output-to-string (str)
    (plump-tex:serialize node str)))
