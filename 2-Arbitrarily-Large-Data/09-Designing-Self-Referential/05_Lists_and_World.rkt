;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_05_lists_and_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.5 Lists and World
;; Exercises: 156-159

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


; A List-of-shots is one of:
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired

; A Shot is a Number.
; interpretation represents the shot's y-coordinate

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
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 50 (cons 9 '())))
              (place-image SHOT XSHOTS 50
                           (place-image SHOT XSHOTS 9 BACKGROUND)))

;(define (to-image w) BACKGROUND)
; ShotWorld -> Image
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else
     (place-image SHOT XSHOTS (first w)
                  (to-image (rest w)))]))

; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
(define (tock w)
  (cond
    [(empty? w) '()]
    [else
     (cons (sub1 (first w))
           (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld
; adds a shot to the world
; if the player pressed the space bar
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))


;; Ex. 156:
;; Equip the program in figure 57 with tests and make sure it passes those.
;; Explain what main does. Then run the program via main
;; See: 09_05_156_shot_world1.rkt

;; Ex. 157:
;; See 09_05_157_shot_world2.rkt

;; eX. 158:
;; See: 09_05_158_shot_world3.rkt

;; Ex. 159:
;; See 09_05_159_lecture_hall2.rkt

