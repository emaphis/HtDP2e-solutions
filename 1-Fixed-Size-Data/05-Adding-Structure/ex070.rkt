#lang htdp/bsl
;; Exercise 70. Spell out the laws for these structure type definitions:


(define-struct centry [name home office cell])
; (cntry-name (make-centy n0 h0 o0 c0)) == n0
; (cntry-home (make-centy n0 h0 o0 c0)) == h0
; (cntry-office (make-centy n0 h0 o0 c0)) == 00
; (cntry-cell (make-centy n0 h0 o0 c0)) == c0

(define-struct phone [area number])
; (phone-area (make-phone a0 no)) == a0
; (phone-number (make-phone a0 n0)) == n0

;; Use these laws to explain how DrRacket finds 101 as the value of
(phone-area
 (centry-office
  (make-centry
    "Shriram Fisler"
    (make-phone 207 "363-2421")
    (make-phone 101 "776-1099")
    (make-phone 208 "112-9981"))))

(phone-area (make-phone 101 "776-1099"))

101
