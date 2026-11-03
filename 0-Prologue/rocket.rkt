#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; rocket scent version 6
;; more realistic landing

; NOTE: I'm getting graphics from a file on the computer
;       so I can leave rkt files in a text mode.
(define ROCKET (bitmap "rocket.png"))

; properties of the "world" and descending rocket
(define WIDTH 100)
(define HEIGHT 200)
(define V 3)
(define X 50)

; other constants
(define MTSCN (empty-scene WIDTH HEIGHT "light blue"))
(define ROCKET-CENTER-TO-BOTTOM
  (- HEIGHT (/ (image-height ROCKET) 2)))

; functions
(define (picture-of-rocket t)
  (cond
    [(<= (distance t) ROCKET-CENTER-TO-BOTTOM)
     (place-image ROCKET X (distance t) MTSCN)]
    [(> (distance t) ROCKET-CENTER-TO-BOTTOM)
     (place-image ROCKET X ROCKET-CENTER-TO-BOTTOM MTSCN)]))

(define (distance t)
  (* V t))

(animate picture-of-rocket)
