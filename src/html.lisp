(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :wax.emitter :wax.utils))
(in-package :wax.html)

(defun e (tree)
  (emit tree :html))

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (e tree) tag))

(defparameter *section-depth* 0)

(defbackend :html
  ;;; Basic formatting
  (defrule b () (&rest text) (print-tag "strong" text))
  (defrule i () (&rest text) (print-tag "em" text))
  ;; Sections
  (defrule section () ((&rest title) &rest text)
    (prog1
        (cat
         (print-tag (format nil "h~A" (incf *section-depth*))
                    (e title))
         (e text))
      (decf *section-depth*)))
  ;; Links
  (defrule link () (url &rest text)
    (format nil "<a href=~S>~A</a>" url (e text)))
  ;; Paragraphs
  (defrule p () (&rest paragraphs)
    (cat-list (mapcar #'(lambda (paragraph)
                          (print-tag "p" (e paragraph)))
                      paragraphs))))
