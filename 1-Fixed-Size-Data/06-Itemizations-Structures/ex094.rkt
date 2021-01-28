;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex094) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 94:
;; Draw some sketches of what the game scenery looks like at various stages.
;; Use the sketches to determine the constant and the variable pieces of the
;; game. For the former, develop physical and graphical constants that describe
;; the dimensions of the world (canvas) and its objects. Also develop some
;; background scenery. Finally, create your initial scene from the constants
;; for the tank, the UFO, and the background.

; Sketch done on paper.

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

;; starting positions
(define UFO-X 100)
(define UFO-Y 50)
(define TANK-X 150)
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))

;; a mock-up
(define MOCK-UP
  (place-image TANK TANK-X TANK-Y
               (place-image UFO UFO-X UFO-Y
                            SCENE)))
