;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex092) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.11 More Virtual Pets
;; Exercise: 92

(require 2htdp/image)
(require 2htdp/universe)

;; Ex. 92:
;; Design the cham program, which has the chameleon continuously walking
;; across the canvas, from left to right. When it reaches the right end of the
;; canvas, it disappears and immediately reappears on the left. Like the cham,
;; the chameleon gets hungry from all the walking and, as time passes by, this
;; hunger expresses itself as unhappiness.


;;  ========================
;;; The chameleon simulation


;;===========================
;; Data Definitions

;; Color is one of:
;; - RED
;; - BLUE
;; - GREEN

(define RED "red")
(define BLUE "blue")
(define GREEN "green")

(define-struct vcham [x-pos happy color])
; cham is a (make-vcham Number Number[0,100] Color)
; interp.  (make-vcham x c) has an 'x' postition an 'h' happyness level
;          'color' is chamelion's Color

(define CHAM1 (make-vcham 0 90 BLUE))  ; happy cham at origin
(define CHAM2 (make-vcham 50 50 RED))  ; meh cham in middle of screen

; Cham -> ???
(define (fn-for-cham vc)
  (... (... (cham-x-pos vc))
       (... (cham-happy vc))
       (... (cham-color vc))))


; graphical constants
(define W-WIDTH 400)
(define W-HEIGHT 200)
(define DY (+  10 (/ W-HEIGHT 2)))
(define G-HEIGHT 10)
;(define MT (empty-scene W-WIDTH W-HEIGHT))

(define CHAM (bitmap "images/chameleon.png"))
(define CHAM-HEIGHT (image-height CHAM))
(define CHAP-WIDTH (image-width CHAM))

(define SPEED 3)

(define HAPPY-MAX 100)
(define HAPPY-MIN 0)
(define HAPPY-CHANGE 0.1)
(define HAPPY-INCREASE 2)


;; =================
;; Functions:

;; VCham -> VCham
;; start the world with (happy-cham (make-vcham 1 30.0 BLUE))
;;
(define (happy-cham vcham)
  (big-bang vcham                    ; VCham
            (on-tick tock)           ; VCham -> VCham
            (to-draw render)         ; VCham -> Image
            (on-key  cham-attention) ; VCham KeyEvent -> VCham
            (stop-when unhappy?)     ; VCham -> Boolean
            ))


;; VCham -> VCham
;; produce the next vcham state
(check-expect (tock (make-vcham 10 50.0 RED)) (make-vcham 13 49.9 RED))
(check-expect (tock (make-vcham W-WIDTH 50.0 RED)) (make-vcham 0 49.9 RED))
(check-expect (tock (make-vcham 10 0.0 RED)) (make-vcham 13 0.0 RED))

(define (tock vcham)
  (tock-happy (tock-x-pos vcham)))

;; VCham -> VCham
;; update chameleons's x-pos, reset at edge of scene
(check-expect (tock-x-pos (make-vcham 10 50 RED))
              (make-vcham 13 50 RED))
(check-expect (tock-x-pos (make-vcham W-WIDTH 50 RED))
              (make-vcham 0 50 RED))

(define (tock-x-pos vcham)
  (cond [(< (vcham-x-pos vcham) W-WIDTH)
         (make-vcham (+ (vcham-x-pos vcham) SPEED)
                     (vcham-happy vcham)
                     (vcham-color vcham))]
        [else (make-vcham 0 (vcham-happy vcham) (vcham-color vcham))]))

;; VCham -> VCham
;; update chameleon's happyness scale
;; range [0, 100]
(check-expect (tock-happy (make-vcham 10 0.0 RED))
              (make-vcham 10 0.0 RED))
(check-expect (tock-happy (make-vcham 10 50.0 RED))
              (make-vcham 10 49.9 RED))
(check-expect (tock-happy (make-vcham 10 101.0 RED))
              (make-vcham 10 100.0 RED))

(define (tock-happy vcham)
  (cond [(<= (vcham-happy vcham) HAPPY-MIN)
         (make-vcham (vcham-x-pos vcham)
                     HAPPY-MIN
                     (vcham-color vcham))]
        [(> (vcham-happy vcham) HAPPY-MAX)
         (make-vcham (vcham-x-pos vcham)
                     HAPPY-MAX
                     (vcham-color vcham))]
        [else
         (make-vcham (vcham-x-pos vcham)
                     (- (vcham-happy vcham) HAPPY-CHANGE)
                     (vcham-color vcham))]))


;; VCham -> Image
;; render the cham and the happyness guage on the scene

(check-expect (render (make-vcham 0 50.0 RED))
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "yellow")
               5 10 "left" "top"
               (place-image CHAM 0 DY (new-scene RED))))

(check-expect (render (make-vcham 4 40.0 RED))
              (place-image/align
               (rectangle (* 3 40.0) G-HEIGHT "solid" "yellow")
               5 10 "left" "top"
               (place-image CHAM 4 DY (new-scene RED))))

(check-expect (render (make-vcham 7 30.0 RED))
              (place-image/align
               (rectangle (* 3 30.0) G-HEIGHT "solid" "yellow")
               5 10 "left" "top"
               (place-image CHAM 7 DY (new-scene RED))))

(define (render vcham)
  (place-image/align
   (rectangle (* 3 (vcham-happy vcham)) G-HEIGHT "solid" "yellow")
   5 10 "left" "top"
   (place-image CHAM (vcham-x-pos vcham) DY (new-scene (vcham-color vcham)))))

(define (render-1 vcham)
  (overlay CHAM
   (place-image/align
   (rectangle (* 3 (vcham-happy vcham)) G-HEIGHT "solid" "yellow")
   5 10 "left" "top"
   (new-scene (vcham-color vcham)))))

(define (render-2 vcham)
  (overlay CHAM
   (new-scene (vcham-color vcham))))


;(render-2 (make-vcham 0 50.0 RED))
;(render-2 (make-vcham 4 40.0 RED))

;; VCham KeyEvent -> VCham
;; handle chameleon's feeding (but no petting!)
;; down arrow feeds chameleon)
(check-expect (cham-attention (make-vcham 10 50.0 RED) "down")
              (make-vcham 10 52.0 RED))
(check-expect (cham-attention (make-vcham 10 50.0 RED) "a")
              (make-vcham 10 50.0 RED))

(define (cham-attention vc ke)
  (cond [(key=? ke "down") (feed vc)]
        [(key=? ke "r") (change-color vc RED)]
        [(key=? ke "b") (change-color vc BLUE)]
        [(key=? ke "g") (change-color vc GREEN)]
        [else vc]))


;; VCham -> VCham
;; feed the chameleon
(check-expect (feed (make-vcham 30 10.0 RED)) (make-vcham 30 12.0 RED))

(define (feed vcham)
  (make-vcham (vcham-x-pos vcham)
              (+ (vcham-happy vcham) HAPPY-INCREASE)
              (vcham-color vcham)))


;; VCham -> Boolean
;; check if the chameleon is unhappy to stop the program
(check-expect (unhappy? (make-vcham 10 50.0 RED)) #false)
(check-expect (unhappy? (make-vcham 10 0.0 RED)) #true)

(define (unhappy? vcham)
  (<= (vcham-happy vcham) 0.0))


;; Color -> Image
;; create a new emtpy scene with a given color
(check-expect (new-scene RED) (rectangle W-WIDTH W-HEIGHT "solid" RED))
(check-expect (new-scene BLUE) (rectangle W-WIDTH W-HEIGHT "solid" BLUE))

(define (new-scene color)
  (rectangle W-WIDTH W-HEIGHT "solid" color))

; VChan Color -> VChan
; change the color of the chameleon
(check-expect (change-color (make-vcham 30 50.0 RED) BLUE)
              (make-vcham 30 50.0 BLUE))

(define (change-color vc cl)
  (make-vcham (vcham-x-pos vc) (vcham-happy vc) cl))
