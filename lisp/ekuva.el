;;; ekuva --- ekuva -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)
(require 'pcase)

(cl-defun enable-debbuger ()
  (setq debug-on-error t))

(cl-defun ekuva:remove-trailing-slash (dir)
  (string-remove-suffix "/" (file-name-as-directory dir)))

(cl-defun ekuva:call-process (com &rest args)
  (apply #'call-process com nil nil nil args))

(cl-defun ekuva:feh-open-file (file)
  (cl-letf ((dir (file-name-directory file)))
    (call-process
     "feh" nil nil nil "-Z" "-F" "-B black" dir)))

(cl-defun ekuva:feh-open-directory (dir)
  (call-process
   "feh" nil nil nil "-Z" "-F" "-B black" dir))

(cl-defun ekuva:sxiv-open-file (file)
  (cl-letf ((dir (thread-first file
                   file-name-directory
                   ekuva:remove-trailing-slash)))
    (ekuva:call-process "sxiv"
                        "-f" "-s" "f"  "-r" dir)))

(cl-defun ekuva:sxiv-open-directory (dir)
  (ekuva:call-process "sxiv" "-f" "-s" "f" "-r" 
                      (thread-first dir ekuva:remove-trailing-slash)))

(cl-defun ekuva:open-function-file ()
  (pcase t
    ((guard (executable-find "sxiv"))
     #'ekuva:sxiv-open-file)
    ((guard (executable-find "feh"))
     #'ekuva:feh-open-file)))

(cl-defun ekuva:open-function-directory ()
  (pcase t
    ((guard (executable-find "sxiv"))
     #'ekuva:sxiv-open-directory)
    ((guard (executable-find "feh"))
     #'ekuva:feh-open-directory)))

(cl-defun ekuva:open (file)
  (pcase file
    ((pred file-regular-p)
     (funcall (ekuva:open-function-file) file))
    ((pred file-directory-p)
     (funcall (ekuva:open-function-directory) file))))

(cl-defun ekuva (args)
  (ekuva:open (expand-file-name args))
  (kill-emacs 0))

(provide 'ekuva)

;;; ekuva.el ends here
