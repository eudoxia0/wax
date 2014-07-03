(in-package :cl-user)
(defpackage wax.files
  (:use :cl)
  (:export :wax-compile))
(in-package :wax.files)

(defun move-file (input-path output-path output-type content)
  (let* ((output-dir (make-pathname
                      :directory (pathname-directory output-path)))
         (output-path (make-pathname
                       :directory (pathname-directory output-path)
                       :name (pathname-name input-path)
                       :type output-type)))
    (ensure-directories-exist output-dir)
    (with-open-file (stream output-path
                            :direction :output
                            :if-exists :supersede)
      (write-string content stream))))

(defun wax-compile (backend system-name build-dir &rest files)
  (let ((full-build-path (asdf:system-relative-pathname system-name
                                                        build-dir)))
    (loop for filepath in files do
      (let ((full-path (asdf:system-relative-pathname system-name
                                                      filepath))
            (output-path (merge-pathnames filepath full-build-path)))
        (move-file full-path
                   output-path
                   (string-downcase (symbol-name backend))
                   (with-output-to-string (str)
                     (plump:serialize
                      (plump:parse
                       (wax.emitter:process full-path backend))
                      str)))))))
