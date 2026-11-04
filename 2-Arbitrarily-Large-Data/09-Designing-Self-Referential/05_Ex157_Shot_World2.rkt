;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_05_157_shot_world2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.5 Lists and World
;; Exercise: 157
;; Shot World 2

;; Ex. 157:
;; Experiment whether the arbitrary decisions concerning constants are truly
;; easy to change. For example, determine whether changing a single constant
;; definition achieves the desired outcome:

;    change the height of the canvas to 220 pixels;

;    change the width of the canvas to 30 pixels;

;    change the x location of the line of shots to “somewhere to the left of
;    the middle;”

;    change the background to a green rectangle; and

;    change the rendering of shots to a red elongated rectangle.

;; Also check whether it is possible to double the size of the shot without
;; changing anything else or change its color to black.

; Besides a change is appearance none of ths made much of a difference
; all of the tests continued to pass.


(require 2htdp/image)
(require 2htdp/universe)


(define HEIGHT 220) ; distances in terms of pixels
(define WIDTH 30)
(define XSHOTS (- (/ WIDTH 2) 5)) ; somewhere left of middle

; graphical constants
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "green"))
(define SHOT (rectangle 6 12 "solid" "black"))

(define (handle-key c ke)
    (cond [(key=? ke " ") 0]
          [(key=? ke "a") 1]
          [(key=? ke "b") 2]
          [else c]))


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

(define (tock w)
  (cond
    [(empty? w) '()]
    [else
     (cons (sub1 (first w))
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
