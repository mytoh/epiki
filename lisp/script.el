;;; script --- script -*- lexical-binding: t; coding: utf-8; -*-


(cl-defun script:mag2tore (mag)
  (apply #'call-process "aria2c" nil nil nil
         `("--bt-metadata=true" "--bt-save-metadata=true"
                                ,mag)))


(cl-defun -main (&rest args)
  (cl-letf ((com (car args)))
    (pcase com
      ("mag2tore"
       (script:mag2tore (cadr args)))))
  (kill-emacs 0))

