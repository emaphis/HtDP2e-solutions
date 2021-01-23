;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex041) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 41:
;; Assemble into a working program

(require 2htdp/image)
(require 2htdp/universe)

;;; Definitions
;; Physical Constants;
(define WIDTH-OF-WORLD 400)
(define WHEEL-RADIUS 5)  ; single point of controlx
(define WHEEL-OFFSET (* WHEEL-RADIUS 3))

;; Graphical Constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-OFFSET WHEEL-RADIUS "solid" "transparent"))

(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BODY-LENGTH (* WHEEL-RADIUS 10))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))

(define BODY
  (above
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2) "solid" "red")
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))

;; a car!
(define CAR
  (overlay/offset BODY
                  0 (* WHEEL-RADIUS 1.5)
                  BOTH-WHEELS))


(define HEIGHT-OF-WORLD (* (image-height CAR) 1.5))
(define Y-CAR (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))


(define BACKGROUND
  (empty-scene WIDTH-OF-WORLD (* WHEEL-RADIUS 6)))


;;; Data Definition

; A WorldState is a Number.
; the number of pixels between the left border of
; the scene and the car.
  
;;; Functions

;; WorldState -> WorldState 
;; moves the car by 3 pixels for every clock tick
;; examples: 
;;   given: 20, expect 23
;;   given: 78, expect 81
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))


;; WorldState -> Image
; place the car into the BACKGROUND scene,
;; according to the given world state
(check-expect (render  50) (place-image CAR  50 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))

(define (render ws)
   (place-image CAR ws Y-CAR BACKGROUND))


;; WorldState -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) #false)
(check-expect (end? 100) #false)
(check-expect (end? (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))) #true)

(define (end? ws)
  (>= ws (- WIDTH-OF-WORLD (/ (image-width CAR) 2))))

;; main : WorldState -> WorldState
;; launch the program from some initial state
;; run: (main 0)
(define (main ws)
   (big-bang ws
             (on-tick tock)
             (to-draw render)
             (stop-when end?)))

;(main 0)

