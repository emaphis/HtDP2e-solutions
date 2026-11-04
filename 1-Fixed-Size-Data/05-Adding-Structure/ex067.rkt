#lang htdp/bsl
;; Ex 67
;; Here is another way to represent bouncing balls"

;; location is a number
;; interpretation. number of pixes distance of balld from top.

;; direction is one of two Strings
;; - "up"
;; - "down
;; interpretation. Direction of balld movement.

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

;; Interpret this code fragment and create other instances of balld

(make-balld 100 "up")
(make-balld (+ 25 SPEED) "down")
(make-balld 0 "up")
