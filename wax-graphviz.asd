(defsystem wax-graphviz
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :description "Graphviz plugin for Wax."
  :depends-on (:wax
               :trivial-shell)
  :components ((:module "contrib"
                :components
                ((:file "graphviz")))))
