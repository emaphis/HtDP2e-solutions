;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex068) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 68:
;; An alternative to the nested data representation of balls uses four fields
;; to keep track of the four properties:


;(define ball1
;  (make-ball (make-posn 30 40) (make-vel -10 5)))

(define-struct ballf [x y deltax deltay])

;; Programmers call this a flat representation.
;; Create an instance of ballf that has the same interpretation as ball1.

(define ball2
  (make-ballf 30 40 -10 5))
