;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 04_04_Ufo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e  -- Enumerations and Intervals
;; 4.4 Intervals
;; ufo example

(require 2htdp/image)
(require 2htdp/universe)


; WorldState is a Number
; interperatation: number of pixels between the top and the UFO

; A WorldState falls into one of three intervals:  
; – between 0 and CLOSE 
; – between CLOSE and HEIGHT 
; – below HEIGHT 
#;
(define (fn-for-ws ws)     ;; template
  (cond  [(<= 0 ws CLOSE) (... ws)] 
    [(and (< CLOSE ws) (<= ws HEIGHT)) (... ws)] 
    [(> ws HEIGHT) (...)])) 


;; constants:
(define WIDTH 300)
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))

;; visual constants:
(define MTSCN (empty-scene WIDTH HEIGHT))

(define UFO
  (overlay (circle 10 "solid" "green")
           (rectangle 40 2 "solid" "green")))



;; functions

; run program
; WorldState -> WorldState
;; run: (main 0)
(define (main y0)
  (big-bang y0
            [on-tick nxt .2]
            [to-draw render]))


;; WorldState -> WorldState 
;; compute next location of UFO  

(check-expect (nxt 11) 14) 

(define (nxt y) 
  (+ y 3)) 


; WorldState -> Image 
; place UFO at given height into the center of MTSCN

(check-expect (render 11) 
              (place-image UFO (/ WIDTH 2) 11 MTSCN))

(define (render y) 
  (place-image UFO (/ WIDTH 2) y MTSCN))


;; Sample Problem -- Status Line

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
  (big-bang y0
            [on-tick nxt .2]
            [to-draw render/status]))
