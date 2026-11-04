#lang htdp/bsl
;; reformulation exercise:
;; figure 24.

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT))
(define ROCKET (circle 10 "solid" "blue"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define (create-rocket-scene.v5 h)
  (cond
    [(<= h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 h MTSCN)]
    [(> h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))

;; nesting the cond expression in a another expression for simplicfication
;; place-image is only executed once.
(define (create-rocket-scene.v6 h)
  (place-image ROCKET 50
   (cond
     [(<= h ROCKET-CENTER-TO-TOP) h]
     [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
   MTSCN))
