;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex007) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
