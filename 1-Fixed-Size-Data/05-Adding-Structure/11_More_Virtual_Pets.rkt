;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 11_More_Virtual_Pets) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.11 More Virtual Pets
;; Exercises: 88-93

;; see exercises 88, 89, 90, 91

(require 2htdp/image)
(require 2htdp/universe)

(define RED "red")

(define CHAM (bitmap "images/chameleon.png"))

(define background
  (rectangle (image-width CHAM)
             (image-height CHAM)
             "solid"
             RED))

(overlay CHAM background)


;; See exercise 92.
;; Ex. 92:
;; Design the cham program, which has the chameleon continuously walking
;; across the canvas, from left to right. When it reaches the right end of the
;; canvas, it disappears and immediately reappears on the left. Like the cat,
;; the chameleon gets hungry from all the walking and, as time passes by, this
;; hunger expresses itself as unhappiness.
;; See chameleon1.rkt

;; Ex. 93:
;; Copy your solution to exercise 92 and modify the copy so that the chameleon
;; walks across a tricolor background. Our solution uses these colors

;(define BACKGROUND
;  (beside (empty-scene WIDTH HEIGHT "green")
;          (empty-scene WIDTH HEIGHT "white")
;          (empty-scene WIDTH HEIGHT "red")))

;; but you may use any colors. Observe how the chameleon changes colors to
;; blend in as it crosses the border between two colors.

;; Note:
;; When you watch the animation carefully, you see the chameleon riding on a
;; white rectangle. If you know how to use image editing software, modify the
;; picture so that the white rectangle is invisible. Then the chameleon will
;; really blend in.
;; See chameleon2.rkt