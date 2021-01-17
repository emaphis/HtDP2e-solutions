#lang htdp/bsl

;; 1.3 Mixing It Up
;; other string operationgs consume or produce data other than strings
;; string-length - consumes a String and prduces a Number
;; string-ith - consumes a String and a Natural and produces a !String
;; number->string - consumes a number and produces a string

;; substring
;; (substring s i j) → string
;;  s : string
;;  i : natural-number
;;  j : natural-number
;; Extracts the substring starting at i up to j (or the end if j is not provided).

(string-length "fourty-two") ;=> 10
;(string-length 42) type error

;; we may nest operations if we keep track of types:
(+ (string-length "hello world") 60) ;=> 71
(+ (string-length (number->string 42)) 2) ;=> 4
;;(+ (string-length 42) 2) type error
;; string-length: expects a string, given 42

;; See exercises 3, 4.