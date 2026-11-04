#lang htdp/bsl
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

(next "yellow")

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
