;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex039) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 39:
;; Develop your favorite image of an automobile so that WHEEL-RADIUS
;; remains the single point of control.

(require 2htdp/image)

;; Physical Constants;

(define WHEEL-RADIUS 5)  ; single point of controlx
(define WHEEL-OFFSET (* WHEEL-RADIUS 3))

;; Graphical Constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-OFFSET WHEEL-RADIUS "solid" "transparent"))

(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BODY-LENGTH (* WHEEL-RADIUS 10))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))

(define BODY
  (above
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2) "solid" "red")
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))

;; a car!
#;
(define CAR (overlay/align/offset
             "middle" "bottom"
             BOTH-WHEELS
             0 (- 0 WHEEL-RADIUS)
             BODY))

(define CAR
  (overlay/offset BODY
                  0 (* WHEEL-RADIUS 1.5)
                  BOTH-WHEELS))

;; test car
CAR