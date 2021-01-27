;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 08_Designing_with_Structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.2 Designing with Structures 
;; Exercises: 80-82

;; The design recipe including structures:

;; Sample Problem:
;; Design a function that computes the distance of objects in a 3-dimensional
;; space to the origin.

;; 1. Data design
;; pieces of data that go to gether belong in a structure

(define-struct r3 [x y z])
; A R3 is a structure:
;   (make-r3 Number Number Number)
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> ???
#;; template for R3
(define (fn-for-r3 r)
  (... (r3-x r)
       (r3-y r)
       (r3-z r)))


;; 2. Signature, purpose statement and function header:

; R3 -> Numbers
; produces the distance from an T3 to origin
; origin: (make-r3 0 0 0)

;(define (r3-distance-to-0 r) 0)

;; 3. Use the examples to creat tests
(check-within (r3-distance-to-0 (make-r3 0 0 0)) 0 0.01)
(check-within (inexact->exact (r3-distance-to-0 ex1)) 13.19 0.01)
(check-within (inexact->exact (r3-distance-to-0 ex2)) 3.162 0.01)

;;  4. create a template
#;;
(define (r3-distance-to-0 r)
  (... (... (r3-x r))   ; Number
       (... (r3-y r))   ; Number
       (... (r3-z r)))) ; Number

;; 5. Use the selector expressions from the template

(define (r3-distance-to-0 r)
  (sqrt (+ (sqr (r3-x r))   ; Number
           (sqr (r3-y r))   ; Number
           (sqr (r3-z r)))))

;; 6. Test!

;; See exercise 80, 81, 82
