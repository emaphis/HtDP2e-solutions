#lang htdp/bsl
;; HtDP 2e - 5 Adding Structure
;; 5.3 Programming with posn
;; Exercises: 63, 64


;; Now consider designing a function that computes the distance of some
;; location to the origin of the canvas:

; computes the distance of ap to the origin

(check-expect (distance-to-0 (make-posn 0 0)) 0)  ; of course
(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)

(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

;(define (distance-to-0 ap) ; stub
;  0)

#; ; template
(define (fn-for-posn ap)
  (... (posn-x ap) ...
   ... (posn-y ap) ...))

(define (distance-to-0 ap)
  (sqrt
    (+ (sqr (posn-x ap))
       (sqr (posn-y ap)))))

;; See exercise 63 - evaluate posn expressions

;; See exercise 64 - Manhatten distance
