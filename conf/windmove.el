(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(with-eval-after-load "org-mode"
  (define-key org-mode-map (kbd "S-left") nil)
  (define-key org-mode-map (kbd "S-right") nil)
  (define-key org-mode-map (kbd "S-up") nil)
  (define-key org-mode-map (kbd "S-down") nil))
