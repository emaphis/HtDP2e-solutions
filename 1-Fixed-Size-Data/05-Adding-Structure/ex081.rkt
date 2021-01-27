;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex081) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 81:
;; Design the function time->seconds, which consumes instances of time
;; structures and produces the number of seconds that have passed since
;; midnight.
;; For example, if you are representing 12 hours, 30 minutes, and 2 seconds
;; with one of these structures and if you then apply time->seconds to this
;; instance, the correct result is 45002.

(define-struct time [hours minutes seconds])
; timet is a (make-time Number Number Number))
; interp: a point in time having hours, minutes, seconds

(define TIME1 (make-time 10 30 00))  ; 10:30

#;; Time -> ???
(define (fn-for-time t)
  (... (... (time-hours t))
       (... (time-minutes t))
       (... (time-seconds t))))


; Time -> Number
; convert a given time to seconds
(check-expect (time->seconds (make-time 0 0 0)) 0)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(check-expect (time->seconds TIME1) 37800)

;(define (time->seconds t) 0) ; stub

(define (time->seconds t)
  (+ (* 3600 (time-hours t))
     (* 60 (time-minutes t))
     (time-seconds t)))
