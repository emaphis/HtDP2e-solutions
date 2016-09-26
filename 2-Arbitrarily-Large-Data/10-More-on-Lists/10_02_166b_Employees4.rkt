;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_02_166b_Employees4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.2 Structures in Lists
;; Exercise: 166-b
;; Employees-4

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

;; version 4

(define-struct employee [number name])
; Employee is a (make-employee Number String)
; interpretation: an employee with an employee number and a name

(define (fun-for-employee e)
  (... (employee-number e)
       (employee-name e)))


(define-struct work [employee rate hours])
; Work is a structure: (make-work Employee Number Number)
; interpretation (make-work-4 number e r h) combines the employee
; (with number and name)name with the pay rate r and the number of hours h

(define WORK1 (make-work (make-employee 111 "Robby") 11.95 39))

; Low (list of works) is one of:
; - '()
; - (cons Work Low)
; interpretation: an instance of Low represents the hours worked for
; employees per week.

(define-struct pay-check [employee amount])
; Pay-check is a (make-paycheck Employee Number)
; where  employee is number, name  and amount
; of check in dollars

; Lopc (short for list of Pay-checks) is one of:
; – '()
; – (cons Pay-check Low)
; interpretation an instance of Lopc represents the
; pay check issued for an emplyees work for the week.


; Low -> List-of-pay-checks
; computes the weekly wages for the given records
(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 (cons (make-work (make-employee 111 "Robby") 11.95 39)
                   '()))
               (cons (make-pay-check (make-employee 111 "Robby") (* 11.95 39))
                     '()))
(check-expect (wage*.v4 (cons (make-work (make-employee 112 "Mathias") 12.00 40)
                              (cons (make-work (make-employee 111 "Robby") 11.95 39)
                   '())))
               (cons (make-pay-check (make-employee 112 "Mathias") (* 12.00 40))
                     (cons (make-pay-check (make-employee 111 "Robby") (* 11.95 39))
                     '())))


(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low)
     (cons (wage.v4 (first an-low))
           (wage*.v4 (rest an-low)))]))

; Work -> Pay-check
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-pay-check (work-employee w)
                  (* (work-rate w) (work-hours w))))
