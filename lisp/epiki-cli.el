;;; epiki-cli --- epiki-cli -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'pcase)
(require 'cl-lib)

(add-to-list 'load-path
             (file-name-directory load-file-name))

(require 'herd)
(herd:setup (expand-file-name "../vendor"
                              (file-name-directory load-file-name)))

(cl-defun epiki-load (name)
  (load (expand-file-name
         name
         (file-name-directory load-file-name))
        (not 'noerror)
        'nomessage))

(cl-defun run (args)
  (pcase-let ((`(,name . ,rargs) args))
    (epiki-load name)
    (apply #'-main rargs)))

(progn
  (run (cdr argv)))


;;; epiki-cli.el ends here
