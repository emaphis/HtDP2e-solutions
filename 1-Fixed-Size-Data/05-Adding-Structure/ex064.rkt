#lang htdp/bsl
;; Ex. 64:
;; Design the function manhattan-distance, which measures the Manhattan
;; distance of the given posn to the origin.

; Posn -> Number
; produce the 'Manhattan distance' from a given Posn to the Origin
(check-expect (manhattan-distance (make-posn 0 0)) 0)
(check-expect (manhattan-distance (make-posn 5 0)) 5)
(check-expect (manhattan-distance (make-posn 0 4)) 4)
(check-expect (manhattan-distance (make-posn 5 4)) 9)

;(define (manhattan-distance p) 0) ; stub

(define (manhattan-distance p)
  (+ (posn-x p)
     (posn-y p)))
