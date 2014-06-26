(in-package :cl-user)
(defpackage wax.emitter
  (:use :cl)
  (:export :defbackend
           :defcontext
           :defrule))
(in-package :wax.emitter)

;;; Backends

(defparameter *output-types* (list))
(defparameter *rules* (make-hash-table))

(defmacro defbackend (name)
  `(progn (pushnew ,name *output-types*)
          (setf (gethash ,name *rules*)
                (make-hash-table :test #'equal))))

;;; Contexts

(defparameter *contexts* (list))

(defmacro defcontext (name)
  `(push ,(string-upcase (symbol-name name)) *contexts*))

(defcontext global)

;;; Rules

(defmacro defrule (name backend (&rest args) &rest body)
  `(setf (gethash ,(string-upcase (symbol-name name))
                  (gethash ,backend *rules*))
         (lambda ,name (args)
           (destructuring-bind ,args args
             ,@body))))
