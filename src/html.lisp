(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :plump :wax.emitter :wax.utils))
(in-package :wax.html)

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (emit tree) tag))

(defparameter *links* (make-hash-table :test #'equal))

(defbackend :html
  ;;; Basic formatting
  (defrule b () (a tree)
    (declare (ignore a)) (print-tag "strong" tree))
  (defrule i () (a tree)
    (declare (ignore a)) (print-tag "em" tree))
  ;; Links
  (defrule links () (a links)
    (declare (ignore a))
    (loop for link across links do
      (let ((href (emit (children link)))
            (id (attribute link "id")))
        (setf (gethash id *links*)
              href))))
  (defrule link () (attrs text)
    (let ((id (gethash "id" attrs))
          (uri (gethash "uri" attrs)))
      (format nil "<a href=~S>~A</a>"
              (if id
                  ;; Get the associated ID
                  (gethash id *links*)
                  ;; Use a bare URI
                  uri)
              (emit text)))))
