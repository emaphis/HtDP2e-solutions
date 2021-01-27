;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex067) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 67
;; Here is another way to represent bouncing balls"

;; location is a number
;; interpretation. number of pixes distance of balld from top.

;; direction is one of two Strings
;; - "up"
;; - "down
;; interpretation. Direction of balld movement.

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

;; Interpret this code fragment and create other instances of balld

(make-balld 100 "up")
(make-balld (+ 25 SPEED) "down")
(make-balld 0 "up")
