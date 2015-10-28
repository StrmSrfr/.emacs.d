(my-require 'adaptive-wrap)
; http://stackoverflow.com/a/13561223/894885
(defun my-activate-adaptive-wrap-prefix-mode ()
  (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1))
  (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)))
(add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode)
