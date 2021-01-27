;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 07_Universe_of_Data) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.7 The Universe of data
;; Exercises: 76-79

;; Strucs expand the universe of BSL types

(define-struct ball [location velocity])

(make-ball -1 0)
(make-ball -1 1)
(make-ball -1 2)

;; data definition for Posn
; Posn is (make-posn Number Number)

(make-posn (make-posn 1 1) "hello") ; nonsensical

;; See exercises 76, 77, 78


;; Provide data example of data definitions to make the data type clear.

;; for a built-in collection of data (number, string, Boolean, images),
;; choose your favorite examples

;; for an enumeration, use several of the items of the enumeration;

;; for intervals, use the end points (if they are included) and at least one interior point;

;; for itemizations, deal with each part separatel

;; for data definitions for structures, follow the natural language description;
;; that is, use the constructor and pick an example from the data collection named for each fiel

;; See exetcise 79
