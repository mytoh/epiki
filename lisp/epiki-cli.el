;;; epiki-cli --- epiki-cli -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(add-to-list 'load-path
             (file-name-directory load-file-name))

(require 'cl-lib)
(require 'ekuva)

;; (funcall (intern "printf") "fuck")

(cl-defun main (args)
  (cl-letf ((com (car args)))
    (apply #'funcall (intern com) (cdr args))))

(main (cdr argv))

;;; epiki-cli.el ends here
