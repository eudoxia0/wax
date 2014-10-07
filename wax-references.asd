(defsystem wax-references
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :description "References plugin for Wax."
  :depends-on (:wax)
  :components ((:module "contrib"
                :components
                ((:file "references")))))
