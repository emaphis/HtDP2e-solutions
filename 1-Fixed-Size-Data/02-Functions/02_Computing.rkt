#lang htdp/bsl
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
;32


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
