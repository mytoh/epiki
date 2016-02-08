;;; clry -- clry -*- lexical-binding: t; coding: utf-8; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)

(require 'glof)

(defvar clry:*colors-foreground*
  '(:black    30
    :red      31
    :green    32
    :yellow   33
    :blue     34
    :magenta  35
    :cyan     36
    :white    37
    :default  39))

(cl-defun clry:paint (color str)
  (thread-first color
    clry:find-color-seq
    (clry:wrap str)))

(cl-defun clry:find-color-seq (color)
  (glof:get clry:*colors-foreground* color))

(cl-defun clry:wrap (cs str)
  (format "\e[%sm%s" cs str))

(cl-defun clry:reset ()
  (format "\e[%sm" 0))


(provide 'clry)

;;; clry ends here
