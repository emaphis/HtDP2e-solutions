;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intermezzo-BSL) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; Intermezzo - BSL
;; Exercise: 116-128


;; BSL has a grammer similar to english, every senence is a expression or a
;; definition,

;; syntax are how programs are constructed, semantics are what programs mean
;; not a correct BSL sentences have meaning or are correct.


;;;;;;;;;;;;;;;;;;;;
;; BSL Vocabulary

; primatives - name with build in meaning

; variable - a defined name.

; value:
;  - number, boolean, string, image


;;;;;;;;;;;;;;
;; BSL Grammer

; = introduces a syntactic category; (is one of)

; | - (or)

; ... - many repetitions


; program  =  def-expr ...

; def-expr =  def
;          |  expr

; def      =  (define (variable variable variable ...) expr)

; expr     =  variable
;          | value
;          |  (primitive expr expr ...)
;          |  (variable expr expr ...)
;          |  (cond [expr expr] ... [expr expr])
;          |  (cond [expr expr] ... [else expr])


;;;;;;;;;;;;;
;; Ex. 116;
;; Take a look at the following sentences:

;    x
; legal variable expression

;    (= y z)
; legal primative application to two variables:  (primitive expr expr)

;    (= (= y z) 0)
; a primaive applications to a expression that is is a primative applications to
; tow variable epxressions and a variable expression: (primitive expr expr)
; where (= y z) is also: (primitive expr expr)


;; Ex. 117
;; Consider the following sentences:

;    (3 + 4)
; the primative must be first in a primative all.

;    number?
; a primative call must be in paranteses and paramters

;    (x)
; a variable call must have one or more parameters

;; Explain why they are syntactically illegal.


;; Ex. 118:
;; Take a look at the following sentences:

;    (define (f x) x)
; it is a 'def' with three variables
; (define (variable variable variable ...) expr)

;    (define (f x) y)
; same: legal: (define (variable variable variable ...) expr)

;    (define (f x y) 3)
; same: legal - (define (variable variable variable ...) expr)

;; Explain why they are syntactically legal definitions


;; Ex. 119:
;;  Consider the following sentences:
;; Explain why they are syntactically illegal.

;    (define (f "x") x)
; "x" is not a variable but a constant
; (define (variable variable variable ...) expr)

;    (define (f x y z) (x))
; 'x' must have parameters ot be leagal
; (variable expr expr ...)


;; Ex. 120:
;;  Discriminate the legal from the illegal sentences:
;; Explain why the sentences are legal or illegal. Determine whether the legal
;; ones belong to the category expr or def
;    (x)
; illegal - (variable expr expr ...)

;    (+ 1 (not x))
;  illegal (not x) is boolean, and 1 is number

;    (+ 1 2 3)
; legal - (primative expr expr ...)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BSL Meaning

;; BSL replaces equals with equals (arithmetic):

;; example:
(boolean? (= (string-length (string-append "h" "w"))
          (+ 1 3)))
;==
(boolean? (= (string-length (string-append "h" "w")) 4))
;==
(boolean? (= (string-length "hw") 4))
;==
(boolean? (= 2 4))
;==
(boolean? #false)
;==
#true

;; BSL replace function call with function bodies (algerbra):
; (beta reduction)
#;
(define (f x-1 ... x-n)
  f-body)

;(f v-1 ... v-n) == f-body
; with all occurrences of x-1 ... x-n 
; replaced with v-1 ... v-n, respectively

;; example:
(define (poly x y)
  (+ (expt 2 x) y))

(poly 3 5)
;==
(+ (expt 2 3) 5)
;... ==
(+ 8 5)
;==
13

;; cond
;; When the first condition is #false, the first cond-line disappears,
;; leaving the rest of the lines intact:

(cond
  [(zero? 3) 1]
  [(= 3 3) (+ 1 1)]
  [else 3])
;== ; by plain arithmetic and “equals for equals”
(cond
  [#false 1]
  [(= 3 3) (+ 1 1)]
  [else 3])
;== ; by rule condfalse
(cond
  [(= 3 3) (+ 1 1)]
  [else 3])
;== ; by plain arithmetic and “equals for equals”
(cond
  [#true (+ 1 1)]
  [else 3])
;== ; by rule condtrue
(+ 1 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 121:
;; Evaluate the following expressions step by step:
;; Use DrRacket’s stepper to confirm your computations.

(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))
;==
(+ (* 3/2 2/3)
   (- 20 (sqrt 4)))
;==
(+ 1 (- 20 (sqrt 4)))
;==
(+ 1 (- 20 2))
;==
(+ 1 18)
;==
19
;; confirmed


(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/  1 0) 9)])
;==
(cond
  [#true #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/  1 0) 9)])
;==
#false
;; confirmed


(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/  1 2) 9)])
;==
(cond
  [#false #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/  1 2) 9)])
;==
(cond
  [(> 2 1) (string=? "a" "a")]
  [else (= (/  1 2) 9)])
;==
(cond
  [#true (string=? "a" "a")]
  [else (= (/  1 2) 9)])
;==
(string=? "a" "a")
;==
#true
;; confirmed


;; Ex. 122:
;;  Suppose the program contains these definitions:

(define (f x y)
  (+ (* 3 x) (* y y)))

; Show how DrRacket evaluates the following expressions, step by step:

(+ (f 1 2) (f 2 1))
;==
(+ (+ (* 3 1) (* 2 3)) (f 2 1))
;==
(+ (+ 3 (* 2 2)) (f 2 1))
;==
(+ (+ 3 4) (f 2 1))
;==
(+ 7 (f 2 1))
;==
(+ 7 (+ (* 3 2) (* 1 1)))
;==
(+ 7 (+ 6 (* 1 1)))
;==
(+ 7 (+ 6 1))
;==
(+ 7 7)
;==
14
;; cofirned



(f 1 (* 2 3))
;==
(f 1 6)
;==
(+ (* 3 1) (* 6 6))
;==
(+ 3 (* 6 6))
;==
(+ 3 36)
;==
39
;; confirmed


(f (f 1 (* 2 3)) 19)
;==
(f (f 1 6) 19)
;==
(f (+ (* 3 1) (* 6 6)) 19)
;==
(f (+ 3 (* 6 6)) 19)
;==
(f (+ 3 36) 19)
;==
(f 39 19)
;==
(+ (* 3 39) (* 19 19))
;==
(+ 117 (* 19 19))
;==
(+ 117 361)
;==
478
;; confirmed


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Meaning and Computing

;; stepper works like an extremly fast pre-algerbra student

;; place the expression to be evaluated at the before any thin else
;; in the buffer


;;;;;;;;;;;;;;;;;;;;;;;
;; BSL Errors

;; Sytax errors  are errors that doen't conform to BSL grammer
;; Runtime error are errors that are problems with a programs meaning
;; or symamtics

; sytax is good but this is not a value:
; > (/ 1 0)
; /: division by zero

; BSL evalueates until it finds an error
;(+ (* 20 2) (/ 1 (- 10 10)))
;==
;(+ (* 20 2) (/ 1 0))
;==
;(+ 40 (/ 1 0))

; so BSL loses context when it find an error


;; not all incorrect evals lead to an error

(define (my-divide n)
  (cond
    [(= n 0) "inf"]
    [else (/ 1 n)]))

(my-divide 0)
;==
(cond
  [(= 0 0) "inf"]
  [else (/ 1 0)])
;==
(cond
  [#true "inf"]
  [else (/ 1 0)])
;==
"inf"

;; defensive programming

;; ** Always choose the outermost and left-most nested expression that is
;; ready for evaluation. **



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Boolean Expressions

; expr  = ...
;       | (and expr expr)
;       | (or expr expr)

;;  'and' and 'or'- are keywords, each followed by two expressions.
;; They are 'not' function applications.

;  formulate a condition that determines whether (/ 1 n) is r: 
(define (check n r)
  (and (not (= n 0)) (= (/ 1 n) r)))

(check 0 1/5)
;==
(and (not (= 0 0)) (= (/ 1 0) 1/5))
;==
(and (not #true) (= (/ 1 0) 1/5))
;==
(and #false (= (/ 1 0) 1/5)) ; short circuit
;==
#false


; (and exp1 exp2)
; ==
;(cond
;  [exp1 exp2]
;  [else exp2])

; (or exp1 exp2)
;==
;(cond
;  [exp1 #true]
;  [else exp2])


;;;;;;;;;;;;;;;;;;
;; Ex. 123:
;; The use of if may have surprised you in another way because this intermezzo
;; does not mention this form elsewhere. In short, the intermezzo appears to
;; explain and with a form that has no explanation either. At this point, we
;; are relying on your intuitive understanding of if as a short-hand for cond.
;; Write down a rule that shows how to reformulate

;(if exp-test exp-then exp-else)
;==
;(cond
;  [exp-test exp-then]
;  [else exp-else])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Constant Definitions

; definition = ...
;            | (define name expr)

(define RADIUS 5)
(define DIAMETER (* 2 RADIUS))
; (define DIAMETER 10)

(define (area r) (* 3.14 (* r r)))

(define AREA-OF-RADIUS (area RADIUS))
;(define AREA-OF-RADIuS 78.5)


;;;;;;;;;;;;;;;;;;;
;; Ex. 124
;; Evaluate the following program, step by step:

;(define PRICE 5)
;(define SALES-TAX (* 0.08 PRICE))
;(define TOTAL (+ PRICE SALES-TAX))

; (define PRICE 5)

; (define SALES-TAX (* 0.08 PRICE))
; (define SALES-TAX 0.4)

; (define TOTAL (* PRICE SALES-TAX))
; (define TOTAL (+ 5 SALES-TAX))
; (define TOTAL (+ 5 0.4))
; (define TOTAL 5.4)

;; Does the evaluation of the following program signal an error?

;(define COLD-F 32)
;(define COLD-C (fahrenheit->celsius COLD-F))
;(define (fahrenheit->celsius f)
;  (* 5/9 (- f 32)))
;== 0
; No, its fine


;How about the next one?

;(define LEFT -100)
;(define RIGHT 100)
;(define (f x) (+ (* 5 (expt x 2)) 10))
;(define f@LEFT (f LEFT))
;(define f@RIGHT (f RIGHT))
;==
;(define (f x) (+ (* 5 (exp x e)) 10))
;(define f@LEFT (f -100))
;==
;(define f@LEFT
;  (+ (* 5 (expt -100 2)) 10))
;==
;(define f@LEFT (+ (* 5 10000) 10))
;==
;(define f@LEFT (+ 50000 10))
;==
;(define f@LEFT 50010)
;==
;(define f@LEFT 50010)
;(define f@RIGHT (f 100))
;==
;(define f@LEFT 50010)
;(define f@RIGHT
;  (+ (* 5 (expt 100 2)) 10))
;==
;(define f@LEFT 50010)
;(define f@RIGHT (+ (* 5 10000) 10))
;==
;(define f@LEFT 50010)
;(define f@RIGHT (+ 50000 10))
;==
;(define f@LEFT 50010)
;(define f@RIGHT 50010)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Structure Type Definitions

;definition   =  ...
;             |  (define-struct name [name ...])

;; example

(define-struct point [x y z])

;; illegal:
;(define-struct [point x y z]) ; not followed by a variable name
;(define-struct point x y z)  ; not followed by a sequence of variable names

;; a define-struct definition defines several functions at once: a constructor,
;; several selectors, and a predicate.

;     (define-struct c [s-1 ... s-n])

; produces:

;    make-c: a constructor;

;    c-s-1... c-s-n: a series of selectors; and

;    c?: a predicate.

; equations characterizing the relationship between the data constructor
; and the selectors

;(c-s-1 (make-c V-1 ... V-n)) == V-1
;(c-s-n (make-c V-1 ... V-n)) == V-n

; equations for pedicates and constructors:

;(c? (make-c V-1 ... V-n)) == #true
;(c? V)                    == #false


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 125: Discriminate the legal from the illegal sentences:

(define-struct oops [])
; legal: (define-struct name [name ...])

(define-struct child [parents dob date])
; legal: (define-struct name [name ...])

;(define-struct (child person) [dob date])
; illegal: first item should be a variable name


;; Ex 126:
;; Identify the values among the following expressions, assuming the
;; definitions area contains these structure type definitions:
;; Explain why the expressions are values or not. image

(define-struct point1 [x y z])
(define-struct none  [])

(make-point1 1 2 3)
; x == 1, y == 2, z == 3

(make-point1 (make-point 1 2 3) 4 5)
; x == (make-point 11 2 3), y == 4, z == 5
; (point1-x (make-point1 1 2 3) == 1
; (point1-y (make-point1 1 2 3) == 2
; (point1-z (make-point1 1 2 3) == 3

(make-point1 (+ 1 2) 3 4)
; x == 3, y == 3, z == 4

(make-none)
; (make-none)

(make-point (point-x (make-point 1 2 3)) 4 5)
; x == 1, y == 4, z == 5


;; Ex. 127:
;;  Suppose the program contains

(define-struct ball [x y speed-x speed-y])

;; Predict the results of evaluating the following expression:

(number? (make-ball 1 2 3 4))
; #false

(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 3

(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 6

;(ball-x (make-posn 1 2))
; error

;(ball-speed-y 5)
; error

;; Check your predictions in the interactions area and with the stepper.


;;;;;;;;;;;;;;;;;;;
;; BSL Tests

;; BSL testing forms

;    check-expect
;    check-within,
;    check-member-of
;    check-range
;    check-error
;    check-random
;    check-satisfied


;; BSL grammer:

; def-expr   =  definition
;            |  expr
;            |  test-case
;
; definition =  (define (name variable variable ...) expr)
;            |  (define name expr)
;            |  (define-struct name [name ...])
;
; expr       =  (name expr expr ...)
;            |  (cond [expr expr] ... [expr expr])
;            |  (cond [expr expr] ... [else expr])
;            |  (and expr expr expr ...)
;            |  (or expr expr expr ...)
;            |  name
;            |  number
;            |  string
;            |  image

; test-case  =  (check-expect expr expr)
;            |  (check-within expr expr expr)
;            |  (check-member-of expr expr ...)
;            |  (check-range expr expr expr)
;            |  (check-error expr)
;            |  (check-random expr expr)
;            |  (check-satisfied expr name)


;; some examples of test expressions

; check-expect compares the outcome and the expected value with equal?
(check-expect 3 3)

; check-member-of compares the outcome and the expected values with equal?
; if one of them yields #true, the test succeeds
(check-member-of "green" "red" "yellow" "green")

; check-within compares the outcome and the expected value with a predicate
;  like equal? but allows for a tolerance of epsilon for each inexact number
(check-within (make-posn #i1.0 #i1.1) (make-posn #i0.9 #i1.2) 0.2)

; check-range is like check-within
; but allows for a specification of an interval
(check-range 0.9 #i0.6 #i1.0)

; check-error checks whether an expression signals (any) error
(check-error (/ 1 0))

; check-random evaluates the sequences of calls to random in the
; two expressions such that they yield the same number
(check-random (make-posn (random 3) (random 9))
              (make-posn (random 3) (random 9)))

; check-satisfied determines whether a predicate produces #true
; when applied to the outcome, that is, whether outcome has a certain property
(check-satisfied 4 even?)


;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 128:
;; Copy the following tests into DrRacket’s definitions area:

;(check-expect 3 4)
; (equal? 3 4) is false

;(check-member-of "green" "red" "yellow" "grey")
; 'green' does not 'equal?' "red" "yellow" "grey"

;(check-within (make-posn #i1.0 #i1.1)
;              (make-posn #i0.9 #i1.2)
;              0.01)
; the posn's aren't within the epsilon value of 0.01

;(check-range #i0.9 #i0.6 #i0.8)
; 0.9 is outside the range 0f [0.6, 0.8]

;(check-error (/ 1 1))
; (/ 1 1) doesn't evaluate to an error

;(check-random (make-posn (random 3) (random 9))
;              (make-posn (random 9) (random 3)))
; the random test failed: (make-posn 0 2) != (make-posn 10)

;(check-satisfied 4 odd?)
; 4 is not odd?

; Validate that all of them fail and explain why. image


;;;;;;;;;;;;;;;;;;;;;;;
;; BSL Error Messages

;(define (absolute n)
;  (cond
;    [< 0 (- n)]
;    [else n]))

; <: expected a function call, but there is no open parenthesis before
; this function


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Error Messages about Function Applications in BSL


; Number Number -> Number
; find the average of x and y
(define (average x y)
  (/ (+ x y)
     2))

;; given the definition above

;> (g 1)
; g: this function is not defined

;> (1 3 "three" #true)
;function call: expected a function after the open parenthesis, but found
;a number

;> (average 7)
;average: expects 2 arguments, but found only 1

;> (average 1 2 3)
;average: expects only 2 arguments, but found 3

;> (make-posn 1)
;make-posn: expects 2 arguments, but found only 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Error Messages about Wrong Data in BSL

; Number Number -> Number
; find the average of x and y
;(define (average x y) ...)

;> (posn-x #true)
;posn-x: expects a posn, given #true

;> (average "one" "two")
;+: expects a number as 1st argument, given "one"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Error Message about Conditonals in BSL

; N in [0,1,...10)
(define 0-to-9 (random 10))

;> (cond
;    [(>= 0-to-9 5)])
;cond: expected a clause with a question and an answer, but found a clause
;with only one part

;> (cond
;    [(>= 0-to-9 5)
;     "head"
;     "tail"])
;cond: expected a clause with a question and an answer, but found a clause
;with 3 parts

;> (cond)
;cond: expected a clause after cond, but nothing's there


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Error Messages about Funtion Definitons in BSL

;> (define f(x) x)
;define: expected only one expression after the variable name f, but found
;1 extra part

;(define (f x x) x)
;define: found a variable that is used more than once: x

;(define (g) x)
;define: expected at least one variable after the function name, but found none

;(define (f x x) x)
;define: found a variable that is used more than once: x

;(define (f (x)) x)
;define: expected a variable, but found a part

;(define (h x y) x y)
;define: expected only one expression for the function body, but found 1 extra
;part


;; Error Message about Structer Type Deinitons in BSL

;(define-struct [x])
;(define-struct [x y])
;define-struct: expected the structure name after define-struct,
;but found a part

;(define-struct x
;  [y y])
;define-struct: found a field name that is used more than once: y

;(define-struct x y)
;(define-struct x y z)
;define-struct: expected at least one field name (in parentheses) after the
;structure name, but found something else

;(define-struct x
;  [(y) z])
;define-struct: expected a field name, but found a part
