(in-package :cl-user)
(defpackage wax
  (:use :cl)
  (:import-from :wax.parser
                :parse-string)
  (:import-from :wax.emitter
                :+default-output-type+
                :emit)
  (:export :process))
(in-package :wax)

(defmethod process ((input string)
                    &optional (output-type +default-output-type+))
  (emit (parse-string input) output-type))

(defmethod process ((input pathname)
                    &optional (output-type +default-output-type+))
  (process (uiop:read-file-string input output-type)))
