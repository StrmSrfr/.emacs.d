;;; auto-complete
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

(defun disable-ac-in-viper-replace (old &rest args)
  (unless (and (boundp 'viper-current-state)
               (eq viper-current-state 'replace-state))
    (apply old args)))

(advice-add 'ac-start :around 'disable-ac-in-viper-replace)

