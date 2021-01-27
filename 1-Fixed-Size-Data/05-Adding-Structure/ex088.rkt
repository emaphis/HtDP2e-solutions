;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex088) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Ex. 88:
; Define a structure type that keeps track of the cat’s x-coordinate and its
; happiness. Then formulate a data definition for cats, dubbed VCat, including
; an interpretation.


; happy cat simulation

(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number[0,100])
; interp.  (make-vcat x h) has an 'x; postition and an 'h' happyness level

(define CAT1 (make-vcat 0 90))  ; happy cat at origin
(define CAT2 (make-vcat 50 50)) ; meh cat in middle of screen

; Cat -> ???
(define (fn-for-cat c)
  (... (... (cat-x-pos c))
       (... (cat-happy c))))

