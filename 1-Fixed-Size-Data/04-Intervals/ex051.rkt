;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 51:
;; Design a big-bang program that simulates a traffic light for
;; a given duration. The program renders the state of a traffic light
;; as a solid circle of the appropriate color, and it changes state
;; on every clock tick.
;; What is the most appropriate initial state? Ask your engineering friends

(require 2htdp/image)
(require 2htdp/universe)

; graphical constants
(define W-WIDTH 100)
(define W-HEIGHT 100)
(define DX (/ W-WIDTH 2))
(define DY (/ W-HEIGHT 2))
(define MT (empty-scene W-WIDTH W-HEIGHT))

;; TraficLight -> Image
;; given state s, return color light
(check-expect (display-light "red") (circle 35 "solid" "red"))

;;(define (display-light s) (square 0 "solid" "white")) ;; Stub
(define (display-light s) (circle 35 "solid" s))


;; TraficLight -> TraficLight
;; start the world with (main "yellow") -- to start red.
;; 
(define (main ws)
  (big-bang ws                   ; TraficLight
            (on-tick   tock 3)   ; TraficLight -> TraficLight (every 3 seconds)
            (to-draw   render)   ; TraficLight -> Image
            ))


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

;; TraficLight -> TraficLight
;; produce the next traffic light state
(check-expect (tock "red") "green")
(check-expect (tock "green") "yellow")
(check-expect (tock "yellow") "red")  

(define (tock tl) 
  (traffic-light-next tl))

;; TraficLight -> Image
;; render the traffic light
(check-expect (render "red") (place-image (display-light "red") DX DY  MT))

(define (render ws) 
  (place-image (display-light ws) DX DY MT))

; test
;(main "yellow")