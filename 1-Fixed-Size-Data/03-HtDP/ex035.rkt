#lang htdp/bsl
;; Ex. 35:
;; Design the function string-last, which extracts the last character from a
;; non-empty string.

;; String represents any text

;; String -> !String
;; Given a string extract last charater
;; given: "h",           expect: "h"
;; given: "hello world", expect: "o"
;;(define (string-last str) "") ;stub

;(define (string-last str)
;  (... str ...))

(define (string-last str)
  (substring str (- (string-length str) 1)))

;; testing
(string-last "h") ; "h"
(string-last "hello world") ; "d"
