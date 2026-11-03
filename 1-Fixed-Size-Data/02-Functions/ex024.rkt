#lang htdp/bsl
;; Ex 24: run in stepper
;; Here is the definition of ==>
;; (define (==> x y)
;;   (or (not x) y))
;; Use the stepper to determine the value of (==> #true #false).

(define (==> x y)
  (or (not x) y))

(==> #true #false)

; steps
(or (not #true) #false)
(or #false #false)
#false
