#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)


(define ROCKET (bitmap "rocket.png"))

;; 1.2 Inputs and Output

(define (y x) (* x x))

;; rocket scene version 1
(define (create-rocket-scene.v1 height) 
  (place-image ROCKET 50 height (empty-scene 100 100))) 


;(create-rocket-scene.v1 0) 
;(create-rocket-scene.v1 10) 
;(create-rocket-scene.v1 20) 
;(create-rocket-scene.v1 30) 

;; test in REPL
;(animate cr;eate-rocket-scene.v1)


;;1.3 Many Ways to Compute

;; condition expression
(define (sign x) 
  (cond 
    [(> x 0) 1] 
    [(= x 0)  0] 
    [(< x 0) -1])) 
  
;(sign 10) 
;(sign -5) 
;(sign 0) 


;; rocket scene version 2
;; land below the surface

(define (create-rocket-scene.v2 height) 
  (cond 
    [(<= height 100) 
     (place-image ROCKET 50 height (empty-scene 100 100))] 
    [(> height 100)   ;; stop the landing
     (place-image ROCKET 50 100 (empty-scene 100 100))])) 

;; try in repl
;(animate create-rocket-scene.v2)

;; fix image height:
(- 100 (/ (image-height ROCKET) 2))  ; find midpoint of immage
;; => 79


;; rocket scene version 3
;; land on the surface
(define (create-rocket-scene.v3 height) 
  (cond 
    [(<= height (- 100 (/ (image-height ROCKET) 2))) 
     (place-image ROCKET 50 height (empty-scene 100 100))] 
    [(> height (- 100 (/ (image-height ROCKET) 2))) 
     (place-image ROCKET 50 (- 100 (/ (image-height ROCKET) 2)) 
                  (empty-scene 100 100))])) 

;(animate create-rocket-scene.v3)


;; 1.4 One Program, Many Definitions


(define Name "Expression") ;; constant definition


;; rocket scene version 4
;; defining some constants and refactoring

;(define WIDTH 100)   ; duplicated defininiton, see definitions below
;(define HEIGHT 100) 

(define (create-rocket-scene.v4 h) 
  (cond 
    [(<= h (- HEIGHT (/ (image-height ROCKET) 2))) 
     (place-image ROCKET 50 h (empty-scene WIDTH HEIGHT))] 
    [(> h (- HEIGHT (/ (image-height ROCKET) 2))) 
     (place-image ROCKET 50 (- HEIGHT (/ (image-height ROCKET) 2)) 
                  (empty-scene WIDTH HEIGHT))])) 
  

;(animate create-rocket-scene.v4)


;; rocket scene version 5
;; more refactoring

; constants  
;(define WIDTH  100)  ; see definitions below
;(define HEIGHT 100) 
;(define MTSCN  (empty-scene WIDTH HEIGHT)) 
;(define ROCKET-CENTER-TO-BOTTOM 
;  (- HEIGHT (/ (image-height ROCKET) 2))) 
  
; functions 
(define (create-rocket-scene.v5 h) 
  (cond 
    [(<= h ROCKET-CENTER-TO-BOTTOM) 
     (place-image ROCKET 50 h MTSCN)] 
    [(> h ROCKET-CENTER-TO-BOTTOM) 
     (place-image ROCKET 50 ROCKET-CENTER-TO-BOTTOM MTSCN)])) 

;(animate create-rocket-scene.v5)



;; rocket scent version 6
;; more realistic landing

; properties of the "world"
(define WIDTH 100)
(define HEIGHT 200)

; properties of the descending rocket
(define VELOCITY 20)
(define DECELERATION 1)

; other constants
(define MTSCN (empty-scene WIDTH HEIGHT "light blue"))
(define ROCKET-CENTER-TO-BOTTOM
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define X 50) ;; magic number

; functions
(define (create-rocket-scene.v6 t)
  (cond
    [(<= (distance t) ROCKET-CENTER-TO-BOTTOM)
     (place-image ROCKET X (distance t) MTSCN)]
    [(> (distance t) ROCKET-CENTER-TO-BOTTOM)
     (place-image ROCKET X ROCKET-CENTER-TO-BOTTOM MTSCN)]))

(define (distance t)
  (- (* VELOCITY t) (* 1/2 DECELERATION (sqr t))))


;(animate create-rocket-scene.v6)
