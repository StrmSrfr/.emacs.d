(when (eq system-type 'cygwin)
  (setq compilation-parse-errors-filename-function #'cygwin-convert-file-name-from-windows))
