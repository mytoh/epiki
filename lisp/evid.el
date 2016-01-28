;;; evid --- evid -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)
(require 'seq)

(cl-defun evid:open (file)
  (cl-letf* ((dir (if (file-directory-p file)
                      file
                    (file-name-directory file)))
             (all-files (directory-files dir 'full)))
    (evid:play-mpv
     (seq-filter
      (lambda (f)
        (pcase (file-name-extension f)
          ((or "webm" "mp4" "wmv" "flv" "mkv" "mov" "gif")
           t)))
      all-files))))

(cl-defun evid:open-single (file)
  (evid:play-mpv `(,file)))

(cl-defun evid:play-mpv (files)
  (apply #'call-process "mpv" nil nil nil
         files))

(cl-defun evid (&rest args)
  (cl-letf ((type (car args)))
    (pcase type
      ("all"
       (evid:open (cadr args)))
      ("single"
       (evid:open-single (cadr args)))))
  (kill-emacs 0))


(provide 'evid)

;; Local Variables:
;; mode: emacs-lisp
;; End:

;;; evid.el ends here
