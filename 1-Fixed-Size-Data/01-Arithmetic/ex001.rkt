#lang htdp/bsl

;; Ex 1
;; The primary goal of this exercise is to create an expression that compute
;; s the distance of some specific Cartesian point (x,y) from the origin (0,0).
; ;The secondary goal is to get some first exposure to BSL, DrRacket and its
;; interactions area to develop expressions.

(define x 3)
(define y 4)

(sqrt (+ (sqr x) (sqr y))) ;=> 5
(sqrt (+ (sqr 12) (sqr 5))) ;=> 13