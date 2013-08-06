;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sinefunction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.3.6 Designing World Programs
;; Exercise 35 - sine function world

(require 2htdp/image)
(require 2htdp/universe)


;; =================
;; Constants:

(define W-WIDTH 30)
(define W-HEIGTH 100)
(define MID-H (/ W-HEIGTH 2))
(define MID-W (/ W-WIDTH 2))

;; Physical Constants

;; Graphical Constants
(define DOT (circle 5 "solid" "red"))

(define BACKGROUND (overlay
  (rectangle W-WIDTH 1 "solid" "black" )
  (empty-scene W-WIDTH W-HEIGTH))) 


;; =================
;; Data definitions:

;; AnimationState is a Number 
;; interp. the number of clock ticks since the animation started 
;; clock clicks will relate to degrees 
(define AS1  0)
(define FULL 360)

;; =================
;; Functions:

;; AS -> AS
;; start the world with (main 0)
;; 
(define (main as)
  (big-bang as                   ; AS
            (on-tick   tock)     ; AS -> AS
            (to-draw   render)   ; AS -> Image
            (stop-when end?)     ; AS -> Boolean
            ))

;; AS -> AS
;; produce the next animation state on a clock tick
;; just increment AS by one 
(check-expect (tock 0) 1)
(check-expect (tock 100) 101)

(define (tock as) (add1 as))


;; Number -> Number
;; produce radians given degrees
;; 180/pi deg = radians
(check-within (deg->rad 0) 0 .001)
(check-within (deg->rad 360) (* 2 pi) .001)
(check-within (deg->rad (/ 180 pi)) 1  .001)

(define (deg->rad d) (inexact->exact (/ (* d pi) 180)))


;; Number -> Number
;; calculate the sine function given input in degrees
(check-within (calc   0)  0 .001)
(check-within (calc  90)  1 .001)
(check-within (calc 180)  0 .001)
(check-within (calc 270) -1 .001)
(check-within (calc 360)  0 .001)

(define (calc deg) (inexact->exact (sin (deg->rad deg))))


;; Number -> Number
;; scale the output of 'calc' to the world view
(check-expect (conv -1) 0)
(check-expect (conv  0) MID-H)
(check-expect (conv  1) W-HEIGTH)

(define (conv num) (+ (* MID-H num) MID-H))

;; AS -> Image
; place the car into a scene, according to the given world state 
(check-expect (render 50) 
              (place-image 
               DOT 
               MID-W (conv (calc 50)) 
               BACKGROUND))


;(define (render as) BACKGROUND) ;stub
(define (render as) 
  (place-image DOT MID-W (conv (calc as)) BACKGROUND))


;; end
;; AS -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) false)
(check-expect (end? 100) false)
(check-expect (end? FULL) true)

(define (end? as) (>= as FULL))


