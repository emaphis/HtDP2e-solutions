#lang htdp/bsl

;; Ex. 15
;; Define ==>. The function consumes two Boolean values, call them sunny
;; and friday. Its answer is #true if sunny is false or friday is true.
;; Note: Logicians call this Boolean operation implication, and they use the
;; notation sunny => friday for this purpose. image
;; Based on ex 7 -- bool imply function

(define (==> p q)
  (or (not p) q))

;; imply truth table
(==> #true  #true)  ; #true
(==> #true  #false) ; #false
(==> #false #true)  ; #true
(==> #false #false) ; #true
