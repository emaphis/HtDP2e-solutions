;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex069) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define-struct sweater [material size producer])
(make-sweater "Cashmere" 10 "Levies")

;; you will just have to assume that I did this.  :-)

