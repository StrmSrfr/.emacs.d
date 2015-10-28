(add-to-list 'load-path "~/.emacs.d/lisp/jdee-2.4.1/lisp")
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
  (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))
(with-eval-after-load "jde"
  (my-require 'diminish)
  (diminish 'jde-plugin-minor-mode)
  (diminish 'jde-jdb-minor-mode)
  (diminish 'abbrev-mode)
  (diminish 'auto-fill-function "F")
  (bury-successful-compilation)
  (with-eval-after-load "flycheck"
    (my-require 'flycheck-color-mode-line)
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  (my-require 'flycheck)
  (require 'flycheck-java)
  (customize-set-variable 'flycheck-java-ecj-jar-path
    "/cygdrive/c/Program Files/Apache Software Foundation/Tomcat 8.0.20/lib/ecj-4.4.1.jar")

  ;; auto-complete
  (add-to-list 'ac-modes 'jde-mode)
  (defun jde-ac-hook ()
    (add-to-list 'ac-sources 'ac-source-semantic))
  (add-hook 'jde-mode-hook 'jde-ac-hook)

  (add-hook 'jde-mode-hook 'auto-fill-mode)
  (add-hook 'jde-mode-hook 'eldoc-mode)
  (diminish 'eldoc-mode)
  (add-hook 'jde-mode-hook 'flycheck-mode)
  (defun my-flyspell-prog-mode ()
    (flyspell-prog-mode)
    (diminish 'flyspell-mode "sp"))
  (add-hook 'jde-mode-hook 'my-flyspell-prog-mode)
  (add-hook 'jde-mode-hook 'visual-line-mode)
  (diminish 'visual-line-mode)
  (add-hook 'jde-mode-hook 'which-function-mode)
  (global-semantic-mru-bookmark-mode t)

  ;; key bindings
  (require 'crosshairs)
  (advice-add 'c-indent-line-or-region :after 'crosshairs-highlight)
  (defun backtab ()
    "`indent-rigidly' backwards by one step.  If the mark is active,
indent the region.  Otherwise, indent the current line."
    (interactive)
    (if mark-active
        (indent-rigidly-left-to-tab-stop
         (region-beginning) (region-end))
      (indent-rigidly-left-to-tab-stop
       (line-beginning-position) (line-end-position))))

  (defun my-jde-keys ()
    ; http://stackoverflow.com/a/1792482/894885
    (setq local-function-key-map (delq '(kp-tab . [9]) local-function-key-map))
    (local-set-key (kbd "M-.") 'jde-open-class-at-point)
    (local-set-key (kbd "C-i") 'indent-relative)
    (local-set-key (kbd "<tab>") 'c-indent-line-or-region); is that the one?
    (local-set-key (kbd "<backtab>") 'backtab)
    (local-set-key (kbd "C-x M-f") 'jde-find-class-source)
    (local-set-key (kbd "<M-next>") 'next-error)
    (local-set-key (kbd "<M-prior>") 'previous-error))
  (add-hook 'jde-mode-hook
            'my-jde-keys)

  (global-set-key (kbd "<f5>") 'jde-debug-cont)
  (global-set-key (kbd "C-<f5>") 'jde-debug)
  (global-set-key (kbd "<f7>") 'jde-debug-step-into)
  (global-set-key (kbd "<f8>") 'jde-debug-step-over)

  (fset 'doc-getter
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([79 47 42 42 return 42 33554464 82 101 116 117 114 110 115 return 42 33554464 64 114 101 116 117 114 110 escape 100 100 112 107 121 121 106 112 107 107 107 74 65 46 escape 106 106 107 74 111 42 47 escape] 0 "%d")) arg)))
  )

(with-eval-after-load "jde-checkstyle"
  (defmethod jde-checkstyle-create-checker-buffer :after ((this jde-checkstyle-checker))
    (let* ((buffer (oref this :buffer))
           (window (or (get-buffer-window buffer)
                       (split-window nil -4 'above))))
      (set-window-buffer window buffer)
      (set-window-dedicated-p window t))))

;;; JDE Run Mode
(with-eval-after-load "jde-run"
  (defun java-src-stack-trace-regexp-to-filename ()
    "Generates a relative filename from java-stack-trace regexp match data."
    (concat "src/"
            (replace-regexp-in-string "\\." "/" (match-string 1))
            (match-string 2)))

  ;; regexps are not case sensitive so we jump through hoops to get this regex to match as expected
  (add-to-list 'compilation-error-regexp-alist 'java-src-stack-trace)
  (add-to-list 'compilation-error-regexp-alist-alist
               '(java-src-stack-trace
                 "at \\(\\(?:[[:alnum:]]+\\.\\)+\\)+[[:alnum:]]+\\..+(\\([[:alnum:]]+\\.java\\):\\([[:digit:]]+\\))$"
                 java-src-stack-trace-regexp-to-filename
                 3)))

