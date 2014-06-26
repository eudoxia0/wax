(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :wax.emitter)
  (:export :*rules*
           :emit))
(in-package :wax.html)

(defbackend :html)
