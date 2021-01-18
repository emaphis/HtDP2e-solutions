;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex015) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
