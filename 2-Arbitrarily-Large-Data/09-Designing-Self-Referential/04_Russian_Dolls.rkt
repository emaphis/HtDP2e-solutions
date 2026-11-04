;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_04_russian_dolls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 9 Designing with Self-Referential Data Definitions
;; 9.4 Russian Dolls
;; Exercises: 154, 155

(require 2htdp/image)

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of:
; – String
; – (make-layer String RD)

(define RD1 "red")
(define RD2 (make-layer "green" "red"))
(define RD3 (make-layer "yellow" (make-layer "green" "red")))

#; ; template
(define (fun-for-rd rd)
  (cond [(string? rd) (... rd)]
        [(layer? rd)
         (... (layer-color rd)
              (fun-for-rd (layer-doll rd)))]))


; RD -> Number
; how many dolls are part on an-rd

(check-expect (depth "red") 1)

(check-expect (depth (make-layer "yellow"
                                 (make-layer "green" "red")))
              3)

(define (depth an-rd)
  (cond [(string? an-rd) 1]
        [(layer? an-rd)
         (+ (depth (layer-doll an-rd)) 1)]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 154:
;; Design the function colors. It consumes a Russian doll and produces a string
;; of all colors, separate by a comma and a space.
;; Thus our example should produce: "yellow, green, red"

; RD -> Color
; produce a String of all the colors, separated by comma and a space

(check-expect (colors "red") "red")

(check-expect (colors (make-layer "yellow"
                                  (make-layer "green" "red")))
              "yellow, green, red")


(define (colors an-rd)
  (cond [(string? an-rd) an-rd]
        [(layer? an-rd)
         (string-append (layer-color an-rd) ", "
                        (colors (layer-doll an-rd)))]))


;; Ex. 155:
;; Design the function inner, which consumes an RD and produces the
;; (color of the) innermost doll.
;; Use DrRacket’s stepper to evaluate (inner rd) for you favorite rd.

; RD -> Color
; produce the color of the innermost doll

(check-expect (inner "red") "red")

(check-expect (inner (make-layer "yellow"
                                  (make-layer "green" "red")))
              "red")

(define (inner an-rd)
  (cond [(string? an-rd) an-rd]
        [(layer? an-rd)
         (inner (layer-doll an-rd))]))

; evaluates in 16 steps
;(inner (make-layer "yellow" (make-layer "green" "red")))
