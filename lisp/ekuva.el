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

(cl-defun ekuva:feh-open (dir)
  (ekuva:call-process
   "feh" "-Z" "-F" "-B black" dir))

(cl-defun ekuva:sxiv-open (dir)
  (ekuva:call-process "sxiv" "-f" "-s" "f" "-b" "-r" dir))

(cl-defun ekuva:pqiv-open (dir)
  (ekuva:call-process "pqiv"
                      "--fullscreen"
                      "--scale-images-up"
                      "--hide-info-box"))


(cl-defun ekuva:open-function ()
  (pcase t
    ((guard (executable-find "sxiv"))
     #'ekuva:sxiv-open)
    ((guard (executable-find "feh"))
     #'ekuva:feh-open)
    ((guard (executable-find "pqiv"))
     #'ekuva:pqiv-open)))

(cl-defun ekuva:file-name-relative-p (file)
  (cl-equalp (seq-elt file 0)
             ?\.))

(cl-defun ekuva:find-directory (file)
  (pcase file
    ((pred file-name-absolute-p)
     (file-name-directory file))
    ((pred ekuva:file-name-relative-p)
     (file-name-directory file))
    (_
     (thread-first file
       (expand-file-name default-directory)
       file-name-directory))))

(cl-defun ekuva:open (file)
  (pcase file
    ((pred file-regular-p)
     (funcall (ekuva:open-function)
        (file-name-directory file)))
    ((pred file-directory-p)
     (funcall (ekuva:open-function) file))))

(cl-defun ekuva (args)
  (ekuva:open (expand-file-name args))
  (kill-emacs 0))

(provide 'ekuva)

;;; ekuva.el ends here
