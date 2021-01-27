;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_Programming_with_Structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.6 Programming with Structures
;; Exercises: 72-75

; some data defininitions are obvious:

(define-struct posn1 [x y])
; A Posn1 is a structure:
; (make-posn1 Number Number)
; interpretation. a point x pixels from left, y from top

;; clearly x,y are numbers

(define-struct entry [name phone email])
; An Entry is a structure:
;   (make-entry String String String)
; interpretation. a contact's name, phone#, and email

;; name, phone# and email are obvious strings


;; ball could have many interpretations:

(define-struct ball [location velocity])
; A Ball-1d is a structure:
;   (make-ball Number Number)
; interpretation 1 distance to top and velocity
; interpretation 2 distance to left and velocity


;; ball can be used in other ways:

; A Ball-2d is a structure:
;   (make-ball Posn Vel)
; interpretation a 2-dimensional position and velocity

(define-struct vel [deltax deltay])
; A Vel is a structure:
;   (make-vel Number Number)
; interpretation (make-vel dx dy) means a velocity of
; dx pixels [per tick] along the horizontal and
; dy pixels [per tick] along the vertical direction

;; See exercise 72 - phone number defininions

;; so how do we use data definitions in a program design?

;; Sample Problem:
;; Your team is designing an interactive game program that moves a red dot
;; across a 100 x 100 canvas and allows players to use the mouse to reset the
;; dot.
;; Here is how far you got together;

(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; A Posn represents the state of the world.

#; ; template for Posn
(define (fn-for-posn p)
  (... (posn-x p) ... (posn-y p) ...))


; Posn -> Posn
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

;; Your task is to design scene+dot, the function that adds a red dot to the
;; empty canvas at the specified position.

; Posn -> Image
; adds a red spot to MTS at p

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))

;(define (scene+dot p) MTS) ; stub

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))


;; Sample Problem:
;; A colleague is asked to define x+, a function that consumes a Posn and
;; increases the x-coordinate by 3.

; Posn -> Posn
; increases the x-coordinate of p by 3

(check-expect (x+ (make-posn 10 20))
              (make-posn 13 20))

;(define (x+ p) p) ; stub

(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))

;; see reset-dot below:

;; see exercise 73 - design the function posn-up-x


;; Sample Problem:
;; Another colleague is tasked to design reset-dot, a function that resets
;; the dot when the mouse is clicked.

; Posn Number Number MouseEvt -> Posn
; for mouse clicks, (make-posn x y); otherwise p
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-down")
  (make-posn 29 31))
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-up")
  (make-posn 10 20))

;; interp. only the "button-down" event updates the posn

;(define (reset-dot p x y me) p) ; stub

#; ; template
(define (reset-dot p x y me)
  (cond
    [(mouse=? "button-down" me) (... p ... x y ...)]
    [else (... p ... x y ...)]))

(define (reset-dot p x y me)
  (cond
    [(mouse=? "button-down" me) (make-posn x y)]
    [else p]))

; (main (make-posn 10 30))

;; See exercise 74.


;; programs with nested structures

;; Sample Problem:
;; Your team is designing a game program that keeps track of an object that
;; moves across the canvas at changing speed.
;; The chosen data representation requires two data definitions:

(define-struct ufo [loc vel])
; A UFO is a structure:
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v.

#;; template
; UFO -> ???
(define (fun-for-ufo u)
  (... (posn-x (ufo-loc u)) ...
   ... (posn-y (ufo-loc u)) ...
   ... (vel-deltax (ufo-vel u)) ...
   ... (vel-deltay (ufo-vel u)) ...))

;; It is your task to develop ufo-move-1. The function computes the location
;; of a given UFO after one clock tick passes.

;; some UFO examples:
(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determins where u move in one clock tick;
; leaves the velocity as is

(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))

;(define (ufo-move-1 u) u) ; stub

;; template
;(define (ufo-move-1 u)
;  (... (ufo-loc u) ... (ufo-vel u) ...))

(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

;; If a function deals with nested structures, develop one function per
;; level of nesting.

; Posn Vel -> Posn
; adds v to p
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

;(define (posn+ p v) p) ; stub

#;; template
(define (posn+ p v)
  (... (posn-x p) ... (posn-y p) ...
   ... (vel-deltax v) ... (vel-deltay v) ...))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))


;; See exercise 75  - UFO program.          
;; Ex. 75:
;; Enter these definitions and their test cases into the definitions area of
;; DrRacket and make sure they work. It is the first time that we made a “wish”
;; and you need to make sure you understand how the two functions work together.
;; See ufo1.rkt