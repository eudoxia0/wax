(defsystem wax-test
  :author "Fernando Borretti"
  :license "LLGPL"
  :depends-on (:wax
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "utils")
                 (:file "macros")
                 (:file "html")))))
