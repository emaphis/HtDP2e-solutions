;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_02_166a_Employees3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.2 Structures in Lists
;; Exercise: 166-a
;; Employees-3

;; Ex. 166:
;; The wage*.v2 function consumes a list of work records and produces a list of
;; numbers. Of course, functions may also produce lists of structures.

;; Develop a data representation for pay checks. Assume that a pay check
;; contains two distinctive pieces of information: the employee’s name and an
;; amount. Then design the function wage*.v3. It consumes a list of work
;; records and computes a list of pay checks from it, one per record.

;; In reality, a pay check also contains an employee number. Develop a data
;; representation for employee information and change the data definition for
;; work records so that it uses employee information and not just a string for
;; the employee’s name. Also change your data representation of pay checks so
;; that it contains an employee’s name and number, too. Finally, design
;; wage*.v4, a function that maps lists of revised work records to lists of
;; revised pay checks.

;; version 3

(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name
; with the pay rate r and the number of hours h

(define WORK1 (make-work "Robby" 11.95 39))


(define-struct pay-check [name amount])
; Pay-check is a (make-paycheck String Number)
; where name is employee's name and amount of check
; in dollars

(define PAY-CHECK1 (make-pay-check "Robby" "446.60"))

(define (fun-for-pay-check pc)
  (... (pay-check-name pc)
       (pay-check-amount pc)))


; Lop (list of paychecks) is one of:
; - '()
; - (cons Paycheck Lop)
; interpretation: an instance of Lop represents pay checkes for a week


; Low -> List-of-pay-checks
; computes the weekly wages for the given records
(check-expect (wage*.v3 '()) '())
(check-expect (wage*.v3 (cons (make-work "Robby" 11.95 39)
                   '()))
               (cons (make-pay-check "Robby" (* 11.95 39)) '()))


(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low)
     (cons (wage.v3 (first an-low))
           (wage*.v3 (rest an-low)))]))

; Work -> Pay-check
; computes the wage for the given work record w
(define (wage.v3 w)
  (make-pay-check (work-employee w)
                  (* (work-rate w) (work-hours w))))
