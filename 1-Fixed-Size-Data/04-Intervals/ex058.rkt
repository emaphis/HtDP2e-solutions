;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex058) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Ex. 58:
;; Introduce constant definitions that separate the intervals for low
;; prices and luxury prices from the others so that the legislator in
;; Tax Land can easily raise the taxes even more.

;; 1. Data definition:

; A Price falls into one of three intervals:
; — 0 through 1000;
; — 1000 through 10000;
; — 10000 and above.
; interpretation the price of an item

(define BASE-LEVEL     0.00)
(define MID-LEVEL   1000.00)
(define HIGH-LEVEL 10000.00)

(define BASE-TAX 0.00)
(define MID-TAX  0.05)
(define HIGH-TAX 0.08)

; Price -> Number
; compute the amount of tax charged for price p
(check-expect (sales-tax BASE-LEVEL) (* BASE-TAX BASE-LEVEL))
(check-expect (sales-tax 537.00)     (* BASE-TAX 537.00))
(check-expect (sales-tax MID-LEVEL)  (* MID-TAX MID-LEVEL))
(check-expect (sales-tax 1282.00)    (* MID-TAX 1282.00))
(check-expect (sales-tax HIGH-LEVEL) (* HIGH-TAX HIGH-LEVEL))
(check-expect (sales-tax 12017.00)   (* HIGH-TAX 12017.00))

#;
(define (sales-tax-template p)        ;template for sales-tax
  (cond
    [(and (<= BASE-LEVEL p) (< MID-LEVEL 1000)) ...]
    [(and (<= MID-LEVEL p) (< p HIGH-LEVEL)) ...]
    [(>= p HIGH-LEVEL) ...]))


(define (sales-tax p)
  (cond
    [(and (<= BASE-LEVEL p) (< p MID-LEVEL)) (* BASE-TAX p)]
    [(and (>= p MID-LEVEL) (< p HIGH-LEVEL)) (* MID-TAX p)]
    [(>= p HIGH-LEVEL) (* HIGH-TAX p)]))

