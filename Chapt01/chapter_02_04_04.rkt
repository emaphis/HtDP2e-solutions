;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname chapter_02_04_04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e  -- Enumerations, Intervals, Itemizations
;; 2.4.4 Intervals
;; Exercises: 44-51

;; for ufo example see: ufo1.rkt

;; Exercise 44.
; [3,5] => 3,4,5
; (3,5] => 4,5
; [3,5) => 3,4
; (3,5) => 4



;; 2.4.5 Itemizations


; string->number : String -> NorF 
; converts the given string into a number; 
; produces false if impossible  

; A NorF is one of:  
; – false 
; – a Number 


; NorF -> Number 
; add 3 to the given number; 3 otherwise 
  
(check-expect (add3 false) 3) 
(check-expect (add3 0.12) 3.12) 
  
(define (add3 x) 
  (cond 
    [(boolean? x) 3] 
    [else (+ x 3)])) 

;; String -> Number
;; converts a String to a Number adds 3 to it
;; if the String is an invalid number return 3

(check-expect (add3-to-str "1") 4)
(check-expect (add3-to-str "10") 13)
(check-expect (add3-to-str "one") 3)

;(define (add3-to-str str) 3) ;stub

(define (add3-to-str str)
  (add3 (string->number str)))


;; Sample problem - rocket launch
;; See rocketlaunch.rkt

;; Exercise 45: 
;; See rocklaunch.rkt data definitions

;; Exercise 46.
;; (string=? "resting" x) is inaccurate because any string can be 
;; concidered a resting state.
;; a better test for the third clause:  (>= x 0 HEIGHT) will catch a 
;; boundry condition.

;; Exercise 47:
;; Integer -> Image
;; render the rocket image at a given height
;(check-expect (render-rocket 10) 
;              (place-image ROCKET 10 (- 10 ROCKET-CENTER) BACKG))
;(define (render-rocket x)
;  (place-image ROCKET 10 (- x ROCKET-CENTER) BACKG))
;; See rocketlaunch.rkt


;; Exercise 48
;; LRCD -> LRCD 
;; run with: (main2 "")
;(define (main2 s) 
;  (big-bang s (on-tick fly) (to-draw show) (on-key launch))) 
;; See rocketlaunch.rkt


;; 2.4.6 Designing with Itemizations

;; Sales tax example

; A Price falls into one of three intervals:  
; — 0 through 1000; 
; — 1000 through 10000; 
; — 10000 and above. 
(define PRC1 0)
(define PRC2 500)
(define PRC3 1000)
#;
(define (fn-for-st st)        ;template
  (cond 
    [(and (<= 0 st) (< st 1000)) (... st)] 
    [(and (<= 1000 st) (< st 10000)) (... st)] 
    [(>= st 10000) (... st)]))


; Price -> Number 
; compute the amount of tax charged for price p 
(check-expect (sales-tax     0.00)   0.00)
(check-expect (sales-tax   537.00)   0.00)
(check-expect (sales-tax  1000.00) (* 0.05 1000.00))
(check-expect (sales-tax  1282.00)  64.10)
(check-expect (sales-tax 10000.00) (* 0.08 10000.00))
(check-expect (sales-tax 12017.00) 961.36)

;(define (sales-tax p) 0.00) ;stub

#;
(define (sales-tax p)        ;template
  (cond 
    [(and (<= 0 p) (< p 1000)) ...] 
    [(and (<= 1000 p) (< p 10000)) ...] 
    [(>= p 10000) ...])) 

(define (sales-tax p) 
  (cond 
    [(and (<= 0 p) (< p 1000)) 0] 
    [(and (>= p 1000) (< p 10000)) (* 0.05 p)] 
    [(>= p 10000) (* 0.08 p)])) 


;; Exercise 49 

(define BASE-PRC 0.00)
(define MID-PRC  0.05)
(define HIGH-PRC 0.08)

; Price -> Number 
; compute the amount of tax charged for price p 
(check-expect (sales-tax2     0.00)   0.00)
(check-expect (sales-tax2   537.00)   0.00)
(check-expect (sales-tax2  1000.00) (* 0.05 1000.00))
(check-expect (sales-tax2  1282.00)  64.10)
(check-expect (sales-tax2 10000.00) (* 0.08 10000.00))
(check-expect (sales-tax2 12017.00) 961.36)

(define (sales-tax2 p) 
  (cond 
    [(and (<= 0 p) (< p 1000)) (* BASE-PRC p)] 
    [(and (>= p 1000) (< p 10000)) (* MID-PRC p)] 
    [(>= p 10000) (* HIGH-PRC p)])) 


;; 2.4.7 A Bit More About Worlds


;; Traffic Light Example
;; Exercise 50
;; see trafficlight.rkt


;; Door state example:
;; Exercise 51
;; see doorstate.rkt



