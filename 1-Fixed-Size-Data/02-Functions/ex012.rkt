;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex012) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 12:
;; Define the function cvolume, which accepts the length of a side of
;; an equilateral cube and computes its volume. If you have time, consider
;; defining csurface, too.

(define (cvolume side)
  (* side side side))

(cvolume 0) ; 0
(cvolume 1) ; 1
(cvolume 5) ; 125


(define (csurface side)
  (* (sqr side) 6))

(csurface 0) ; 0
(csurface 1) ; 6
(csurface 5) ; 150
