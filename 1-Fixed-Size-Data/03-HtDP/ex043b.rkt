;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex043b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 3 How to Design Programs
;; 3.6 Designing World Programs
;; Exercise 43b - sine function worldz

(require 2htdp/image)
(require 2htdp/universe)

;; Ex. 43a:
;; Use the data definition to design a program that moves the car
;; according to a sine wave. Don’t try to drive like that.

;; This one still needs work ***

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
;(check-expect (render  50) (place-image CAR (*  50 3) Y-CAR BACKGROUND))
;(check-expect (render 200) (place-image CAR (* 200 3) Y-CAR BACKGROUND))

;(define (render as) BACKGROUND) ;stub
(define (render as)
  (place-image CAR (* as SPEED) (y-pos as) BACKGROUND))


;; AnimationState -> Number
;; produce the Y position of the car given an AnimationState
(define (y-pos as)
  (+ (/ HEIGHT-OF-WORLD 2) (* 10 (sin as))))

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

;   0 0/4 p  0.0000
;  45 1/4 p  0.7071
;  90 2/4 p  1.0000
; 135 3/4 p  0.7071
; 180 4/4 p  0.0000
; 225 5/4 p -0.7071
; 270 6/4 p -1.0000
; 315 7/4 p -0.7071
; 360 8/4 p  0.0000

;(define (calc2 x)  )

;; Number -> Number
;; scale the output of 'calc' to the world view
;(check-expect (conv -1) 0)
;(check-expect (conv  0) MID-H)
;(check-expect (conv  1) W-HEIGTH)

;(define (conv num) (+ (* MID-H num) MID-H))

;; AS -> Image
; place the car into a scene, according to the given world state 
;(check-expect (render 50)
;              (place-image
;               DOT
;               MID-W (conv (calc 50))
;               BACKGROUND))