(in-package :cl-user)
(defpackage wax.references
  (:use :cl :plump :wax.emitter :wax.utils))
(in-package :wax.references)

(with-backend :html
  ;; References
  (defrule references () (a references)
    (declare (ignore a))
    (loop for ref across references do
      (if (element-p ref)
          (let ((id (attribute ref "id")))
            (setf (gethash id *references*) nil)))))
  (defrule ref () (attrs text)
    (let ((id (gethash "id" attrs)))
      (format nil "<a href=\"#ref-~A\">~A</a>"
              (gethash id *references*)
              (emit text)))))
