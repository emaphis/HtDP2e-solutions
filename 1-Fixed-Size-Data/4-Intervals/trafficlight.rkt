;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname trafficlight) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 - Enumerations and Intervals
;; 4.7 Finite State Worlds

;; Ex 61:
;; Finish the design of a world program that simulates the

(require 2htdp/image)
(require 2htdp/universe)

;; constants
(define RAD 10)         ; bulb's redius
(define SPACE (/ RAD 2)) ; the space between bulbs
(define MT (empty-scene (* RAD 10) (* RAD 3)))


;; traffic light FSA.
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


;; functions

; TrafficLight -> TrafficLight
; yields the next state given current state cs

(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")

;(define (tl-next cs) cs) ; stub

(define (tl-next tl)
  (cond [(string=? tl "red") "green"]
        [(string=? tl "yellow") "red"]
        [(string=? tl "green") "yellow"]))


; TrafficLight -> Image
; renderS the current state cs as an image

(check-expect (tl-render "red")
              (overlay
               (beside (circle RAD "solid" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "green"))
               MT))
(check-expect (tl-render "yellow")
              (overlay
               (beside (circle RAD "outline" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "solid" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "green"))
               MT))
(check-expect (tl-render "green")
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
  (beside (bulb cs "red")
          (square SPACE "outline" "white")
          (bulb cs "yellow")
          (square SPACE "outline" "white")
          (bulb cs "green"))
  MT))


; TrafficLight TrafficLight -> Image
; render the c colored bulb of the traffic light,
; when on is the current state
(define (bulb on c)
  (if (string=? on c)
      (circle RAD "solid" c)
      (circle RAD "outline" c)))


; TrafficLight -> TrafficLight
; simulate a clock-based American traffic light
; run: (traffic-light-simulation "red")
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next 1]))