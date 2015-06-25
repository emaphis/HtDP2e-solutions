;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.4  Errors

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; syntax errors

;; Exercise 2.4.1.
;; Evaluate the following sentences in DrScheme, one at a time:
;; Read and understand the error messages

;(+ (10) 20)
;function call: expected a function after the open parenthesis, but found a number

;(10 + 20)
;function call: expected a function after the open parenthesis, but found a number

;(+ +)
;+: expected a function call, but there is no open parenthesis before this function


;; Exercise 2.4.2.   Enter the following sentences, one by one, into DrScheme's
;; Definitions window and click Execute:
;; Read the error messages, fix the offending definition in an appropriate manner,
;; and repeat until all definitions are legal.

;(define (f 1)
;  (+ x 10))
; define: expected a variable, but found a number
(define (f x)
  (+ x 10))

;(define (g x)
;  + x 10)
; define: expected only one expression for the function body, but
; found 2 extra parts
(define (g x)
  (+ x 10))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Run-time Errors:

;; Exercise 2.4.3.
;; Evaluate the following grammatically legal Scheme expressions
;; in DrScheme's Interactions window:
;; Read the error messages.

; (+ 5 (/ 1 0))
; /: division by zero

; (sin 10 20)
; sin: expects only 1 argument, but found 2

; (somef 10)
; somef: this function is not defined



;; Exercise 2.4.4.
;; Enter the following grammatically legal Scheme program into the
;; Definitions window and click the Execute button:

(define (somef x)
  (sin x x))

;; Then, in the Interactions window, evaluate the expressions:

; (somef 10 20)
; somef: expects only 1 argument, but found 2

; (somef 10)
; sin: expects only 1 argument, but found 2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Logical Errors:




