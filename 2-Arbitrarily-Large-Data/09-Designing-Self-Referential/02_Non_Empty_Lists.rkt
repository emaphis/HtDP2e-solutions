;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_02_non_empty_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.2 Non-empty Lists
;; Exercises: 143-148


; A List-of-temperatures is one of:
; – '()
; – (cons CTemperature List-of-temperatures)

; A CTemperature is a Number greater than -273.


; List-of-temperatures -> Number
; computes the average temperature
(check-expect (average (cons 3 '())) 3)
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (average alot)
  (/ (sum alot) (how-many alot)))

; List-of-temperatures -> Number
; adds up the temperatures on the given list
(check-expect (sum (cons 3 '())) 3)
(check-expect
  (sum (cons 1 (cons 2 (cons 3 '())))) 6)

(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number
; counts the temperatures on the given list
(check-expect (how-many (cons 3 '())) 1)
(check-expect
  (how-many (cons 1 (cons 2 (cons 3 '())))) 3)

(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ 1 (how-many (rest alot)))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 143:
;; Determine how average behaves in DrRacket when applied to the empty list.
;; Then design checked-average, a function that produces an informative error
;; message when it is applied to '().

;; You have division by zero on empty List-of-temperaturs becuase the how-many
;; function yields the base case: 0
;> (average '())
;/: division by zero

; List-of-temperatures -> Number
; computes the average temperature
(check-expect (checked-average (cons 3 '())) 3)
(check-expect
  (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error (checked-average '()))

(define (checked-average alot)
  (cond
    [(empty? alot)
     (error "List of temperatures must have at least one temperature")]
    [else (average alot)]))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aternative implementation

;; average temperture should only take lista of at least one member

; A NEList-of-temperatures is one of:
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures


; NEList-of-temperatures -> Number
; computes the average temperature

(check-expect (average-n (cons 1 (cons 2 (cons 3 '()))))
              2)

(define (average-n ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))


;;;;;;;;;;;;;
;; Ex. 144:
;; Will sum and how-many work for NEList-of-temperatures even though they are
;; designed for inputs from List-of-temperatures? If you think they don’t work,
;; provide counter-examples. If you think they would, explain why.

; They will work, NEList-of-temperatures is a subset of List-of-temperaturs, so
; every item in NELOT has a corresponding item in LOT


;;;;;;;;;;;;;;;;;;;;;;

; a test for a list of one item:
; (empty? (rest list))

; else -- (cons? (rest list))

; NEList-of-temperatures -> Number
; computes the sum of the given temperatures
(check-expect
  (sum-n (cons 1 (cons 2 (cons 3 '())))) 6)

;(define (sum-n ne-l) 0)

#; ;NEList-of-temperatures -> Number
(define (sum-n ne-l)
  (cond
    [(empty? (rest ne-l)) (... (first ne-l) ...)]
    [else ... (first ne-l) ... (rest ne-l) ...]))

; explain why the first clause does not contain the selector
; expression (rest ne-l):
; (first (rest ne-)) returns the second item in the list. We need to access the
; first item.


;; Self reference:
#;
(define (sum-n ne-l)
  (cond
    [(empty? (rest ne-l)) (... (first ne-l) ...)]
    [else
     (... (first ne-l) ... (sum-n (rest ne-l)) ...)]))

(define (sum-n ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum-n (rest ne-l)))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex> 145:
;; Design sorted>?. The function consumes a NEList-of-temperatures. It produces
;; #true if the temperatures are sorted in descending order, that is, if the
;; second is smaller than the first, the third smaller than the second, and
;; so on. Otherwise it produces #false.

;; NEList-of-temperatures -> Boolean
;; produce #true is NEList-of-temperatures is sorted in desending order

(check-expect (sorted>? (cons 3 '())) #true)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(check-expect (sorted>? (cons 3 (cons 2 '()))) #true)
(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) #false)

;                                       (sort>?)       (sorted>?
;   l         (first l)     (rest l)      (rest l))      l)
;-------------------------------------------------------------
; (cons 1
;    (cons 2     1          (cons 2        #true        #false
;       '()))                 '())
; (cons 3
;   (cons 2       3         (cons 2        #true        #true
;      '()))                  '())
; (cons 0
;   (cons 3       0         (cons 3        #true        #false
;     (cons 2                 (cons 2
;       '()))                   '()))

(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else
     (and (> (first ne-l) (first (rest ne-l)))
          (sorted>? (rest ne-l)))]))


;; Ex. 146:
;; Design how-many for NEList-of-temperatures. Doing so completes average, so
;; ensure that average passes all of its tests, too.

; List-of-temperatures -> Number
; counts the temperatures on the given list
(check-expect (how-many-n (cons 3 '())) 1) ;base case
(check-expect
  (how-many-n (cons 1 (cons 2 (cons 3 '())))) 3)

#; ; template
(define (how-many-n ne-l)
  (cond
    [(empty? (rest ne-l)) (... (first ne-l) ...)]
    [else
     (... (first ne-l) ... (sum-n (rest ne-l)) ...)]))

; (first ne-1) represents 1

(define (how-many-n ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else
     (+ 1 (how-many-n (rest ne-l)))]))

; NEList-of-temperatures -> Number
; computes the average temperature
(check-expect (average-n2 (cons 3 '()))
              3)
(check-expect (average-n2 (cons 1 (cons 2 (cons 3 '()))))
              2)

(define (average-n2 ne-l)
  (/ (sum-n ne-l) ; see above
     (how-many-n ne-l)))


;; Ex. 147
;; Develop a data definition for NEList-of-Booleans, a representation of
;; non-empty lists of Boolean values. Then re-design the functions all-true
;; and one-true from exercise 140.

; A NEList-of-Booleans is one of:
; – (cons Boolean '())
; – (cons Booleans NEList-of-temperatures)
; interpretation non-empty list of Booleans

(define LOB2 (cons #true '())) ;base case
(define LOB3 (cons #false '())) ;base case
(define LOB4 (cons #true (cons #false '())))
(define LOB5 (cons #false (cons #true (cons #true '()))))

#; ; template for nlob
(define (fun-for-nlob nlob)
  (cond [(empty? (rest nlob)) (... (first nlob))]
        [else
         (... (first nlob) ...
              (fun-for-nlob (rest nlob)) ....)]))


;; NEList-of-Booleans -> Boolean
;; produce #true if a list contains all #true, #false otherwise

(check-expect (all-true? (cons #true '())) #true)
(check-expect (all-true? (cons #true (cons #true '()))) #true)
(check-expect (all-true? (cons #true (cons #false '()))) #false)
(check-expect (all-true? (cons #false (cons #true '()))) #false)

(define (all-true? nlob)
  (cond [(empty? (rest nlob)) (first nlob)]
        [else
         (and (first nlob)
              (all-true? (rest nlob)))]))

;; List-of-booleans -> Boolean
;; return #true if at least one item in a lob is #true

(check-expect (one-true? (cons #false '())) #false)
(check-expect (one-true? (cons #true '())) #true)
(check-expect (one-true? (cons #false (cons #false '()))) #false)
(check-expect (one-true? (cons #false (cons #true '()))) #true)

(define (one-true? nlob)
  (cond [(empty? (rest nlob)) (first nlob)]
        [else
         (or (first nlob)
             (one-true? (rest nlob)))]))


;; Ex. 148:
;; Compare the function definitions from this section (sum, how-many, all-true,
;; one-true) with the corresponding function definitions from the preceding
;; sections. Is it better to work with data definitions that accommodate empty
;; lists as opposed to definitions for non-empty lists? Why? Why not?

; I think it's easier to work with lists that can be empty. The templates are
; simpler and the base case and the combining funtions are much easier to
; reason about.
