#lang htdp/bsl


;; Ex. 14:
;; Define the function string-last, which extracts the last 1String from
;; a non-empty string. Don’t worry about empty strings.
(define (string-last str)
  (substring str (- (string-length str) 1)))

(string-last "d")   ; "d"
(string-last "hello world") ; "d"
