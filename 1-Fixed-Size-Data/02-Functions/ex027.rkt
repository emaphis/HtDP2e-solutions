;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex027) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
