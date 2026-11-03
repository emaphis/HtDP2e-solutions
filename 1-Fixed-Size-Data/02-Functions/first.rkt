#lang htdp/bsl
;; first interactive program from fig 18 "interactive programs"

(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (main y)
  (big-bang y
            [on-tick sub1]
            [stop-when zero?]
            [to-draw place-dot-at]
            [on-key stop]))

(define (place-dot-at y)
  {place-image DOT 50 y BACKGROUND})

(define (stop y ke)
  0)

;; Try out program
; > (place-dot-at 89)
; > (stop 89 "q")
; > (main 90)
