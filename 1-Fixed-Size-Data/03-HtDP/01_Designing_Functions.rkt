;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01_Designing_Functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 3 How to Design Programs
;; 3.1 Desgining Funtions
;; Exercises: 33

;; See ex033.txt for exercise 33.

(require 2htdp/image)

;; 3.1 Designing Functions

;; First we must specify the data
;; Simple data types: Number, String, Image, Boolean
;; Information is different than data
;; You represent Information as Data
;; You interpret Data as Information

;; the Number 42 can mean anything including a Tenperature

;; A data definition:

;; Temperature is a Number.
;; interp. represents degrees Celsius

; 102 is a Ttemperature because it is a number
; "cold" is not a Temperature but an interpretation


;; Number -> Number
;; produce temperature in Celsius given a temparature in Fahrenheit
(define (f2c f)
  (* 5/9 (- f 32)))



;; The Design Process

;;; 1. Express how you wish to represent information as data.

;; We use numbers to represent centimeters.

;;; 2. Write down a signature, a statement of purpost and a function header.

;; a. function signature

;; String -> Number

;; Temperature -> String

;; b. A purpose statement
;; what does the function compute


;; c. A header

(define (f a-string) 0)
(define (g n) "a")
(define (h num str img) (empty-scene 100 100))

;; an example:

;; Number String Image -> Image 
;; add s to img,
;; y pixels from top, 10 pixels to the left
(define (add-image y s img) 
  (place-image (text s 10 "red") 10 y img)) 


;;; 4. Illustrate the signature and the purpose statements with some
;; functional exampesl

;; Number -> Number
;; compute the area of a square whose side is len 
;; given: 2, expect: 4
;; given: 7, expect: 49
;(define (area-of-square len) 0) ;stub

;;; 4. Take inventory.
;; represent inventory in a template

;(define (area-of-square len)
;   (... len ...))

;; now code up the problems

;; Number -> Number
;; computes the area of a square with side len 
;; given: 2, expect: 4
;; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))

;; See add-image.rkt for example from Figure 20.

;;; 6. Test the function
(area-of-square 2)  ; 4
(area-of-square 7)  ; 49
