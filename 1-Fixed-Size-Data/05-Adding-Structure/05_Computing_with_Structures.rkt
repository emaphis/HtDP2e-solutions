;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_Computing_with_Structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.5 Computing with Stuctures
;; Exercises: 69-71

;; structues generalize the concept of cartesian points, so computing with
;; sructs generalizes computing with cartesians

(define-struct entry [name phone email])

(define pl
  (make-entry "Al Abe" "666-7771" "lee@x.me"))

(make-entry "Tara Harp" "666-7770" "th@smlu.edu")


;; See exercise 69 - diagram structs


;; A selector is like a key

(entry-name pl) ; "Al Abe"

(define-struct ball [location velocity])
(define-struct vel [deltax deltay])

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

(ball-velocity ball1) ; (make-vel -10 5)

;; two layers
(vel-deltax (ball-velocity ball1))  ; -10

;; A nested definition
; (define-struct ball [location velocity])

(define-struct centry [name home office cell])

(define-struct phone [area number])

;; creating a new stucture add new laws to DrRackets environment
;; creating the struct:
;(define-struct ball [location velocity])
; creates tw laws, one per selector
;; (ball-location (make-ball l0 v0)) == l0
;; (ball-velocity (make-ball l0 v0)) == v0

;; See exercise 70 - struct laws

;; law of centry-office
(phone-area (make-phone 101 "776-1099"))

;; law of phone-area
101


;;; predicates

(define ap (make-posn 7 0))

;(define pl  ; defined above
;  (make-entry "Sara Lee" "666-7771" "lee@camlu.edu"))

(posn? ap) ;#true
(posn? 42) ;#false
(posn? #true) ;#false
(posn? (make-posn 3 4)) ;#true

(entry? pl) ;#true
(entry? 42) ;#false
(entry? #true) ;#false

;; See exercise 71
