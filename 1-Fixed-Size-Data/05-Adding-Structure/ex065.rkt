;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex065) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 65.
;; Write down the names of the functions
;; (constructors, selectors, and predicates) that it introduces

 (define-struct movie [title producer year])
;; make-movie, movie?, movie-title, movie-producer, movie-year

(define-struct person [name hair eyes phone])
;; make-person, person?, person-name, person-hair, person-eyes

(define-struct pet [name number])
;; make-pet, pet? pet-name pet-number

(define-struct CD [artist title price])
;; make-CD, CD?, CD-artist, CD-title, CD-price

(define-struct sweater [material size producer])
;; make-sweater, seater? seater-material, seater-size, seater-produce
