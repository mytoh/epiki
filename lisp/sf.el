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

(cl-defun -main (&rest args)
  (colle:each 
   #'princ
   `[,(sf:make-info "os" (sf:os))
     ,(sf:make-info "uptime" (sf:os))
     ,(sf:make-info "shell" (sf:os))
     ,(sf:make-info "packages" (sf:os))     
     ,(sf:make-info "wM" (sf:os))
     ,(sf:make-info "font" (sf:os))
     ,(sf:make-info "resolution" (sf:os))
     ,(sf:make-info "cpu" (sf:os))
     ,(sf:make-info "memory" (sf:os))
     ,(sf:make-info "colorscheme" (sf:os))])
  (kill-emacs 0))

;;; sf.el ends here
