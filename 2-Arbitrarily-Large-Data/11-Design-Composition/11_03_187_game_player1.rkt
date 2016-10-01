;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11_03_187_game_player1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 11 Design by Composition
;; 11.2 Composing Functions
;; Exercise: 187


;; Ex 187:
;;  Design a program that sorts lists of game players by score:
;; Hint Formulate a function that compares two elements of GamePlayer.

;; data definitions:

(define-struct gp [name score])
; A GamePlayer is a structure:
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who
; scored a maximum of s points

(define PLAYER1 (make-gp "Fred" 15))
(define PLAYER2 (make-gp "Joan" 20))

; ; template
(define (fn-for-gp p)
  (... (gp-name p)
       (gp-score p)))


;; funtion definitions:

;; Hnt:  Formulate a function that compares two elements of GamePlayer.:

; Gp Gp -> Boolean
; return #true if first Gp has a higher score than second Gp
(check-expect (gp>? (make-gp "Joan" 20) (make-gp "Fred" 15)) #true)
(check-expect (gp>? (make-gp "Fred" 15) (make-gp "Joan" 20)) #false)

;(define (gp>? gp1 gp2) #false) ; stub

(define (gp>? gp1 gp2)
  (> (gp-score gp1) (gp-score gp2)))


; List-of-gp -> List-of-gp
; sort a list of gp (game players) is descending order of score
(check-expect (sort-players '()) '())  ; of course
(check-expect (sort-players (list (make-gp "Joan" 20)))
              (list (make-gp "Joan" 20)))  ; likewise
(check-expect (sort-players (list (make-gp "Joan" 20)
                                  (make-gp "Fred" 15)))
              (list (make-gp "Joan" 20)
                    (make-gp "Fred" 15)))
(check-expect (sort-players (list (make-gp "Fred" 15)
                                  (make-gp "Joan" 20)))
              (list (make-gp "Joan" 20)
                    (make-gp "Fred" 15)))
(check-expect (sort-players (list (make-gp "Fred" 15)
                                  (make-gp "Joan" 20)
                                  (make-gp "Charley" 18)))
              (list (make-gp "Joan" 20)
                    (make-gp "Charley" 18)
                    (make-gp "Fred" 15)))

;(define (sort-players logp) logp) ;stub

(define (sort-players logp)
  (cond [(empty? logp) '()]  ; of course
        [else
         (insert-player (first logp) (sort-players (rest logp)))]))



; Gp List-of-Gp -> List-of-Gp
; insert a player into the proper place in a sorted List of Gp
(check-expect (insert-player (make-gp "Joan" 20) '()) ; base case
              (cons (make-gp "Joan" 20) '()))
(check-expect (insert-player (make-gp "Joan" 20)
                             (list (make-gp "Fred" 15)))
              (list (make-gp "Joan" 20)
                    (make-gp "Fred" 15)))
(check-expect (insert-player (make-gp "Fred" 15)
                             (list  (make-gp "Joan" 20)))
              (list (make-gp "Joan" 20)
                    (make-gp "Fred" 15)))
(check-expect (insert-player (make-gp "Charley" 18)
                             (list (make-gp "Joan" 20)
                                   (make-gp "Fred" 15)))
              (list (make-gp "Joan" 20)
                    (make-gp "Charley" 18)
                    (make-gp "Fred" 15)))


;(define (insert-player p s-logp) s-logp) ; stub

(define (insert-player p s-logp)
  (cond [(empty? s-logp) (cons p '())]
        [else
         (if (gp>? p (first s-logp))
             (cons p s-logp)
             (cons (first s-logp) (insert-player p (rest s-logp))))]))
