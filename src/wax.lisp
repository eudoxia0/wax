(in-package :cl-user)
(defpackage wax
  (:use :cl :wax.utils)
  (:import-from :wax.emitter
                :with-backend
                :defbackend
                :defcontext
                :defrule
                :emit)
  (:import-from :wax.files
                :wax-compile)
  (:export :with-backend
           :defbackend
           :defcontext
           :defrule
           :emit
           :process
           :pop-by-name
           :wax-compile))
(in-package :wax)

(defparameter +default-backend+ :html)

(defmethod process ((input string) &optional (backend +default-backend+))
  (wax.emitter:process input backend))

(defmethod process ((input pathname) &optional (backend +default-backend+))
  (wax.emitter:process input backend))
