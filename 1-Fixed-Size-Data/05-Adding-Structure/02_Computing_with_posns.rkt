#lang htdp/bsl
;; HtDP 2e - 5 Adding Structure
;; 5.2 Computing with posns

;; Number Number -> Posn
(make-posn 3 4)


;; Selecting components of a posn

(define p (make-posn 31 26))

(posn-x p) ; 31

(posn-y p) ; 26

;; posn identities

; (posn-x (make-posn x0 y0)) == x0
; (posn-y (make-posn x0 y0)) == y0

;; evaluation

(posn-x p)
; racket replaces p with (make-posn 31 26)
(posn-x (make-posn 31 26))
31
