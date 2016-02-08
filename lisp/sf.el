;;; sf --- sf -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)
(require 'seq)

(require 'clry)

(cl-defun sf:command-uname ()
  (thread-first "uname"
    shell-command-to-string
    string-trim))

(cl-defun sf:os ()
  (sf:command-uname))

(cl-defun sf:make-info (name inf)
  (format "%s%s: %s\n"
          (clry:paint :red name)
          (clry:reset)
          (clry:paint :default inf)))

(cl-defun sf (&rest args)
  (princ (sf:make-info "OS" (sf:os)))
  (kill-emacs 0))


(provide 'sf)

;;; sf.el ends here
