;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 07_Finite_State_Worlds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 Enumerations, Intervals, Itemizations
;; 4.4 Finite State Worlds
;; Exercises: 59-62

;; Finite state machines


;; Traffic light example

;; Cycles though 3 states red -> green -> yellow -> red

(require 2htdp/image)
(require 2htdp/universe)

;; TrafficLight is on of the following Strings"=:
;;  - "red"
;;  - "green"
;;  - "yellow"
;; interp. one of three Strings represent the three
;; possible states that a traffic light may assume

#;  ;; Template for traffic light
(define (fn-for-tl tl)  ; template
  (cond [(string=? tl "red") (... tl)]
        [(string=? tl "yellow") (... tl)]
        [(string=? tl "green") (... tl)]))


;; traffic-light-next example:


; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs) cs)
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (empty-scene 90 30))


;; See exercise 59 - finish the simulation.

;; See exercise 60 - alternative definition

;; See exercise 61 -  Change the program using constamts



;; Door state example:

;; Sample Problem Design a world program that simulates the working of a
;; door with an automatic door closer. If this kind of door is locked,
;; you can unlock it with a key. An unlocked door is closed but someone
;; pushing at the door opens it. Once the person has passed through the
;; door and lets go, the automatic door takes over and closes the door
;; again. When a door is closed, it can be locked again.

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN

(define LOCKED "locked") 
(define CLOSED "closed")
(define OPEN "open")


;; Function definitions

; DoorState -> DoorState
; closes an open door over the period of one tick 
;(define (door-closer state-of-door) state-of-door)

(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)

#;
(define (door-closer-template state-of-door)
  (cond
    [(string=? LOCKED state-of-door) ...]
    [(string=? CLOSED state-of-door) ...]
    [(string=? OPEN state-of-door) ...]))

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))

;; Second function: door-action

; DoorState KeyEvent -> DoorState
; turns key event k into an action on state s 
;(define (door-action s k)  s)

(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k))
     CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k))
     LOCKED]
    [(and (string=? CLOSED s) (string=? " " k))
     OPEN]
    [else s]))

; DoorState -> Image
; translates the state s into a large text image
(check-expect (door-render CLOSED)
              (text CLOSED 40 "red"))
(define (door-render s)
  (text s 40 "red"))

;; main program
; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer]
    [on-key door-action]
    [to-draw door-render]))

;; Exercise 62
;; see doorstate.rkt
