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

(defmacro simple-html (tag-name)
  `(rule ,tag-name
         (progn
           (format nil ,(format nil "<~A>~~A</~A>" tag-name tag-name)
                   (print-tree (emit tree))))))

(defmacro do-tag-list (&rest tags)
  `(progn
     ,@(loop for tag in tags collecting
             `(simple-html ,tag))))

(do-tag-list "h1" "h2" "h3" "h4" "h5" "h6" "ul" "ol" "li")

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
  
