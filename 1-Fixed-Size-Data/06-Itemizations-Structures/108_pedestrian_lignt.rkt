;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 108_pedestrian_lignt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.2 Mixing up Worlds
;; Exercise: 108

;; Ex. 108:
;; In its default state, a pedestrian crossing light shows an orange person
;; standing on a red background. When it is time to allow pedestrian to cross
;; the street, the light receives a signal and switches to a green, walking
;; person. This phase lasts for 10 seconds. After that the light displays the
;; digits 9, 8, ..., 0 with odd numbers colored orange and even numbers colored
;; green. When the count-down reaches 0, the light switches back to its
;; default state.

;; Design a world program that implements such a pedestrian traffic light.
;; The light switches from its default state when you press the space bar on
;; your keyboard. All other transitions must be reactions to clock ticks.

; crosswalk signal simulation:

(require 2htdp/image)
(require 2htdp/universe)

; graphical constants

(define GREEN-IMG (bitmap "pedestrian_traffic_light_green.png")) ; 68 x 56
(define ORANGE-IMG (bitmap "pedestrian_traffic_light_red.png")) ; 57 x 56

(define SIDE 70) ; size of square scene
(define H-SIDE (/ SIDE 2))

(define TEXT-SIZE 62)

(define MT-GREEN (empty-scene SIDE SIDE "darkgreen"))
(define MT-RED (empty-scene SIDE SIDE "red"))

(define COUNT 9)  ; 10 second count down, 0 counts as a second


;;;;;;;;;;;;;;;;;;;;
;; data definition

;; analysis of  states

; "wait"  - pedestrians wait at cross walk - orange wait signal
; "walk"  - pedestrians can walk 10 seconds - green walk signal
; "count" - pedestrians walk with countdown - count down signal
;           count alternates red on odd nubmers, green on even nubmers

; state swithces :  wait -> walk -> count -> wait



; State is one of
;  - "wait"
;  - "walk"
;  - "count"
; interp. pedestrians wait for "walk" state
;         pedestrians can walk for 20 seconds
;           - "walk"  - 10 seconds
;           - "count" - 10 second count down.


(define-struct ts [state count])
; interp. ts (traffic signal) is a (make-ts State Number)
;          s - State of sigenal "wait", "walk" "count"
;          c - is a Number [0,10] that is a count down till next state
;          only "wait" and "count" have countdowns

(define WAIT1 (make-ts "wait" 0))
(define WALK1 (make-ts "walk" 10)) ; walk for 10 seconds
(define COUNT1 (make-ts "count" 5)) ; walk for 8 more seconds


; TS -> ???
; ; template
(define (fn-for-ts ts)
  (... (... (ts-state ts))    ; State (String)
       (... (ts-count ts))))  ; Number[1,10]



;;;;;;;;;;;;;;;;;;;;;;;
;; funtion definitions

;; on-tock handler

; TS -> TS
; countdown on each tick switching states or counting down

(check-expect (countdown (make-ts "wait" 0)) ; do nothing
              (make-ts "wait" 0))
(check-expect (countdown (make-ts "walk" 5)) ; count down
              (make-ts "walk" 4))
(check-expect (countdown (make-ts "walk" 0)) ; state change
              (make-ts "count" COUNT))
(check-expect (countdown (make-ts "count" 5)) ; count down
              (make-ts "count" 4))
(check-expect (countdown (make-ts "count" 0)) ; state change
              (make-ts "wait" 0))

;(define (countdown ts) (make-ts "wait" 0)) ; stub

(define (countdown ts)
  (cond [(string=? (ts-state ts) "wait")      ; just wait
         ts]
        [(zero? (ts-count ts))                 ; switch
          (switch-state ts)]
        [else                                ; count down
          (make-ts (ts-state ts)
                   (sub1 (ts-count ts)))]))

; TS -> TS
; return a new TS with a new State
; "walk" states are created by keyboard handler
(check-expect (switch-state (make-ts "walk" 0))
              (make-ts "count" COUNT))
(check-expect (switch-state (make-ts "count" 0))
              (make-ts "wait" 0))

;(define (switch-state ts) ts) ; stub

(define (switch-state ts)
  (cond [(string=? (ts-state ts) "walk")
         (make-ts "count" COUNT)]
        [else
         (make-ts "wait" 0)]))


; TS -> TS
; render the various states of the traffic signal

; State 1
(check-expect (render (make-ts "wait" 0))
              (render-sign ORANGE-IMG MT-RED))

; State 2
(check-expect (render (make-ts "walk" 19))
              (render-sign GREEN-IMG MT-GREEN))

; State 3 Odd
(check-expect (render (make-ts "count" 9))
              (render-sign (text "9" TEXT-SIZE "darkorange") MT-GREEN))

; State 3 Even
(check-expect (render (make-ts "count" 8))
              (render-sign (text "8" TEXT-SIZE "green") MT-GREEN));

;(define (render ts) (make-ts "count" 0)) ; stub

(define (render ts)
  (cond [(string=? (ts-state ts) "wait")
         (render-sign ORANGE-IMG MT-RED)]
        [(string=? (ts-state ts) "walk")
         (render-sign GREEN-IMG MT-GREEN)]
        [(string=? (ts-state ts) "count")
         (render-sign (render-num (ts-count ts)) MT-GREEN)]
        [else ts]))


; Image Image -> Image
; render a light given an Images and the back-ground
(check-expect (render-sign GREEN-IMG MT-GREEN)
              (place-image/align GREEN-IMG
                                 H-SIDE H-SIDE "center" "center"
                                 MT-GREEN))

;(define (render-sign img bg) (empty-scene 0 0 "white")) ; stub

(define (render-sign img bg)
  (place-image/align img
                     H-SIDE H-SIDE "center" "center"
                     bg))

; Number -> Images
; render the Numbers as an Image, green text on even, orange text on odd
(check-expect (render-num 9) (text "9" TEXT-SIZE "darkorange"))
(check-expect (render-num 8) (text "8" TEXT-SIZE "green"))

(define (render-num n)
  (cond [(odd? n)
         (text (number->string n) TEXT-SIZE "darkorange")]
        [(even? n)
         (text (number->string n) TEXT-SIZE "green")]))


;;;;;;;;;;;;;;;;;;;;;;
;; event handlers

; TS KeyEvent -> TS
; handle the space key to start the simulation

(check-expect (start (make-ts "walk" 15) "a")  (make-ts "walk" 15))
(check-expect (start (make-ts "wait" 0) " ") (make-ts "walk" COUNT))

;(define (start cl ke) cl) ; stub

(define (start  cl ke)
  (cond [(key=? ke " ") (make-ts "walk" COUNT)]
        [else cl]))

;;;;;;;;;;;;;;;;;;;;;
;; the main program

;; TS -> TS
;; start the world with: (main (make-ts "wait" 0)
;;
(define (main cl)
  (big-bang cl                       ; TS
            [on-tick countdown .7]   ; TS -> TS
            [to-draw render]         ; TS -> Image
            [on-key  start]          ; TS KeyEvent -> TS
            ))
