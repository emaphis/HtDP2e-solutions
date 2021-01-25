;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex053) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 53:
;; In some way it is best to draw some world scenarios and to represent
;; them with data and, conversely, to pick some data examples and to
;; draw pictures that match them. Do so for the LR definition, including
;; at least HEIGHT and 0 as examples.

(require 2htdp/image)

;; Datad  

; physical constants
(define HEIGHT 100)
(define WIDTH  100)

; graphical constants
(define SCENE  (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "images/rocket.png")) ; use your favorite image

(define ROCKET-HEIGHT (image-height ROCKET))
(define ROCKET-CENTER (- HEIGHT (/ ROCKET-HEIGHT 2)))
(define CENTER-Y  (/ WIDTH 2))

; A LR (short for: launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight.


ROCKET-HEIGHT
;; some mock-up images
(place-image ROCKET CENTER-Y (- HEIGHT (/ ROCKET-HEIGHT 2)) SCENE)  ; "resting"
(place-image ROCKET CENTER-Y (/ HEIGHT 2) SCENE)  ; almost half way
(place-image ROCKET CENTER-Y 0 SCENE)  ; almost all the way
(place-image ROCKET CENTER-Y HEIGHT SCENE)  ; all the way up

