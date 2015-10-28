(add-to-list 'load-path "~/Projects/benchmark-init-el/")
(require 'benchmark-init-loaddefs)
(benchmark-init/activate)

(load "~/Projects/cedet/cedet-devel-load.el")
(add-to-list 'load-path "~/.emacs.d/lisp/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(apropos-do-all t)
 '(auto-revert-verbose nil)
 '(blink-cursor-blinks 1)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cursor-in-non-selected-windows nil)
 '(delete-selection-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(git-gutter:handled-backends (quote (git svn)))
 '(global-semantic-idle-local-symbol-highlight-mode t nil (semantic/idle))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(jde-checkstyle-classpath (quote ("/cygdrive/c/checkstyle-6.5-all.jar")))
 '(jde-cygwin-path-converter (quote (jde-cygwin-path-converter-cygpath)))
 '(jde-db-option-connect-socket (quote ("127.0.0.1" "4444")))
 '(load-prefer-newer t)
 '(mark-ring-max 32)
 '(mode-line-format
   (quote
    ((:eval
      (number-to-string
       (floor
        (log
         (memory-limit)
         1.5))))
     "%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
     (vc-mode vc-mode)
     "  " mode-line-modes mode-line-misc-info mode-line-end-spaces)))
 '(recentf-max-menu-items 400)
 '(recentf-max-saved-items 400)
 '(recentf-menu-filter (quote recentf-arrange-by-dir))
 '(recentf-mode t)
 '(show-paren-style (quote mixed))
 '(show-trailing-whitespace t)
 '(split-height-threshold 120)
 '(undo-outer-limit 14000000)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(visible-bell t)
 '(which-key-key-replacement-alist
   (quote
    (("<\\(\\(C-\\|M-\\)*.+\\)>" . "\\1")
     ("left" . "←")
     ("right" . "→")
     ("C-" . "^")
     ("M-" . "$"))))
 '(which-key-mode t)
 '(which-key-separator " ")
 '(window-combination-resize t)
 '(x-stretch-cursor t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-prompt ((t (:foreground "mint cream" :weight bold)))))

(setq-default abbrev-mode nil)
(mapcar 'load
        (mapcar 'expand-file-name
                (mapcar (lambda (x) (concat "~/.emacs.d/conf/" x))
                        '(
                          "melpa"; defines my-require
                          "viper"; requires my-require
                          "cygwin"

                          "color-theme"
                          "adaptive-wrap"
                          "auto-complete"
                          "avy"
                          "backup"
                          "buffer-move"
                          "dired"
                          "eldoc-mode"
                          "elisp"
                          "fill-column-indicator"
                          "flyspell"
                          "heartbeat-cursor"
                          "nameses"; load prior to ido
                          "ido"
                          "jdee"; depends(ish) auto-complete
                          "linum-mode"
                          "show-paren-mode"
                          "slime"
                          "sql"
                          "windmove"
                          "zygospore"))))

;;; http://stackoverflow.com/a/29504426/894885
(defun my-vc-dir-delete-marked-files ()
  "Delete all marked files in a `vc-dir' buffer."
  (interactive)
  (let ((files (vc-dir-marked-files)))
    (if (not files)
        (message "No marked files.")
      (when (yes-or-no-p (format "%s %d marked file(s)? "
                                 (if delete-by-moving-to-trash "Trash" "Delete")
                                 (length files)))
        (unwind-protect
            (mapcar
             (lambda (path)
               (if (and (file-directory-p path)
                        (not (file-symlink-p path)))
                   (when (or (not (directory-files
                                   path nil directory-files-no-dot-files-regexp))
                             (y-or-n-p
                              (format "Directory `%s' is not empty, really %s? "
                                      path (if delete-by-moving-to-trash
                                               "trash" "delete"))))
                     (delete-directory path t t))
                 (delete-file path t)))
             files)
          (revert-buffer))))))

; http://rejeep.github.io/emacs/elisp/2010/03/26/rename-file-and-buffer-in-emacs.html
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))
(global-set-key (kbd "C-x C-r") 'rename-this-buffer-and-file)

(eval-after-load 'vc-dir
  '(define-key vc-dir-mode-map (kbd "k") 'my-vc-dir-delete-marked-files))
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

;(my-require "git-gutter-fringe+")
;(git-gutter-fr+-minimal)
(which-key-mode)
(diminish 'which-key-mode)

(add-hook 'eshell-mode-hook
              '(lambda nil
                 (eshell/export "EDITOR=emacsclient")
                 (eshell/export "VISUAL=emacsclient")))
(my-require 'highlight-symbol)
(setq highlight-symbol-on-navigation-p t)
(global-set-key (kbd "C-<f3>") 'highlight-symbol-next)
(global-set-key (kbd "C-S-<f3>") 'highlight-symbol-prev)
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))

(defun viz ()
  (interactive)
  (message (let ((keysboard '(("`" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "[" "]" "<backspace>")
                              ("<tab>" "'" "," "." "p" "y" "f" "g" "c" "r" "l" "/" "=" "\\")
                              ("a" "o" "e" "u" "i" "d" "h" "t" "n" "s" "-" "<ret>")
                              (";" "q" "j" "k" "x" "b" "m" "w" "v" "z")
                              ("<SPC>"))))
             (mapconcat (lambda (row)
                          (mapconcat (lambda (s) (if s "x" "o"))
                                     (mapcar #'key-binding
                                             (mapcar #'kbd
                                                     (mapcar
                                                      (lambda (s)
                                                        (concat "C-" s))
                                                      row)))
                                     ""))
                        keysboard "\n"))
           )
  )
(load "~/Projects/javap-handler/javap-handler.el")

(defun xah-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.

URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-01-26"
  (interactive)
  (let* (
         (ξfile-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (ξdo-it-p (if (<= (length ξfile-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))

    (when ξdo-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (fPath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))) ξfile-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (fPath) (shell-command (format "open \"%s\"" fPath)))  ξfile-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) ξfile-list))))))

(defun xah-open-in-desktop ()
  "Show current file in desktop (OS's file manager).
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-06-12"
  (interactive)
  (cond
   ((string-equal system-type "cygwin")
    (shell-command "explorer" (cygwin-convert-file-name-to-windows default-directory)))
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil)) (start-process "" nil "xdg-open" "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. ⁖ with nautilus
    )))

(defun backward-kill-word-or-kill-region (&optional arg)
      (interactive "p")
      (if (region-active-p)
    	  (kill-region (region-beginning) (region-end))
    	(backward-kill-word arg)))

    (global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)

(benchmark-init/deactivate)
(benchmark-init/show-durations-tabulated)
