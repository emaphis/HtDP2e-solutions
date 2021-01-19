;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname animationstate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Programs
;; 3.6 Designing World Programs
;; Exercise 43,44 - animation state

(require 2htdp/image)
(require 2htdp/universe)

;; Car animation program

;; Ex. 43a:
;; In the original program WS represented pixels between the left border
;; and the car so you do translation in the on-tick function
;; In this program the WS represents the number of ticks sinces the program
;; began, so you do translation in the render function

;; =================
;; Constants:

;; Physical Constants;
(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 40)

(define WHEEL-RADIUS 5)  ; single point of control
(define WHEEL-DISTANCE (* WHEEL-RADIUS 4))

;; Graphical Constants
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))

(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS
                         "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BODY-LENGTH (+ WHEEL-DISTANCE (* 4 WHEEL-RADIUS)))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))

(define BODY
  (above
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2)
               "solid" "red")
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))

;; a car!
(define CAR (overlay/align/offset
             "middle" "bottom"
             BOTH-WHEELS
             0 (- 0 WHEEL-RADIUS)
             BODY))


(define Y-CAR (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image
                    TREE
                    200 (- HEIGHT-OF-WORLD (/ (image-height TREE) 2))
                    (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define SPEED 3)  ; pixels moved per clock tick


;; =================
;; Data definitions:

; AnimationState is a Number
; interp. the number of clock ticks since the animation started

(define AS1  0)


;; =================
;; Functions:

;; AnimationState -> AnimationState
;; add 1 to AnimationState per clock tick
(check-expect (tock 0) 1)
(check-expect (tock 100) 101)

(define (tock as) (add1 as))


;; AnimationState -> Image
; place the image of the CAR on the BACKGROUNDaccording to the given world state
(check-expect (render  50) (place-image CAR (*  50 3) Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR (* 200 3) Y-CAR BACKGROUND))

;(define (render as) BACKGROUND) ;stub
(define (render as)
  (place-image CAR (* as SPEED) Y-CAR BACKGROUND))

;; end
;; AnimationState -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) #false)
;(check-expect (end? (- WIDTH-OF-WORLD (sub1 (image-width CAR)))) #false)
(check-expect (end? WIDTH-OF-WORLD) #true)

(define (end? as)
  (>= (* as SPEED) (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))))


;; AnimationState -> AnimationState
;; start the world with (main 0)
;;
(define (main as)
  (big-bang as                   ; AnimationState
            [on-tick   tock]     ; AnimationState -> AnimationState
            [to-draw   render]   ; AnimationState -> Image
            [stop-when end?]     ; AnimationState -> Boolean
            ))
