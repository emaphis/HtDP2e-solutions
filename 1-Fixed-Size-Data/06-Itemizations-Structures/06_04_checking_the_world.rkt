;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_04_checking_the_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.4 Checking the World
;; Exercise: 114

;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6.4 Checking the World


;; world programs can deal with a lot of variing data so "bigban' comes with a
;; data verification mechanism

#;
(define (main s0)
  (big-bang so [...] [check-with number?] [...]))

;; examples:

; A UnitWorld is a number
; between 0 (inclusize and 1 (exclosive)
; [0,1)


; Any -> Boolean
; is x beween 0 (iclusive and 1 (exclusive)

(check-expect (between-0-and-1? "a") #false)
(check-expect (between-0-and-1? 1.2) #false)
(check-expect (between-0-and-1? 0.2) #true)
(check-expect (between-0-and-1? 0.0) #true)
(check-expect (between-0-and-1? 1.0) #false)

(define (between-0-and-1? x)
  (and (number? x) (<= 0 x) (< x 1)))

#;
(define (main s0)
  (big-bang s0
            ...
            [check-with between-0-and-1?]
            ...))


;;;;;;;;;;;;;;;
;; Ex. 114:
;; Use the predicates from exercise 113 to check the space invader world
;; program, the virtual pet program (exercise 106), and the editor program
;; (A Graphical Editor).

;; See 06_04_space_invater_3.rkt, 06_04_chat_cham_4.rkt, 06_04_editor_4.rkt
