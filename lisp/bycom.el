;;; bycom -- bycom -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)

(defun bycom-compile-directory (dir)
  (cl-letf ((files (directory-files-recursively
                    (expand-file-name dir)
                    "el\\'")))
    (seq-each #'byte-compile-file files)))

(cl-defun bycom-add-to-load-path (path)
  (cl-letf ((realpath (expand-file-name path)))
    (when (file-exists-p realpath)
      (add-to-list 'load-path realpath))))

(cl-defun -main (&rest args)
  (pcase (car args)
    ((or "-l" "--load-path")
     (cl-letf ((lpaths (split-string (cadr args) ",")))
       (seq-each #'bycom-add-to-load-path lpaths)
       (seq-each #'bycom-compile-directory
                 (seq-drop args 2))))
    (_
     (bycom-compile-directory (car args))))
  
  (kill-emacs 0))

;;; bycom.el ends here
