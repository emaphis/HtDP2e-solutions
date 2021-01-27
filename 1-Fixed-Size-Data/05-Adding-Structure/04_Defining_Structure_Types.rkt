;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_Defining_Structure_Types) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.4 Defining Structure Types
;; Exercises: 65-68


;(define-struct posn [x y])

;; (define-struct StructuteName [FieldName ..])

;; Structure type definitions defines several function.

;; One constructor that creates structure instances
;; One selector per field
;; A predicate
 

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


;; Sample Problem:
;; Develop a structure type definition for a program that deals with “bouncing
;; balls” , briefly mentioned at the very beginning of this chapter. The ball’s
;; location is a single number, namely the distance of pixels from the top.
;; Its constant speed is the number of pixels it moves per clock tick. Its
;; velocity is the speed plus the direction in which it moves.

; velocity is a number
; positive number means ball moves down.
; negative number means ball moves up.

(define-struct ball [location velocity])


;; See exercise 67 - another way to represent bouncing balls:

;; a ball with velocity in a 2d universe

(define-struct vel [deltax deltay])
;; "delta" usually indicates a change in a physical quantity over time

;; make a ball with a position and a velocity

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

;; See exercise 68. - Alternative definition.


;;; another example of a nested structure

(define-struct centry [name home office cell])
 
(define-struct phone [area number])
 
(make-centry "Shriram Fisler"
             (make-phone 207 "363-2421")
             (make-phone 101 "776-1099")
             (make-phone 208 "112-9981"))