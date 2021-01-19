;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex032) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 32:

;; Ten different events varius interactive programs will have to deal with:
;; Eye movements, skin temperature, heart rate, screan touches, car speeds, car postions,
;; incomming messages.

(require 2htdp/image)
(require 2htdp/universe)


;; first basic definitions:
(define (number->square s)
  (square s "solid" "red"))

; >(number->square 5)

; > (big-bang 100 [to-draw number->square])

#;
(big-bang 100
          [to-draw number->square]
          [on-tick sub1]
          [stop-when zero?])


;; a function that consumes the current state and a string that describes
;; the key event and then returns a new state:
(define (reset s ke)
  100)

#;  ; now handle keypresses
(big-bang 100
    [to-draw number->square]
    [on-tick sub1]
    [stop-when zero?]
    [on-key reset])

;; See "first.rkt" for first interactive program from figure 18: