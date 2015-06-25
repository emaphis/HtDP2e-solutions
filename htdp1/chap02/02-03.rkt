;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.3  Word Problems

;; word problems are sometimes ambiguos

;; Company XYZ & Co. pays all its employees $12 per hour. A typical employee works
;; between 20 and 65 hours per week. Develop a program that determines the wage of
;; an employee from the number of hours of work.

(define (wage hrs)
  (* 12 hrs))

(check-expect (wage 10) 120)


;; Exercise 2.3.1.
;; Utopia's tax accountants always use programs that compute income taxes even though
;; the tax rate is a solid, never-changing 15%. Define the program tax, which determines
;; the tax on the gross pay.

(define (tax pay)
  (* 0.15 pay))

(check-expect (tax 120) 18)

;; Also define netpay. The program determines the net pay of an employee from the number
;; of hours worked. Assume an hourly rate of $12

(define (netpay hrs)
  (- (wage hrs)
     (tax (wage hrs))))

(check-expect (netpay 10) 102)


;; Exercise 2.3.2.
;; The local supermarket needs a program that can compute the value of a bag of coins.
;; Define the program sum-coins. It consumes four numbers: the number of pennies, nickels,
;; dimes, and quarters in the bag; it produces the amount of money in the bag

(define (sum-coins p n d q)
  (+ (/ p 100)
     (/ n 20)
     (/ d 10)
     (/ q 4)))

(check-expect (sum-coins 10 10 10 10) 4.10)
(check-expect (sum-coins 1 0 0 0) .01)
(check-expect (sum-coins 0 1 0 0) .05)
(check-expect (sum-coins 0 0 1 0) .10)
(check-expect (sum-coins 0 0 0 1) .25)
(check-expect (sum-coins 1 1 1 1) .41)


;; Exercise 2.3.3.
;; An old-style movie theater has a simple profit function. Each customer pays
;; $5 per ticket. Every performance costs the theater $20, plus $.50 per attendee.
;; Develop the function total-profit. It consumes the number of attendees (of a show)
;; and produces how much income the attendees produce.

(define (profit n)
  (-
  (* n 5)     ; 5$ per ticket
  20          ; - 20 per showing
  (* n 0.5))) ; - .50 per attendee fee.

(check-expect (profit 5) 2.50)
(check-expect (profit 2) -11.00)
(check-expect (profit 100) 430.00)
