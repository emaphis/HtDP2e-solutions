;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname allmouse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 3 How to Design Programs
;; 2.3.6 Designing World Programs
;; AllMouseEvts is an element of Image.  
;; Figure 9: A mouse event recorder

(require 2htdp/image)
(require 2htdp/universe)

; graphical constants 
(define MT (empty-scene 100 100)) 
  

; clack : AllMouseEvts Number Number String -> AllMouseEvts 
; add a dot at (x,y) to ws  
  
(check-expect 
 (clack MT 10 20 "something mousy") 
 (place-image (circle 1 "solid" "red") 10 20 MT)) 
  
(check-expect 
 (clack (place-image (circle 1 "solid" "red") 1 2 MT) 3 3 "") 
 (place-image (circle 1 "solid" "red") 3 3 
              (place-image (circle 1 "solid" "red") 1 2 MT))) 
  
(define (clack ws x y action) 
  (place-image (circle 1 "solid" "red") x y ws)) 



; show : AllMouseEvts -> AllMouseEvts  
; just reveal the current world state  
  
(check-expect (show MT) MT) 
  
(define (show ws) 
  ws) 


;; AllMouseEvts -> AllMouseEvts
;; start the world with: (main MT)
;; 
(define (main ws)
  (big-bang ws                        ; AllMouseEvts
            (to-draw   show)          ; AllMouseEvts -> Image
            (on-mouse   clack)))      ; AllMouseEvts KeyEvent -> AllKeys
