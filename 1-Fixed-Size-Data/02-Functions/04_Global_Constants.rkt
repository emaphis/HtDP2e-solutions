#lang htdp/bsl
;; HtDP 2e 2.3 Functions
;; 2.4 Global Constants
;; Exercise 30

(require 2htdp/image)

;; Examples

; the current price of a movie ticket
(define CURRENT-PRICE 5)

; useful to compute the area of a disk:
(define ALMOST-PI 3.14)

; a blank line:
(define NL "\n")

; an empty scene:
(define MT (empty-scene 100 100))

; literal constants
(define WIDTH 100)
(define HEIGHT 200)

; arbitrary expressions
(define MID-WIDTH (/ WIDTH 2))
(define MID-HEIGHT (/ HEIGHT 2))

;; see exercise 30.
