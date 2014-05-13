(defsystem wax
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :description "An S-expression-based markup language."
  :depends-on (:esrap
               :uiop
               :anaphora)
  :components ((:module "src"
                :serial t
                :components
                ((:file "parser")
                 (:file "html")
                 (:file "emitter")
                 (:file "wax")))))
