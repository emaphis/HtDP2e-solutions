;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_02_04_01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.4 Intervals, Enumerations, etc.
;; --------2.4.1 Cond
;; Exercises 40,41

(require 2htdp/image)

(define (next traffic-light-state)
  (cond
    [(string=? "red" traffic-light-state) "green"]
    [(string=? "green" traffic-light-state) "yellow"]
    [(string=? "yellow" traffic-light-state) "red"]))


; PositiveNumber -> String
; compute the reward level from the given score s
(define (reward s)
  (cond
    [(<= 0 s 10)
     "bronze"]
    [(and (< 10 s) (<= s 20))
     "silver"]
    [(< 20 s)
     "gold"]))

;; Exercise 40
(reward 18)  ;=> "silver"
 
;; Exercise 41
(- 200 (cond
         [(> 100 200) 0]
         [else 100]))      ;=> 100

(- 200 (cond
         [(> 210 200) 0]
         [else 210]))      ;=> 200


