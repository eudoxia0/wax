(in-package :cl-user)
(defpackage wax
  (:use :cl)
  (:export :process))
(in-package :wax)

(defmethod process ((input string)
                    &optional (output-type +default-output-type+))
  (parse-string input))

(defmethod process ((input pathname)
                    &optional (output-type +default-output-type+))
  (process (uiop:read-file-string input output-type)))
