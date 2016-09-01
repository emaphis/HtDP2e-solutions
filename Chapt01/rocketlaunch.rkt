;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rocketlaunch) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e  -- Enumerations and Intervals
;; 2.4.5 Itemization
;; rocketlaunch.rkt  - rocket example

(require 2htdp/image)
(require 2htdp/universe)


;; A LR (short for: launching rocket) is one of: 
;; – "resting" 
;; – non-negative number  
;; interp. a rocket on the ground or the height of a rocket in flight 

;; Exercise 45: 
(define LR1 "resting")
(define LR2 0) ; Launch!
(define LR3 10) ; HEIGHT above ground

; A LRCD (short for: launching rocket count down) is one of: 
; – "resting" 
; – a number in [-3,-1] 
; – a non-negative number  
; interp. a rocket resting on the ground, in count-down mode,  
;   or the height of an in-flight rocket
(define LRCD1 "resting") ; resting on the ground
(define LRCD2 -3) ; start of countdown
(define LRCD3 -2) ; middle of countdowm
(define LRCD4 -1) ; end of coundown
(define LRCD5  0) ; beginning of flight!
(define LRCD6 10) ; height of flight of 10.

#;
(define (fn-for-lrcd lrcd)    ;; template
  (cond 
    [(string? lrcd) (... lrcd)] 
    [(<= -3 lrcd -1) (... lrcd)] 
    [(>= lrcd 0) (... lrcd)])) 

; physical constants  
(define HEIGHT 300) 
(define WIDTH  100) 
(define YDELTA 3) 
  
; graphical constants  
(define BACKG  (empty-scene WIDTH HEIGHT)) 
(define ROCKET (rectangle 5 30 "solid" "red")) ; use your favorite image  
(define ROCKET-CENTER (/ (image-height ROCKET) 2))


;; Functions

;; LRCD -> Image
;; render the rocket image at a given height
(check-expect (render-rocket 10) 
              (place-image ROCKET 10 (- 10 ROCKET-CENTER) BACKG))
(define (render-rocket x)
  (place-image ROCKET 10 (- x ROCKET-CENTER) BACKG))

; LRCD -> Image 
; render the state as a resting or flying rocket  

(check-expect 
 (show "resting") 
 (place-image ROCKET 
              10 (- HEIGHT (/ (image-height ROCKET) 2)) 
              BACKG)) 
  
(check-expect 
 (show -2) 
 (place-image (text "-2" 20 "red") 
              10 (* 3/4 WIDTH) 
              (place-image ROCKET 
                           10 (- HEIGHT (/ (image-height ROCKET) 2)) 
                           BACKG))) 
  
(check-expect 
 (show HEIGHT) 
 (place-image ROCKET 10 (- HEIGHT ROCKET-CENTER) BACKG)) 

(check-expect 
 (show 53) 
 (place-image ROCKET 10 (- 53 ROCKET-CENTER) BACKG)) 

;(define (show x) BACKG) ;stub

(define (show x) 
  (cond 
    [(string? x) 
     (render-rocket HEIGHT)]
    [(<= -3 x -1) 
     (place-image (text (number->string x) 20 "red") 
                  10 (* 3/4 WIDTH) 
                  (render-rocket HEIGHT))]
   [(>= x 0)
     (render-rocket x)]))


; LRCD KeyEvent -> LRCD 
; start the count-down when space bar is pressed,  
; and the rocket is resting  
(check-expect (launch "resting" " ") -3) 
(check-expect (launch "resting" "a") "resting") 
(check-expect (launch -3 " ") -3) 
(check-expect (launch -1 " ") -1) 
(check-expect (launch 33 " ") 33) 
(check-expect (launch 33 "a") 33) 

;(define (launch x ke) x) ;stub

(define (launch x ke) 
  (cond 
    [(string? x) (if (string=? " " ke) -3 x)] 
    [(<= -3 x -1) x] 
    [(>= x 0) x])) 


; LRCD -> LRCD 
; raise the rocket by YDELTA if it is moving already  
(check-expect (fly "resting") "resting") 
(check-expect (fly -3) -2) 
(check-expect (fly -2) -1) 
(check-expect (fly -1) HEIGHT) 
(check-expect (fly 10) (- 10 YDELTA)) 
(check-expect (fly 22) (- 22 YDELTA)) 
  
;(define (fly x)  x) ;stub

(define (fly x) 
  (cond 
    [(string? x) x] 
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))] 
    [(>= x 0) (- x YDELTA)])) 


; LRCD -> LRCD 
; run with: (main1 "")
(define (main1 s) 
  (big-bang s (to-draw show) (on-key launch))) 

;; ex 48
; LRCD -> LRCD 
; run with: (main2 "")
(define (main2 s) 
  (big-bang s (on-tick fly) (to-draw show) (on-key launch))) 
