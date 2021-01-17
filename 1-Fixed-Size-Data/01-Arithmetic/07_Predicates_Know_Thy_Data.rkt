#lang htdp/bsl

; 1.7  Predicates: Know Thy Data

;; string-length: expects a string, given 42
;;(* (+ (string-length 42) 1) pi)

(number? 4) ; #true
(number? pi) ; #true
(number? #true) ; #false
(number? "fortytwo") ; #false

(define in 42)

(if (string? in)
    (string-length in)
    0)

;; Type predicates:
;; number?
;; string? image? boolean?
;; interger? rational? real? complex?
;; exact? Inexact?

;; See exercises 9, 10