;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_01_designing_self_ref) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.0 Designing with Self-Referential Data Definitions
;; 9.1 Finger Exercises
;; Exercises: 137-142


;; A List-of-strings is one of
;; - '()
;; - (cons String List-of-strings)

#; ; template
(define (fun-for-los los)
  (cond
    [(empty? los) ...] ; base case
    [else  ; (cons? los)
     (... (first los) ...
          (fun-for-los (rest los)) ...)]))


; List-of-strings -> Number
; count how many strings alos contains

(check-expect (how-many '()) 0)
(check-expect (how-many (cons "a" '())) 1)
(check-expect (how-many (cons "b" (cons "a" '()))) 2)

;(define (how-many alos)
;  0)

(define (how-many los)
  (cond
    [(empty? los) 0] ; base case
    [else
     (+ (how-many (rest los)) 1)]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 9.1 Finger Exercises: Lists

;; Ex. 137:
;; Compare the template for contains-flatt? with the one for how-many.
;; Ignoring the function name, they are the same. Explain the similarity.

#; ; templat for list of names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) ...]
    [(cons? alon)
     (... (first alon)
          ... (conains-flat? (rest alon)) ...)]))

#; ; template
(define (fun-for-los los)
  (cond
    [(empty? los) ...]
    [else  ; (cons? los)
     (... (first los) ...
          (fun-for-los (rest los)) ...)]))

; They are the same because they work on the same shape data. The only real
; differece is the combining function.


;; Ex. 138:
;; Here is a data definition for representing sequences of amounts of money:

; A List-of-amounts is one of:
; – '()
; – (cons PositiveNumber List-of-amounts)

;; Create some examples to make sure you understand the data definition.
;; Also add an arrow for the self-reference.

;; Design the sum function, which consumes a List-of-amounts and computes
;; the sum of the amounts. Use DrRacket’s stepper to see how (sum l) works
;; for a short list l in List-of-amounts.

(define LOA1 '())  ; empty list-of-amounts
(define LOA2 (cons 1 '()))
(define LOA3 (cons 3
                   (cons 2
                         (cons 1 '()))))
#; ; template
(define (fun-for-loa loa)
  (cond
    [(empty? loa) ...]
    [else
     (... (first loa) ...
          (fun-for-loa (rest loa) ...))]))

;; List-of-amouns -> PositveNumber
;; return the sum of a List-of-amounts
(check-expect (sum-loa '()) 0) ;base case
(check-expect (sum-loa (cons 1 '())) 1)
(check-expect (sum-loa (cons 3
                             (cons 2
                                   (cons 1
                                         '()))))
              6)

;(define (sum-loa loa) 0) ; stub

(define (sum-loa loa)
  (cond
    [(empty? loa) 0]
    [else
     (+ (first loa)
        (sum-loa (rest loa)))]))


;; Ex 139:
;; Now take a look at this data definition:

; A List-of-numbers is one of:
; – '()
; – (cons Number List-of-numbers)

;; Some elements of this class of data are appropriate inputs for sum from
;; exercise 138 and some aren’t.

;; Design the function pos?, which consumes a List-of-numbers and determines
;; whether all numbers are positive numbers. In other words, if (pos? l) yields
;; #true, then l is an element of List-of-amounts.
;; Use DrRacket’s stepper to understand how pos? works
;; for (cons 5 '()) and (cons -1 '()).

;; Also design checked-sum. The function consumes a List-of-numbers.
;; It produces their sum if the input also belongs to List-of-amounts;
;; otherwise it signals an error. Hint Recall to use check-error.

;; What does sum compute for an element of List-of-numbers?

; A List-of-numbers is one of:
; – '()
; – (cons Number List-of-numbers)

(define LON1 '())
(define LON2 (cons 5 '()))
(define LON3 (cons -1 '()))

#; ;template
(define (fn-for-lon lon)
  (cond
    [(empty? lon) ...]
    [else
     (... (first lon)
          (fn-for-lon (rest lon)))]))

; List-of-Number -> Boolean
; return #true if List-of-numbers contains all positve numbers
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons 1 (cons -2 '()))) #false)

;(define (pos? loa) #false) ;stub

(define (pos? lon)
  (cond
    [(empty? lon) #true]
    [else
     (and (positive? (first lon))
          (pos? (rest lon)))]))

; List-of-numbers -> Boolean
; return the sum of a list of all postive Numbers, error otherwiase
(check-expect (check-sum '()) 0)
(check-expect (check-sum (cons 1 '())) 1)
(check-expect (check-sum (cons 1 (cons 2 '()))) 3)
(check-error (check-sum (cons 1 (cons -2 '()))))

(define (check-sum lon)
  (cond [(pos? lon) (sum-loa lon)]
        [else
         (error "check-sum must be applied to a list of postive numbers")]))


;; Ex. 140:
;; Design the function all-true, which consumes a list of Boolean values and
;; determines whether all of them are #true. In other words, if there is any
;; #false on the list, the function produces #false.

;; Now design one-true, a function that consumes a list of Boolean values and
;; determines whether at least one item on the list is #true.

; A List-of-Booleans is one of:
; - '()
; - (cons Boolean List-of-Booleans)
; interpretations: represents a list of Boolean values.
(define LOB1 '()) ; empty list of booleans
(define LOB2 (cons #true '()))
(define LOB3 (cons #false '()))
(define LOB4 (cons #true (cons #false '())))
(define LOB5 (cons #false (cons #true (cons #true '()))))

#; ; template for lob
(define (fun-for-lob lob)
  (cond [(empty? lob) ...]
        [else
         (... (first lob)
              (fun-for-lob (rest lob)))]))


;; List-of-booleans -> Boolean
;; produce #true if a list contains all #true, #false otherwise

(check-expect (all-true? '()) #true)
(check-expect (all-true? (cons #true '())) #true)
(check-expect (all-true? (cons #true (cons #false '()))) #false)
(check-expect (all-true? (cons #false (cons #true '()))) #false)

(define (all-true? lob)
  (cond [(empty? lob) #true]
        [else
         (and (first lob)
              (all-true? (rest lob)))]))

;; List-of-booleans -> Boolean
;; return #true if at least one item in a lob is #true
(check-expect (one-true? '()) #false)
(check-expect (one-true? (cons #false '())) #false)
(check-expect (one-true? (cons #true '())) #true)
(check-expect (one-true? (cons #false (cons #true '()))) #true)

(define (one-true? lob)
  (cond [(empty? lob) #false]
        [else
         (or (first lob)
             (one-true? (rest lob)))]))


;; Ex. 141:
;; If you are asked to design the function cat, which consumes a list of
;; strings and appends them all into one long string, you are guaranteed to
;; end up with this partial definition:

; List-of-string -> String
; concatenate all strings in l into one long string

(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
 (cat (cons "ab" (cons "cd" (cons "ef" '()))))
 "abcdef")
#;
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (... (first l) ... (cat (rest l)) ...)]))

; l         (first l)  (rest l)    (cat (rest l))  (cat l)
;----------------------------------------------------------
;(cons "a"    "a"       (cons "b"    "b"            "ab"
; (cons "b"                '())
;  '()))
;
;(cons                  (cons "cd"   "cdef"        "abcdef"
; "ab"         "ab"       (cons "ef
; (cons "cd"                 '()))
;   (cons "ef"
;     '())))

(define (cat l)
  (cond
    [(empty? l) ""]
    [else
     (string-append (first l)
                    (cat (rest l)))]))

;; Use DrRacket’s stepper to evaluate (cat (cons "a" '())).


;; Ex. 142
;; Design ill-sized?. The function consumes a list of images loi and a positive
;; number n. It produces the first image on loi that is not an n by n square;
;; if it cannot find such an image, it produces #false

;; Hint Use

    ; ImageOrFalse is one of:
    ; – Image
    ; – #false

;; for the result part of the signature.

(require 2htdp/image)

;; List-of-images Number -> ImageOrFalse
;; produce the first Image that is not an NxN square or #false
;; if all Images match
(check-expect (ill-size? '() 1) #false)
(check-expect (ill-size? (cons (square 10 "solid" "blue") '()) 10)
              (square 10 "solid" "blue"))
(check-expect (ill-size? (cons (square 10 "solid" "blue") '()) 8)
              #false)
(check-expect (ill-size? (cons (rectangle 10 8 "solid" "blue") '()) 10)
              #false)
(check-expect (ill-size? (cons (rectangle 10 9 "solid" "green")
                               (cons (square 10 "solid" "blue") '())) 10)
              (square 10 "solid" "blue"))
(check-expect (ill-size? (cons (rectangle 10 8 "solid" "blue")
                               (cons (rectangle 10 20 "solid" "blue") '())) 10)
              #false)

;(define (ill-size? loi n) #false)

(define (ill-size? loi n)
  (cond [(empty? loi) #false]
        [else
         (if (image-square? (first loi) n)
             (first loi)
             (ill-size? (rest loi) n))]))


;; Image Number -> Boolean
;; produce #true if the Images is square with size n
(check-expect (image-square? (square 10 "solid" "blue") 10) #true)
(check-expect (image-square? (square 20 "solid" "red") 10) #false)
(check-expect (image-square? (rectangle 10 8 "solid" "green") 10) #false)

;(define (image-square? ing n) #false)

(define (image-square? img n)
  (and (= (image-height img) n)
       (= (image-width img) n)))