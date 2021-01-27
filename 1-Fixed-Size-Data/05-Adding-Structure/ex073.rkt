;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex073) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 73:
;; Design the function posn-up-x, which consumes a Posn p and a Number n.
;; It produces a Posn like p with n in the x field.

;; Note Functions such as posn-up-x are often called updaters or functional
;; setters. They are extremely useful when you write large programs.

; Posn Number -> Posn
; produces a Posn given a Posn and a Number with the x field replaced by n
(check-expect (posn-up-x (make-posn 10 20) 30)
              (make-posn 30 20))

; (define (posn-up-x p n) (make-posn 0 0)) ; stub

(define (posn-up-x p n)
  (make-posn n (posn-y p)))
