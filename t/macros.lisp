(in-package :cl-user)
(defpackage wax-test.macros
  (:use :cl :fiveam))
(in-package :wax-test.macros)

(def-suite macros
  :description "Tests for the macro system.")
(in-suite macros)

(run! 'macros)
