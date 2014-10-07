(defsystem wax-math
  :version "0.1"
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "LLGPL"
  :description "Math plugin for Wax."
  :depends-on (:wax
               :texgen)
  :components ((:module "contrib"
                :components
                ((:file "math")))))
