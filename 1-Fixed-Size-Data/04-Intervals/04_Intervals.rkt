;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_Intervals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
