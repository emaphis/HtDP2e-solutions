;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex035) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 35:
;; Design the function string-last, which extracts the last character from a
;; non-empty string.

;; String represents any text

;; String -> !String
;; Given a string extract last charater
;; given: "h",           expect: "h"
;; given: "hello world", expect: "o"
;;(define (string-last str) "") ;stub

;(define (string-last str)
;  (... str ...))

(define (string-last str)
  (substring str (- (string-length str) 1)))

;; testing
(string-last "h") ; "h"
(string-last "hello world") ; "d"
