(defsystem wax
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :depends-on (:plump-tex
               :uiop
               :anaphora
               :cl-ppcre)
  :components ((:module "src"
                :serial t
                :components
                ((:file "utils")
                 (:file "parser")
                 (:file "macros")
                 (:file "emitter")
                 (:file "files")
                 (:file "html")
                 (:file "wax"))))
  :description "TeX-like programmatic markup language."
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op wax-test))))
