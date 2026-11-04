#lang htdp/bsl
;; Figure 22: The wish list for designing world programs

;(require 2htdp/image)
(require 2htdp/universe)

; WorldState: data representing the current world (cw)
 
; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
(define (render cw) ...)
 
; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
(define (clock-tick-handler cw) ...)
 
; WorldState String -> WorldState 
; for each keystroke, big-bang obtains the next state 
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler cw ke) ...)
 
; WorldState Number Number String -> WorldState 
; for each mouse gesture, big-bang obtains the next state
; from (mouse-event-handler cw x y me) where x and y are
; the coordinates of the event and me is its description 
(define (mouse-event-handler cw x y me) ...)
 
; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw) 
(define (end? cw) ...)
