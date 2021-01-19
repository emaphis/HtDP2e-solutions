;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex030) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 30:
;; Define constants for the price optimization program so that the price
;; sensitivity of attendance (15 people for every 10 cents) becomes a computed constant.

;; definitions
(define ATTENDEES 15)
(define PRICE 0.10)
(define PRICE-SENSITIVITY (/ ATTENDEES PRICE))  ; 150

(define BASE-ATTENDEES 120)
(define BASE-PRICE 5.00)

(define ATTENDANCE-CHANGE 15)
(define PRICE-CHANGE 0.10)

(define VARIABLE-COST 1.50)

;; functions
(define (attendees ticket-price)
  (- BASE-ATTENDEES
     (* (- ticket-price BASE-PRICE) PRICE-SENSITIVITY)))

(define (revenue ticket-price)
  (* ticket-price  (attendees ticket-price)))

(define (cost ticket-price)
  (* VARIABLE-COST (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; examples
(profit 2.00)  ;  285
(profit 3.00)  ;  630
(profit 4.00)  ;  675
(profit 5.00)  ;  420
