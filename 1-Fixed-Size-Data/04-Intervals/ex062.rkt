;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex062) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 Enumerations and Intervals
;; 4.7 Finite State Machines
;; Ex 62.


;; During a door simulation the “open” state is barely visible. Modify
;; door-simulation so that the clock ticks once every three seconds.
;; Re-run the simulation. 

;; door state example  (state machine)

(require 2htdp/image)
(require 2htdp/universe)

;;; data

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

;; KeyEvent  ; key presses
(define UNLOCK "u")
(define LOCK "l")
(define PUSH " ") ; space bar


#;
(define (fun-for-ds state-of-door)  ; template
  (cond
    [(string=? LOCKED state-of-door) ...]
    [(string=? CLOSED state-of-door) ...]
    [(string=? OPEN state-of-door) ...]))



;; functions

; DoorState -> DoorState
; closes an open door over the period of one tick
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
;(define (door-closer state-of-door) state-of-door) ;stub

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))


; DoorState KeyEvent -> DoorState
; three key events simulate actions on the door

(check-expect (door-actions LOCKED "u") CLOSED)
(check-expect (door-actions CLOSED "l") LOCKED)
(check-expect (door-actions CLOSED " ") OPEN)
(check-expect (door-actions OPEN "a") OPEN)
(check-expect (door-actions CLOSED "a") CLOSED)

;(define (door-actions ds ke) ds) ;stub

(define (door-actions s k)
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


;; DoorState -> DoorState
;; simulate a door with an automatic door closer
;; run with: (door-simulation CLOSED)
(define (door-simulation initial-state)
  (big-bang initial-state
          [on-tick door-closer 3]  ;; Ex. 64
          [on-key door-actions]
          [to-draw door-render]))
