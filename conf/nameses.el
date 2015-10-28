(require 'desktop)
(require 'nameses)
(defun nameses-autosave ()
  (interactive)
  (let ((name (nameses-current-name))
        (old-desktop-dirname desktop-dirname))
    (when name
      (nameses-save (concat name "~"))
      (setq desktop-dirname old-desktop-dirname))))
