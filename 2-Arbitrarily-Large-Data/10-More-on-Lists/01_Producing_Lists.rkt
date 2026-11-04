;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_01_producing_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.1 Functions that Produce Functions
;; Exercises: 161-165


;; Here is a function for determining the wage of an hourly employee:

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 12 h))


; calculate wages for a list of employees

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 336 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 48 (cons 24 '())))

(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs))
                (wage* (rest whrs)))]))


;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 161
;; See 10_01_161_wages1.rkt

;; Ex. 162
;; See 10_01_162_wages2.rkt

;; Ex. 163
;; See 10_01_163_FTC.rkt

;; Ex. 164
;; See 10_01_164_dollars_to_euros.rkt

;; Ex. 165:
;; See 10_01_165_subst_robot.rkt


