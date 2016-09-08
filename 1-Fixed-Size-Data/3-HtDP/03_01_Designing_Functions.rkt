;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_01_Designing_Functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 3 How to Design Programs
;; 3.1 Desgining Funtions
;; Exercises: 33

(require 2htdp/image)

;; Ex. 33:
;; Research the “year 2000” problem and what it meant for software developers.

; It was a lot of work becuase programs weren't desinged for the long term
; Also programs weren't designed to be modified so that created more work.


;; 3.1 Designing Functions

;; Simple data types: Number, String, Image, Boolean

;; A data definition:

;; Temperature is a Number.
;; interp. represents degrees Celsius

; 102 is a dTtemperature because it is a number
; "cold" is not a Te
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





