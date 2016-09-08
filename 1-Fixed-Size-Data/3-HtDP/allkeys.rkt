;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname allkeys) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 3 How to Design Programs
;; 3.6 Designing World Programs
;; allkeys example
;; Exercise 44

(require 2htdp/image)
(require 2htdp/universe)

;; Car sample world

;; Physical Constants;
(define W-WIDTH 300)
(define W-HEIGTH 40)

(define WHEEL-RADIUS 5)  ; single point of control
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define BODY-LENGTH (+ WHEEL-DISTANCE (* 6 WHEEL-RADIUS)))
(define BODY-HEIGHT (* WHEEL-RADIUS 3))

;; Graphical Constants
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))

(define BODY
  (above
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2)
               "solid" "red")
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))

(define SPC (rectangle WHEEL-DISTANCE WHEEL-RADIUS
                       "solid" "transparent"))

;; a car!
(define CAR (above BODY
                   (beside WHEEL SPC WHEEL)))

(define Y-CAR (- W-HEIGTH (/ (image-height CAR) 2)))
(define BACKGROUND (empty-scene W-WIDTH W-HEIGTH))


;; Data definitions

; WorldState is a Number
; the number of pixels between the left border and the car

;; Functions

;; clock ticks
;; WorldState -> WorldState
; the clock ticked; move the car by 3 pixels
; example:
; given: 20, expected 23
; given: 78, expected 81
;(define (tock cs) cs) ;stub
(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

;; rendering
;; WorldState -> Image
; place the car into the BACKGROUND scene,
;; according to the given world state

;(define (render ws) BACKGROUND) ;stub

(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

(check-expect (render 50)
              (place-image
               CAR
               50 Y-CAR
               BACKGROUND))
(check-expect (render 100)
              (place-image
               CAR
               100 Y-CAR
               BACKGROUND))

;; Ex. 43:
;; Assemble into a working program
;; end
;; WorldState -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) #false)
(check-expect (end? 100) #false)
(check-expect (end? (+ W-WIDTH (/ (image-width CAR) 2))) #true)

(define (end? ws)
  (>= ws (+ W-WIDTH (/ (image-width CAR) 2))))

;; WorldState Number Number String -> WorldState
;; places the car at the x-coordinate
;; if the given me is "button-down"
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42

;(define (hyper x-coordinate x-mouse y-mouse me) ; stub
;  x-coordinate)

(define (hyper x-coordinate x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else  x-coordinate]))

(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)

;; main : WorldState -> WorldState
;; launch the program from some initial state
;; run: (main 0)
(define (main ws)
   (big-bang ws
             (on-tick tock)
             (on-mouse hyper)
             (to-draw render)
             (stop-when end?)))

;(main 0)

