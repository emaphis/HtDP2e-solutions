;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;  2.1 - Numbers and aritmetic

(* (+ 2 2) (/ (* (+ 3 5) (/ 30 10)) 2))
48

;; Exercise 2.1.1
;; Find out whether DrScheme has operations for squaring a number;
;; for computing the sine of an angle;
;; and for determining the maximum of two numbers

(sqr 4)     ;> 16
(sin .33)   ;> #i0.32404302839486837
(max 10 20) ;> 20

;; Exercise 2.1.2.
;; Evaluate (sqrt 4), (sqrt 2), and (sqrt -1) in DrScheme.
;; Then, find out whether DrScheme knows an operation for determining the tangent of an angle.
(sqrt 4)   ;> 2
(sqrt 2)   ;> #i1.4142135623730951
(sqrt -1)  ;> 0+1i  complex number
(tan .25)  ;> #i0.25534192122103627
(tan 0)    ;> 0
(tan pi)   ;> #i-1.2246467991473532e-016