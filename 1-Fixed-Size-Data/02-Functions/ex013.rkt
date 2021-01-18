#lang htdp/bsl

;; Ex. 13:
;; Define the function string-first, which extracts the first 1String from a
;; non-empty string. Don’t worry about empty strings. 

(define (string-first str)
  (substring str 0 1))

(string-first "s")  ; "s"
(string-first "string")  ; "s"
