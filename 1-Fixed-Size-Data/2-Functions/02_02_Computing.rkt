;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chp1_02_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 2.2 Functions
;; 2.2.2 Computing
;; Exercises 23-25
(require 2htdp/image)

(define (f x) 1)

(define (ff a)
  (* 10 a))

;; Ex. 23:
;; Use DrRacket’s stepper to evaluate (ff (ff 1)) step by step.
;; Also try (+ (ff 1) (ff 1)).
;; Does DrRacket’s stepper reuse the results of computations?

(ff (ff 1))
(ff (* 10 1))
(ff 10)
(* 10 10)
100

(+ (ff 1) (ff 1))
(+ (* 10 1) (ff 1))
(+ 10 (* 10 1))
(+ 10 10)
20


;; Sample program
;; Attendee's example and Letter example

;; Letter sample -- function composition

(define (opening first-name last-name)
  (string-append "Dear " first-name ","))

(check-expect (opening "Matthew" "Fisler") "Dear Matthew,")


;; Ex. 24: run in stepper

(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(distance-to-origin 3 4)
(sqrt (+ (sqr 3) (sqr 4)))
(sqrt (+ 9 (sqr 4)))
(sqrt (+ 9 16))
(sqrt 25)
5

;; Ex. 25:  run in stepper
(define (string-first s)
  (substring s 0 1))

(string-first "hello world")
(substring "hello world" 0 1)
"h"

;; Ex 26: run in stepper
(define (==> x y)
  (or (not x) y))

(==> #true #false)
(or (not #true) #false)
(or #false #false)
#false

;; Ex 27 Does the stepping suggest how to fix this attempt? image

(define (image-classify img)
  (cond
    [(>= (image-height img) (image-width img))
     "tall"]
    [(= (image-height img) (image-width img))
     "square"]
    [(<= (image-height img) (image-width img))
     "wide"]))

(image-classify (circle 3 "solid" "red"))

;; Yes the "=" clause should come first.

(define (image-classify-fixed img)
  (cond
    [(= (image-height img) (image-width img))
     "square"]
    [(>= (image-height img) (image-width img))
     "tall"]
    [(<= (image-height img) (image-width img))
     "wide"]))

;; Ex 28: Confirm with stepper

(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))

(string-insert "helloworld" 6)
"hellow_orld"
