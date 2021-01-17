;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname allkeys) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 3 How to Design Programs
;; 3.6 Designing World Programs
;; a program to demonstrate keyboard handling

;; http://www.ccs.neu.edu/home/matthias/notes/notes/note_mice-and-chars.html
;; Figure 4: A key event recorder

(require 2htdp/image)
(require 2htdp/universe)

; distances in terms of pixels 
(define WIDTH 100)
(define HEIGHT 30)
 
; graphical constant:
(define MT (empty-scene WIDTH HEIGHT))
 
; An AllKeys is a String.
; interpretation the keys pressed since big-bang created the canvas
 
; String -> AllKeys
(define (main s)
  (big-bang s
    [on-key remember]
    [to-draw show]))
 
 
; AllKeys String -> AllKeys
; adds ke to ak, the state of the world
 
(check-expect (remember "hello" " ") "hello ")
(check-expect (remember "hello " "w") "hello w")
 
(define (remember ak ke)
  (string-append ak ke))
 
; AllKeys -> Image
; renders the string as a text and place it into MT
 
(check-expect (show "hel") (overlay (text "hel" 11 "red") MT))
(check-expect (show "mark") (overlay (text "mark" 11 "red") MT))
 
(define (show ak)
  (overlay (text ak 11 "red") MT))