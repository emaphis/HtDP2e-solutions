;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_02_03_01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.3 How to Design Programs

;; Exercises 26-31
(require 2htdp/image)

;; Exercise 26. Uhmm, It meant a lot of work.


;; 2.3.1 Designing Functions

;; Simple data types: Number, String, Image, Boolean

;; Temperature is a Number.
;; interp. degrees Celsius

;; Number -> Number
;; produce temperature in Celsius given a temparature in Fahrenheit
(define (f2c f)
  (* 5/9 (- f 32)))


; Number String Image -> Image 
; add s to img, y pixels from top, 10 pixels to the left
(check-expect (add-image 5 "hello" (empty-scene 100 100))
              (place-image (text "hello" 10 "red") 10 5 (empty-scene 100 100)))

;(define (add-image y s img) ;stub
;  (empty-scene 100 100))

(define (add-image y s img) 
  (place-image (text s 10 "red") 10 y img)) 


; Number -> Number
; compute the area of a square whose side is len 
(check-expect (area-of-square 2) 4); given: 2, expect: 4
(check-expect (area-of-square 7) 49); given: 7, expect: 49
;(define (area-of-square len) 0) ;stub

;(define (area-of-square len)    ;template
;  (... len ...)) 

(define (area-of-square len)
  (sqr len))

;; 2.3.2 Finger Exercises

;; Exercise 27
;; String -> String
;; Given a string extract first charcter
(check-expect (string-first "hello") "h")

;;(define (string-first str) "") ;stub

(define (string-first str)
  (substring str 0 1))


;; Exercise 28
;; String -> String
;; Given a string extract last charater
;; given: "hello", expect: "o"
(check-expect (string-last "hello") "o")
;;(define (string-last str) "") ;stub

(define (string-last str)
  (substring str (- (string-length str) 1)))


;; Exercise 29
;; Image -> Number
;; Given an image return area of image
(check-expect (image-area (square 10 "solid" "red")) 100)

(define (image-area img)
  (* (image-height img) (image-width img)))


;; Exercise 30
;; String -> String
;; Given a string return all but first char
;; given: "hello", expect "ello"
(check-expect (string-rest "hello world") "ello world")

(define (string-rest str)
  (substring str 1))


;; Exercise 31
;; String -> String
;; Given a string remove last char
;; given "hello", expect: "hell"
(check-expect (string-remove-last "hello") "hell")

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))




