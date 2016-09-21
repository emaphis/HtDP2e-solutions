;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 08_04_computing_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 8 Lists
;; 8.4 Computing with Lists
;; Exercises: 135-136


(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))


;; Eval:

(contains-flatt? (cons "Flatt" (cons "C" '())))
;==
(cond
    [(empty? (cons "Flatt" (cons "C" '()))) #false]
    [(cons? (cons "Flatt" (cons "C" '())))
     (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
         (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
;==
(cond
    [#false #false]
    [(cons? (cons "Flatt" (cons "C" '())))
     (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
         (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
;==
(cond
    [(cons? (cons "Flatt" (cons "C" '())))
     (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
         (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
;==
(cond
    [#true
     (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
         (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
;==
(or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
;==
(or (string=? "Flatt" "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
;==
(or #true
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
;==
#true


;;;;;;;;;;;;;;;;;;;;
;; Ex. 135:
;; Use DrRacket’s stepper to check the calculation for

(contains-flatt? (cons "Flatt" (cons "C" '())))
;==
#true

;; Also use the stepper to determine the value of

(contains-flatt?
  (cons "A" (cons "Flatt" (cons "C" '()))))
;==
#true

;; What happens when "Flatt" is replaced with "B"?

(contains-flatt?
  (cons "A" (cons "B" (cons "C" '()))))
;==
#false


;; for exercist 136:

(define-struct pair [left right])


; A ConsOrEmpty is one of:
; – '()
; – (cons Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists

; Any ConsOrEmpty -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> ConsOrEmpty
; extracts the right part of athe given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-right a-list)))

;; Ex. 136:
;; Validate with DrRacket’s stepper

; (our-first (our-cons "a" '())) == "a"
; (our-rest (our-cons "a" '())) == "a"
