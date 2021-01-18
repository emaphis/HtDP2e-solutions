#lang htdp/bsl

;; Ex 20
;; Define the function string-delete, which consumes a string plus a number
;; i and deletes the ith position from str. Assume i is a number between 0
;; (inclusive) and the length of the given string (exclusive).
;; Can string-delete deal with empty strings?
;; based on ex. 4

(define (string-delete str i)
  (string-append (substring str 0 i) (substring str (+ i 1))))

(string-delete "helloworld" 5) ; "helloorld"

;; Cant handle 0 length strings -- starting index out of range
