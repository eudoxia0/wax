(defsystem wax
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :description "Markup."
  :depends-on (:plump-tex
               :uiop
               :anaphora
               :cl-ppcre
               :texgen)
  :components ((:module "src"
                :serial t
                :components
                ((:file "utils")
                 (:file "parser")
                 (:file "emitter")
                 (:file "files")
                 (:file "html")
                 (:file "wax")))))
