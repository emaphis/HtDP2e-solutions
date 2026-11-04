#lang htdp/bsl
;; Ex. 69:
;; Draw box representations for the solution of exercise 65.

(define-struct movie [title producer year])
(make-movie "The Great Gatsby" "John Ford" 1955)

(define-struct person [name hair eyes phone])
(make-person "Susanne" "Blonde" "Blue" "555-3545")

(define-struct pet [name number])
(make-pet "Muffy" 5)

(define-struct CD [artist title price])

(define-struct sweater [material size producer])
(make-sweater "Cashmere" 10 "Levies")

;; you will just have to assume that I did this.  :-)
