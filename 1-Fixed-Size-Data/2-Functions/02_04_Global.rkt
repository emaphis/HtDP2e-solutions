;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chp1_02_4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 2.3 Functions
;; 2.2.4 Global Constants

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

;; Ex. 32:
;; Define constants for the price optimization program so that the price
;; sensitivity of attendance (15 people for every 10 cents) becomes a computed constant.
(define ATTENDEES 15)
(define PRICE 0.10)
(define PRICE-SENSITIVITY (/ ATTENDEES PRICE))  ; 150