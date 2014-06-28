(in-package :cl-user)
(defpackage wax
  (:use :cl :wax.emitter :wax.utils)
  (:import-from :wax.parser
                :parse-string)
  (:export :process
           :with-backend
           :defrule
           :print-tree))
(in-package :wax)

(defparameter +default-backend+ :html)

(defmethod process ((input string) &optional (backend +default-backend+))
  (emit (parse-string input) backend))

(defmethod process ((input pathname) &optional (backend +default-backend+))
  (process (uiop:read-file-string input) backend))
