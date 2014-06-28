(in-package :cl-user)
(defpackage wax
  (:use :cl)
  (:import-from :wax.parser
                :parse-string)
  (:import-from :wax.emitter
                :emit)
  (:export :process))
(in-package :wax)

(defparameter +default-backend+ :html)

(defmethod process ((input string) &optional (backend +default-backend+))
  (emit (parse-string input) backend))

(defmethod process ((input pathname) &optional (backend +default-backend+))
  (process (uiop:read-file-string input backende)))
