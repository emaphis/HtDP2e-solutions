;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_02_04_03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.4 Intervals, Enumerations, etc.
;; 2.4.3 Enumerations
;; Exercises 42, 43

(require 2htdp/image)
(require 2htdp/universe)

;; Traffic Light simulation

;; =================
;; Constants: 

; graphical constants 
(define W-WIDTH 100)
(define W-HEIGHT 100)
(define DX (/ W-WIDTH 2))
(define DY (/ W-HEIGHT 2))
(define MT (empty-scene W-WIDTH W-HEIGHT)) 

;; =================
;; Data definitions:


; A TrafficLight shows one of three colors:
; – "red"
; – "green"
; – "yellow"
; interp. each element of TrafficLight represents which colored
; bulb is currently turned on



;; =================
;; Functions:


; TrafficLight -> TrafficLight
; given state s, determine the next state of the traffic light
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")  ; ex. 42
(check-expect (traffic-light-next "yellow") "red")    ; ex. 42

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))


;; Exercise 42 -- complete the tests


;; Exercise 43:

;; TraficLight -> Image
;; given state s, return color light
(check-expect (display-light "red") (circle 35 "solid" "red"))

;;(define (display-light s) (square 0 "solid" "white")) ;; Stub
(define (display-light s) (circle 35 "solid" s))


;; TraficLight -> TraficLight
;; start the world with ...
;; 
(define (main ws)
  (big-bang ws                   ; TraficLight
            (on-tick   tock)     ; TraficLight -> TraficLight
            (to-draw   render)   ; TraficLight -> Image
            ))


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


