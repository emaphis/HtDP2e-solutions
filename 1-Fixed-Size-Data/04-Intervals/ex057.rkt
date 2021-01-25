;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex057) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 57:
;; Recall that the word “height” forced us to choose one of two possible
;; interpretation. Now that you have solved the exercises in this section,
;; solve them again using the first interpretation of the word.
;; Compare and contrast the solutions.

(require 2htdp/image)
(require 2htdp/universe)


;; Constants Definitions

(define WIDTH 100) ; pixels
(define HEIGHT 200) ; pixels
(define SCENE (empty-scene WIDTH HEIGHT))

(define ROCKET (bitmap "./images/rocket.png"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))
(define ROCKET-X (/ WIDTH 2))
(define ROCKET-GROUNDED-RL ROCKET-CENTER)
(define ROCKET-VELOCITY 3) ; pixels per clock tick


;; RocketLaunch -> Image
;; Renders the state as a resting or flying rocket image.
(check-expect (show "resting") (draw-rocket ROCKET-GROUNDED-RL))
(check-expect (show -2) (place-image
                         (text "-2" 20 "red")
                         10 (* 3/4 WIDTH)
                         (draw-rocket ROCKET-GROUNDED-RL)))
(check-expect (show 53) (draw-rocket (+ 53 ROCKET-CENTER)))
(check-expect (show HEIGHT) (draw-rocket (+ HEIGHT ROCKET-CENTER)))
(define (show rl)
  (cond
    [(string? rl)
     (draw-rocket ROCKET-GROUNDED-RL)]
    [(<= -3 rl -1)
     (place-image (text (number->string rl) 20 "red")
                  10 (* 3/4 WIDTH)
                  (draw-rocket ROCKET-GROUNDED-RL))]
    [(>= rl 0)
     (draw-rocket (+ rl ROCKET-CENTER))]))



;; RocketLaunch -> Image
;; An auxiliary function that draws a rocket image.
(check-expect (draw-rocket 50) (place-image ROCKET ROCKET-X (- HEIGHT 50) SCENE))
(define (draw-rocket rl)
  (place-image ROCKET ROCKET-X (- HEIGHT rl) SCENE))

;; RocketLaunch KeyEvent -> RocketLaunch
;; Starts  the contdown when the space bar is pressed,
;; if the rocket is still resting.
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") (- HEIGHT 33))
(check-expect (launch 33 "a") (- HEIGHT 33))
(define (launch rl key-event)
  (cond
    [(string? rl) (if (string=? " " key-event) -3 rl)]
    [(<= -3 rl -1) rl]
    [(>= rl 0) (- HEIGHT rl)]))


;; RocketLaunch -> RocketLaunch
;; Raises the rocket by ROCKET-VELOCITY
;; if it is moving  already.
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (+ 10 ROCKET-VELOCITY))
(check-expect (fly 22) (+ 22 ROCKET-VELOCITY))
(define (fly rl)
  (cond
    [(string? rl) rl]
    [(<= -3 rl -1) (if (= rl -1) 0 (+ rl 1))]
    [(>= rl 0) (+ rl ROCKET-VELOCITY)]))


;; RocketLaunch -> RocketLaunch
(define (main rl)
  (big-bang rl
    [to-draw show]
    [on-key launch]
    [on-tick fly 0.2]))


;; test
;(main "resting")
