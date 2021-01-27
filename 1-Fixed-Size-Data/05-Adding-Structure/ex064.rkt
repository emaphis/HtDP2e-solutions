;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex064) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 64:
;; Design the function manhattan-distance, which measures the Manhattan
;; distance of the given posn to the origin.

; Posn -> Number
; produce the 'Manhattan distance' from a given Posn to the Origin
(check-expect (manhattan-distance (make-posn 0 0)) 0)
(check-expect (manhattan-distance (make-posn 5 0)) 5)
(check-expect (manhattan-distance (make-posn 0 4)) 4)
(check-expect (manhattan-distance (make-posn 5 4)) 9)

;(define (manhattan-distance p) 0) ; stub

(define (manhattan-distance p)
  (+ (posn-x p)
     (posn-y p)))
