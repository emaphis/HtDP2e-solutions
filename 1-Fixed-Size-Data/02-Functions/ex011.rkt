;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex011) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 11:
;; Define a function that consumes two numbers, x and y, and that
;; computes the distance of point (x,y) to the origin.
;; based on ex. 1

(define (distance x y) 
  (sqrt (+ (sqr x) (sqr y))))

(distance 0 0) ;; 0
(distance 3 4) ;; 5
