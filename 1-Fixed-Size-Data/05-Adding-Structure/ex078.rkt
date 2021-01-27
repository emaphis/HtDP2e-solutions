;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex078) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
  (cond [(and (string? l) (string<=? "a" l) (string<=? l "z")) ...]
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
