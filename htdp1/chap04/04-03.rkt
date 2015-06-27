;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 4.3  Conditionals and Conditional Functions

;; Exercise 4.3.1.
;; Decide which of the following two cond-expressions is legal:

;(cond
;  [(< n 10) 20]
;  [(> n 20) 0]
;  [else 1])
;; legal

;(cond
;  [(< n 10) 20]
;  [(and (> n 20) (<= n 30))]
;  [else 1])
;; illegal: the second clause is missing an anwer

;(cond [(< n 10) 20]
;      [* 10 n]
;      [else 555])

;; illegal: the second clause is missing a question, it's just an answer


;; Exercise 4.3.2.
;; What is the value of
(define (fun1 n)
  (cond
    [(<= n 1000) .040]
    [(<= n 5000) .045]
    [(<= n 10000) .055]
    [(> n 10000) .060]))

;; when n is (a) 500, (b) 2800, and (c) 15000?
(check-expect (fun1   500) .040)
(check-expect (fun1  2800) .045)
(check-expect (fun1 15000) .060)

;; Exercise 4.3.3.
;; What is the value of

(define (fun2 n)
  (cond
    [(<= n 1000) (* .040 1000)]
    [(<= n 5000) (+ (* 1000 .040)
                    (* (- n 1000) .045))]
    [else (+ (* 1000 .040)
             (* 4000 .045)
             (* (- n 10000) .055))]))

;; when n is (a) 500, (b) 2800, and (c) 15000?
(check-expect (fun2   500) 40)
(check-expect (fun2  2800) 121)
(check-expect (fun2 15000) 495)

;; With the help of cond-expressions, we can now define the interest
;; rate function that we mentioned at the beginning of this section.
;; Suppose the bank pays:
;; 4% for deposits of up to $1,000 (inclusive),
;; 4.5% for deposits of up to $5,000 (inclusive), and
;; 5% for deposits of more than $5,000.
;; Clearly, the function consumes one number and produces one:

;; DepositAmount is 1 of 3:
;; - Natural(0, 1000]
;; - Natural(1000, 5000]
;; - Natural(> 5000)
;; interp. 3 differnt intervals of giving differen interest rates
(define RS1   500)
(define RS2  2800)
(define RS3 15000)

#;; template
(define (fn-for-deposit-amount da)
  (cond [(<= da 1000) (...)]
        [(<= da 5000) (...)]
        [else (...)]))
;; Template rules used:
;; - one of: 3 cases
;; - atomic non-distinct Natural[0,1000]
;; - atomic non-distinct Natural(1000, 5000]
;; - atomic non-distinct Natural(> 5000)

;; interest-rate : DepositAmount ->  Number
;; produces interest rate for the given deposit amount
(check-expect (interest-rate   500) .040)
(check-expect (interest-rate  2800) .045)
(check-expect (interest-rate 15000) .050)

; <template from data definition>

(define (interest-rate pn)
  (cond [(<= pn 1000) .040]
        [(<= pn 5000) .045]
        [else .050]))

