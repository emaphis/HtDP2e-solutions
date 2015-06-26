;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 3.2  Variable Definitions

(define PI 3.14159)


;; Exercise 3.2.1.
;; Provide variable definitions for all constants that appear in the
;; profit program of figure 5 and replace the constants with their names.

;; attendees : number  ->  number
;; to compute the number of attendees, given ticket-price
;; increase 150 for every $1 ticket price decrease

(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5.00)
(define INC-PER-DOLLAR 150)
(define BASE-COST 180.00)
(define COST-FACTOR 0.04)

(define (attendance price)
  (+ BASE-ATTENDANCE
     (* INC-PER-DOLLAR (- BASE-PRICE price))))

(check-expect (attendance 5.00) 120)
(check-expect (attendance 4.00) 270)
(check-expect (attendance 3.00) 420)


;; cost : number  ->  number
;; to compute the costs, given ticket-price
(define (cost price)
  (+ BASE-COST (* (attendance price) COST-FACTOR)))

(check-expect (cost 5.00) 184.80)
(check-expect (cost 4.00) 190.80)
(check-expect (cost 3.00) 196.80)

;; revenue : number  ->  number
;; to compute the revenue, given ticket-price
(define (revenue price)
  (* price (attendance price)))

(check-expect (revenue 5.00)  600.00)
(check-expect (revenue 4.00) 1080.00)
(check-expect (revenue 3.00) 1260.00)

;; profit : number  ->  number
;; to compute the profit as the difference between revenue and costs
;; at some given ticket price
(define (profit price)
  (- (revenue price) (cost price)))

(check-expect (profit 5.00)  415.20)
(check-expect (profit 4.00)  889.20)
(check-expect (profit 3.00) 1063.20)