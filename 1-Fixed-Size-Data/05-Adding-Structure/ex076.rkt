;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex76) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 76:
;; Formulate data definitions for the following structure type definitions:

; Note: I include a function templare and an example as part of a data definition.

(define-struct movie [title producer year])
; movie is (make-movie String String Number)
; interp: title is the name of the movie
;         producer is the name of the producer
;         year is the year the movie was made

(define MOVIE1 (make-movie "Gone With the Wind" "John Ford" 1944))

#;; template
(define (fn-for-movie m)
  (... (movie-title m)
       (movie-producer m)
       (movie-year m)))


(define-struct person1 [name hair eyes phone])
; person is a (make-person1 String String String String)
; interp: a person1 is composed of name, hair color, eye color, phone number

(define PERSON1 (make-person1 "Bettsy Sue" "Brown" "Brown" "555-2223"))

#;; template
(define (fn-for-person1 p)
  (... (person1-name p)
       (person1-hair p)
       (person1-eyes p)
       (person1-phone)))


(define-struct pet [name number])
; pet is a (make-pet String Number)
; interp: a pet with a name and an id number

(define CAT1 (make-pet "Fluffy" 100))

#;; template
(define (fn-for-pet p)
  (... (pet-name p)
       (pet-number p)))


(define-struct CD [artist title price])
; CD is a (make-CD String String Number)
; interp: a CD with an artist name, a CD title and a price in dollars

(define CD1 (make-CD "Beethoven" "Beethoven's Piano Concertos" 10.44))

#;; template
(define (fn-for-CD cd)
  (... (CD-artist cd)
       (CD-title cd)
       (CD-price cd)))


(define-struct sweater [material size producer])
; sweater is a (make-sweater String String String)
; interp: a sweater has a material, a size, and a manufacturer

(define SWEATER1 (make-sweater "angora" "large" "Archer Daniels Midland"))

#;; template
(define (fn-for-sweater s)
  (... (sweater-material s)
       (sweater-size s)
       (sweater-producer s)))


