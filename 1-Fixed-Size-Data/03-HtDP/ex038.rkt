#lang htdp/bsl
;; Ex. 38:
;; Design the function string-remove-last, which produces a string like the
;; given one with the last character removed.

;; String represents any text.

;; String -> String
;; Given a string remove last char
;; given "h",     expect: ""
;; given "hello", expect: "hell"
;(define (string-remove-last str) "")

;(define (string-remove-last str)
;  (... str ...))

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(string-remove-last "h") ; ""
(string-remove-last "hello") ; "hell"

