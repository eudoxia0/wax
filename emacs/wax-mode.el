(setq wax-functions-regexp
      "([a-z]+")

(setq wax-font-lock-keywords
  `((,wax-functions-regexp . font-lock-function-name-face)))

(define-derived-mode wax-mode lisp-mode "Wax markup language"
  "Wax mode"
  (setq font-lock-defaults '((wax-font-lock-keywords)))
  (setq comment-start ";")
  (setq comment-end ""))

(provide 'wax-mode)
