;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ufo1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e  -- Enumerations and Intervals
;; 2.4.4 Intervals
;; ufo1.rkt  ufo example

(require 2htdp/image)
(require 2htdp/universe)


;; Data

; WorldState is a Number  
; interp. height of UFO (from top) 

;; constants:  
(define WIDTH 300) 
(define HEIGHT 100) 
(define CLOSE (/ HEIGHT 3)) 

;; visual constants:  
(define MT (empty-scene WIDTH HEIGHT)) 
(define UFO 
  (overlay (circle 10 "solid" "green") 
           (rectangle 40 2 "solid" "green"))) 

;; Data

; WorldState is a Number  
; interp. height of UFO (from top) 

; A WorldState falls into one of three intervals:  
; – between 0 and CLOSE 
; – between CLOSE and HEIGHT 
; – below HEIGHT 
#;
(define (fn-for-ws ws)     ;; template
  (cond  [(<= 0 ws CLOSE) (... ws)] 
    [(and (< CLOSE ws) (<= ws HEIGHT)) (... ws)] 
    [(> ws HEIGHT) (...)])) 

;; functions

;; WorldState -> WorldState 
;; compute next location of UFO  

(check-expect (nxt 11) 14) 

(define (nxt y) 
  (+ y 3)) 


; WorldState -> Image 
; place UFO at given height into the center of MT 

(check-expect (render 11) 
              (place-image UFO (/ WIDTH 2) 11 MT)) 

(define (render y) 
  (place-image UFO (/ WIDTH 2) y MT)) 


; run program run  
; WorldState -> WorldState
;; run: (main 0)
(define (main y0) 
  (big-bang y0 (on-tick nxt) (to-draw render))) 



; WorldState -> Image 
; add a status line to the scene create by render   

(check-expect (render/status 10) 
              (place-image (text "descending" 14 "green") 
                           20 20 
                           (render 10))) 
(check-expect (render/status 50) 
              (place-image (text "closing in" 14 "orange") 
                           20 20 
                           (render 50))) 
(check-expect (render/status 101) 
              (place-image (text "landed" 14 "red") 
                           20 20 
                           (render 101))) 

(define (render/status y) 
  (place-image 
   (cond 
     [(<= 0 y CLOSE) 
      (text "descending" 14 "green")] 
     [(and (< CLOSE y) (<= y HEIGHT)) 
      (text "closing in" 14 "orange")] 
     [(> y HEIGHT) 
      (text "landed" 14 "red")]) 
   20 20 
   (render y))) 


; WorldState -> WorldState 
(define (main1 y0) 
  (big-bang y0 (on-tick nxt) (to-draw render/status))) 
