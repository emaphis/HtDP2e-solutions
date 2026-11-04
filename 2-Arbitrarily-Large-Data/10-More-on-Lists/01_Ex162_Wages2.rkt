;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_01_162_wages2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.1 Functions that Produce Functions
;; Exercise: 162
;; Wages 2

;; Ex. 162
;; No employee could possibly work more than 100 hours per week. To protect the
;; company against fraud, the function should check that no item of the input
;; list of wage* exceeds 100. If one of them does, the function should
;; immediately signal an error. How do we have to change the function in
;; figure 60 if we want to perform this basic reality check?


(define PAY-RATE 12)
(define OVERTIME-LIMIT 100)


; Number -> Number
; computes the wage for h hours of work
(check-expect (wage 10) (* PAY-RATE 10))

(define (wage h)
  (* PAY-RATE h))


; calculate wages for a list of employees

; List-of-numbers -> List-of-numbers or Error
; computes the weekly wages for the weekly hours
; produce "error" if time limit is exceeded

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* PAY-RATE 28) '()))
(check-expect (wage* (cons 4 (cons 2 '())))
              (cons (* PAY-RATE 4) (cons (* PAY-RATE 2) '())))
(check-error (wage* (cons 10 (cons 100 '()))))

(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (if (reasonable? (first whrs))
              (cons (wage (first whrs))
                    (wage* (rest whrs)))
              (error "Error: found too much overtime"))]))


;; Number -> Boolean
;; produce #true time is not below OVERTIME-LIMIT
(check-expect (reasonable? 99) #true)
(check-expect (reasonable? 100) #false)

(define (reasonable? n)
  (< n OVERTIME-LIMIT))