(tool-bar-mode -1)
(my-require 'diminish)
(require 'auto-dim-other-buffers)
(diminish 'auto-dim-other-buffers-mode)
(auto-dim-other-buffers-mode)
(global-hl-line-mode)
(when nil
  (my-require 'powerline)
  (powerline-default-theme)
  (with-eval-after-load "desktop"
    (defun powerline-delete-cache ()
      (set-frame-parameter nil 'powerline-cache nil))
    (add-hook 'desktop-save-hook 'powerline-delete-cache))
)
;;; based on dwj's color scheme:
(if (or (eq window-system 'w32) (eq window-system 'x) )
    (progn (global-font-lock-mode t)         ; colorize all files
	   (set-face-attribute 'default nil
			      ;:family "Consolas"
			       :family "Anonymous Pro"
                              ;:family "Inconsolata"
                              ;:family "Source Code"
			      ;:family "Droid Sans Mono Slashed"
			      ;:height 100
			       :height 130
			       )
           (set-face-attribute 'variable-pitch nil
			       :family "Georgia"
			       )
           (set-background-color  "#0f2f2f"); "dark slate gray" but darker
           (set-background-color  "#172626"); "dark slate gray" but darker
	   (set-face-background 'auto-dim-other-buffers-face "dark slate gray")
           (set-foreground-color  "springgreen3")
           (set-cursor-color      "green")
           (set-face-foreground 'mode-line "black")
           ;(set-face-background 'mode-line "grey")
           (set-face-background 'mode-line "LightSlateGrey")
           (set-face-foreground 'region   "snow")
           (set-face-background 'region   "darkolivegreen")
	   (set-face-background 'hl-line "#2f474f"); "similar to" dark slate gray
	   (set-face-background 'hl-line "#261717"); complementary to #172626
	   (set-face-background 'hl-line "#101927")
           (set-face-foreground 'font-lock-comment-face "salmon")
           (set-face-foreground 'font-lock-doc-face "PaleVioletRed1")
           (set-face-foreground 'font-lock-doc-face "lightgoldenrod1")
           (set-face-foreground 'font-lock-doc-face "bisque1")
           (set-face-foreground 'font-lock-function-name-face "skyblue1")
           (set-face-foreground 'font-lock-variable-name-face "gold3")
           (set-face-foreground 'font-lock-type-face "green3")
           (set-face-foreground 'font-lock-keyword-face "cyan")
           (set-face-foreground 'font-lock-constant-face "MediumOrchid2")
           (set-face-background 'fringe "grey20")

	   (set-face-background 'menu "dark slate blue")
           (set-face-background 'tooltip "blanched almond")

           (set-face-background 'trailing-whitespace "misty rose")

           (with-eval-after-load "col-highlight"
             (set-face-background 'col-highlight "#101927"))
           (with-eval-after-load 'viper-init
	     (set-face-attribute 'viper-minibuffer-insert nil
				 :foreground "dark slate gray"
				 :background "PaleGreen2")
	     )

           (with-eval-after-load "ido-vertical-mode"
             (progn
               (set-face-background 'ido-vertical-first-match-face
                                    "#e5b7c0")
               (set-face-attribute 'ido-vertical-only-match-face nil
                                   :background "#e52b50"
                                   :foreground "white")
               (set-face-attribute 'ido-vertical-match-face nil
                                   :background "green"
                                   :foreground "#b00000")
               ))
           (with-eval-after-load "flycheck-color-mode-line"
             (set-face-attribute 'flycheck-color-mode-line-error-face nil
                                 :foreground 'unspecified)
             (set-face-attribute 'flycheck-color-mode-line-info-face nil
                                 :foreground 'unspecified)
             (set-face-attribute 'flycheck-color-mode-line-warning-face nil
                                 :foreground 'unspecified))
           (with-eval-after-load "hi-lock"
             (set-face-attribute 'hi-yellow nil
                                 :distant-foreground "white"))
           (with-eval-after-load "jde"
             (set-face-foreground 'jde-java-font-lock-doc-tag-face "PaleVioletRed1")
             (set-face-attribute 'jde-java-font-lock-link-face nil
                                 :foreground "DodgerBlue3"
                                 :inherit 'link))
           ))

