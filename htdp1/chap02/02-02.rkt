;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.2  Variables and Programs


(define (area-of-disk r)
  (* 3.14 (* r r)))

;; function application acts like a form of algerbra

;; APPLY area-of-disk to 5
(area-of-disk 5)
(* 3.14 (* 5 5))  ; substitute body
(* 3.14 25)       ; simplify
78.5

;; programs can consume more than one output:
(define (area-of-ring outer inner)
  (- (area-of-disk outer)
     (area-of-disk inner)))

(area-of-ring 5 3)

(- (area-of-disk 5)
   (area-of-disk 3))

(- (* 3.14 (* 5 5))
   (* 3.14 (* 3 3)))

50.24

;; Exercise 2.2.1.
;; Define the program Fahrenheit->Celsius, which consumes a temperature measured in
;; Fahrenheit and produces the Celsius equivalent.

(define (fahrenheit->celsius f)
  (* 5/9 (- f 32)))

(fahrenheit->celsius 32) "should be" 0
(fahrenheit->celsius 212) "should be" 100
(fahrenheit->celsius -40) "should be" -40

;; Exercise 2.2.2.
;; Define the program dollar->euro, which consumes a number of dollars and produces the euro equivalent.
;; Use the currency table in the newspaper to look up the current exchange rate.

;; 1 euro = 1.12 dollars  25/6/1015

(define (dollar->euro d)
  (* 1.12 d))

(dollar->euro 0)    ;> 0
(dollar->euro 10.0) ;> 11.20


;; Exercise 2.2.3.
;; Define the program triangle. It consumes the length of a triangle's side and the perpendicular height.
;; The program produces the area of the triangle.
;; 1/2 * B * H

(define (triangle b h)
  (* 1/2 b h))

(triangle 10 20)  ;> 100
(triangle 10 5)   ;> 25


;; Exercise 2.2.4.
;; Define the program convert3. It consumes three digits, starting with the least significant digit,
;; followed by the next most significant one, and so on. The program produces the corresponding number. For example,
;; the expected value of
;; (convert3 1 2 3)
;; is 321. Use an algebra book to find out how such a conversion works

(define (convert3 x y z)
  (+ (* 100 z) (* 10 y) x))

(convert3 1 2 3) ;> 321


;; Exercise 2.2.5.
;; A typical exercise in an algebra book asks the reader to evaluate an expression like 

;;  n/3 + 2

;; for n = 2, n = 5, and n = 9. Using Scheme, we can formulate such an expression as a program
;; and use the program as many times as necessary. Here is the program that corresponds to the above expression: 

(define (f n)
  (+ (/ n 3) 2))


;; First determine the result of the expression at n = 2, n = 5, and n = 9 by hand, then with DrScheme's stepper.

(f 2)  ;> 8/3
(f 3)  ;> 3
(f 9)  ;> 5

;; Also formulate the following three expressions as programs:

;; 1.   n2 + 10

(define (g n)
  (+ (sqr n) 10))

(g 2)  ;> 14
(g 9)  ;> 91

;; 2.  (1/2) · n2 + 20

(define (h n)
  (+ (* 1/2 (sqr n)) 20))

(h 2) ;> 22
(h 9) ;> 121/2


;; 3.  2 - (1/n)

(define (i n)
  (- 2 (/ 1 n)))

(i 2)  ;>  3/2
(i 9)  ;>  17/9

;; Determine their results for n = 2 and n = 9 by hand and with DrScheme.
