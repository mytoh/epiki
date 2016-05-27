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
  (colle:each 
   #'princ
   `[,(sf:make-info "OS" (sf:os))
      ,(sf:make-info "Uptime" (sf:os))
      ,(sf:make-info "Shell" (sf:os))
      ,(sf:make-info "WM" (sf:os))
      ,(sf:make-info "Font" (sf:os))
      ,(sf:make-info "Resolution" (sf:os))
      ,(sf:make-info "Color Scheme" (sf:os))
      ]
   )
  (kill-emacs 0))


(provide 'sf)

;;; sf.el ends here
