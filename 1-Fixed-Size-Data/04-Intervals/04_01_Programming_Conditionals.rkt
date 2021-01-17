;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_01_Programming_Conditionals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 1.4 Intervals, Enumerations, etc.
;; 4.1 Programming with Condinals


(define (next traffic-light-state)
  (cond
    [(string=? "red" traffic-light-state) "green"]
    [(string=? "green" traffic-light-state) "yellow"]
    [(string=? "yellow" traffic-light-state) "red"]))


; A PositiveNumber is a Number greater or equal to 0.

; PositiveNumber-> String
; compute the reward level from the given score s
(define (reward s)
  (cond
    [(<= 0 s 10)
     "bronze"]
    [(and (< 10 s) (<= s 20))
     "silver"]
    [(< 20 s)
     "gold"]))
