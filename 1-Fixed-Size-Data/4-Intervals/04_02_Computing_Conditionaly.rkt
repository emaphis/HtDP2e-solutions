;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_02_Computing_Conditionaly) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 1.4 Intervals, Enumerations, etc.
;; 4.2 Computing Conditionally
;; Exercises 50,51

(require 2htdp/image)

; A PositiveNumber is a Number greater or equal to 0.

; PositiveNumber-> String
; compute the reward level from the given score s
(define (reward s)
  (cond
    [(<= 0 s 10)
     "bronze"]
    [(and (< 10 s) (<= s 20))
     "silver"]
    [else "gold"]))

;; evaluation:
(reward 3)

(cond
  [(<= 0 3 10)
   "bronze"]
  [(and (< 10 3) (<= 3 20))
   "silver"]
  [else "gold"])

(cond
  [#true "bronze"]
  [(and (< 10 3) (<= 3 20))
   "silver"]
  [else "gold"])

"bronze"


;; Ex. 50:
;; Enter the definition of reward followed by (reward 18) into the
;; definitions area of DrRacket and use the stepper to find out how
;; DrRacket evaluates applications of the function.

(reward 18)

(cond
  [(<= 0 18 10)
   "bronze"]
  [(and (< 10 18) (<= 18 20))
   "silver"]
  [else "gold"])

(cond
  [#false "bronze"]
  [(and (< 10 18) (<= 18 20))
   "silver"]
  [else "gold"])

(cond
  [(and (< 10 18) (<= 18 20))
   "silver"]
  [else "gold"])

(cond
  [(and #true (<= 18 20))
   "silver"]
  [else "gold"])

(cond
  [(and #true #true)
   "silver"]
  [else "gold"])

(cond
  [#true "silver"]
  [else "gold"])

"silver"

;; Ex. 51:
;; (- 200 (cond [(> y 200) 0] [else y]))
;; Use the stepper to evaluate the expression for y as 100 and 210.

(- 200 (cond [(> 100 200) 0] [else 100]))
(- 200 (cond [#false 0] [else 100]))
(- 200 (cond [else 100]))
(- 200 100)
100

(- 200 (cond [(> 210 200) 0] [else 210]))
(- 200 (cond [#true 0] [else 210]))
(- 200 0)
200


;; reformulation exercise:

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

(define (create-rocket-scene.v6 h)
  (place-image ROCKET 50
   (cond
     [(<= h ROCKET-CENTER-TO-TOP) h]
     [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
   MTSCN))