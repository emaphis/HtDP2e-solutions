;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname trafficlight2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 - Enumerations and Intervals
;; 4.7 Finite State Worlds

;; Ex 62:
;; An alternative data representation for a traffic light
;; program may use numbers instead of strings:

(require 2htdp/image)
(require 2htdp/universe)

;; constants
(define RAD 10)         ; bulb's redius
(define SPACE (/ RAD 2)) ; the space between bulbs
(define MT (empty-scene (* RAD 10) (* RAD 3)))


;; data:

; A N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow
; 0 -> 1 -> 2 -> 0   R=0 G=1 Y=2

#;
(define (fn-for-tl tl)  ; template
  (cond [(= tl 0) (... tl)]
        [(= tl 1) (... tl)]
        [(= tl 2) (... tl)]))


;; functions

; TrafficLight -> TrafficLight
; yields the next state given current state cs
; 0 -> 1 -> 2 -> 0   R=0 G=1 Y=2

(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

;(define (tl-next cs) cs) ; stub

(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

#; ; the old version
(define (tl-next cs)
  (cond [(string=? cs "red") "green"]
        [(string=? cs "yellow") "red"]
        [(string=? cs "green") "yellow"]))

;; the old version of tl-next is much clearer in it's intetntion
;; the rest of the program didn't change much. I did have to create a
;; function that converts color as numbers to color strings so the
;; representation of colors using strings is much more convenient.


; TrafficLight -> Image
; renderS the current state cs as an image

(check-expect (tl-render 0)
              (overlay
               (beside (circle RAD "solid" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "green"))
               MT))
(check-expect (tl-render 2)
              (overlay
               (beside (circle RAD "outline" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "solid" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "green"))
               MT))
(check-expect (tl-render 1)
              (overlay
               (beside (circle RAD "outline" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "solid" "green"))
               MT))

;(define (tl-render cs)  ; stub
;  (empty-scene 90 30))

(define (tl-render cs)
 (overlay
  (beside (bulb cs 0)
          (square SPACE "outline" "white")
          (bulb cs 2)
          (square SPACE "outline" "white")
          (bulb cs 1))
  MT))


; TrafficLight -> String
; Converts a TrafficLight into a String representing a Color
(check-expect (conv 0) "red")
(check-expect (conv 1) "green")
(check-expect (conv 2) "yellow")

(define (conv tl)
  (cond [(equal? tl 0) "red"]
        [(equal? tl 1) "green"]
        [(equal? tl 2) "yellow"]))


; TrafficLight -> Image
; render the c colored bulb of the traffic light,
; when on is the current state
(define (bulb on c)
  (if (= on c)
      (circle RAD "solid" (conv c))
      (circle RAD "outline" (conv c))))


; TrafficLight -> TrafficLight
; simulate a clock-based American traffic light
; run: (traffic-light-simulation 0)
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next-numeric 1]))
