;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_05_159_lecture_hall2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.5 Lists and World
;; Exercise: 159
;; Lecture Hall 2

;; Ex. 159:
;; Turn the exercise of exercise 153 into a world program. Its main function,
;; dubbed riot, consumes how many balloons the students want to throw; its
;; visualization shows one balloon dropping after another at a rate of one per
;; second. The function produces the list of Posns where the balloons hit.

;; Hints (1) Here is one possible data representation:

;(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of:
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons
; must yet be thrown and added to lob

; (2) A big-bang expression is really just an expression. It is legitimate to
; nest it within another expression.

; (3) Recall that random creates random numbers.


(require 2htdp/image)
(require 2htdp/universe)

;; functions from Ex. 152:

; N Image -> Image
; produce a column of n images
(check-expect (col 0 (square 10 "solid" "blue")) empty-image)
(check-expect (col 1 (square 10 "solid" "blue"))
              (above (square 10 "solid" "blue")
                     empty-image))
(check-expect (col 3 (square 10 "solid" "blue"))
              (above (square 10 "solid" "blue")
                     (above (square 10 "solid" "blue")
                            (above (square 10 "solid" "blue")
                                   empty-image))))
(define (col n img)
  (cond [(zero? n) empty-image]
        [(positive? n)
         (above img (col (sub1 n) img))]))

; N Image -> Image
; produce a row of n images
(check-expect (row 0 (square 10 "solid" "blue")) empty-image)
(check-expect (row 1 (square 10 "solid" "blue"))
              (beside (square 10 "solid" "blue")
                      empty-image))
(check-expect (row 3 (square 10 "solid" "blue"))
              (beside (square 10 "solid" "blue")
                      (beside (square 10 "solid" "blue")
                               (beside (square 10 "solid" "blue")
                                       empty-image))))
(define (row n img)
  (cond [(zero? n) empty-image]
        [(positive? n)
         (beside img (row (sub1 n) img))]))


;;;;;;;;;;;;;;;;;;;;
;; constants:

(define ROWS 18)
(define COLS 8)
(define AREA (* ROWS COLS))

(define CELL-SIZE 10)

;; graphical constants

(define CELL (square CELL-SIZE "outline" "black"))
(define BALLOON (circle 3 "solid" "red"))

(define BACKGROUND (empty-scene (* CELL-SIZE COLS)
                                (* CELL-SIZE ROWS)
                                "white"))

;; row of CELLs COLS long
(define ROW (row COLS CELL))

;; column of ROWs, ROWS high
(define COL (col ROWS ROW))


;; the HALL images
(define HALL
  (place-image COL
               (/ (image-width BACKGROUND) 2)
               (/ (image-height BACKGROUND) 2)
               BACKGROUND))


;; Data definitions:

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of:
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons
; must yet be thrown and added to lob

(define PR1 (make-pair 0 '()))
(define PR2 (make-pair 1 (cons (make-posn 10 20) '())))
(define PR3 (make-pair 3 (cons (make-posn 10 20)
                               (cons (make-posn 20 40)
                                     (cons (make-posn 40 30) '())))))
#; ;template
(define (fn-for-pair pr)
  (... (pair-balloon# pr)
       (fn-for-lob (pair-lob pr))))

#; ;template
(define (fn-for-lob lob)
  (cond [(empty? lob) ...]
        [else
         (... (first lob)
              (fn-for-lob (rest lob)))]))


;; Functions

;; Pair -> Image
;; place PAINT images at Posn locations given a Pair
(check-expect (add-balloons (make-pair 3 '()))
              HALL)

(check-expect (add-balloons (make-pair 3 (cons (make-posn 10 10) '())))
              (place-image BALLOON 10 10
                           HALL))

(check-expect (add-balloons (make-pair 3 (cons (make-posn 10 10)
                                               (cons (make-posn 20 20)
                                                     (cons (make-posn 30 30)
                                                           '())))))
             (place-image BALLOON 10 10
                          (place-image BALLOON 20 20
                                       (place-image BALLOON 30 30
                                                    HALL))))



(define (add-balloons pr)
  (cond [(empty? (pair-lob pr)) HALL]
        [else
         (place-image BALLOON
                      (posn-x (first (pair-lob pr)))
                      (posn-y (first (pair-lob pr)))
                      (add-balloons (make-pair (pair-balloon# pr)
                                      (rest (pair-lob pr)))))]))

;; Pair Number Number -> Pair
;; produce a new pair given a pair and an x-pos ans y-pos

(check-expect (throw-balloon (make-pair 0 '()) 10 10) ; base case
              (make-pair 0 '()))

(check-expect (throw-balloon (make-pair 1 (cons (make-posn 10 10) '())) 20 30)
              (make-pair 0 (cons (make-posn 20 30)
                                 (cons (make-posn 10 10) '()))))

;;(define (throw-balloon pr xp yp) pr) ;stub

(define (throw-balloon pr xpos ypos)
  (if (zero? (pair-balloon# pr))
      pr
      (make-pair (sub1 (pair-balloon# pr))
                 (cons (make-posn xpos ypos) (pair-lob pr)))))


;; Pair -> Pair
;; on-tock handler, creates a new balloon and trows it at a random location
;; xpos and ypos are at increments of 10

(define (make-balloon pr)
  (throw-balloon pr (* 10 (random COLS)) (* 10 (random ROWS))))


;;;;;;;;;;;;;;;;;;;;;;;;
;; main program
;; run with (riot (make-pair 10 '()))
;; where number can be any positive number

; Pair -> Pair
(define (riot pr)
  (big-bang pr
    [on-tick make-balloon 1.0]
    [to-draw add-balloons]))
