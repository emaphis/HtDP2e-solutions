;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname reddot1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.6 Programming with Structures
;; Exercise: 74

;; Ex. 74:
;; Copy all relevant constant and function definitions to DrRacket’s definition
;; area. Add the tests and make sure they pass.
;; Then run the program and use the mouse to place the red dot.


(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; A Posn represents the state of the world.

#; ; template for Posn
(define (fn-for-posn p)
  (... (posn-x p) ... (posn-y p) ...))


; Posn -> Posn
; run: (main (make-posn 20 10)

(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))


; Posn -> Image
; adds a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
;(define (scene+dot p) MTS) ; stub

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))


; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 20))
              (make-posn 13 20))
;(define (x+ p) p) ; stub

(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


; Posn Number Number MouseEvt -> Posn
; for mouse clicks, (make-posn x y); otherwise p
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-down")
  (make-posn 29 31))
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-up")
  (make-posn 10 20))
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

