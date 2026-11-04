#lang htdp/bsl
;; HtDP 2e - 4 Enumerations, Intervals, Itemizations
;; 4.4 Intervals
;; Exercises: 52


;; for ufo example see: 04_Ufo.rkt


;;; Examples

; A WorldState falls into one of three intervals: 
; – between 0 and CLOSE
; – between CLOSE and HEIGHT
; – below HEIGHT

;; Template

(define CLOSE 10)
(define HEIGHT 100)

; WorldState -> WorldState
(define (f y)
  (cond
    [(<= 0 y CLOSE) ...]
    [(<= CLOSE y HEIGHT) ...]
    [(>= y HEIGHT) ...]))

;; More obvious"
; WorldState -> WorldState
(define (g y)
  (cond
    [(<= 0 y CLOSE) ...]
    [(and (< CLOSE y) (<= y HEIGHT)) ...]
    [(> y HEIGHT) ...]))
