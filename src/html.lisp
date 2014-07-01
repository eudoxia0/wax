(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :plump :wax.emitter :wax.utils))
(in-package :wax.html)

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (emit tree) tag))

(defparameter *links* (make-hash-table :test #'equal))

(defparameter *references* (make-hash-table :test #'equal))

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
      (if (element-p link)
          (let ((href (emit (children link)))
                (id (attribute link "id")))
            (setf (gethash id *links*)
                  href)))))
  (defrule link () (attrs text)
    (let ((id (gethash "id" attrs))
          (uri (gethash "uri" attrs)))
      (format nil "<a href=~S>~A</a>"
              (if id
                  ;; Get the associated ID
                  (gethash id *links*)
                  ;; Use a bare URI
                  uri)
              (emit text))))
  ;; Sections
  (defrule h1 () (a tree)
    (declare (ignore a)) (print-tag "h1" tree))
  (defrule h2 () (a tree)
    (declare (ignore a)) (print-tag "h2" tree))
  (defrule h3 () (a tree)
    (declare (ignore a)) (print-tag "h3" tree))
  (defrule h4 () (a tree)
    (declare (ignore a)) (print-tag "h4" tree))
  (defrule h5 () (a tree)
    (declare (ignore a)) (print-tag "h5" tree))
  (defrule h6 () (a tree)
    (declare (ignore a)) (print-tag "h6" tree))
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
              (emit text))))
  ;; Abbreviations
  (defrule abbr () (a tree)
    (format nil "<abbr title=~S>~A</abbr>"
            (gethash "alt" a)
            (emit tree)))
  ;; Quotes
  (defrule quote () (a tree)
    (format nil "<blockquote>~A</blockquote>"
            (emit tree))))
