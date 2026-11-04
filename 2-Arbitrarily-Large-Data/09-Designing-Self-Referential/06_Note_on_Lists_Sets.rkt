;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_06_note_on_lists_sets) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.6 A Note on Lists ans Sets
;; Exercises: 160

; A BSL data definition names a 'set' of values:
; Does an item belong to a set? 4 is a Number but "four" is not.


; List-of-string String -> N
; determine how often s occurs in los
(check-expect (count '() "a") 0)  ; base
(check-expect (count (cons "a" '()) "a") 1)
(check-expect (count (cons "b" '()) "a") 0)
(check-expect (count (cons "b"
                           (cons "a"
                                 (cons "b"
                                       (cons "a" '())))) "a") 2)

(define (count los s)
  (cond [(empty? los) 0]
        [else
         (if (string=? (first los) "a")
             (add1 (count (rest los) s))
             (count (rest los) s))]))


;; two notions of sets of Numbers

; A Son.L is one of:
; – empty
; – (cons Number Son.L)
;
; Son is used when it
; applies to Son.L and Son.R

; A Son.R is one of:
; – empty
; – (cons Number Son.R)
;
; Constraint If s is a Son.R,
; no number occurs twice in s.

; emtpy set
; Son
(define es '())

; Number Son -> Son
; is x in s
(define (in? x s)
  (member? x s))

; the same sets:
(cons 1 (cons 2 (cons 3 '())))
(cons 2 (cons 1 (cons 3 '())))

; but is this?
(cons 1 (cons 2 (cons 1 (cons 3 '())))) ; not a Son.R

;; a Couple of functions for both definitions
; Number Son.L -> Son.L
; remove x from s
(define s1.L
  (cons 1 (cons 1 '())))

(check-expect
  (set-.L 1 s1.L) es)

(define (set-.L x s)
  (remove-all x s))


; a function that removes a number from a set.

; Number Son -> Son
; subtract x from s
(define (set- x s)
  s)


; Number Son.R -> Son.R
; remove x from s
(define s1.R
  (cons 1 '()))

(check-expect
  (set-.R 1 s1.R) es)

(define (set-.R x s)
  (remove x s))

; testing set-

(define set123-version1
  (cons 1 (cons 2 (cons 3 '()))))

(define set123-version2
  (cons 1 (cons 3 (cons 2 '()))))

; results

(define set23-version1
  (cons 2 (cons 3 '())))

(define set23-version2
  (cons 3 (cons 2 '())))

(check-member-of (set-.L 1 set123-version2)
                 set23-version1
                 set23-version2)

(check-member-of (set-.R 1 set123-version2)
                 set23-version1
                 set23-version2)

; Son -> Boolean
; #true if 1 a member of s;  #false otherwise
(define (not-member-1? s)
  (not (in? 1 s)))

(check-satisfied (set-.R 1 set123-version1) not-member-1?)

(check-satisfied (set-.L 1 set123-version1) not-member-1?)

(check-satisfied (set-.R 1 set123-version2) not-member-1?)

(check-satisfied (set-.L 1 set123-version2) not-member-1?)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 160: TODO: imporve this
;;
;; Design the functions set+.L and set+.R, which create a set by adding a
;; number x to some given set s for the left-hand and right-hand data
;; definition, respectively.

; Number Son.L -> Son.L
; add x from s
(check-expect (set+.L 1 es) s1.L)

(define (set+.L x s)
  (cons x s))


; Number Son.R -> Son.R
; remove x from s
(check-expect (set+.R 1 es) s1.R)
(define (set+.R x s)
  (cons x s))
