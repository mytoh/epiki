;;; empv --- empv -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)
(require 'seq)

(cl-defun empv:open (file)
  (cl-letf* ((dir (if (file-directory-p file)
                      file
                    (file-name-directory file)))
             (all-files (directory-files dir 'full)))
    (empv:open-mpv
     (seq-filter
      (lambda (f)
        (pcase (file-name-extension f)
          ((or "webm" "mp4" "wmv" "flv" "mkv" "mov" "gif")
           t)))
      all-files))))

(cl-defun empv:open-mpv (files)
  (apply #'call-process "mpv" nil nil nil
         files))

(cl-defun empv (arg)
  (empv:open arg)
  (kill-emacs 0))


;; Local Variables:
;; mode: emacs-lisp
;; End:

;;; empv.el ends here
