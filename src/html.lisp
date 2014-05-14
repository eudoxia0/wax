(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora)
  (:export :*rules*
           :emit))
(in-package :wax.html)

(defun print-tree (tree)
  (format nil "~{~A~#[~:; ~]~}" tree))

(defparameter *rules* (make-hash-table :test #'equal))

(defmacro rule (name body)
  `(setf (gethash ,name wax.html:*rules*)
         (lambda (tree) ,body)))

(defun get-rule (name)
  (gethash name *rules*))

(rule "h1"
      (progn
        (format nil "<h1>~A</h1>"
                (print-tree (emit tree)))))

(defun emit (tree)
  (if (atom tree)
      tree
      (let ((first (first tree)))
        (cond
          ((atom first)
           ;; Find the rule, and call it
           (aif (get-rule first)
                (progn
                  (funcall it (rest tree)))
                (loop for item in tree
                      collecting (emit item))))
          ((list first)
           (loop for item in tree
                 collecting (emit item)))))))
  
