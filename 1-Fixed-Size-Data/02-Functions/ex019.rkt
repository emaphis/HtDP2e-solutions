#lang htdp/bsl

;; Exercise 19
;; Define the function string-insert, which consumes a string str plus
;; a number i and inserts "_" at the ith position of str. Assume i is
;; a number between 0 and the length of the given string (inclusive).
;; based on ex. 3

(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))

(define str "helloworld")
(define i 5)

(string-insert "" 0) ; "_"
(string-insert "helloworld" 5) ; "hello_world"
