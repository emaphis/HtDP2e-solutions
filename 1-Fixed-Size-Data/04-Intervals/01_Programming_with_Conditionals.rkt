;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01_Programming_with_Conditionals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 1.4 Intervals, Enumerations, etc.
;; 4.1 Programming with Condinals

;(cond
;  [ConditionExpression1 ResultExpression1]
;  [ConditionExpression2 ResultExpression2]
;  ...
;  [ConditionExpressionN ResultExpressionN])

; A function that uses a cond expression.
(define (next traffic-light-state)
  (cond
    [(string=? "red" traffic-light-state) "green"]
    [(string=? "green" traffic-light-state) "yellow"]
    [(string=? "yellow" traffic-light-state) "red"]))

(next"yellow")

;; else for all other cases

;(cond
;  [ConditionExpression1 ResultExpression1]
;  [ConditionExpression2 ResultExpression2]
;  ...
;  [else DefaultResultExpressionN])


; A PositiveNumber is a Number greater or equal to 0.

; PositiveNumber-> String
; compute the reward level from the given score s
(define (reward-1 s)
  (cond
    [(<= 0 s 10)
     "bronze"]
    [(and (< 10 s) (<= s 20))
     "silver"]
    [(< 20 s)
     "gold"]))

(define (reward-2 s)
  (cond
    [(<= 0 s 10)
     "bronze"]
    [(and (< 10 s) (<= s 20))
     "silver"]
    [else
     "gold"]))
