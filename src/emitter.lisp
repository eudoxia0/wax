(in-package :cl-user)
(defpackage wax.emitter
  (:use :cl :plump :anaphora :wax.utils)
  (:export :with-backend
           :defbackend
           :defcontext
           :defrule
           :emit))
(in-package :wax.emitter)

;;; Backends

(defparameter *output-types* (list))
(defparameter *rules* (make-hash-table))

(defmacro backend-rules (backend-name)
  `(gethash ,backend-name *rules*))

(defmacro with-backend (name &rest body)
  `(let ((+backend+ ,name))
     ,@body))

(defmacro defbackend (name &rest body)
  `(with-backend ,name
     (pushnew ,name *output-types*)
     (setf (backend-rules ,name)
           (make-hash-table :test #'equal))
     ,@body))

;;; Contexts

(defparameter *contexts* (list))

(defmacro defcontext (name)
  `(push ,(string-downcase (symbol-name name)) *contexts*))

(defcontext global)

;;; Rules

(defmacro defrule (name (&optional (context 'global))
                   (&rest args) &rest body)
  `(setf (gethash ,(string-downcase (symbol-name name))
                  (gethash +backend+ *rules*))
         (lambda (args)
           (destructuring-bind ,args args
             ,@body))))

(defun rule (name backend)
  (gethash name (backend-rules backend)))

;;; Emit

(defmethod process ((str string) backend)
  (with-output-to-string (stream)
    (defmethod emit ((node text-node))
      (write-string (text node) stream backend))

    (defmethod emit ((vec vector))
      (loop for elem across vec do
        (emit elem)))

    (defmethod emit ((node element))
      (let ((name (tag-name node))
            (attr (attributes node))
            (children (children node)))
        (aif (rule name backend)
             (funcall it stream attr children)
             (emit children))))

    (emit (parse str) backend)))

(defmethod process ((path pathname) backend)
  (process (uiop:read-file-string path) backend))
