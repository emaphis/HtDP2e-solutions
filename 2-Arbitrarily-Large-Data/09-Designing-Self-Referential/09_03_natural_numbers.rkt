;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_03_natural_numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.3 Natural Numbers
;; Exercises: 149-152

(require 2htdp/image)

; a build-in function that consumes atomic data and produces an
; arbitrarily long data

;> (make-list 2 "hello")
;(cons "hello" (cons "hello" '()))
;> (make-list 3 #true)
;(cons #true (cons #true (cons #true '())))
;> (make-list 0 19)
;'()

; make-list consumes a positive Integer or a Nutural Number which can be
; concidered a structured data type.

; A N is one of:
; – 0
; – (add1 N)
; interpretation represents the counting numbers

; add1 -- cons
; sub1 -- first rest

; zero?  - emtpy?
; positive? - cons? - else


; N String -> List-of-strings
; creates a list of n copies of s

(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))

;(define (copier n s)
;  '())

(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons  s (copier (sub1 n) s))]))

; (positive? n) == else


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 149:
;; Does copier function properly when you apply it to a natural number and a
;; Boolean or an image? Or do you have to design another function? Read
;; Similarities Everywhere for an answer.

;> (copier 4 #true)
;(cons #true (cons #true (cons #true (cons #true '()))))
;> (copier 4 3)
;(cons 3 (cons 3 (cons 3 (cons 3 '()))))

; no, copier doesn't care about the class of it's second parameter, becuase
; 'cons' doesn't care, it will cons any type onto any list (polymorphic)

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

(check-expect (copier.v2 4 0.1)
              (cons 0.1 (cons 0.1 (cons 0.1 (cons 0.1 '())))))
(check-expect (copier.v2 4 "x")
              (cons "x" (cons "x" (cons "x" (cons "x" '())))))

; the outputs are identical, but the (positive?) requires one more computation
; than the 'else' version per (sub1 ...)


;; Ex. 150:
;; Design the function add-to-pi. It consumes a natural number n and adds it to
;; pi without using the primitive + operation. Here is a start:

; N -> Number
; computes (+ n pi) without using +

(check-within (add-to-pi 0)  pi 0.001)
(check-within (add-to-pi 3) (+ 3 pi) 0.001)

;(define (add-to-pi n)
;  pi)

(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else
     (add1 (add-to-pi (sub1 n)))]))

;; Once you have a complete definition, generalize the function to add, which
;; adds a natural number n to some arbitrary number x without using +.
;; Why does the skeleton use check-within?

; N Number -> Number
; compute (+ N n) without using '+'

(check-expect (add 0 0.0) 0.0)
(check-expect (add 3 3.1) (+ 3 3.1))
(check-within (add 3 pi) (+ 3 pi) 0.001) ; old example

;(define (add-to-num N num) 0.0) ; stub

(define (add n num)
  (cond
    [(zero? n) num]
    [(positive? n)
     (add1 (add (sub1 n) num))]))

; use check-within because pi is an inexact number.


;; Ex. 151:
;; Design the function multiply. It consumes a natural number n and multiplies
;; it with a number x without using

;; Use DrRacket’s stepper to evaluate (multiply 3 x) for any x you like.
;; How does multiply relate to what you know from grade school.

;; N Number -> Number
;; multiply a N with a Number without using '*'

(check-expect (multiply 0 1.0) 0.0)
(check-expect (multiply 1 0.0) 0.0)
(check-expect (multiply 3 3.0) (* 3 3.0))

(define (multiply n num)
  (cond [(zero? n) 0.0]
        [(positive? n)
         (add (multiply (sub1 n) num) num)]))


;; Ex. 152:
;; Design two functions: col and row.

;; The function col consumes a natural number n and an image img. It produces
;; a column—a vertical arrangement—of n copies of img.

;; The function row consumes a natural number n and an image img. It produces
;; a row—a horizontal arrangement—of n copies of img.

; N Image -> Image
; produce a column of n images
(check-expect (col 0 (square 10 "solid" "blue")) empty-image)
(check-expect (col 1 (square 10 "solid" "blue"))
              (above (square 10 "solid" "blue")
                     empty-image))
(check-expect (col 3 (square 10 "solid" "blue"))
              (above (square 10 "solid" "blue")
                     (above (square 10 "solid" "blue")
                            (above (square 10 "solid" "blue")
                                   empty-image))))
(define (col n img)
  (cond [(zero? n) empty-image]
        [(positive? n)
         (above img (col (sub1 n) img))]))

; N Image -> Image
; produce a row of n images
(check-expect (row 0 (square 10 "solid" "blue")) empty-image)
(check-expect (row 1 (square 10 "solid" "blue"))
              (beside (square 10 "solid" "blue")
                      empty-image))
(check-expect (row 3 (square 10 "solid" "blue"))
              (beside (square 10 "solid" "blue")
                      (beside (square 10 "solid" "blue")
                               (beside (square 10 "solid" "blue")
                                       empty-image))))
(define (row n img)
  (cond [(zero? n) empty-image]
        [(positive? n)
         (beside img (row (sub1 n) img))]))

;; Ex. 153:
;; see 09_03_153_lecture_hall.rkt
