;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04-02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 4.2  Functions that Test Conditions

;; is-5? : number  ->  boolean
;; to determine whether n is equal to 5
(define (is-5? n)
  (= n 5))

;; is-between-5-6? : number  ->  boolean
;; to determine whether n is between 5 and 6 (exclusive)
(define (is-between-5-6? n)
  (and (< 5 n) (< n 6)))

;; Interval Boundaries:
;; An interval boundary marked with ``('' or ``)'' is excluded from the interval
;; an interval boundary marked with ``['' or ``]'' is included.

;; is-between-5-6-or-over-10? : number  ->  boolean  to determine whether n is
;; between 5 and 6 (exclusive) or larger than or equal to 10
(define (is-between-5-6-or-over-10? n)
  (or (is-between-5-6? n) (>= n 10)))


;; Exercise 4.2.1.
;; Translate the following five intervals on the real line into Scheme functions
;; that accept a number and return true if the number is in the interval and
;; false if it is outside:

;; 1 1.the interval (3,7]:

;; interval-1 : Number -> Boolean
;; determines if n is in the interval (3,7]
(define (interval-1 num)
  (and (> num 3) (<= num 7)))

(check-expect (interval-1 -1) #false)
(check-expect (interval-1  3) #false)
(check-expect (interval-1  5) #true)
(check-expect (interval-1  7) #true)
(check-expect (interval-1 10) #false)


;; 2.the interval [3,7]:

;; interval-2 : Number -> Boolean
;; determines if n is in the interval [3,7]
(define (interval-2 num)
  (and (>= num 3) (<= num 7)))

(check-expect (interval-2 -1) #false)
(check-expect (interval-2  3) #true)
(check-expect (interval-2  5) #true)
(check-expect (interval-2  7) #true)
(check-expect (interval-2 10) #false)

;; 3.the interval [3,9):

;; interval-3 : Number -> Boolean
;; determines if n is in the interval [3,9)
(define (interval-3 num)
  (and (>= num 3) (< num 9)))

(check-expect (interval-3 -1) #false)
(check-expect (interval-3  3) #true)
(check-expect (interval-3  5) #true)
(check-expect (interval-3  9) #false)
(check-expect (interval-3 10) #false)

;; 4.the union of (1,3) and (9,11):

;; interval-4 : Number -> Boolean
;; determines .the union of (1,3) and (9,11)
(define (interval-4 num)
  (or (and (> num 1) (< num 3))
      (and (> num 9) (< num 11))))

(check-expect (interval-4 -1) #false)
(check-expect (interval-4  2) #true)
(check-expect (interval-4  3) #false)
(check-expect (interval-4  9) #false)
(check-expect (interval-4 10) #true)
(check-expect (interval-4 11) #false)

;; 5.and the range of numbers outside of [1,3].

;; interval-5 : Number -> Boolean
;; determines if in the range of numbers outside of [1,3]
(define (interval-5 num)
  (or (< num 1) (> num 3)))

(check-expect (interval-5 -1) #true)
(check-expect (interval-5  3) #false)
(check-expect (interval-5  5) #true)
(check-expect (interval-5  9) #true)


;; Exercise 4.2.2.
;; Translate the following three Scheme functions into intervals on
;; the line of reals:

;; in-interval-1? : Number -> Boolean
;; Produces true if num is < -3 and num is < 0
;; (-3, 0)
(define (in-interval-1? x)
  (and (< -3 x) (< x 0)))

;; in-interval-2? : Number -> Boolean
;; Produces true if num is < 1 or num > 2
;; (...1) or (2...)
(define (in-interval-2? x)
  (or (< x 1) (> x 2)))

;; in-interval-3? : Number -> Boolean
;; produce true if greater or equal to 1
;; (...1) or (5...)
(define (in-interval-3? x)
  (not (and (<= 1 x) (<= x 5))))

;; Also formulate contracts and purpose statements for the three
;; functions.

;; Evaluate the following expressions by hand:

;; 1.(in-interval-1? -2)
(in-interval-1? -2)
(and (< -3 -2) (< -2 0))
(and true (< -2 0))
(< -2 8)
true

;; 2.(in-interval-2? -2)
(in-interval-2? -2)
(or (< -2 1) (> -2 2))
(or true (> -2 2))
true

;; 3.(in-interval-3? -2)
(in-interval-3? -2)
(not (and (<= 1 -2) (<= -2 5)))
(not (and false (<= -2 5)))
(not false)
true

;; Show the important steps. Use the pictures to check your results



;; Exercise 4.2.3.  representations of quadratic equations

;; equation-1 : Number -> Boolean
;; determines if n satisfies equation #1
(define (equation-1 n)
  (= (+ (* 4 n) 2)
     62))

(check-expect (equation-1 10) false)
(check-expect (equation-1 12) false)
(check-expect (equation-1 14) false)

;; equation-2 : Number -> Boolean
;; determines if n satisfies equation #2
(define (equation-2 n)
  (= (* 2 (* n n))
     102))

(check-expect (equation-2 10) false)
(check-expect (equation-2 12) false)
(check-expect (equation-2 14) false)

;; equation-3 : number -> boolean
;; determines if n satisfies equation #3
(define (equation-3 n)
  (= (+ (* 4 (* n n)) (* 6 n) 2)
     462))

(check-expect (equation-3 10) true)
(check-expect (equation-3 12) false)
(check-expect (equation-3 14) false)


;;;;;;;;;;;;;
;; Exercise 4.2.4.  using equations to test

;; 2.2.1.

;; fahrenheit->celsius :  Number -> Number
;; produces celsius given fahrenheit
(define (fahrenheit->celsius f)
  (* 5/9 (- f 32)))

(check-expect (= (fahrenheit->celsius  32)   0) true)
(check-expect (= (fahrenheit->celsius 212) 100) true)
(check-expect (= (fahrenheit->celsius -40) -40) true)

;; 2.2.2.
;; dollar->euro : Number -> Number
;; produces value in euros given value in dollars
;; 1 euro = 1.12 dollars  25/6/1015
(define (dollar->euro d)
  (* 1.12 d))

(check-expect (= (dollar->euro 0)     0)    true)
(check-expect (= (dollar->euro 10.0) 11.20) true)


;; 2.2.3.
;; triangle: Number Number -> Number
;; produeces area of a triangle given base and height
(define (triangle b h)
  (* 1/2 b h))

(check-expect (= (triangle 10 20) 100) true)
(check-expect (= (triangle 10 5)   25) true)
