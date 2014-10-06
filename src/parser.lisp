(in-package :cl-user)
(defpackage wax.parser
  (:use :cl)
  (:export :parse-string
           :parse-file))
(in-package :wax.parser)

(defun parse-string (string)
  (plump-tex:parse string))

(defun parse-file (pathname)
  (plump-tex:parse pathname))
