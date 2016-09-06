;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_05_Itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e  Enumerations, Intervals, Itemizations
;; 4.5 Itemizations
;; Exercises: 55-58

(require 2htdp/image)
(require 2htdp/universe)

; String -> NorF
; converts the given string into a number;
; produces #false if impossible
(define (string->number1 s) (... s ...))

; A NorF is one of:
; – #false
; – a Number


; NorF -> Number
; add 3 to the given number; 3 otherwise

(check-expect (add3 #false) 3)
(check-expect (add3 0.12) 3.12)

(define (add3 x)
  (cond
    [(false? x) 3]
    [else (+ x 3)]))

;; String -> Number
;; converts a String to a Number adds 3 to it
;; if the String is an invalid number return 3

(check-expect (add3-to-str "1") 4)
(check-expect (add3-to-str "10") 13)
(check-expect (add3-to-str "one") 3)

;(define (add3-to-str str) 3) ;stub

(define (add3-to-str str)
  (add3 (string->number str)))


;; Sample problem - rocket launch
;; See rocketlaunch.rkt

;; Ex. 55:
;; In some way it is best to draw some world scenarios and to represent
;; them with data and, conversely, to pick some data examples and to
;; draw pictures that match them. Do so for the LR definition, including
;; at least HEIGHT and 0 as examples.

; physical constants
(define HEIGHT 300)
(define WIDTH  100)
(define YDELTA 3)

; graphical constants
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red")) ; use your favorite image

;(define CENTER (- HEIGHT (/ (image-height ROCKET) 2)))
(define CENTER (/ (image-height ROCKET) 2))

;; A LR (short for: launching rocket) is one of:
;; – "resting"
;; – non-negative number
;; interp. "resting is a rocket on the ground
;; the number denotes the height of a rocket in flight

;; sample data FOR LR
(define LR1 "resting")
(define LR2 0)                         ; landed
(define LR3 (/ HEIGHT 2))              ; half way up.
(define LR4 (- HEIGHT                  ; touching top of screen
               (image-height ROCKET)))
(define LR5 HEIGHT)                    ; just off screenR

;; transform rocket height to screen pixels
(define (trans n)  (- CENTER n))

;; some mock-up images
(place-image ROCKET 50 (trans LR2) BACKG)  ; landed
(place-image ROCKET 50 (trans 75) BACKG)   ; 75 units high
(place-image ROCKET 50 (trans LR3) BACKG)  ; almost half way
(place-image ROCKET 50 (trans LR4) BACKG)  ; almost all the way
(place-image ROCKET 50 (trans LR5) BACKG)  ; all the way up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rocket Launch with countdown using Itemizations

;; Constants defined above

;; Data definition

; A LRCD (for launching rocket count down) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in count-down mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

(define LRCD0 "resting")
(define LRCD1 -2)  ; counting down
(define LRCD2  0)  ; launch!!!
(define LRCD3 100) ; 100 pixels high

;; Template:
(define (LRCD-temple x)
  (cond
    [(string? x) (... x)]
    [(<= -3 x -1) (... x)]
    [(>= x 0) (... x)]))


;; Function definition

; LRCD -> Image
; renders the state as a resting or flying rocket

(check-expect (show "resting")
              (place-image ROCKET
                           10 (- HEIGHT CENTER)
                           BACKG))

(check-expect (show -2)
              (place-image (text "-2" 20 "red")
                           10 (* 3/4 WIDTH)
                           (place-image ROCKET
                                        10 (- HEIGHT CENTER)
                                        BACKG)))

(check-expect (show HEIGHT)
              (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect (show 53)
              (place-image ROCKET 10 (- 53 CENTER) BACKG))

(check-expect (show 0)
              (place-image ROCKET 10 (- 0 CENTER) BACKG))

;(define (show x) ; stub
;  BACKG)

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


;; Ex. 56:
;; Why is (string=? "resting" x) incorrect as the first condition in
;; show? Conversely, formulate a completely accurate condition, that is,
;; a Boolean expression that evaluates to #true precisely when x belongs
;; to the first sub-class of LRCD.

;; (string=? "resting" x) is inaccurate because any string can be
;; concidered a resting state.
;; a better test   (and (string? x) (string=? "resting" x)


;; Ex. 57:
;; Integer -> Image
;; render the rocket image at a given height
(check-expect (render-rocket 10)
              (place-image ROCKET 10 (- 10 CENTER) BACKG))

(define (render-rocket x)
  (place-image ROCKET 10 (- x CENTER) BACKG))

(define (show-2 x)
  (cond
    [(string? x)
     (render-rocket HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (render-rocket HEIGHT))]
    [(>= x 0)
     (render-rocket x)]))

;; See rocketlaunch.rkt


;; Now work on "launch"

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed,
; if the rocket is still resting ignore key presses otherewise

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

;(define (launch x ke)  ; stub
;  x)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)] ; switch state
    [(<= -3 x -1) x]
    [(>= x 0) x]))


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


; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))


;; Ex. 58:
;; Define main2 so that you can launch the rocket and watch it lift off.
;; Read up on the on-tick clause to determine the length of one tick
;; and how to change it.

;; LRCD -> LRCD
;; run with: (main2 "")
(define (main2 s)
  (big-bang s
            [on-tick fly .3]
            [to-draw show]
            on-key launch)))
;; See rocketlaunch.rkt
