;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_Designing_World_Programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Programs
;; 3.6 Designing World Programs
;; Exercises 39-44

(require 2htdp/image)
(require 2htdp/universe)

;; Car sample world

;; 1. Define constants

;; a. Physical constants
(define WIDTH-OF-WORLD 200)
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

;; b. Graphical constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle ... WHEEL-RADIUS ... "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define BACKGROUND-WIDTH (* (image-width CAR) 8))
(define BACKGROUND-HEIGHT (* (image-height CAR) 2))
(define BACKGROUND (empty-scene BACKGROUNE-WIDTH BACKGROUND-HEIGHT))

;; 2. Those properties that change over time

;; A WorldState is a Number.
;; interpretation the number of pixels between
;; the left border of the scene and the car

;; 3. design a number of functions so that you can form
;;    a valid big-bang expression.

;; render
;; clock-tick-handler
;; keystroke-handler
;; mouse-event-handler
;; end?

;; WorldState -> Image
;; places the image of the car x pixels from 
;; the left margin of the BACKGROUND image 
(define (render x)
  BACKGROUND)
 
;; WorldState -> WorldState
;; adds 3 to x to move the car right 
(define (tock x)
  x)

;; WorldState -> WorldState
;; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))

;; to run program
; > (main 13)

;;;
;; See example 39
;;;.

;;;;
;;; The next entry on the wish list is the clock tick handling function:

;; Data definitions

;; WorldState is a Number
;; interpretation the number of pixels between the left border and the car

;; clock ticks
;; WorldState -> WorldState
;; the clock ticked; move the car by 3 pixels


;; Functions

;; WorldState -> WorldState 
;; moves the car by 3 pixels for every clock tick
;; examples: 
;;   given: 20, expect 23
;;   given: 78, expect 81
;(define (tock cs) cs\\cw) ;stub

(define (tock-2 cs\w)
  (+ cw 3))

;; See. exercise 40:


;; Formulate the examples as BSL tests.

;;; Second wishlist item:  rendering
;;   a function that translates the state of the world into an image:

(define Y-CAR 10)

;; WorldState -> Image
; place the car into the BACKGROUND scene,
;; according to the given world state
;(define (render ws)
;  BACKGROUND) ;stub]
(define (render-2 cw)
   (place-image CAR cw Y-CAR BACKGROUND))

;(place-image CAR 50 Y-CAR BACKGROUND)
;(place-image CAR 100 Y-CAR BACKGROUND)
;(place-image CAR 150 Y-CAR BACKGROUND)
;(place-image CAR 200 Y-CAR BACKGROUND)

;(check-expect (render-2  50) (place-image CAR  50 Y-CAR BACKGROUND))
;(check-expect (render-2 200) (place-image CAR 200 Y-CAR BACKGROUND))

;; See exercist 41 for complete program


;; Ex. 43a:
;; In the original program WS represented pixels between the left border 
;; and the car so you do translation in the on-tick function
;; In this program the WS represents the number of ticks sinces the program
;; began, so you do translation in the render function
;; See animationstate.rkt


;; Ex. 43b:
;; Use the data definition to design a program that moves the car according
;; to a sine wave. Don’t try to drive like that.
;; See sinefunction.rck


;; Ex. 44:
;; Add mousehandling
;; See carkeys.rkt


;; Of Mice and Keyboard examples
;; ;; http://www.ccs.neu.edu/home/matthias/notes/notes/note_mice-and-chars.html
;; See allmouse.rkt
;; See allkeys.rkt
