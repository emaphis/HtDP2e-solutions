;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex045) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Programs
;; 3.7 Virtual Pet Worlds

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 47 VirtualPet
;; Design a “virtual cat” world program that continuously moves the cat from left
;; to right. Let’s call it cat-prog and let’s assume it consumes the starting
;; position of the cat. Furthermore, make the cat move three pixels per clock
;; tick. Whenever the cat disappears on the right, it reappears on the left
;; . You may wish to read up on the modulo function. 

(require 2htdp/image)
(require 2htdp/universe)

;; Virual Pet Cat.

;; =================
;; Constants:

; graphical constants
(define W-WIDTH 400)
(define W-HEIGHT 150)
(define DY (/ W-HEIGHT 2))
(define MT (empty-scene W-WIDTH W-HEIGHT))

(define CAT1 (bitmap "images/cat.png"))

(define SPEED 3)

;; =================
;; Data definitions:

;; WS is Number
;; interp. WS is the x position from the right.


;; =================
;; Functions:

;; WS -> WS
;; start the world with (main 0)
;;
(define (main ws)
  (big-bang ws                   ; WS
            (on-tick   tock)     ; WS -> WS
            (to-draw   render)   ; WS -> Image
            ))

;; WS -> WS
;; produce the next world state
(check-expect (tock 10) 13)
(check-expect (tock W-WIDTH) 0)

(define (tock ws)
  (if (< ws W-WIDTH)
      (+ ws SPEED)
      0))


;; WS -> Image
;; render the cat on the scene

;(check-expect (render 0) (place-image CAT 0 DY MT))
;(define (render ws) (place-image CAT ws DY MT)) ;;ex 37

(check-expect (render 0) (place-image CAT1  0 DY MT))
(check-expect (render 4) (place-image CAT1  4 DY MT))

(define (render ws)
  (place-image CAT1 ws DY MT))
