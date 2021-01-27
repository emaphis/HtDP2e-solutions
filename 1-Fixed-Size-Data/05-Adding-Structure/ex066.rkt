;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex066) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 66:
;; Revisit the structure type definitions of exercise 65. Make sensible
;; guesses as to what kind of values go with which fields. Then create at
;; least one instance per structure type definition.

(define-struct movie [title producer year])
; title: String
; producer: String
; year: PositiveNumber
(make-movie "The Great Gatsby" "John Ford" 1955)

(define-struct person [name hair eyes phone])
; name: String
; hair: String
; eyes: String
; phone: String
(make-person "Susanne" "Blonde" "Blue" "555-3545")

(define-struct pet [name number])
; name: String
; number: PositiveNumber
(make-pet "Muffy" 5)

(define-struct CD [artist title price])
; artist: String
; title: String
; price Number
(make-CD "Joan Jett" "Raw" 13.99)

(define-struct sweater [material size producer])
; material: String
; size: Natrural
; produce: String
(make-sweater "Cashmere" 10 "Levies")
