(defun untabify-before-new-line ()
  "Strip trailing whitespaces and untabify this line before new line."
  (save-excursion
    (untabify (line-beginning-position) (line-end-position))
    (delete-trailing-whitespace (line-beginning-position) (line-end-position))
    (ruby-newline-and-indent)
  ))

(add-hook 'ruby-mode-hook
	  (lambda()
            (local-set-key (if rails-use-another-define-key
                               (kbd "RET") (kbd "<return>"))
                           'untabify-before-new-line)))
(provide 'untabify-before-new-line)
