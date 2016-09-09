;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_02_Finger_Exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Functions
;; 3.2 Finger Exercises: Functions
;; Exercises 34-38

(require 2htdp/image)


;; Ex. 34
;; Design the function string-first, which extracts the first character from
;; a non-empty string. Don’t worry about empty strings.

;; String -> !String
;; Given a string extract first charcter
;; given: "h"            expected: "h"
;; given: "hello world"  expected: "h"
;;(define (string-first str) "") ;stub

(define (string-first str)
  (substring str 0 1))

(check-expect (string-first "h") "h")
(check-expect (string-first "hello world") "h")


;; Ex. 35:
;; Design the function string-last, which extracts the last character from a
;; non-empty string. image

;; String -> !String
;; Given a string extract last charater
;; given: "h",           expect: "h"
;; given: "hello world", expect: "o"

;;(define (string-last str) "") ;stub

(define (string-last str)
  (substring str (- (string-length str) 1)))

(check-expect (string-last "h") "h")
(check-expect (string-last "hello world") "d")


;; Ex. 36:
;; Design the function image-area, which counts the number of pixels in a
;; given image.

;; Image -> Number
;; Given an image return area of image in pixils

(define (image-area img)
  (* (image-height img) (image-width img)))

(check-expect (image-area (square 0 "solid" "blue")) 0)  ; degenerate case
(check-expect (image-area (square 10 "solid" "red")) 100)


;; Ex. 37:
;; Design the function string-rest, which produces a string like the given
;; one with the first character removed.

;; String -> String
;; Given a String return all but first 1String
;; given: "h",     expect: ""
;; given: "hello", expect "ello"

(define (string-rest str)
  (substring str 1))

(check-expect (string-rest "h") "")
(check-expect (string-rest "hello world") "ello world")


;; Ex. 38:
;; Design the function string-remove-last, which produces a string like the
;; given one with the last character removed.

;; String -> String
;; Given a string remove last char
;; given "h",     expect: ""
;; given "hello", expect: "hell"

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(check-expect (string-remove-last "h") "")
(check-expect (string-remove-last "hello") "hell")