;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_Enumerations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 Intervals, Enumerations, etc.
;; 4.3 Enumerations
;; Exercises 50,51

;;(require 2htdp/image)
;;(require 2htdp/universe)

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
; interp. each element of TrafficLight represents one of the three
; posible states a traffic ligh may asume.

#; ;template
(define (fun-traffic-light tl)
  (cond
    [(string=? "red"tl) ...]
    [(string=? "green" tl) ...]
    [(string=? "yellow" tl) ...]))


;; a function consumming TrafficLight

; TrafficLight -> TrafficLight
; yields the next s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")  ; Ex. 50
(check-expect (traffic-light-next "yellow") "red")    ; Ex. 50

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))


;; See Ex. 50: complete the tests.
;; See Ex. 51:


;; The main idea of an enumeration is that it defines a collection of data as a finite number of pieces of data.  
;; Enumerations can be specified by an English sentence:

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
#;
(define (handle-key-events w ke)
  (cond
    [(= (string-length ke) 1) ...]  ; regular char's
    [(string=? "left" ke) ...]
    [(string=? "right" ke) ...]
    [(string=? "up" ke) ...]
    [(string=? "down" ke) ...]
    ...))


;;; Figure 25: Conditional functions and special enumerations

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
