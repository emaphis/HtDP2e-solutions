#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)


;; rocket scent version 6
;; more realistic landing


(define ROCKET (bitmap "rocket.png"))

; properties of the "world"
(define WIDTH 100)
(define HEIGHT 200)

; properties of the descending rocket
(define VELOCITY 15)

; other constants
(define MTSCN (empty-scene WIDTH HEIGHT "light blue"))
(define ROCKET-CENTER-TO-BOTTOM
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define X 50) ;; magic number

; functions
(define (create-rocket-scene t)
  (cond
    [(<= (distance t) ROCKET-CENTER-TO-BOTTOM)
     (place-image ROCKET X (distance t) MTSCN)]
    [(> (distance t) ROCKET-CENTER-TO-BOTTOM)
     (place-image ROCKET X ROCKET-CENTER-TO-BOTTOM MTSCN)]))

(define (distance t)
  (* VELOCITY t))

;(animate create-rocket-scene)
