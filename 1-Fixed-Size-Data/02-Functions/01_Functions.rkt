#lang htdp/bsl
(require 2htdp/image)

;;  2.1 funcions

;; Definitions examples

;; Silly functions that don't use the parameters
(define (f x) 1)
(define (g x y) (+ 1 1))
(define (h x y z) (+ (* 2 2) 3))

;; doesn't matter what parameters ypu pass
(f 1) ; 1
(f "hello world") ; 1
(f #true)  ;1
(f (circle 3 "solid" "red"))
(g 1 2)  ; 2
(g 1 "hello") ; 2
(h 2 "hello" #false) ; 7


;; a useful funtion
(define (ff a)
  (* 10 a))

;; aplications  (fn par1 par2 par3)
(ff 2) ; 20
(ff 4) ; 40

;; See exercises 11 - 20