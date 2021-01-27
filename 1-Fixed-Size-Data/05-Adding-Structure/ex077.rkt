;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex77) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Ex. 77:
;; Provide a structure type definition and a data definition for representing
;; points in time since midnight.
;; A point in time consists of three numbers: hours, minutes, and seconds

(define-struct time-pt [hours minutes seconds])
; time-pt is a (make-time-pt Number Number Number))
; interp: a point in time having hours, minutes, seconds

(define TIME1 (make-time-pt 10 30 00))  ; 10:30:00

#;; template
(define (fn-for-time-pt tm)
  (... (time-pt-hours tm)
       (time-pt-minutes tm)
       (time-pt-seconds tm)))
