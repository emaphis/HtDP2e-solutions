;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_07_Finite_State_Worlds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e  Enumerations, Intervals, Itemizations
;; 4.4 Finite State Worlds
;; Exercises: 61-64

;; Finite state machines


;; Traffic light example

;; Cycles though 3 states red -> green -> yellow -> red

;; TrafficLight is on of
;;  - "red"
;;  - "green"
;;  - "yellow"
;; interp. one of three colors at any given time in order of r-g-y
#;
(define (fn-for-tl tl)  ; template
  (cond [(string=? tl "red") (... tl)]
        [(string=? tl "yellow") (... tl)]
        [(string=? tl "green") (... tl)]))


;; Ex. 61:
;; Finish the design of a world program that simulates the
;; traffic light FSA.
;; see trafficlight.rkt

;; Ex. 62:  see trafficlight2.rkt
;; An alternative data representation for a traffic light program
;; may use numbers instead of strings:
;; Does the tl-next function convey its intention more clearly than
;; the tl-next-numeric function? If so, why? If not, why not?

;; the old version of tl-next is much clearer in it's intetntion
;; the rest of the program didn't change much. I did have to create a
;; function that converts color as numbers to color strings so the
;; representation of colors using strings is much more convenient.


;; Ex. 63:   See trafficlight3.rkt
;; Change the program using constamts

;; Door state example:

;; Sample Problem Design a world program that simulates the working of a
;; door with an automatic door closer. If this kind of door is locked,
;; you can unlock it with a key. An unlocked door is closed but someone
;; pushing at the door opens it. Once the person has passed through the
;; door and lets go, the automatic door takes over and closes the door
;; again. When a door is closed, it can be locked again.

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN


;; Exercise 64
;; see doorstate.rkt
