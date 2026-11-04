;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11_03_188_email1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 11 Design by Composition
;; 11.2 Composing Functions
;; Exercise: 188
;; email exercise


;; Ex. 188:
;; Design a program that sorts lists of emails by date:

(define-struct email [from date message])
; A Email Message is a structure:
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m
; sent by f, d seconds after the beginning of time

;; Also develop a program that sorts lists of email messages by name.
;; To compare two strings alphabetically, use the string<? primitive.


; List-of-Email -> List-of-Email
; sort list of email asending by email date

(define EMAIL-100 (make-email "George" 100 "Hello"))
(define EMAIL-150 (make-email "Nancy" 150 "Good day"))
(define EMAIL-200 (make-email "Fred" 200 "Goon night"))

(check-expect (sort-date '()) '())
(check-expect (sort-date (list EMAIL-100)) (list EMAIL-100))
(check-expect (sort-date (list EMAIL-100 EMAIL-150))
              (list EMAIL-100 EMAIL-150))
(check-expect (sort-date (list EMAIL-150 EMAIL-100))
              (list EMAIL-100 EMAIL-150))
(check-expect (sort-date (list EMAIL-150 EMAIL-100 EMAIL-200))
              (list EMAIL-100 EMAIL-150 EMAIL-200))

;(define (sort-date lst) lst) ; stub

(define (sort-date loe)
  (cond [(empty? loe) '()]
        [else
         (insert-date (first loe)
                      (sort-date (rest loe)))]))


; Email List-of-Email -> List-of-Email
; insert the given Email in the proper place (by date) in a sorted List of Email
(check-expect (insert-date EMAIL-100 '()) (cons EMAIL-100 '()))
(check-expect (insert-date EMAIL-100 (list EMAIL-150))
              (list EMAIL-100 EMAIL-150))
(check-expect (insert-date EMAIL-150 (list EMAIL-100))
              (list EMAIL-100 EMAIL-150))
(check-expect (insert-date EMAIL-150 (list EMAIL-100 EMAIL-200))
              (list EMAIL-100 EMAIL-150 EMAIL-200))
(check-expect (insert-date EMAIL-200 (list EMAIL-100 EMAIL-150))
              (list EMAIL-100 EMAIL-150 EMAIL-200))

;(define (insert-date e loe) loe)  ; stub

(define (insert-date e loe)
  (cond [(empty? loe) (cons e '())]
        [else
         (if (e-date<? e (first loe))
             (cons e loe)
             (cons (first loe) (insert-date e (rest loe))))]))


; Email Email -> Boolean
; returns #true if date of Email 1 is less than Email 2
; date is an epoch defined as the numbers of seconds since some begin time

(check-expect (e-date<? EMAIL-100 EMAIL-150) #true)
(check-expect (e-date<? EMAIL-150 EMAIL-100) #false)

(define (e-date<? e1 e2)
  (< (email-date e1) (email-date e2)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Also develop a program that sorts lists of email messages by name.
;; To compare two strings alphabetically, use the string<? primitive.

; List-of-Email -> List-of-Email
; sort list of email asending by email name


(define EMAIL-A (make-email "Abe" 200 "Good night"))
(define EMAIL-B (make-email "Bobby" 100 "Hello"))
(define EMAIL-C (make-email "Charley" 150 "Good day"))

(check-expect (sort-name '()) '())
(check-expect (sort-name (list EMAIL-A)) (list EMAIL-A))
(check-expect (sort-name (list EMAIL-A EMAIL-B))
              (list EMAIL-A EMAIL-B))
(check-expect (sort-name (list EMAIL-B EMAIL-A))
              (list EMAIL-A EMAIL-B))
(check-expect (sort-name (list EMAIL-B EMAIL-A EMAIL-C))
              (list EMAIL-A EMAIL-B EMAIL-C))

(define (sort-name loe)
  (cond [(empty? loe) '()]
        [else
         (insert-name (first loe)
                      (sort-name (rest loe)))]))


; Email List-of-Email -> List-of-Email
; insert the given Email in the proper place (by name) in a sorted List of Email
(check-expect (insert-name EMAIL-A '()) (cons EMAIL-A '()))
(check-expect (insert-name EMAIL-A (list EMAIL-B))
              (list EMAIL-A EMAIL-B))
(check-expect (insert-name EMAIL-B (list EMAIL-A))
              (list EMAIL-A EMAIL-B))
(check-expect (insert-name EMAIL-B (list EMAIL-A EMAIL-C))
              (list EMAIL-A EMAIL-B EMAIL-C))
(check-expect (insert-name EMAIL-C (list EMAIL-A EMAIL-B))
              (list EMAIL-A EMAIL-B EMAIL-C))

(define (insert-name e loe)
  (cond [(empty? loe) (cons e '())]
        [else
         (if (name<? e (first loe))
             (cons e loe)
             (cons (first loe) (insert-name e (rest loe))))]))


; predicate for sorting Emails by from name (String)
(define (name<? e1 e2)
  (string<? (email-from e1) (email-from e2)))


;;;;*****;;;;;****;;;;
;; both programs a very much the same. It was much the same as the Number
;; sorting program The only real difference was the predicate used by the sort
;; function, and of course the example check-expects.
;;
;; I think we need an abstraction mechanism instead of cut-n-paste!  :-)
