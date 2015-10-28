(defun my-turn-on-linum-mode ()
  "turns on linum mode and turns off line-number-mode as it is
  redundant with linum-mode and a waste of space."
  (linum-mode t)
  (line-number-mode 0))

(mapcar (lambda (mode) (add-hook mode 'my-turn-on-linum-mode))
        '(
          conf-javaprop-mode
          emacs-lisp-mode-hook
          fundamental-mode-hook
          jde-mode-hook
          nxml-mode-hook
          sql-mode-hook
          vc-annotate-mode-hook
          ))
