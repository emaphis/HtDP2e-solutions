;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_07_universe_of_data) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.7 The Universe of data
;; Exercises: 76-79



(define-struct ball [location velocity])

; Posn is (make-posn Number Number)

(make-posn (make-posn 1 1) "hello")


;; Ex. 76:
;; Formulate data definitions for the following structure type definitions:

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


;; Ex. 77:
;; Provide a structure type definition and a data definition for representing
;; points in time since midnight.
;; A point in time consists of three numbers: hours, minutes, and seconds

(define-struct time-pt [hours minutes seconds])
; time-pt is a (make-time-pt Number Number Number))
; interp: a point in time having hours, minutes, seconds

(define TIME1 (make-time-pt 10 30 00))  ; 10:30

#;; template
(define (fn-for-time-pt tm)
  (... (time-pt-hours tm)
       (time-pt-minutes tm)
       (time-pt-seconds tm)))


;; Ex. 78:
;; Provide a structure type definition and a data definition for representing
;; three-letter words. A word consists of lower-case letters, represented with
;; the one-letter strings "a" through "z" plus #false.
;; Note This exercise is a part of the design of a Hangman game;
;; see exercise 396.

;; LCL is one of
; 1String [a,z]
; #false
; interp. lower case letters [a,z] or no letter

(define L1 "a")
(define L2 "k")
(define L3 #false)

#;; template
(define (fn-for-LCL l)
  (cond [(and (string? l) (string<=? "a" l "z")) ...]
        [(equal? #false l) ...]))


(define-struct word3 [let1 let2 let3])
;; word3 is a (make-word3 LCL LCL LCL)
;; interp.  word3 consists of 3 lower case letters

(define WORD1 (make-word3 "c" "a" "t"))
(define WORD2 (make-word3 "d" "o" "g"))
(define WORD3 (make-word3 "m" "e" #false))

#;; template
(define (fn-for-word3 w)
  (... (... (word3-let1 w))
       (... (word3-let2 w))
       (... (word3-let3 w))))


;; Ex. 79:
;; Create examples for the following data definitions:

; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define RED "red")
(define BLUE "blue")
(define GREEN "green")


; H is a Number between 0 and 100.
; interpretation represents a “happiness value”

(define HAPPY 100)
(define MEH 50)
(define SAD 0)


(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

(define TOM (make-person "Tom" "Smith" #true))
(define BETTY (make-person "Betty" "Lou" #false))

;; I don't think field names that look like a predicate is a bad idea.
;; They willl generally be tested with predicates, and the names are just
;; for documentation


(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; interp. a dog with an owner, the dog's name, the dog's age
;;        and the dog's happiness level`

(define FEFE (make-dog (make-person "Sue" "Hech" #false)
                       "Fefe" 3 80))
(define BUTCH (make-dog (make-person "Bill" "Jander" #true)
                        "Butch" 8 50))


; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

(define MISSLE1 (make-weapon #false))
(define DRONE2 (make-weapon (make-posn 30 56)))
