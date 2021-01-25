;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex055) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ex55.
;;Take another look at show. It contains three instances of an expression
;; with the approximate shape:
;;(place-image ROCKET 10 (- ... CENTER) BACKG)

;; This expression appears three times in the function: twice to draw a resting rocket and once to draw a flying rocket. Define an auxiliary function that performs this work and thus shorten show. Why is this a good idea? 

(require 2htdp/image)
(require 2htdp/universe)

;; Constants

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red")) 
(define CENTER (/ (image-height ROCKET) 2))

;; Function definition

; LRCD -> Image
; renders the state as a resting or flying rocket

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))

(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))

;(define (show x) ; stub
;  SCENE)

;; Ex. 55:
;; an axiliary function:

;; Integer -> Image
;; render the rocket image at a given height
(check-expect (render-rocket 10)
              (place-image ROCKET 10 (- 10 CENTER) BACKG))

(define (render-rocket x)
  (place-image ROCKET 10 (- x CENTER) BACKG))

;; new show using render-rocket.
(define (show x)
  (cond
    [(string? x)
     (render-rocket HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (render-rocket HEIGHT))]
    [(>= x 0)
     (render-rocket x)]))
