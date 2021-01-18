#lang htdp/bsl

;; Ex. 11:
;; Define a function that consumes two numbers, x and y, and that
;; computes the distance of point (x,y) to the origin.
;; based on ex. 1

(define (distance x y) 
  (sqrt (+ (sqr x) (sqr y))))

(distance 0 0) ;; 0
(distance 3 4) ;; 5
