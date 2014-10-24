(in-package :cl-user)
(defpackage wax.graphviz
  (:use :cl :plump :wax.emitter :wax.utils))
(in-package :wax.graphviz)

(defun dot-command (dot-string)
  (trivial-shell:shell-command "dot -Tsvg"
                               :input dot-string))

(with-backend :html
  (defrule graphviz () (a tree)
    (declare (ignore a))
    (format nil "<div class='graphviz'>~A</div>"
            (dot-command (serialize-to-string tree)))))
