;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_05_computing_with_structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.2 Computing with Stuctures
;; Exercises: 69-71

;; structues generalize the concept of cartesian points, so computing with
;; sructs generalizes computing with cartesians

(define-struct entry [name phone email])

(define pl
  (make-entry "Sara Lee" "666-7771" "lee$camlu.edu"))

(make-entry "Tara Harp" "666-7770" "th@smlu.edu")

(define-struct vel [deltax deltay])

(define-struct ball [location velocity])

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))

(define-struct centry [name home office cell])

(define-struct phone [area number])


;; Ex. 69:
;; Draw box representations for the solution of exercise 65.

(define-struct movie [title producer year])

(define-struct person [name hair eyes phone])

(define-struct pet [name number])

(define-struct CD [artist title price])

(define-struct sweater [material size producer])

;; you will just have to assume that I did this.  :-)


;; creating a new stucture add new laws to DrRackets environment
;; creating the struct:
; (define-struct ball [location velocity])
; creates tw laws, one per selector

;; (ball-location (make-ball l0 v0)) == l0
;; (ball-velocity (make-ball l0 v0)) == v0


;; Exercise 70. Spell out the laws for these structure type definitions:

;(define-struct centry [name home office cell])
; (cntry-name (make-centy n0 h0 o0 c0)) == n0
; (cntry-home (make-centy n0 h0 o0 c0)) == h0
; (cntry-office (make-centy n0 h0 o0 c0)) == 00
; (cntry-cell (make-centy n0 h0 o0 c0)) == c0

;(define-struct phone [area number])
; (phone-area (make-phone a0 no)) == a0
; (phone-number (make-phone a0 n0)) == n0

;; Use these laws to explain how DrRacket finds 101 as the value of
(phone-area
 (centry-office
  (make-centry
    "Shriram Fisler"
    (make-phone 207 "363-2421")
    (make-phone 101 "776-1099")
    (make-phone 208 "112-9981"))))

;; law of centry-office
(phone-area (make-phone 101 "776-1099"))

;; law of phone-area
101


;; predicates

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


;; Ex. 71:
;; Place the following into DrRacket’s definition area:

; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))

(define-struct game [left-player right-player ball])

(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

;; Explain the results with step-by-step computations.
;; Double-check your computations with DrRacket’s stepper.

(game-ball game0)
;(game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
;(game-ball (make-game 100 MIDDLE (make-posn CENTER CENTER)))
;(game-ball (make-game 100 100 (make-posn CENTER CENTER)))
;(game-ball (make-game 100 100 (make-posn 200 CENTER)))
;(game-ball (make-game 100 100 (make-posn 200 200)))
;(make-posn 200 200)

(posn? (game-ball game0))
;(posn? (game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER))))
;(posn? (game-ball (make-game 100 MIDDLE (make-posn CENTER CENTER))))
;(posn? (game-ball (make-game 100 100 (make-posn CENTER CENTER))))
;(posn? (game-ball (make-game 100 100 (make-posn 200 CENTER))))
;(posn? (game-ball (make-game 100 100 (make-posn 200 200))))
;(posn? (make-posn 200 200))
;#true

(game-left-player game0)
;(game-left-player (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
;(game-left-player (make-game 100 MIDDLE (make-posn CENTER CENTER)))
;(game-left-player (make-game 100 100 (make-posn CENTER CENTER)))
;(game-left-player (make-game 100 100 (make-posn 200 CENTER)))
;(game-left-player (make-game 100 100 (make-posn 200 200)))
;100