#lang htdp/bsl

;; Ex. 7
;;
;; Add these two lines to the definitions area of DrRacket:
;; (define sunny #true)
;; (define friday #false)
;; Now create an expression that computes whether sunny is false or friday is true.
;; So in this particular case, the answer is #false. (Why?)
;; How many combinations of Booleans can you associate with sunny and friday?

(define sunny #true)
(define friday #false)

(or (not sunny) friday)  ; #false

;; logical implication!
(or (not #true) #true)  ; #true
(or (not #true) #false) ; #false
(or (not #false) #true) ; #true
(or (not #false) #false) ; #true
