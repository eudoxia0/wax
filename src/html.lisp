(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :plump :wax.emitter :wax.utils)
  (:import-from :wax.files
                :*input-path*
                :*output-path*))
(in-package :wax.html)

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (emit tree) tag))

(defparameter *links* (make-hash-table :test #'equal))

(defparameter *references* (make-hash-table :test #'equal))

(defbackend :html
  ;; Basic Markup
  (defrule p () (a tree)
    (declare (ignore a))
    (cat-list
     (loop for block across tree collecting
       (if (typep block 'text-node)
           ""
           (let ((block-name (tag-name block)))
             (if (equal block-name "div")
                 (print-tag "p" (children block))
                 (emit block)))))))
  (defrule b () (a tree)
    (declare (ignore a))
    (print-tag "strong" tree))
  (defrule i () (a tree)
    (declare (ignore a))
    (print-tag "em" tree))
  ;; Lists
  (defrule list () (a tree)
    (declare (ignore a))
    (print-tag "ul" tree))
  (defrule olist () (a tree)
    (declare (ignore a))
    (print-tag "ol" tree))
  (defrule item () (a tree)
    (declare (ignore a))
    (print-tag "li" tree))
  (defrule deflist () (a tree)
    (declare (ignore a))
    (print-tag "dl" tree))
  (defrule term () (a tree)
    (declare (ignore a))
    (print-tag "dt" tree))
  (defrule def () (a tree)
    (declare (ignore a))
    (print-tag "dd" tree))
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
    (declare (ignore a))
    (print-tag "h1" tree))
  (defrule h2 () (a tree)
    (declare (ignore a))
    (print-tag "h2" tree))
  (defrule h3 () (a tree)
    (declare (ignore a))
    (print-tag "h3" tree))
  (defrule h4 () (a tree)
    (declare (ignore a))
    (print-tag "h4" tree))
  (defrule h5 () (a tree)
    (declare (ignore a))
    (print-tag "h5" tree))
  (defrule h6 () (a tree)
    (declare (ignore a))
    (print-tag "h6" tree))
  ;; Abbreviations
  (defrule abbr () (a tree)
    (format nil "<abbr title=~S>~A</abbr>"
            (gethash "alt" a)
            (emit tree)))
  ;; Quotes
  (defrule quote () (a tree)
    (declare (ignore a))
    (print-tag "blockquote" tree))
  ;; Verbatim
  (defrule verb () (a tree)
    (declare (ignore a))
    (text (elt tree 0)))
  ;; Code
  (defrule code () (a tree)
    (declare (ignore a))
    (print-tag "code" tree))
  (defrule codeb () (a tree)
    (declare (ignore a))
    (format nil "<pre>~A</pre>"
            (print-tag "code" tree))))
