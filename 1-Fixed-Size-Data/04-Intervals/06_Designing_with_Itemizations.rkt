;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_Designing_with_Itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 4 Enumerations, Intervals, Itemizations
;; 4.6 Designing with Itemizations
;; Exercise: 58

;; Sales tax example

;; Sample Problem The state of Tax Land has created a three-stage sales
;; tax to cope with its budget deficit.
;; - Inexpensive items, those costing less than $1,000, are not taxed.
;; - Luxury items, with a price of morethan $10,000, are taxed at the
;;   rate of eight percent (8.00%).
;; - Everything in between comes with a five percent (5%) mark up.

;; Design a function for a cash register that given the price of an item,
;; computes the sales tax.

;; 1. Data definition:

; A Price falls into one of three intervals:
; — 0 through 1000;
; — 1000 through 10000;
; — 10000 and above.
; interpretation the price of an item

;; sample data
(define PRC1 0)
(define PRC2 500)
(define PRC3 1000)

;; Template for Price
#;
(define (fn-for-st st)
  (cond
    [(and (<= 0 st) (< st 1000)) (... st)]
    [(and (<= 1000 st) (< st 10000)) (... st)]
    [(>= st 10000) (... st)]))


;; 2. Signature, purpose statement and function hearder

; Price -> Number
; computes the amount of tax charged for price p
;(define (sales-tax p) 0.00) ;stub

;; 3.  Function examples

;;     0.00  => 0.00
;;   537.00  => 0.00
;;  1000.00  => (* 0.05 1000.00)  => 50.00
;; 10000.00  => (* 0.08 10000.00) => 800.00

(check-expect (sales-tax     0.00)   0.00)
(check-expect (sales-tax   537.00)   0.00)
(check-expect (sales-tax  1000.00) (* 0.05 1000.00))
(check-expect (sales-tax 10000.00) (* 0.08 10000.00))
(check-expect (sales-tax 12017.00) 961.36)

;; 4. The template based on classes of data

#;
(define (sales-tax-template p)        ;template for sales-tax
  (cond
    [(and (<= 0 p) (< p 1000)) ...]
    [(and (<= 1000 p) (< p 10000)) ...]
    [(>= p 10000) ...]))


;; Function definition

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (>= p 1000) (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))

;; See exercise 58.
