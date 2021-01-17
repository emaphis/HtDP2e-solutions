;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chameleon2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.11 More Virtual Pets
;; Exercise: 93

(require 2htdp/image)
(require 2htdp/universe)


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

;; The chameleon simulation

(define-struct vcham [x-pos happy clr])
; cham is a (make-vcham Number Number[0,100] String)
; interp.  (make-vcham x c) has an 'x' postition an 'h' happyness level
;          'c' color

(define CHAM1 (make-vcham 0 90 "blue"))  ; happy cham at origin
(define CHAM2 (make-vcham 50 50 "red")) ; meh cham in middle of screen

; Cham -> ???
(define (fn-for-cham vc)
  (... (... (cham-x-pos vc))
       (... (cham-happy vc))
       (... (cham-clr vc))))


;; Ex. 89:
;; Design the happy-cham world program, which manages a walking cham and its
;; happiness level.
;; Let’s assume that the cham starts out with perfect happiness.

; graphical constants
(define WIDTH 150)
(define W-WIDTH (* 3 WIDTH))
(define W-HEIGHT 200)
(define DY (+  10 (/ W-HEIGHT 2)))
(define G-HEIGHT 10)
;(define MT (empty-scene W-WIDTH W-HEIGHT))

(define MT
  (beside (empty-scene WIDTH W-HEIGHT "green")
          (empty-scene WIDTH W-HEIGHT "white")
          (empty-scene WIDTH W-HEIGHT "red")))

(define CHAM (bitmap "chameleon.png"))

(define SPEED 3)


;; =================
;; Functions:


;; VCham -> VCham
;; start the world with (happy-cham (make-vcham 1 50.0 "blue"))
;;
(define (happy-cham vc)
  (big-bang vc                       ; VCham
            (on-tick tock)           ; VCham -> VCham
            (to-draw render)         ; VCham -> Image
            (on-key  cham-attention) ; VCham KeyEvent -> VCham
            (stop-when unhappy?)     ; VCham -> Boolean
            ))


;; VCham -> VCham
;; produce the next vcham state
(check-expect (tock (make-vcham 10 50.0 "red")) (make-vcham 13 49.9 "red"))
(check-expect (tock (make-vcham W-WIDTH 50.0 "red")) (make-vcham 0 49.9 "red"))
(check-expect (tock (make-vcham 10 0.0 "red")) (make-vcham 13 0.0 "red"))

(define (tock vc)
  (tock-happy (tock-x-pos vc)))

;; VCham -> VCham
;; update chameleons's x-pos, reset at edge of scene
(check-expect (tock-x-pos (make-vcham 10 50 "red"))
              (make-vcham 13 50 "red"))
(check-expect (tock-x-pos (make-vcham W-WIDTH 50 "red"))
              (make-vcham 0 50 "red"))

(define (tock-x-pos vc)
  (cond [(< (vcham-x-pos vc) W-WIDTH)
         (make-vcham (+ (vcham-x-pos vc) SPEED)
                     (vcham-happy vc)
                     (vcham-clr vc))]
        [else (make-vcham 0 (vcham-happy vc) (vcham-clr vc))]))

;; VCham -> VCham
;; update chameleon's happyness scale
;; range [0, 100]
(check-expect (tock-happy (make-vcham 10 0.0 "red"))
              (make-vcham 10 0.0 "red"))
(check-expect (tock-happy (make-vcham 10 50.0 "red"))
              (make-vcham 10 49.9 "red"))
(check-expect (tock-happy (make-vcham 10 101.0 "red"))
              (make-vcham 10 100.0 "red"))

(define (tock-happy vc)
  (cond [(<= (vcham-happy vc) 0.0)
         (make-vcham (vcham-x-pos vc)
                     0.0
                     (vcham-clr vc))]
        [(> (vcham-happy vc) 100.0)
         (make-vcham (vcham-x-pos vc)
                     100.0
                     (vcham-clr vc))]
        [else
         (make-vcham (vcham-x-pos vc)
                     (- (vcham-happy vc) 0.1)
                     (vcham-clr vc))]))


;; VCham -> Image
;; render the cham and the happyness guage on the scene

(check-expect (render (make-vcham 0 50.0 "red"))
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CHAM 0 DY MT)))

(check-expect (render (make-vcham 4 40.0 "red"))
              (place-image/align
               (rectangle (* 3 40.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CHAM 4 DY MT)))

(check-expect (render (make-vcham 7 30.0 "red"))
              (place-image/align
               (rectangle (* 3 30.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CHAM 7 DY MT)))

(define (render vc)
  (place-image/align
   (rectangle (* 3 (vcham-happy vc)) G-HEIGHT "solid" "red")
   5 10 "left" "top"
   (place-image CHAM (vcham-x-pos vc) DY MT)))


;; VCham KeyEvent -> VCham
;; handle chameleon's feeding (but no petting!)
;; down arrow feeds chameleon)
(check-expect (cham-attention (make-vcham 10 50.0 "red") "down")
              (make-vcham 10 52.0 "red"))
(check-expect (cham-attention (make-vcham 10 50.0 "red") "a")
              (make-vcham 10 50.0 "red"))

(define (cham-attention vc ke)
  (cond [(key=? ke "down") (feed vc)]
;        [(key=? ke "r") (change-clr vc "red")]
;        [(key=? ke "b") (change-clr vc "blue")]
;        [(key=? ke "g") (change-clr vc "green")]
        [else vc]))


;; VCham -> VCham
;; feed the chameleon
(check-expect (feed (make-vcham 30 10.0 "red")) (make-vcham 30 12.0 "red"))

(define (feed vc)
  (make-vcham (vcham-x-pos vc)
              (+ (vcham-happy vc) 2.0)
              (vcham-clr vc)))


;; VCham -> Boolean
;; check if the chameleon is unhappy to stop the program
(check-expect (unhappy? (make-vcham 10 50.0 "red")) #false)
(check-expect (unhappy? (make-vcham 10 0.0 "red")) #true)

(define (unhappy? vc)
  (<= (vcham-happy vc) 0.0))


;; Color -> Image
;; create a new emtpy scene with a given color
(check-expect (new-scene "red") (empty-scene W-WIDTH W-HEIGHT "red"))
(check-expect (new-scene "blue") (empty-scene W-WIDTH W-HEIGHT "blue"))

(define (new-scene cl)
  (empty-scene W-WIDTH W-HEIGHT cl))

; VChan Color -> VChan
; change the color of the chameleon
(check-expect (change-clr (make-vcham 30 50.0 "red") "blue")
              (make-vcham 30 50.0 "blue"))

(define (change-clr vc cl)
  (make-vcham (vcham-x-pos vc) (vcham-happy vc) cl))