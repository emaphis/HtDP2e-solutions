;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_03_Enumerations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 Intervals, Enumerations, etc.
;; 4.3 Enumerations
;; Exercises 50,51

(require 2htdp/image)
(require 2htdp/universe)

; A MouseEvt is one of these Strings:
; – "button-down"
; – "button-up"
; – "drag"
; – "move"
; – "enter"
; – "leave"


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; A traffic light sample

; A TrafficLight shows one of three Strings:
; – "red"
; – "green"
; – "yellow"
; interp. each element of TrafficLight represents which colored
; bulb is currently turned on

#; ;template
(define (fun-traffic-light tl)
  (cond
    [(string=? "red"tl) ...]
    [(string=? "green" tl) ...]
    [(string=? "yellow" tl) ...))


;; a function consumming TrafficLight

; TrafficLight -> TrafficLight
; given state s, determine the next state of the traffic light
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")  ; Ex. 50
(check-expect (traffic-light-next "yellow") "red")    ; Ex. 50

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))


;; Ex. 50: complete the tests -- see above.


;; Ex. 51:
;; Design a big-bang program that simulates a traffic light for
;; a given duration. The program renders the state of a traffic light
;; as a solid circle of the appropriate color, and it changes state
;; on every clock tick.
;; What is the most appropriate initial state? Ask your engineering friends


; graphical constants
(define W-WIDTH 100)
(define W-HEIGHT 100)
(define DX (/ W-WIDTH 2))
(define DY (/ W-HEIGHT 2))
(define MT (empty-scene W-WIDTH W-HEIGHT))


;; TraficLight -> Image
;; given state s, return color light
(check-expect (display-light "red") (circle 35 "solid" "red"))

;;(define (display-light s) (square 0 "solid" "white")) ;; Stub
(define (display-light s) (circle 35 "solid" s))


;; TraficLight -> TraficLight
;; start the world with (main "yellow") -- to start red.
;; 
(define (main ws)
  (big-bang ws                   ; TraficLight
            (on-tick   tock 3)   ; TraficLight -> TraficLight (every 3 seconds)
            (to-draw   render)   ; TraficLight -> Image
            ))


;; TraficLight -> TraficLight
;; produce the next traffic light state
(check-expect (tock "red") "green")
(check-expect (tock "green") "yellow")
(check-expect (tock "yellow") "red")  

(define (tock tl) 
  (traffic-light-next tl))


;; TraficLight -> Image
;; render the traffic light
(check-expect (render "red") (place-image (display-light "red") DX DY  MT))

(define (render ws) 
  (place-image (display-light ws) DX DY MT))



;;; Enumerations can be specified by an English sentence:

; A 1String is a String of length 1,
; including
; – "\\" (the backslash),
; – " " (the space bar),
; – "\t" (tab),
; – "\r" (return), and
; – "\b" (backspace).
; interpretation represents keys on the keyboard

;; You know that such a data definition is proper if you can describe all of
;; its elements with a BSL test.

;; (= (string-length s) 1)

;; Can use a definition in another definition:
; A KeyEvent is one of:
; – 1String
; – "left"
; – "right"
; – "up"
; – "down"
; – ...

;; a key-event template
; WorldState KeyEvent -> ...
(define (handle-key-events w ke)
  (cond
    [(= (string-length ke) 1) ...]  ; regular char's
    [(string=? "left" ke) ...]
    [(string=? "right" ke) ...]
    [(string=? "up" ke) ...]
    [(string=? "down" ke) ...]
    ...))


;;; Figure 20: Conditional functions and special enumerations

;; Sample Problem: Design a key-event handler that moves a red dot left or
;; right on a horizontal line in response to pressing the left and right
;; arrow keys.

; A Position is a Number.
; interpretation distance between the left margin and the ball

; Position KeyEvent -> Position
; computes the next location of the ball

(check-expect (keh 13 "left") 8)
(check-expect (keh 13 "right") 18)
(check-expect (keh 13 "a") 13)

(define (keh p k)
  (cond
    [(= (string-length k) 1)
     p]
    [(string=? "left" k)
     (- p 5)]
    [(string=? "right" k)
     (+ p 5)]
    [else p]))
