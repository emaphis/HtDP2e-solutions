#lang htdp/bsl
;; HtDP 2e - 5 Adding Structure
;; 5.1 From Positions to posn Structures

(require 2htdp/image)

;; A Position on a world canvas is defined by two pieces of data
;; x-coordinate - the distance from the left margin
;; y-coordinate - the distance from the top margin

(make-posn 3 4)

(define one-posn (make-posn 8 6))
