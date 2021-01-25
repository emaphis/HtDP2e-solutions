;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex50) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 50.
;; If you copy and paste the above function definition into
;; the definitions area of DrRacket and click RUN, DrRacket
;; highlights two of the three cond lines.
;; This coloring tells you that your test cases do not cover the
;; full conditional. Add enough tests to make DrRacket happy.

;; a function consumming TrafficLight

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")  ; Ex. 50
(check-expect (traffic-light-next "yellow") "red")    ; Ex. 50

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))
