(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(defun my-require (package)
  (when (not (package-installed-p package))
    (package-install package))
  (require package))
