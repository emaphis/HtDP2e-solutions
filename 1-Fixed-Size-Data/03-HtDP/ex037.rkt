;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex037) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 37:
;; Design the function string-rest, which produces a string like the given
;; one with the first character removed.

;; String represents any text

;; String -> String
;; Given a String return all but first 1String
;; given: "h",     expect: ""
;; given: "hello", expect "ello"
;(define (string-rest str) "a") ; stub

;(define (string-rest str)
;  (... str ...))
 
(define (string-rest str)
  (substring str 1))

(string-rest "h") ; ""
(string-rest "hello") ; "ello"
