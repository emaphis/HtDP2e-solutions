;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex096) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 96:
;; Sketch how each of the three game states could be rendered assuming
;; a 200 by 200 canvas. See MOCK-UP above


(require 2htdp/image)

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
(define MISSILE-Y 125)
(define MISSILE-X 150)
(define TANK-X 150)
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))

;; original mock-up
(define MOCK-UP
  (place-image TANK TANK-X TANK-Y
               (place-image UFO UFO-X UFO-Y
                            (place-image MISSILE MISSILE-X MISSILE-Y
                                         SCENE))))


; an instance that describes the tank maneuvering into position to fire:
; the missile:
; (make-aim (make-posn 20 10) (make-tank 28 -3))

(define AIM-SCENE1
  (place-image TANK 58 TANK-Y
               (place-image UFO 50 30
                            SCENE)))

; just like the previous one but the missile has been fired:
; (make-fired (make-posn 20 10) (make-tank 28 -3)
; (make-posn 28 (- HEIGHT TANK-HEIGHT)))

(define FIRE-SCENE1
  (place-image TANK 60 TANK-Y
               (place-image UFO 50 60
                            (place-image MISSILE 58 (- HEIGHT TANK-HEIGHT 10)
                                         SCENE))))

; one where the missile is about to collide with the UFO:
; (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103))
; TANK -> UFO -> MISSLE
(define FIRE-SCENE2
  (place-image TANK 60 TANK-Y
               (place-image UFO 50 100
                            (place-image MISSILE 58 120
                                         SCENE))))
;; Tests
AIM-SCENE1
FIRE-SCENE1
FIRE-SCENE2
