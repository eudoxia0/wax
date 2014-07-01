(in-package :cl-user)
(defpackage wax
  (:use :cl)
  (:export :process))
(in-package :wax)

(defparameter +default-backend+ :html)

(defmethod process ((input string) &optional (backend +default-backend+))
  (wax.emitter:process input backend))

(defmethod process ((input pathname) &optional (backend +default-backend+))
  (wax.emitter:process input backend))
