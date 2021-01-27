;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_Computing_with_posns) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.2 Computing with posns

;; Number Number -> Posn
(make-posn 3 4)


;; Selecting components of a posn

(define p (make-posn 31 26))

(posn-x p) ; 31

(posn-y p) ; 26

;; posn identities

; (posn-x (make-posn x0 y0)) == x0
; (posn-y (make-posn x0 y0)) == y0

;; evaluation

(posn-x p)
; racket replaces p with (make-posn 31 26)
(posn-x (make-posn 31 26))
31
