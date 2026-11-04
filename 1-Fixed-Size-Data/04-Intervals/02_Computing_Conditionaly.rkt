#lang htdp/bsl
;; HtDP 2e - 4 Intervals, Enumerations, etc.
;; 4.2 Computing Conditionally
;; Exercises 48,49

(require 2htdp/image)

; A PositiveNumber is a Number greater or equal to 0.

;; Unit Tests
(check-expect (reward 5) "bronze")
(check-expect (reward 15) "silver")
(check-expect (reward 35) "gold")

; PositiveNumber-> String
; compute the reward level from the given score s
(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

;;; evaluation:
(reward 3)

(cond
  [(<= 0 3 10) "bronze"]
  [(and (< 10 3) (<= 3 20)) "silver"]
  [else "gold"])

(cond
  [#true "bronze"]
  [(and (< 10 3) (<= 3 20)) "silver"]
  [else "gold"])

"bronze"

;;; a scond example

(reward 21)

(cond
  [(<= 0 21 10) "bronze"]
  [(and (< 10 21) (<= 21 20)) "silver"]
  [else "gold"])

(cond
  [#false "bronze"]
  [(and (< 10 21) (<= 21 20)) "silver"]
  [else "gold"])

(cond
  [(and (< 10 21) (<= 21 20)) "silver"]
  [else "gold"])


;; See exercise 48,49

;; See rocket1.rkt for reformation exercise
;; Figure 24.
