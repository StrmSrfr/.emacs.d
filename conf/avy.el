(my-require 'avy)
(define-key viper-vi-global-user-map
  (kbd "SPC") 'avy-goto-char-2)
(with-eval-after-load "dired"
  (define-key dired-mode-map
    (kbd "TAB") 'avy-goto-char-2))
(customize-set-variable 'avy-keys
                        '(?t ?e ?u ?h ?o ?n ?a ?s ?i ?d))
(customize-set-variable 'avy-goto-word-style 'post)
