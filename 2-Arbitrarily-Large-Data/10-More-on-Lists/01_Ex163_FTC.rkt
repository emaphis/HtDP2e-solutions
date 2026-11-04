#lang htdp/bsl
;; HtDP 2e - 10 More on Lists
;; 10.1 Functions that Produce Functions
;; Exercise: 163
;; Fahrenheit to Celcius


;; Ex. 163:
;; Design convertFC. The function converts a list of measurements in Fahrenheit
;; to a list of Celsius measurements.



; List-of-Temps -> List-of-Temps
; convert a list of Temps in Fahrenhieght to a List of Temps is Celcius

(check-expect (f->c* '()) '())
(check-expect (f->c* (cons -40 (cons 32 (cons 68 (cons 212 '())))))
              (cons -40 (cons 0 (cons 20 (cons 100 '())))))

(define (f->c* lot)
  (cond
    [(empty? lot) '()]
    [else (cons (f->c (first lot))
                (f->c* (rest lot)))]))


; Number -> Number
; convert a temp in Fahrenheit to a temp in Celcius
(check-expect (f->c -40) -40)
(check-expect (f->c  32)   0)
(check-expect (f->c  68)  20)
(check-expect (f->c 212) 100)
(define (f->c f)
  (* 5/9 (- f 32)))
