(in-package :cl-user)
(defpackage wax-test.utils
  (:use :cl :fiveam))
(in-package :wax-test.utils)

(def-suite utils
  :description "Testing Wax's utilities.")
(in-suite utils)

(test cat
  (is
   (equal (wax.utils:cat "test" "test")
          "testtest")))

(test cat-list
  (is
   (equal (wax.utils:cat-list (list "test" "test" "test"))
          "testtesttest")))

(test read-string-preserving-case
  (is
   (equal (wax.utils:read-string-preserving-case ":test")
          :|test|)))

(test serialize-to-string
  (is
   (equal (wax.utils:serialize-to-string
           (plump-tex:parse "\\test{1 2 3}"))
          "\\test{1 2 3}")))

(run! 'utils)