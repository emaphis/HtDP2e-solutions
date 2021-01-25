;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex056) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 56:
;; Define main2 so that you can launch the rocket and watch it lift off.
;; Read up on the on-tick clause to determine the length of one tick
;; and how to change it.


(require 2htdp/image)
(require 2htdp/universe)

;; Constants

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

;; Data definition

; A LRCD (for launching rocket count down) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in count-down mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

; sample data
(define LRCD0 "resting")
(define LRCD1 -2)  ; counting down
(define LRCD2  0)  ; launch!!!
(define LRCD3 100) ; 100 pixels high

;; Template for LRCD
(define (LRCD-template x)
  (cond
    [(string? x) (... x)]
    [(<= -3 x -1) (... x)]
    [(>= x 0) (... x)]))


;; Function definition

; LRCD -> Image
; renders the state as a resting or flying rocket

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))

(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))


;(define (show x) ; stub
;  SCENE)


;; See exercise 54.


;; combining the examples and the template we can define

(define (show x)
  (cond
    [(string? x)
     (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER)
                               BACKG))]
    [(>= x 0)
     (place-image ROCKET 10 (- x CENTER) BACKG)]))


;; Now work on second function "launch"

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed,
; if the rocket is still resting ignore key presses otherewise

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

#; ;; template
(define (launch x ke)
  (cond
    [(string? x) ...]
    [(<= -3 x -1) ...]
    [(>= x) ...]))


(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)] ; switch state
    [(<= -3 x -1) x]
    [(>= x 0) x]))


;; Figure 29
; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

;(define (fly x) ; stub
;  x)

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))


;; LRCD -> LRCD
;; run with: (main2 "")
(define (main2 s)
  (big-bang s
            [on-tick fly .3]
            [to-draw show]
            [on-key launch]))
