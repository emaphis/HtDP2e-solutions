;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname trafficlight3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; HtDP 2e - 4 Enumerations and Intervals
;; 4.7 Finite State Worlds

;; Ex 61:
;; programs must define constants and use names instead of actual constants.
;; In this spirit, a data definition for traffic lights introduces must use
;; constants, too:

(require 2htdp/image)
(require 2htdp/universe)

;; constants
(define RAD 10)         ; bulb's redius
(define SPACE (/ RAD 2)) ; the space between bulbs
(define MT (empty-scene (* RAD 10) (* RAD 3)))


;; data:

(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; A S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

#;
(define (fn-for-tl tl)  ; template
  (cond [(equal? tl RED) (... tl)]
        [(equal? tl GREEN) (... tl)]
        [(equal? tl YELLOW) (... tl)]))


;; functions

; S-TrafficLight -> S-TrafficLight
; yields the next state given current state cs
; 0 -> 1 -> 2 -> 0   R=0 G=1 Y=2

(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)

(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

#;
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

#; ; the old version
(define (tl-next cs)
  (cond [(string=? cs "red") "green"]
        [(string=? cs "yellow") "red"]
        [(string=? cs "green") "yellow"]))



; S-TrafficLight -> Image
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

(define (tl-render cs)
 (overlay
  (beside (bulb cs 0)
          (square SPACE "outline" "white")
          (bulb cs 2)
          (square SPACE "outline" "white")
          (bulb cs 1))
  MT))


; S-TrafficLight -> String
; Converts a TrafficLight into a String representing a Color
(check-expect (conv RED) "red")
(check-expect (conv GREEN) "green")
(check-expect (conv YELLOW) "yellow")

(define (conv tl)
  (cond [(equal? tl RED) "red"]
        [(equal? tl GREEN) "green"]
        [(equal? tl YELLOW) "yellow"]))


; S-TrafficLight -> Image
; render the c colored bulb of the traffic light,
; when on is the current state
(define (bulb on c)
  (if (equal? on c)
      (circle RAD "solid" (conv c))
      (circle RAD "outline" (conv c))))


; S-TrafficLight -> TrafficLight
; simulate a clock-based American traffic light
; run: (traffic-light-simulation RED)
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next-symbolic 1]))
