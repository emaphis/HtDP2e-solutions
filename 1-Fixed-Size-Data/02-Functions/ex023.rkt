;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex023) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 23:
;; The first 1String in "hello world" is "h".
;; How does the following function compute this result?
;; (define (string-first s)
;;   (substring s 0 1))
;; Use the stepper to confirm your ideas.


(define (string-first s)
  (substring s 0 1))

(string-first "hello world")
(substring "hello world" 0 1)
"h"
