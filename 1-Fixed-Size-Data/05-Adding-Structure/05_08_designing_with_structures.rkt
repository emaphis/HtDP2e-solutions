;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_08_designing_with_structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.2 Designing with Structures 
;; Exercises: 80-82

;; The design recipe for structures:

;; Sample Problem:
;; Design a function that computes the distance of objects in a 3-dimensional
;; space to the origin.

;; 1. Data design
;; pieces of data that go to gether belong in a structure


(define-struct r3 [x y z])
; A R3 is a structure:
;   (make-r3 Number Number Number)
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> ???
#;; template for R3
(define (fn-for-r3 r)
  (... (r3-x r)
       (r3-y r)
       (r3-z r)))


;; 2. Signature, purpose statement and function header:

; R3 -> Numbers
; produces the distance from an T3 to origin

;(define (r3-distance-to-0 r) 0)

;; Use the examples to creat tests
(check-within (r3-distance-to-0 (make-r3 0 0 0)) 0 0.01)
(check-within (inexact->exact (r3-distance-to-0 ex1)) 13.19 0.01)
(check-within (inexact->exact (r3-distance-to-0 ex2)) 3.162 0.01)

#;; 4 create a template
(define (r3-distance-to-0 r)
  (... (... (r3-x r))   ; Number
       (... (r3-y r))   ; Number
       (... (r3-z r)))) ; Number

;; 5. Use the selector expressions from the template

(define (r3-distance-to-0 r)
  (sqrt (+ (sqr (r3-x r))   ; Number
           (sqr (r3-y r))   ; Number
           (sqr (r3-z r)))))


;; Ex. 80
;; Create templates for functions that consume instances of the following
;; structure types:

(define-struct movie [title director year])

; Movie -> ???
(define (fn-for-movie m)
  (... (... (movie-title m))
       (... (movie-director m))
       (... (movie-year m))))


(define-struct person [name hair eyes phone])

; Person -> ???
(define (fn-for-person p)
  (... (... (person-name p))
       (... (person-hair p))
       (... (person-eyes p))
       (... (person-phone p))))


(define-struct pet [name number])

; Pet -> ???
(define (fn-for-pet p)
  (... (... (pet-name p))
       (... (pet-number p))))


(define-struct CD [artist title price])

; CD -> ???
(define (fn-for-CD cd)
  (... (... (CD-artist cd))
       (... (CD-title cd))
       (... (CD-price cd))))


(define-struct sweater [material size color])

; Sweater -> ???
(define (fn-for-sweater s)
  (... (... (sweater-material s))
       (... (sweater-size s))
       (... (sweater-color s))))


;; Ex. 81:
;; Design the function time->seconds, which consumes instances of time
;; structures and produces the number of seconds that have passed since
;; midnight.
;; For example, if you are representing 12 hours, 30 minutes, and 2 seconds
;; with one of these structures and if you then apply time->seconds to this
;; instance, the correct result is 45002.

(define-struct time [hours minutes seconds])
; timet is a (make-time Number Number Number))
; interp: a point in time having hours, minutes, seconds

(define TIME1 (make-time 10 30 00))  ; 10:30

#;; Time -> ???
(define (fn-for-time t)
  (... (... (time-hours t))
       (... (time-minutes t))
       (... (time-seconds t))))


; Time -> Number
; convert a given time to seconds
(check-expect (time->seconds (make-time 0 0 0)) 0)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(check-expect (time->seconds TIME1) 37800)

;(define (time->seconds t) 0) ; stub

(define (time->seconds t)
  (+ (* 3600 (time-hours t))
     (* 60 (time-minutes t))
     (time-seconds t)))


;; Ex. 82:
;; Design the function compare-word. The function consumes two (representations
;; of) three-letter words. It produces a word that indicates where the given
;; ones agree and disagree. The function retains the content of the structure
;; fields if the two agree; otherwise it places #false in the field of the
;; resulting word.
;; Hint The exercises mentions two tasks: the comparison of words and the
;; comparison of “letters.”

;; data definition:

;; LCL is one of
; 1String [a,z]
; #false
; interp. lower case letters [a,z] or no letter

(define L1 "a")
(define L2 "k")
(define L3 #false)

#;; template
(define (fn-for-LCL l)
  (cond [(and (string? l) (string<=? "a" l "z")) ...]
        [(equal? #false l) ...]))


(define-struct word3 [let1 let2 let3])
;; word3 is a (make-word3 LCL LCL LCL)
;; interp.  word3 consists of 3 lower case letters

(define WORD1 (make-word3 "c" "a" "t"))
(define WORD2 (make-word3 "d" "o" "g"))
(define WORD3 (make-word3 "m" "e" #false))

#;; template
(define (fn-for-word3 w)
  (... (... (word3-let1 w))
       (... (word3-let2 w))
       (... (word3-let3 w))))

; Word3 World3 -> Word3
; matches two Word3 letter for letter and returns one that contains the matched
; letters and #false for unmatched letters

(check-expect (compare-word (make-word3 "c" "a" "t") (make-word3 "c" "a" "t"))
              (make-word3 "c" "a" "t"))

(check-expect (compare-word (make-word3 "c" "a" "t") (make-word3 "c" "a" "b"))
            (make-word3 "c" "a" #false))

(check-expect (compare-word (make-word3 "c" "a" "t") (make-word3 "c" "a" #false))
              (make-word3 "c" "a" #false))

(check-expect (compare-word (make-word3 "c" "a" "t") (make-word3 "d" "o" "g"))
              (make-word3 #false #false #false))

;(define (compare-word w1 w2) (make-word3 "a" "a" "a")) ; stub

(define (compare-word w1 w2 )
  (make-word3 (compare-letter (word3-let1 w1) (word3-let1 w2))
              (compare-letter (word3-let2 w1) (word3-let2 w2))
              (compare-letter (word3-let3 w1) (word3-let3 w2))))

; LCL LCL -> LCL
; campare two letters and return them if they match or
; return #false if they don't

(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)
(check-expect (compare-letter "a" #false) #false)

;(define (compare-letter l1 l2) "o") ; stub

(define (compare-letter l1 l2)
  (cond [(and (string? l1) (string<=? "a" l1 "z")
              (string? l2) (string<=? "a" l2 "z"))
         (cond [(string=? l1 l2) l1]
               [else #false])]
        [else #false]))
