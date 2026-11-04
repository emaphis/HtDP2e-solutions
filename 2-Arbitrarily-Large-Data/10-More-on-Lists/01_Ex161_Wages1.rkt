#lang htdp/bsl
;; HtDP 2e - 10 More on Lists
;; 10.1 Functions that Produce Functions
;; Exercise: 161
;; Wage 2

;; Ex. 161
;; Translate the examples into tests and make sure they all succeed. Then
;; change the function in figure 60 so that everyone gets $14 per hour.
;; Now revise the entire program so that changing the wage for everyone is a
;; single change to the entire program and not several.

;(define PAY-RATE 12)
(define PAY-RATE 14)

; Number -> Number
; computes the wage for h hours of work
(check-expect (wage 10) (* PAY-RATE 10))

(define (wage h)
  (* PAY-RATE h))


; calculate wages for a list of employees

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* PAY-RATE 28) '()))
(check-expect (wage* (cons 4 (cons 2 '())))
              (cons (* PAY-RATE 4) (cons (* PAY-RATE 2) '())))

(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs))
                (wage* (rest whrs)))]))
