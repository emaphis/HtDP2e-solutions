;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex029) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ex 29.

;; After studying the costs of a show, the owner discovered several ways of lowering the cost.
;; As a result of these improvements, there is no longer a fixed cost;
;; a variable cost of $1.50 per attendee remains.
;; Modify both programs to reflect this change.
;; When the programs are modified,
;; test them again with ticket prices of $3, $4, and $5 and compare the results.

;; definitions
(define AVG-ATTENDEES 120)
(define BASE-PRICE 5.00)

(define ATTENDANCE-CHANGE 15)
(define PRICE-CHANGE 0.10)

(define VARIABLE-COST 1.50)

;; functions
(define (attendees ticket-price)
  (- AVG-ATTENDEES
     (* (- ticket-price BASE-PRICE)
        (/ ATTENDANCE-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price  (attendees ticket-price)))

(define (cost ticket-price)
  (* VARIABLE-COST (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; examples
(profit 1.00)  ; -360
(profit 2.00)  ;  285
(profit 3.00)  ;  630
(profit 4.00)  ;  675
(profit 5.00)  ;  420
