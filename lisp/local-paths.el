;;; local-paths.el --- local-pahts.el  -*- lexical-binding: t; -*-


(add-to-list 'load-path
             (expand-file-name
              "huone/ateljee/emacs-glof"
              (getenv "HOME")))

(add-to-list 'load-path
             (expand-file-name
              "huone/ateljee/emacs-colle"
              (getenv "HOME")))

(provide 'local-paths)
