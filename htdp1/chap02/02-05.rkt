;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.5 Designing Programs


;; A complete design recipe:

;; Contract: area-of-ring : number number  ->  number

;; Purpose: to compute the area of a ring whose radius is
;; outer and whose hole has a radius of inner

;; Example: (area-of-ring 5 3) should produce 50.24

;; Definition: [refines the header]
(define (area-of-ring outer inner)
  (- (area-of-disk outer)
     (area-of-disk inner)))

;; Tests:
(check-expect (area-of-ring 5 3) 50.24)


;; helper function
(define (area-of-disk r)
  (* 3.14 r r))
