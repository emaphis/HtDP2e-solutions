;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Conditional Expressions and Functions

;; 4.1  Booleans and Relations


;; Company XYZ & Co. pays all its employees $12 per hour. A typical
;; employee works between 20 and 65 hours per week.
;; Develop a program that determines the wage of an employee from
;; the number of hours of work, if the number is within the proper
;; range.

;; HoursWorked is Natural[20,65]
;; interp. the number of hours and employee must work to get paid
(define HW1 20) ; lowist
(define HW2 40) ; ok
(define HW3 65) ; highest

#;
;; HoursWorked -> ...
;; Produce ... given hours worked
(define (fn-for-hours-worked hw)
  (... hw))

;; Template rules used:
;; - atomic non-distinct: Natural[20,65]


;; Exercise 4.1.1.
;; What are the results of the following Scheme conditions?

(and (> 4 3) (<= 10 100)) ;-> true
(or (> 4 3) (= 10 100))   ;=> true
(not (= 2 3))  ;=> true


;; Exercise 4.1.2.
;; What are the results of

;; (> x 3)
;; (and (> 4 x) (> x 3))
;; (= (* x x) x)

;; (a) x = 4    true  false false
;; (b) x = 2    false false fasle
;; (c) x = 7/2  true  true  false







