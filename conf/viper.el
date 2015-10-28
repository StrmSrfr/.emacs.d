(setq viper-mode t)
(my-require 'viper); vimpulse is obsolete, evil is broken today
;; Viper is overreaching by caring whether a visited file is under version
;; control -- disable this check.
(defadvice viper-maybe-checkout (around viper-vcs-check-is-retarded activate)
  nil)

(define-key viper-vi-global-user-map
  (kbd "C-u") 'universal-argument) ; default: viper-scroll-down
