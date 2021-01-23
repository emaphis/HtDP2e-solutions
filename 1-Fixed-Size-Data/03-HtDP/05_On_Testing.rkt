;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_On_Testing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Functions
;; 3.5 On Testing
 ;; Exercises 36-40

;; Using check-expect helps automate testing

;; Figure 21: Testing in BSL

; Number -> Number
; convert Fahrenheit temperatures to Celsius temperatures

(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)

(check-expect (f2c -40) 40) ;; a wrong example

(define (f2c f)
  (* 5/9 (- f 32)))
