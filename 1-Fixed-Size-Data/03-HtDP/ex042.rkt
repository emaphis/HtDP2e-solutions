;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname righthand) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Programs
;; 3.6 Designing World Programs
;; Exercise 42

(require 2htdp/image)
(require 2htdp/universe)

;; Car sample world

;; Ex. 42
;; Modify the interpretation of the sample data definition so that a state
;; denotes the x-coordinate of the right-most edge of the car.

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

(define CAR-CENTER (/ (image-width CAR) 2))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image
                    TREE
                    200 (- HEIGHT-OF-WORLD (/ (image-height TREE) 2))
                    (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))


;; Data definitions

; WorldState is a Number
; interpretation the number of pixels between the right border and the car

;; Functions

;; clock ticks
;; WorldState -> WorldState
; the clock ticked; move the car by 3 pixels


(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))


;; rendering
;; WorldState -> Image
; place the car into the BACKGROUND scene,
;; according to the given world state

;(define (render ws) BACKGROUND) ;stub

(check-expect (render  50)
              (place-image CAR  (- 50 CAR-CENTER) Y-CAR BACKGROUND))
(check-expect (render 200)
              (place-image CAR (- 200 CAR-CENTER) Y-CAR BACKGROUND))

(define (render ws)
  (place-image CAR (- ws CAR-CENTER) Y-CAR BACKGROUND))

;; WorldState -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) #false)
(check-expect (end? WIDTH-OF-WORLD) #false)
(check-expect (end? (+ WIDTH-OF-WORLD (image-width CAR) )) #true)

(define (end? ws)
  (>= ws (+ WIDTH-OF-WORLD (image-width CAR))))


;; main : WorldState -> WorldState
;; launch the program from some initial state
;; run: (main 0)
(define (main ws)
   (big-bang ws
             [on-tick tock]
             [to-draw render]
             [stop-when end?]))

;(main 0)
