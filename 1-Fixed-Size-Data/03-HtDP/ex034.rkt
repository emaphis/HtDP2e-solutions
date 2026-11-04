#lang htdp/bsl
;; Ex. 34
;; Design the function string-first, which extracts the first character from
;; a non-empty string. Don’t worry about empty strings.

;; We use a String to represent random text. The String cannot be empty

;; String -> 1String
;; Given a string extract first charcter
;; given: "h"            expected: "h"
;; given: "hello world"  expected: "h"
;;(define (string-first str) "") ;stub

;(define (sting-first str)  ;; template
;  (... str ...))

(define (string-first str)
  (substring str 0 1))

;; testing
(string-first "h") ; "h"
(string-first "hello world")  ; "h"
