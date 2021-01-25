;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex048) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 48.
;;  Enter the definition of reward followed by (reward 18) into the definitions
;; area of DrRacket and use the stepper to find out how DrRacket evaluates
;; applications of the function.

; PositiveNumber-> String
; compute the reward level from the given score s
;; Unit Tests
(check-expect (reward 5) "bronze")
(check-expect (reward 15) "silver")
(check-expect (reward 35) "gold")

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

(reward 18)

(cond
    [(<= 0 18 10) "bronze"]
    [(and (< 10 18) (<= 18 20)) "silver"]
    [else "gold"])

(cond
    [#false "bronze"]
    [(and (< 10 18) (<= 18 20)) "silver"]
    [else "gold"])

(cond
    [(and (< 10 18) (<= 18 20)) "silver"]
    [else "gold"])

(cond
    [(and #true (<= 18 20)) "silver"]
    [else "gold"])

(cond
    [(and #true #true) "silver"]
    [else "gold"])

(cond
    [#true "silver"]
    [else "gold"])

"silver"