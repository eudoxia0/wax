(in-package :cl-user)
(defpackage wax.macros
  (:use :cl :anaphora)
  (:export :def-wax-macro
           :expand-macros))
(in-package :wax.macros)

(defparameter *macros* (make-hash-table :test #'equal))

(defmacro def-wax-macro (name (&rest args) &rest body)
  `(setf (gethash ,(string-downcase (symbol-name name))
                  *macros*)
         #'(lambda (args)
             (destructuring-bind ,args args
               ,@body))))

(defun expand-macros (tree)
  (if (atom tree)
      tree
      (let ((first (first tree)))
        (aif (gethash first *macros*)
             (funcall it (rest tree))
             (mapcar #'expand-macros
                     tree)))))
