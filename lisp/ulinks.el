;;; ulinks --- ulinks -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'subr-x)
(require 'dom)
(require 'xml)

(cl-defun ulinks (url)
  (thread-first (with-current-buffer
          (url-retrieve-synchronously
           url)
        (libxml-parse-html-region
         (point-min) (point-max)))
    cdr
    princ))


;; http://himasoku.com/archives/51938836.html

;; (cl-letf* ((html)
;;            (root html)
;;            (divs (thread-first root
;;                    (xml-get-children 'body)
;;                    car
;;                    get-div))
;;            (my-body (thread-first divs
;;                       (node-filter "my_body" 'id)
;;                       car
;;                       get-div))
;;            (main (thread-first my-body
;;                    (node-filter "main" 'id)
;;                    car
;;                    get-div))
;;            (my-footer (thread-first main
;;                         (node-filter "my_footer" 'id)
;;                         car
;;                         get-div))
;;            (box02 (car (node-filter my-footer "box02" 'class)))
;;            (links (xml-get-children box02 'a))
;;            (url (xml-get-attribute (seq-elt links 1)
;;                                    'href)))
;;   (message "playing %s" where)
;;   (require 'async)
;;   (muki:play-mpv url))

(provide 'ulinks)

;;; ulinks.el ends here
