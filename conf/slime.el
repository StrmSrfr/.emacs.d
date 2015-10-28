(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")
(with-eval-after-load "slime"
  (setq slime-from-lisp-filename-function #'cygwin-convert-file-name-from-windows)
  (defun convert-cygwin-to-windows-filename (path)
    (concat "c:/cygwin64/" path))
  (setq slime-to-lisp-filename-function #'convert-cygwin-to-windows-filename))
