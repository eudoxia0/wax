(in-package :cl-user)
(defpackage wax.emitter
  (:use :cl)
  (:export :defbackend
           :defcontext
           :defrule
           :emit))
(in-package :wax.emitter)

;;; Backends

(defparameter *output-types* (list))
(defparameter *rules* (make-hash-table))

(defmacro backend-rules (backend-name)
  `(gethash ,backend-name *rules*))

(defmacro defbackend (name &rest body)
  `(let ((+backend+ ,name))
     (pushnew ,name *output-types*)
     (setf (backend-rules ,name)
           (make-hash-table :test #'equal))
     ,@body))

;;; Contexts

(defparameter *contexts* (list))

(defmacro defcontext (name)
  `(push ,(string-upcase (symbol-name name)) *contexts*))

(defcontext global)

;;; Rules

(defmacro defrule (name (&optional (context 'global))
                   (&rest args) &rest body)
  `(setf (gethash ,(string-upcase (symbol-name name))
                  (gethash +backend+ *rules*))
         (lambda (args)
           (destructuring-bind ,args args
             ,@body))))

(defmacro rule (name backend)
  `(gethash ,(string-upcase (symbol-name name))
            (backend-rules ,backend)))

;;; Emit

(defun emit (tree backend)
  (if (atom tree)
      atom
      (let ((first (first tree)))
        (aif (rule first backend)
             (funcall it (rest tree))
             (mapcar #'(lambda (elem)
                         (emit elem backend))
                     tree)))))
