;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_04_defining_structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.4 Defining Structure Types
;; Exercises: 65-68

;; (define-struct StructuteName [FieldName ..])


;; Ex 65.
;; Write down the names of the functions
;; (constructors, selectors, and predicates) that it introduces

;; (define-struct movie [title producer year])
;; make-movie, movie?, movie-title, movie-producer, movie-year

;; (define-struct person [name hair eyes phone])
;; make-person, person?, person-name, person-hair, person-eyes


;; a structure type definition that we might use to keep track of contacts such
;; as those in your cell phone:

(define-struct entry [name phone email])


;; predifined functions:

;; make-entry String String String -> Entry

;; entry-name : Entry -> String
;; entry-phone : Entry -> String
;; entry-email : Entry -> String

;; entry? : Any -> Bool



(make-entry "Sara Lee" "666-7771" "lee@camlu.edu")


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

(define-struct sweater [material size producer])


;; Sample Problem:
;; Develop a structure type definition for a program that deals with “bouncing
;; balls” , briefly mentioned at the very beginning of this chapter. The ball’s
;; location is a single number, namely the distance of pixels from the top.
;; Its constant speed is the number of pixels it moves per clock tick. Its
;; velocity is the speed plus the direction in which it moves.

(define-struct ball [location velocity])


;; Ex. 66:
;; Here is another way to represent bouncing balls:

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

;; Interpret this code fragment and create other instances of balld

(make-balld 100 "up")
(make-balld (+ 25 SPEED) "down")
(make-balld 0 "up")


;; a ball with velocity in a 2d universe

(define-struct vel [deltax deltay])
;; "delta" usually indicates a change in a physical quantity over time

;; make a ball with a position and a velocity

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))


;; Ex. 68:
;; An alternative to the nested data representation of balls uses four fields
;; to keep track of the four properties:

(define-struct ballf [x y deltax deltay])

;; Programmers call this a flat representation.
;; Create an instance of ballf that has the same interpretation as ball1.

(define ball2
  (make-ballf 30 40 -10 5))


;; another example of a nested structure

(define-struct centry [name home office cell])
 
(define-struct phone [area number])
 
(make-centry "Shriram Fisler"
             (make-phone 207 "363-2421")
             (make-phone 101 "776-1099")
             (make-phone 208 "112-9981"))