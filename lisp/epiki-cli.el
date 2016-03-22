;;; epiki-cli --- epiki-cli -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(add-to-list 'load-path
             (file-name-directory load-file-name))

(require 'herd)
(herd:setup (expand-file-name "../vendor"
                              (file-name-directory load-file-name)))

(require 'cl-lib)
(require 'ekuva)
(require 'evid)
(require 'ulinks)
(require 'sf)
(require 'script)
(require 'etard)

(cl-defun main (args)
  (cl-letf ((com (car args)))
    (apply #'funcall (intern com) (cdr args))))

(main (cdr argv))

;;; epiki-cli.el ends here
