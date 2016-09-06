;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_06_Designing_Itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e  Enumerations, Intervals, Itemizations
;; 4.6 Designing with Itemizations
;; Exercises: 60


;; Sales tax example

;; Sample Problem The state of Tax Land has created a three-stage sales
;; tax to cope with its budget deficit.
;; - Inexpensive items, those costing less than $1,000, are not taxed.
;; - Luxury items, with a price of morethan $10,000, are taxed at the
;;   rate of eight percent (8.00%).
;; - Everything in between comes with a five percent (5%) mark up.

;; Design a function for a cash register that given the price of an item,
;; computes the sales tax.

; A Price falls into one of three intervals:
; — 0 through 1000;
; — 1000 through 10000;
; — 10000 and above.
; interpretation the price of an item

;; sample data
(define PRC1 0)
(define PRC2 500)
(define PRC3 1000)

#;
(define (fn-for-st st)        ;template
  (cond
    [(and (<= 0 st) (< st 1000)) (... st)]
    [(and (<= 1000 st) (< st 10000)) (... st)]
    [(>= st 10000) (... st)]))


; Price -> Number
; computes the amount of tax charged for price p
(check-expect (sales-tax     0.00)   0.00)
(check-expect (sales-tax   537.00)   0.00)
(check-expect (sales-tax  1000.00) (* 0.05 1000.00))
(check-expect (sales-tax  1282.00)  64.10)
(check-expect (sales-tax 10000.00) (* 0.08 10000.00))
(check-expect (sales-tax 12017.00) 961.36)

;(define (sales-tax p) 0.00) ;stub

#;
(define (sales-tax p)        ;template for sales-tax
  (cond
    [(and (<= 0 p) (< p 1000)) ...]
    [(and (<= 1000 p) (< p 10000)) ...]
    [(>= p 10000) ...]))

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (>= p 1000) (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))


;; Ex. 60:
;; Introduce constant definitions that separate the intervals for low
;; prices and luxury prices from the others so that the legislator in
;; Tax Land can easily raise the taxes even more.

(define BASE-TAX 0.00)
(define MID-TAX  0.05)
(define HIGH-TAX 0.08)

(define BASE-LEVEL     0.00)
(define MID-LEVEL   1000.00)
(define HIGH-LEVEL 10000.00)

; Price -> Number
; compute the amount of tax charged for price p
(check-expect (sales-tax2 BASE-LEVEL) (* BASE-TAX BASE-LEVEL))
(check-expect (sales-tax2 537.00)     (* BASE-TAX 537.00))
(check-expect (sales-tax2 MID-LEVEL)  (* MID-TAX MID-LEVEL))
(check-expect (sales-tax2 1282.00)    (* MID-TAX 1282.00))
(check-expect (sales-tax2 HIGH-LEVEL) (* HIGH-TAX HIGH-LEVEL))
(check-expect (sales-tax2 12017.00)   (* HIGH-TAX 12017.00))

(define (sales-tax2 p)
  (cond
    [(and (<= BASE-LEVEL p) (< p MID-LEVEL)) (* BASE-TAX p)]
    [(and (>= p MID-LEVEL) (< p HIGH-LEVEL)) (* MID-TAX p)]
    [(>= p HIGH-LEVEL) (* HIGH-TAX p)]))

