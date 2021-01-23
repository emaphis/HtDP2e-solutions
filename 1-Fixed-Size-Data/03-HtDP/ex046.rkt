;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex046) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 3 How to Design Programs
;; 3.7 Virtual Pet Worlds

;; Exercise 46 VirtualPet
;; Improve the cat animation with a slightly different image
;; Adjust the rendering function from exercise 45 so that it uses one cat image
;; or the other based on whether the x-coordinate is odd. Read up on odd? in the
;; HelpDesk, and use a cond expression to select cat images. 

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

(define CAT (bitmap "images/cat.png"))
(define SPEED 3)

;; =================
;; Data definitions:

;; WS is Number
;; interp. WS is the x position from the right.


;; =================
;; Functions:

;; WS -> WS
;; start the world with (main 1)
;;
(define (main ws)
  (big-bang ws                   ; WS
            (on-tick   tock)     ; WS -> WS
            (to-draw   render)   ; WS -> Image
            ))

;; WS -> WS
;; produce the next world state
(check-expect (tock 0) 3)
(check-expect (tock 10) 13)
(check-expect (tock W-WIDTH) 0)

(define (tock ws)
  (if (< ws W-WIDTH)
      (+ ws SPEED)
      0))


;; WS -> Image
;; render the cat on the scene
;; Use rotate function instead of two cat images.
;(check-expect (render 0) (place-image CAT1 0 DY MT))
;(define (render ws) (place-image CAT1 ws DY MT)) ;;ex 37

(check-expect (render 0) (place-image (rotate 5 CAT) 0 DY MT))
(check-expect (render 4) (place-image (rotate 5 CAT) 4 DY MT))
(check-expect (render 7) (place-image (rotate -5 CAT) 7 DY MT))

(define (render ws)
  (if (= (modulo ws 2) 0)
      (place-image (rotate 5 CAT) ws DY MT)
      (place-image (rotate -5 CAT) ws DY MT)))

;; run.
;; (main 0)
