(require 'ido)
;;; flx-ido
(require 'flx-ido)
(ido-mode t)
(ido-everywhere 1)
;(customize-set-variable 'ido-auto-merge-delay-time 0.1)
(customize-set-variable 'ido-use-virtual-buffers t)
(customize-set-variable 'ido-use-filename-at-point 'guess)
(customize-set-variable 'ido-file-extensions-order '("" ".java" ".form" t))
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;;; ido-vertical-mode
(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(customize-set-variable
 'ido-vertical-define-keys
 'C-n-C-p-up-down-left-right)

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(my-require 'idomenu)
