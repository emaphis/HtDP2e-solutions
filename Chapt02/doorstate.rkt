;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname doorstate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e - 2.4 - Enumerations and Intervals
;; 2.4.7 A Bit More About Worlds; A DoorState is one of: 
;; door state example  (state machine)

(require 2htdp/image)
(require 2htdp/universe)

;; data

; A DoorState is one of: 
; – "locked" 
; – "closed" 
; – "open" 

(define (fun-for-ds ds)    ; template
  (cond [(string=? "locked" ds) (... ds)]
        [(string=? "closed" ds) (... ds)]
        [(string=? "open" ds) (... ds)]))


;; functions

; DoorState -> DoorState 
; closes an open door over the period of one tick  
(check-expect (door-closer "locked") "locked") 
(check-expect (door-closer "closed") "closed") 
(check-expect (door-closer "open") "closed") 

;(define (door-closer state-of-door) state-of-door) ;stub

(define (door-closer ds)
  (cond [(string=? "locked" ds) "locked"]
        [(string=? "closed" ds) "closed"]
        [(string=? "open" ds) "closed"]))


; DoorState KeyEvent -> DoorState 
; three key events simulate actions on the door
(check-expect (door-actions "locked" "u") "closed") 
(check-expect (door-actions "closed" "l") "locked") 
(check-expect (door-actions "closed" " ") "open") 
(check-expect (door-actions "open" "a") "open") 
(check-expect (door-actions "closed" "a") "closed") 

;(define (door-actions ds ke) ds) ;stub

(define (door-actions ds ke)
  (cond [(and (string=? "locked" ds) (string=? "u" ke)) "closed"]
        [(and (string=? "closed" ds) (string=? "l" ke)) "locked"]
        [(and (string=? "closed" ds) (string=? " " ke)) "open"]
        [else ds]))


; DoorState -> Image 
; translate the current state of the door into a large text  
  
(check-expect (door-render "closed") (text "closed" 40 "red")) 
  
(define (door-render s) 
  (text s 40 "red")) 


;; DoorState -> DoorState 
;; simulate a door with an automatic door closer 
;; run with: (door-simulation "closed")
(define (door-simulation initial-state) 
  (big-bang initial-state 
          (on-tick door-closer 3)  ;; Ex. 51
          (on-key door-actions) 
          (to-draw door-render))) 
