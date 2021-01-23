;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex038) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 38:
;; Design the function string-remove-last, which produces a string like the
;; given one with the last character removed.

;; String represents any text.

;; String -> String
;; Given a string remove last char
;; given "h",     expect: ""
;; given "hello", expect: "hell"
;(define (string-remove-last str) "")

;(define (string-remove-last str)
;  (... str ...))

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(string-remove-last "h") ; ""
(string-remove-last "hello") ; "hell"

