;;; ekuva --- ekuva -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)

(cl-defun enable-debbuger ()
  (setq debug-on-error t))

(cl-defun ekuva:image-program ()
  (executable-find "feh"))

(cl-defun ekuva:open-file (file)
  (cl-letf ((dir (file-name-directory file))
            (prog (ekuva:image-program)))
    (call-process
     prog nil nil nil "-Z" "-F" "-B black" dir)))

(cl-defun ekuva:open-directory (dir)
  (cl-letf ((prog (ekuva:image-program)))
    (call-process
     prog nil nil nil "-Z" "-F" "-B black" dir)))

(cl-defun ekuva:open (file)
  (pcase file
    ((pred file-regular-p)
     (ekuva:open-file file))
    ((pred file-directory-p)
     (ekuva:open-directory file))))

(cl-defun ekuva (args)
  (ekuva:open args)
  (kill-emacs 0))

(provide 'ekuva)

;;; ekuva.el ends here
