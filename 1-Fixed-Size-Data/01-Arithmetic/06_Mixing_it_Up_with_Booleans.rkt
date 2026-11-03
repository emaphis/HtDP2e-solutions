#lang htdp/bsl
;;; 1.6 Mixing It Up with Booleans

;; definitions
(define x 2)

;; compute inverse of x
(define inverse-of-x (/ 1 x))

;; but what if x is zero?
;; use an if expression as a guard expression
(if (= x 0) 0 (/ 1 x))

;Stop!
(define x1 0)
(if (= x1 0) 0 (/ 1 x1))  ; should be 0

;; boolean expressions for strings
;; string=?  string>=? string<=?

;; See exercise 8
