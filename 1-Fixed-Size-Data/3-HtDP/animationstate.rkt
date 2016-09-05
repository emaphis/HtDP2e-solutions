;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname animationstate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 3.6 Designing World Programs
;; Exercise 45 - animation state

(require 2htdp/image)
(require 2htdp/universe)

;; Car animation program

;; =================
;; Constants:

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


;; =================
;; Data definitions:

; AnimationState is a Number
; interp. the number of clock ticks
; since the animation started
(define AS1  0)

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
;; produce the next animation state
;; just increment AS by one
(check-expect (tock 0) 1)
(check-expect (tock 100) 101)

(define (tock as) (add1 as))


;; AS -> Image
; place the car into a scene, according to the given world state
(check-expect (render 50)
              (place-image
               CAR
               (* 50 3) Y-CAR
               BACKGROUND))
(check-expect (render 100)
              (place-image
               CAR
               (* 100 3) Y-CAR
               BACKGROUND))

;(define (render as) BACKGROUND) ;stub
(define (render as)
  (place-image CAR (* as 3) Y-CAR BACKGROUND))

;; end
;; AS -> Boolean
;; end car simulation when car reaches end of world
(check-expect (end? 0) false)
(check-expect (end? 100) true)
(check-expect (end? W-WIDTH) true)

(define (end? as)
  (>= (* as 3) W-WIDTH))


