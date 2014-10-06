(in-package :cl-user)
(defpackage wax.html
  (:use :cl :anaphora :plump :wax.emitter :wax.utils)
  (:import-from :wax.files
                :*input-path*
                :*output-path*))
(in-package :wax.html)

(defun print-tag (tag tree)
  (format nil "<~A>~A</~A>" tag (emit tree) tag))

(defun read-string-preserving-case (string)
  (let ((cur-case (readtable-case *readtable*)))
    (setf (readtable-case *readtable*) :preserve)
    (prog1
        (read-from-string string)
      (setf (readtable-case *readtable*) cur-case))))

(defparameter *links* (make-hash-table :test #'equal))

(defparameter *references* (make-hash-table :test #'equal))

(defbackend :html
  ;;; Basic Markup
  (defrule p () (a tree)
    (declare (ignore a))
    (print-tag "p" tree))
  (defrule b () (a tree)
    (declare (ignore a))
    (print-tag "strong" tree))
  (defrule i () (a tree)
    (declare (ignore a))
    (print-tag "em" tree))
  ;; Lists
  (defrule item () (a tree)
    (declare (ignore a))
    (print-tag "li" tree))
  (defrule list () (a tree)
    (declare (ignore a))
    (print-tag "ul" tree))
  (defrule olist () (a tree)
    (declare (ignore a))
    (print-tag "ol" tree))
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
  ;; TeX Math
  (defrule tex () (a tree)
    (declare (ignore a))
    (format nil "$~A$" (plump-tex:serialize (emit tree))))
  (defrule texb () (a tree)
    (declare (ignore a))
    (format nil "\\[~A\\]" (plump-tex:serialize (emit tree))))
  ;; texgen math
  (defrule m () (a tree)
    (declare (ignore a))
    (format nil "\\(~A\\)"
            (eval (read-string-preserving-case
                   (format nil "(TEXGEN:EMIT '~A)" (emit tree))))))
  ;; Sidenotes
  (defrule sidenote () (a tree)
    (declare (ignore a))
    (format nil "<div class=\"sidenote\">~A</div>"
            (emit tree)))
  ;; Quotes
  (defrule quote () (a tree)
    (declare (ignore a))
    (format nil "<blockquote>~A</blockquote>"
            (emit tree)))
  ;; Verbatim
  (defrule verb () (a tree)
    (declare (ignore a))
    (text (elt tree 0))))
