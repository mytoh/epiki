;;; sf --- sf -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)
(require 'seq)

(require 'clry)

(cl-defun sf:wrap-command (cmd)
  (thread-first cmd
    shell-command-to-string
    string-trim))

(cl-defun sf:os ()
  (sf:wrap-command "uname"))

(cl-defun sf:uptime ()
  (pcase-let* ((`(,i1 ,i2 . ,_) (thread-first (sf:wrap-command "uptime")
                                  (split-string "," )))
               (`(,_ ,_ . ,u1) (split-string i1)))
    (concat (apply #'concat u1)
            i2)))

(cl-defun sf:make-info (name inf)
  (format "%s%s: %s\n"
          (clry:paint :red name)
          (clry:reset)
          (clry:paint :default inf)))


(cl-defun -main (&rest args)
  (cl-letf ((os (sf:os))
            (up (sf:uptime)))
    (colle:each 
     #'princ
     `[,(sf:make-info "os" os)
       ,(sf:make-info "uptime" up)
       ,(sf:make-info "shell" os)
       ,(sf:make-info "packages" os)     
       ,(sf:make-info "wM" os)
       ,(sf:make-info "font" os)
       ,(sf:make-info "resolution" os)
       ,(sf:make-info "cpu" os)
       ,(sf:make-info "memory" os)
       ,(sf:make-info "colorscheme" os)]))
  (kill-emacs 0))

;;; sf.el ends here
