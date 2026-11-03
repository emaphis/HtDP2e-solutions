#lang htdp/bsl

;; Ex 27:
;; Our solution to the sample problem contains several constants
;; in the middle of functions. As “One Program, Many Definitions”
;; already points out, it is best to give names to such constants so that future
;; readers understand where these numbers come from. Collectalldefinitions
;; in DrRacket’s definitions area and change them so that all magic numbers
;; are refactored into constant definitions.

;; definitions
(define BASE-ATTENDEES 120)
(define BASE-PRICE 5.00)

(define ATTENDEE-CHANGE 15)
(define PRICE-CHANGE 0.10)

(define FIXED-COST 180.00)
(define ATTENDEE-COST 0.04)

;; functions
(define (attendees ticket-price)
  (+ BASE-ATTENDEES
     (* (/ ATTENDEE-CHANGE PRICE-CHANGE)
        (- BASE-PRICE ticket-price))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST
     (* ATTENDEE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; examples
(profit 1.00) ; 511.2
(profit 2.00) ; 937.2
(profit 2.90) ; 1064.1
(profit 3.00) ; 1063.2
(profit 4.00) ; 889.2
(profit 5.00) ; 415.2
