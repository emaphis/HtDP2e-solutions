;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex022) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 22
;; Use DrRacket’s stepper on this program fragment:
;; (define (distance-to-origin x y)
;; (+ (sqr x) (sqr y))))
;; (distance-to-origin 3 4)
;; Does the explanation match your intuition?

(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(distance-to-origin 3 4)
(sqrt (+ (sqr 3) (sqr 4)))
(sqrt (+ 9 (sqr 4)))
(sqrt (+ 9 16))
(sqrt 25)
5
