;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_05_Itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e  Enumerations, Intervals, Itemizations
;; 4.5 Itemizations
;; Exercises: 55

(require 2htdp/image)

; String -> NorF
; converts the given string into a number;
; produces #false if impossible
(define (string->number1 s) (... s ...))

; A NorF is one of:
; – #false
; – a Number


; NorF -> Number
; add 3 to the given number; 3 otherwise

(check-expect (add3 #false) 3)
(check-expect (add3 0.12) 3.12)

(define (add3 x)
  (cond
    [(false? x) 3]
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

;; Ex. 55:
;; In some way it is best to draw some world scenarios and to represent
;; them with data and, conversely, to pick some data examples and to
;; draw pictures that match them. Do so for the LR definition, including
;; at least HEIGHT and 0 as examples.

; physical constants
(define HEIGHT 300)
(define WIDTH  100)
(define YDELTA 3)

; graphical constants
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red")) ; use your favorite image
(define ROCKET-CENTER (/ (image-height ROCKET) 2))

;; A LR (short for: launching rocket) is one of:
;; – "resting"
;; – non-negative number
;; interp. "resting is a rocket on the ground
;; the number denotes the height of a rocket in flight

;; sample data FOR LR
(define LR1 "resting")
(define LR2 0)                         ; landed
(define LR3 (/ HEIGHT 2))              ; half way up.
(define LR4 (- HEIGHT (image-height ROCKET)))  ; touching top of screen
(define LR5 HEIGHT)                    ; just off screenR

;; transform rocket height to screen pixels
(define (trans n)  (- (- HEIGHT  n) ROCKET-CENTER))

;; some mock-up images
(place-image ROCKET 50 (trans LR2) BACKG)  ; landed
(place-image ROCKET 50 (trans 75) BACKG)   ; 75 units high
(place-image ROCKET 50 (trans LR3) BACKG)  ; almost half way
(place-image ROCKET 50 (trans LR4) BACKG)  ; almost all the way
(place-image ROCKET 50 (trans LR5) BACKG)  ; all the way up



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



