;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; reformulation exercise:
;; figure 24.

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
