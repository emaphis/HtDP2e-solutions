;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_05_equality_predicates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.5 Equality Predicates
;; Exercise: 115


;; An equality predicate is a function that compares two elements of the same
;; collection of data.

#|
; TrafficLight TrafficLight -> Boolean
; are the two (states of) traffic lights equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)

; origina incorrect versionn

(define (light=? a-value another-value)
  (string=? a-value another-value))
|#

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given: some other value")

; Any Any -> Boolean
; are the two values elements of TrafficLight and,
; if so, are they equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)

(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error MESSAGE)))


;;;;;;;;;;;;;;;;;;;
;; Ex. 115:
;; Revise light=? so that the error message specifies which of the two
;; arguments aren’t elements of TrafficLight.

(define MESSAGE-1
  "traffic light expected for parameter 1, given: some other value")

(define MESSAGE-2
  "traffic light expected for parameter 2, given: some other value")

; Any Any -> Boolean
; are the two values elements of TrafficLight and,
; if so, are they equal

(check-expect (light=?-2 "red" "red") #true)
(check-expect (light=?-2 "red" "green") #false)
(check-expect (light=?-2 "green" "green") #true)
(check-expect (light=?-2 "yellow" "yellow") #true)

(define (light=?-2 a-value another-value)
  (if (light? a-value)
      (if (light? another-value)
          (string=? a-value another-value)
          (error MESSAGE-2))
      (error MESSAGE-1)))

