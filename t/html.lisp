(in-package :cl-user)
(defpackage wax-test.html
  (:use :cl :fiveam))
(in-package :wax-test.html)

(def-suite html
  :description "Tests for the HTML backend.")
(in-suite html)

(defun equal-output (input output)
  (equal (wax:process input :html)
         output))

(test paragraphs
 (is-true
  (equal-output "\\p{{a}{b}}" "<p>a</p><p>b</p>"))
 (is-true
  (equal-output "\\p{{a}  {b}}" "<p>a</p><p>b</p>")))

(test bold
 (is-true
  (equal-output "\\b{test}" "<strong>test</strong>")))

(test italics
 (is-true
  (equal-output "\\i{test}" "<em>test</em>")))

(test list
  (is-true
   (equal-output "\\list{\\item{1}\\item{2}}"
                 "<ul><li>1</li><li>2</li></ul>")))

(test enumerated-list
  (is-true
   (equal-output "\\olist{\\item{1}\\item{2}}"
                 "<ol><li>1</li><li>2</li></ol>")))

(test quote
  (is-true
   (equal-output "\\quote{test}"
                 "<blockquote>test</blockquote>")))

(run! 'html)
