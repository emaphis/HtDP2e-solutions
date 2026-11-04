#lang htdp/bsl
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
