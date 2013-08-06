;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname chapter_02_03_06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.3 How to Design Programs
;; Exercises 32-39

(require 2htdp/image)
(require 2htdp/universe)

;; 2.3.3 Domain Knowledge

;; 2.3.4 From Functions to Programs

;; 2.3.5 On Testing


;; Figure 8

; Number -> Number 
; convert Fahrenheit temperatures to Celsius temperatures  
  
(check-expect (f2c -40) -40) 
(check-expect (f2c 32) 0) 
(check-expect (f2c 212) 100) 
  
(define (f2c f) 
  (* 5/9 (- f 32))) 


;; 2.3.6 Designing World Programs

;; Exercise 32.
;; Car sample world

;; Constants;
(define W-WIDTH 300)
(define W-HEIGTH 40)
(define SCALE 3)

;; Physical Constants
(define WHEEL-RADIUS 5) 
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5)) 
(define BODY-LENGTH (+ WHEEL-DISTANCE (* 6 WHEEL-RADIUS))) 
(define BODY-HEIGHT (* WHEEL-RADIUS 2)) 

;; Graphical Constants
(define WHL (circle WHEEL-RADIUS "solid" "black")) 
(define BDY 
  (above 
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2) 
               "solid" "red") 
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red"))) 
(define SPC (rectangle WHEEL-DISTANCE 1 "solid" "white")) 

;; a car!
(define CAR (above BDY
                   (beside WHL SPC WHL)))

(define Y-CAR (- W-HEIGTH (/ (image-height CAR) 2)))
(define BACKGROUND (empty-scene W-WIDTH W-HEIGTH)) 


;; Data definitions

; CarState is a Number 
; the number of pixels between the left border and the car 

;; Functions

;; clock ticks
;; CarState -> CarState
; the clock ticked; move the car by three pixels 
; example:  
; given: 20, expected 23 
; given: 78, expected 81 
;(define (tock cs) cs) ;stub
(define (tock cs) (+ cs SCALE))


;; keyboard handling
; CarState String -> CarState

;; mouse clicks
;; CarState Number Number String -> CarState

;; rendering
;; CarState -> Image
; place the car into a scene, according to the given world state 
(check-expect (render 50) 
              (place-image 
               CAR 
               50 Y-CAR 
               BACKGROUND))
(check-expect (render 100)               
              (place-image 
               CAR 
               100 Y-CAR 
               BACKGROUND) )

;(define (render cs) (empty-scene 300 50)) ;stub
(define (render cs) 
  (place-image CAR cs Y-CAR BACKGROUND))

;; end -- ex. 33
;; CarState -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) false)
(check-expect (end? 100) false)
(check-expect (end? W-WIDTH) true)

(define (end? cs) (= cs W-WIDTH))

; main : CarState -> CarState 
; launch the program from some initial state  
(define (main cs) 
   (big-bang cs 
             (on-tick tock) 
             (to-draw render)
             (stop-when end?)))



;; Exercise 33
;; Get world working and run
;(main 0)


;; Exercise 34
;; In the original program WS represented pixels between the left border 
;; and the car so you do translation in the on-tick function
;; In this program the WS represents the number of ticks sinces the program
;; began, so you do translation in the render fucntion
;; See animationstate.rkt


;; Exercise 35
;; See sinefunction.rck


;; Of Mice and Characters example
;; See allkeys.rkt


;; Exercise 36
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









