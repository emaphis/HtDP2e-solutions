;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 Enumerations, Intervals, Itemizations
;; 4.5 Itemizations
;; Rocket experiment

;; version using (define CENTER (/ (image-height ROCKET) 2))
;; The formula for the check-expects and "show" are very different
;; from the book

(require 2htdp/image)
(require 2htdp/universe)

;; Physical constants

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
;(define CENTER (- HEIGHT (/ (image-height ROCKET) 2)))
(define CENTER (/ (image-height ROCKET) 2))


; A LRCD (for launching rocket count down) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in count-down mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

;; Functions

; LRCD -> Image
; renders the state as a resting or flying rocket

(check-expect
 (show "resting")
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
 
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))

(check-expect  ; just off the screen
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER HEIGHT 10) BACKG))

(check-expect
 (show 53)
 (place-image ROCKET 10 (-  HEIGHT CENTER 53) BACKG))



;(define (show x) ; stub
;  (place-image (square 10 "solid" "blue") 10 53 BACKG));

(define (show x)
  (cond
    [(string? x)
     (place-image ROCKET 10 (- HEIGHT CENTER 0) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER 0)
                               BACKG))]
    [(>= x 0)
     (place-image ROCKET 10 (- HEIGHT CENTER x) BACKG)]))


; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)
  x)
 
; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already 
(define (fly x)
  x)
 