;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_Computing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 2.2 Functions
;; 2.2 Computing
;; Exercises 21-26

(define (f x) 1)

;; evaluatets
(f (+ 1 1))
;(f 2)
;1


(define (ff a)
  (* 10 a))

;; evaluate
(ff (+ 1 1))
;(ff 2)
;(* 10 2)
;20

(+ (ff (+ 1 2)) 2)
;(+ (ff 3) 2)
;(+ (* 10 3) 2)
;(+ 30 2)
;s32


;; See exercise 21

;;; programs that process strings

(string-append "hello" " " "world") ; "hello world"
(string-append "bye" ", " "world")  ; "bye, world"


;; Sample program
;; Attendee's example and Letter example

(define (opening first-name last-name)
  (string-append "Dear " first-name ","))

(opening "Matthew" "Fisler") ; "Dear Matthew,"

;; See exercises 22, 23, 24, 25, 26
