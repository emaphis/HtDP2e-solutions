;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 07_Predicates_Know_Thy_Data) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1.7  Predicates: Know Thy Data

;; string-length: expects a string, given 42
;;(* (+ (string-length 42) 1) pi)

(number? 4) ; #true
(number? pi) ; #true
(number? #true) ; #false
(number? "fortytwo") ; #false

(define in 42)

(if (string? in)
    (string-length in)
    0)

;; Type predicates:
;; number?
;; string? image? boolean?
;; interger? rational? real? complex?
;; exact? Inexact?

;; See exercises 9, 10