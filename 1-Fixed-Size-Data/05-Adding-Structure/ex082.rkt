;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex082) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
  (cond [(and (string? l1) (string? l2))
         (cond [(string=? l1 l2) l1]
               [else #false])]
        [else #false]))
