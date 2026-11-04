;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_05_158_shot_world3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.5 Lists and World
;; Exercise: 158
;; Shot World 3

;; Ex. 158:
;; If you run main, press the space bar (fire a shot), and wait for a good
;; amount of time, the shot disappears from the canvas. When you shut down the
;; world canvas, however, the result is a world that still contains this
;; invisible shot.

;; Design an alternative tock function, which not just moves shots one pixel
;; per clock tick but also eliminates those whose coordinates places them above
;; the canvas.
;; Hint You may wish to consider the design of an auxiliary function for the
;; srecursive cond clause.


;; Sample Problem
;; Design a world program that simulates firing shots. Every time the “player”
;; hits the space bar, the program adds a shot to the bottom of the canvas.
;; These shots rise vertically at the rate of one pixel per tick.

(require 2htdp/image)
(require 2htdp/universe)


(define HEIGHT 80) ; distances in terms of pixels
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))

; graphical constants
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))


;; data definitions

; A Shot is a Number.
; interpretation represents the shot's y-coordinate


; A List-of-shots is one of:
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired

(define LOS1 '())  ; no shots, base case
(define LOS2 (cons 50 '()))
(define LOS3 (cons 80 (cons 60 (cons 50 '()))))


; A ShotWorld is List-of-numbers.
; interpretation each number on such a list
;   represents the y-coordinate of a shot


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function defininitons

; ShotWorld -> ShotWorld
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

; ShotWorld -> Image
; adds the image of a shot for each  y on w
; at (MID,y} to the background image
(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 50 '()))
              (place-image SHOT XSHOTS 50 BACKGROUND))
(check-expect (to-image (cons 50 (cons 30 '())))
              (place-image SHOT XSHOTS 50
                           (place-image SHOT XSHOTS 30 BACKGROUND)))

;(define (to-image w) BACKGROUND)
; ShotWorld -> Image
(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 50 (cons 40 '())))
              (place-image SHOT XSHOTS 50
                           (place-image SHOT XSHOTS 40
                                        BACKGROUND)))

(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else
     (place-image SHOT XSHOTS (first w)
                  (to-image (rest w)))]))

; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
(check-expect (tock '()) '())
(check-expect (tock (cons 50 (cons 40 '())))
              (cons 49 (cons 39 '())))
(check-expect (tock (cons 50 (cons 40 (cons -1 '()))))
              (cons 49 (cons 39 '())))

(define (tock w)
  (cond
    [(empty? w) '()]
    [else
     (if (positive? (first w))
         (cons (sub1 (first w))
           (tock (rest w)))
         (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld
; adds a shot to the world
; if the player pressed the space bar
(check-expect (keyh '() " ")
              (cons HEIGHT '()))

(check-expect (keyh (cons 10 '()) " ")
              (cons HEIGHT (cons 10 '())))

(check-expect (keyh (cons 10 '()) "a")
              (cons 10 '()))

(define (keyh w ke)
  (if (key=? ke " ")
      (cons HEIGHT w)
      w))

