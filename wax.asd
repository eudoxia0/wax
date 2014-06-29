(defsystem wax
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :description "An S-expression-based markup language."
  :depends-on (:plump
               :uiop
               :anaphora
               :cl-ppcre)
  :components ((:module "src"
                :serial t
                :components
                ((:file "utils")
                 (:file "emitter")
                 (:file "html")))))
