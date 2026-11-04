#lang htdp/bsl
;; Ex. 72:
;; Formulate a data definition for the above phone structure type
;; definition that accommodates the given examples.

(define-struct phone [area number])
; A Phone is a structure:
;    (make-phone Number String)
; interpretation
; area the area code
; number the local phone-number

(make-phone 207 "363-2421")

;; Next formulate a data definition for phone numbers using this
;; structure type definition:
;; Describe the content of the three fields
;; as precisely as possible with intervals.

(define-struct phone# [area switch num])
; A Phone# is a structure:
;   (make-phone# Number Number Number)
; interpretation:
; area is the area code               [100, 999]
; switch is phonew switch exhange     [100, 999]
; number is number in the neighborhood [0000, 9999]

(make-phone# 207 363 2421)
