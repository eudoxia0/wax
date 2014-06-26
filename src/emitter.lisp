(in-package :cl-user)
(defpackage wax.emitter
  (:use :cl)
  (:export :+default-output-type+
           :emit))
(in-package :wax.emitter)

(defparameter *output-types* (list))

(defmacro defbackend (name)
  `(push-new ,name *output-types*))

(defparameter +output-types+ (list :html :tex))
(defparameter +default-output-type+ :html)

(defparameter *contexts* (list))

(defmacro defcontext (name)
  `(push ,(string-upcase (symbol-name name)) *contexts*))

(defcontext global)

(defmacro deftag (outout-type name (&optional (context global))
                  (&rest args) &rest body)
  (


(defun emit (tree output-type)
  (cond
    ((eq output-type :html)
     (wax.html:emit tree))
    (t nil)))
