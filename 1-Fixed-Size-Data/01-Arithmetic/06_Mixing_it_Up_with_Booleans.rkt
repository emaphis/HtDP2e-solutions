#lang htdp/bsl

;;; 1.6 Mixing It Up with Booleans

;; definitions
(define x 2)

(define inverse-of-x (/ 1 x))

;; but what if x is zero?
;; use an if expression as a guard expression
(if (= x 0) (/ 1 x))

;; boolean expressions for strings
;; string=?  string>=? string<=?

;; See exercise 8
