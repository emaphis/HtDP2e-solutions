;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex097) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 97:
;; Design the functions tank-render, ufo-render, and missile-render.

(require 2htdp/image)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Physical Constants

(define WIDTH 200)
(define HEIGHT 200)
(define SCENE (empty-scene WIDTH HEIGHT "skyblue"))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO (overlay  (circle (/ UFO-HEIGHT 2) "solid" "purple")
             (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "blue")))

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "olive"))

(define MISSILE-WIDTH 1)
(define MISSILE-HEIGHT 15)
(define MISSILE
  (rectangle MISSILE-WIDTH MISSILE-HEIGHT "solid" "red"))

;; starting positions
(define UFO-X 100)
(define UFO-Y 50)
(define TANK-X 150)
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; data definitions:

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number).
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define TANK1 (make-tank 50 10))


; A Missile is a Posn.
; interpretation (make-posn x y) is the missile's place

(define MISSILE1 (make-posn 20 80))


; the time period when the player is trying to get the tank in position
; for a shot,
(define-struct aim [ufo tank])

;; example
(define AIM0 (make-aim (make-posn 100 120)
                       (make-tank 50 3)))


; States after the missile is fired. Before we can formulate a data definition
; for the complete game state
(define-struct fired [ufo tank missile])

(define FIRED1 (make-fired (make-posn 100 120)
                           (make-tank 50 3)
                           (make-posn 20 150)))


; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

;;; do an example


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 97:
;; Design the functions tank-render, ufo-render, and missile-render.

#; ;; Compare this expression:
(tank-render
  (fired-tank img)
  (ufo-render (fired-ufo s)
              (missile-render (fired-missile s)
                              SCENE)))

#; ;; with this one:
(ufo-render
  (fired-ufo s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s)
                               BACKGROUND)))

;; When do the two expressions produce the same result?
; Answer:
; the different implementations will only produce the same result
; when the images don't overlap.


;; Designed functions

; Tank Image -> Image
; adds t to the given image im
(check-expect (tank-render (make-tank 28 -3) SCENE)
              (place-image TANK 28 TANK-Y SCENE))

;(define (tank-render t im) im) ;stub

(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))


; UFO Image -> Image
; adds u to the given image im
(check-expect (ufo-render (make-posn 20 100) SCENE)
              (place-image UFO 20 100 SCENE))

;(define (ufo-render u im) im) ;stub

(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))


; Missle Image -> Image
; adds m to the given image im
(check-expect (missile-render (make-posn 28 30) SCENE)
              (place-image MISSILE 28 30 SCENE))

;(define (missile-render u im) im) ;stub

(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))
