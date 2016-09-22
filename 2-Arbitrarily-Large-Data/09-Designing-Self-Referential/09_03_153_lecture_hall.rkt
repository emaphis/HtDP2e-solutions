;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_03_153_lecture_hall) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.3 Natural Numbers
;; Exercises: 153

;; Ex. 153:
;; The goal of this exercise is to visualizes the result of a 1968-style
;; European student riot. Here is the rough idea. A small group of students
;; meets to make paint-filled balloons, enters some lecture hall and randomly
;; throws the balloons at the attendees. Your world program displays how the
;; balloons color the seats in the lecture hall.

;; Use the two functions from exercise 152 to create a rectangle of 8 by 18
;; squares, each of which has size 10 by 10. Place it in an empty-scene of the
;; same size. This image is your lecture hall.

;; Design add-balloons. The function consumes a list of Posn whose coordinates
;; fit into the dimensions of the lecture hall. It produces an image of the
;; lecture hall with red dots added as specified by the Posns.

(require 2htdp/image)

;; functions from 152:

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

(define BACKGROUND (empty-scene (* CELL-SIZE COLS) (* CELL-SIZE ROWS) "white"))

;; row of CELLs COLS long
(define ROW (row COLS CELL))

;; column of ROWs, ROWS high
(define COL (col ROWS ROW))

(define HALL
  (place-image COL
               (/ (image-width BACKGROUND) 2)
               (/ (image-height BACKGROUND) 2)
               BACKGROUND))

;; Data:

;; List-of-Posns is one of
;; - '()
;; - (cons Posn '())

(define NONE '())
(define ONE (cons (make-posn 10 10) '()))
(define THREE (cons (make-posn 0 0)
                    (cons (make-posn 10 10)
                          (cons (make-posn 20 20) '()))))


;; Functions

;; List-of-Posns -> Image
;; place PAINT images at Posn locations given a List-of-Posns
(check-expect (add-balloons '())
              HALL)

(check-expect (add-balloons (cons (make-posn 10 10) '()))
              (place-image BALLOON 10 10
                           HALL))

(check-expect (add-balloons (cons (make-posn 10 10)
                                  (cons (make-posn 20 20)
                                        (cons (make-posn 30 30) '()))))
             (place-image BALLOON 10 10
                          (place-image BALLOON 20 20
                                       (place-image BALLOON 30 30
                                                    HALL))))

;(define (add-balloons lop) empty-image)

(define (add-balloons lop)
  (cond [(empty? lop) HALL]
        [else
         (place-image BALLOON
                      (posn-x (first lop))
                      (posn-y (first lop))
                      (add-balloons (rest lop)))]))

;;;;;;;;;
;; the final example image
(define FINAL-IMAGE
  (add-balloons   (cons (make-posn 0 0)
                      (cons (make-posn 10 20)
                            (cons (make-posn 20 40)
                                  (cons (make-posn 30 60)
                                        (cons (make-posn 40 80)
                                              (cons (make-posn 50 100)
                                                    (cons (make-posn 60 120)
                                                          (cons (make-posn 70 140)
                                                                '()))))))))))