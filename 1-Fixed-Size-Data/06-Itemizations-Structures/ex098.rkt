;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex098) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 98:
;; Design the function si-game-over? for use as the stop-when handler.
;; The game stops if the UFO lands or if the missile hits the UFO.
;; For both conditions, we recommend that you check for proximity of one object
;; to another.

;; The stop-when clause allows for an optional second sub-expression, namely a
;; function that renders the final state of the game. Design si-render-final
;; and use it as the second part for your stop-when clause in the main function
;; of exercise 100

; NOTE:
; make-aim is relevan when UFO is landed, landed is always #true
; make-fired is relevant when UFO is landed or Missile hits UFO
; Tank x-pos does not matter

; SIGS -> Boolean
; returns #true if the UFO has landed or if the Missile is in
; proximity of the UFO

(require 2htdp/image)
(require 2htdp/universe)

;;; Physical constants

(define WIDTH 200)
(define HEIGHT 200)
(define SCENE (empty-scene WIDTH HEIGHT "skyblue"))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO (overlay  (circle (/ UFO-HEIGHT 2) "solid" "purple")
             (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "blue")))

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "olive"))

(define MISSILE-WIDTH 1)
(define MISSILE-HEIGHT 15)
(define MISSILE
  (rectangle MISSILE-WIDTH MISSILE-HEIGHT "solid" "red"))

;;; data definitions

(define-struct aim [ufo tank])

(define-struct fired [ufo tank missile])

(define-struct tank [loc vel])

;;; Function definitions

(check-expect (si-game-over?    ; not landed, no missle
               (make-aim (make-posn 20 100)
                         (make-tank 10 3)))
              #false)

(check-expect (si-game-over?   ; landed, no missle
               (make-aim (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                         (make-tank 10 3)))
              #true)

(check-expect (si-game-over?   ; landed, no hit
               (make-fired (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                           (make-tank 10 3) (make-posn 10 10)))
              #true)

(check-expect (si-game-over?   ; not landed, no hit
               (make-fired (make-posn 20 100)
                           (make-tank 10 3) (make-posn 10 10)))
              #false)

(check-expect (si-game-over?   ; not landed, hit!
               (make-fired (make-posn 20 100)
                           (make-tank 10 3) (make-posn 20 100)))
              #true)


;(define (si-game=over? s) #false) ;stub

(define (si-game-over? s)
  (cond [(aim? s)
         (ufo-landed? (aim-ufo s))]
        [(fired? s)
         (or
          (ufo-landed? (fired-ufo s))
          (ufo-hit? (fired-ufo s)
                    (fired-missile s)))]))

; UFO -> Boolean
; #true if the UFO has landed -- you loose
(check-expect (ufo-landed?    ; not landed
               (make-posn 20 100))
              #false)
(check-expect (ufo-landed?   ; landed
               (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2))))
              #true)

;(define (ufo-landed? u) #false) ;stub

(define (ufo-landed? u)
  (>= (posn-y u) (- HEIGHT (/ UFO-HEIGHT 2))))

; UFO  Missile -> Boolean
; #true if the UFO was hit by the Missle -- you win
(check-expect (ufo-hit?   ; landed, no hit
               (make-posn 20 (- HEIGHT UFO-HEIGHT))
               (make-posn 10 10))
              #false)

(check-expect (ufo-hit?   ; not landed, no hit
               (make-posn 20 100)
               (make-posn 10 10))
              #false)

(check-expect (ufo-hit?   ; not landed, hit!
               (make-posn 20 100)
               (make-posn 20 100))
              #true)

;(define (ufo-hit? u m) #false) ;stub

(define (ufo-hit? u m)
  (and (<= (abs (- (posn-x u) (posn-x m)))
           (+ (/ UFO-WIDTH 2) (/ MISSILE-WIDTH 2)))
       (<= (abs (- (posn-y u) (posn-y m)))
           (+ (/ UFO-HEIGHT 2) (/ MISSILE-HEIGHT 2)))))
