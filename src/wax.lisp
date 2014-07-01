(in-package :cl-user)
(defpackage wax
  (:use :cl)
  (:import-from :wax.emitter
                :with-backend
                :defbackend
                :defcontext
                :defrule
                :emit)
  (:export :with-backend
           :defbackend
           :defcontext
           :defrule
           :emit
           :process))
(in-package :wax)

(defparameter +default-backend+ :html)

(defmethod process ((input string) &optional (backend +default-backend+))
  (wax.emitter:process input backend))

(defmethod process ((input pathname) &optional (backend +default-backend+))
  (wax.emitter:process input backend))
