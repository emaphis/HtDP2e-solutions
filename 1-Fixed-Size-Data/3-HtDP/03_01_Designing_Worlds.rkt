;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 03_01_Designing_Worlds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Programs
;; 3.6 Designing World Programs
;; Exercises 41-46

(require 2htdp/image)
(require 2htdp/universe)

;; Car sample world

;; Ex. 41:
;; Develop your favorite image of an automobile so that WHEEL-RADIUS
;; remains the single point of control.

;; Physical Constants;
(define W-WIDTH 300)
(define W-HEIGTH 40)
;(define SCALE 3)

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


;;; The next entry on the wish list is the clock tick handling function:

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

;; Ex. 42:
;; Formulate the examples as BSL tests.


;;; Second wishlist item:

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

;; main : WorldState -> WorldState
;; launch the program from some initial state
;; run: (main 0)
(define (main ws)
   (big-bang ws
             (on-tick tock) 
             (to-draw render)
             (stop-when end?)))

;(main 0)


;; Ex. 45a:
;; In the original program WS represented pixels between the left border 
;; and the car so you do translation in the on-tick function
;; In this program the WS represents the number of ticks sinces the program
;; began, so you do translation in the render fucntion
;; See animationstate.rkt


;; Ex 45b.
;; See sinefunction.rck


;; Of Mice and Characters example
;; See allkeys.rkt

;; Exercise 46
;; See allkeys.rkt


;; AllMouseEvents example
;; Figure 9: A mouse event recorder
;; See allmouse.rkt


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2.3.7 Virtual Pet Worlds

;; Exercise 37 VirtualPet
;; See virtualpet.rkt

;; Exercise 38 Improvements
;; See virtualpet.rkt

;; Exercise 39 Pet Guage
;; See virtualpet2.rkt









