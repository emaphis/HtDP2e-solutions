;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex079) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define MISSLE1 #false)
(define DRONE2  (make-posn 30 56))
