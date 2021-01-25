;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex049) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 49:
;; (- 200 (cond [(> y 200) 0] [else y]))
;; Use the stepper to evaluate the expression for y as 100 and 210.

(- 200 (cond [(> 100 200) 0] [else 100]))
(- 200 (cond [#false 0] [else 100]))
(- 200 (cond [else 100]))
(- 200 100)
100

(- 200 (cond [(> 210 200) 0] [else 210]))
(- 200 (cond [#true 0] [else 210]))
(- 200 0)
200
