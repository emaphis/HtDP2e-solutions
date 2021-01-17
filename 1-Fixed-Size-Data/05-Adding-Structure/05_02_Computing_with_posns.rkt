;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_02_Computing_with_posns) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.3 Programming with posn
;; Exercises: 63, 64

;; 5.2 Computing with posns

;; Number Number -> Posn
(make-posn 3 4)

(define one-posn (make-posn 8 6))

;; Selecting components of a posn

(define p (make-posn 31 26))

;(posn-x p) ; 31

;(posn-y p) ; 26

;; posn identities

; (posn-x (make-posn x0 y0)) == x0

; (posn-y (make-posn x0 y0)) == y0


;; 5.3 Programming with posn

;; Now consider designing a function that computes the distance of some
;; location to the origin of the canvas:

; computes the distance of ap to the origin

(check-expect (distance-to-0 (make-posn 0 0)) 0)  ; of course
(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)

(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

;(define (distance-to-0 ap) ; stub
;  0)

#; ; template
(define (fn-for-posn ap)
  (... (posn-x ap) ...
   ... (posn-y ap) ...))

(define (distance-to-0 ap)
  (sqrt
    (+ (sqr (posn-x ap))
       (sqr (posn-y ap)))))

;; Ex. 64:
;; Evaluate the following expressions:

(distance-to-0 (make-posn 3 4))

(sqrt
    (+ (sqr (posn-x (make-posn 3 4)))
       (sqr (posn-y (make-posn 3 4)))))

(sqrt
    (+ (sqr 3)
       (sqr (posn-y (make-posn 3 4)))))

(sqrt (+ 9
       (sqr (posn-y (make-posn 3 4)))))

(sqrt (+ 9
       (sqr 4)))

(sqrt (+ 9 16))

(sqrt 25)

5

(distance-to-0 (make-posn 6 (* 2 4)))


(sqrt
 (+ (sqr (posn-x (make-posn 6 (* 2 4))))
    (sqr (posn-y (make-posn 6 (* 2 4))))))

(sqrt
 (+ (sqr (posn-x (make-posn 6 8)))
    (sqr (posn-y (make-posn 6 (* 2 4))))))

(sqrt
 (+ (sqr 6)
    (sqr (posn-y (make-posn 6 (* 2 4))))))

(sqrt (+ 36  (sqr (posn-y (make-posn 6 (* 2 4))))))

(sqrt (+ 36  (sqr (posn-y (make-posn 6 8)))))

(sqrt (+ 36  (sqr 8)))

(sqrt (+ 36 64))

(sqrt 100)

10


;; Ex. 64:
;; Design the function manhattan-distance, which measures the Manhattan
;; distance of the given posn to the origin.

; Posn -> Number
; produce the 'Manhattan distance' from a given Posn to the Origin
(check-expect (manhattan-distance (make-posn 0 0)) 0)
(check-expect (manhattan-distance (make-posn 5 4)) 9)

;(define (manhattan-distance p) 0) ; stub

(define (manhattan-distance p)
  (+ (posn-x p)
     (posn-y p)))