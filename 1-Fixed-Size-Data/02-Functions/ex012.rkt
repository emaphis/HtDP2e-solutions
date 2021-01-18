#lang htdp/bsl

;; Ex. 12:
;; Define the function cvolume, which accepts the length of a side of
;; an equilateral cube and computes its volume. If you have time, consider
;; defining csurface, too.

(define (cvolume side)
  (* side side side))

(cvolume 0) ; 0
(cvolume 1) ; 1
(cvolume 5) ; 125


(define (csurface side)
  (* (sqr side) 6))

(csurface 0) ; 0
(csurface 1) ; 6
(csurface 5) ; 150
