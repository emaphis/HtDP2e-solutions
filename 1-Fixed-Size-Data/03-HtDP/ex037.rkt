#lang htdp/bsl
;; Ex. 37:
;; Design the function string-rest, which produces a string like the given
;; one with the first character removed.

;; String represents any text

;; String -> String
;; Given a String return all but first 1String
;; given: "h",     expect: ""
;; given: "hello", expect "ello"
;(define (string-rest str) "a") ; stub

;(define (string-rest str)
;  (... str ...))
 
(define (string-rest str)
  (substring str 1))

(string-rest "h") ; ""
(string-rest "hello") ; "ello"
