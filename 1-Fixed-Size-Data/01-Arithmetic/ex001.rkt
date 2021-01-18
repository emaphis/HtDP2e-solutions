;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex001) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 1
;; The primary goal of this exercise is to create an expression that compute
;; s the distance of some specific Cartesian point (x,y) from the origin (0,0).
; ;The secondary goal is to get some first exposure to BSL, DrRacket and its
;; interactions area to develop expressions.

(define x 3)
(define y 4)

(sqrt (+ (sqr x) (sqr y))) ;=> 5
(sqrt (+ (sqr 12) (sqr 5))) ;=> 13