;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_11_virtual_pet3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.11 More Virtual Pets
;; Exercises: 88-93

(require 2htdp/image)
(require 2htdp/universe)


; Ex. 88:
; Define a structure type that keeps track of the cat’s x-coordinate and its
; happiness. Then formulate a data definition for cats, dubbed VCat, including
; an interpretation.


; happy cat simulation

(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number[0,100])
; interp.  (make-vcat x h) has an 'x; postition and an 'h' happyness level

(define CAT1 (make-vcat 0 90))  ; happy cat at origin
(define CAT2 (make-vcat 50 50)) ; meh cat in middle of screen

; Cat -> ???
(define (fn-for-cat c)
  (... (... (cat-x-pos c))
       (... (cat-happy c))))


;; Ex. 89:
;; Design the happy-cat world program, which manages a walking cat and its
;; happiness level. Let’s assume that the cat starts out with perfect happiness.

; graphical constants
(define W-WIDTH 400)
(define W-HEIGHT 150)
(define DY (+  10 (/ W-HEIGHT 2)))
(define G-HEIGHT 10)
(define MT (empty-scene W-WIDTH W-HEIGHT))

(define CAT (bitmap "cat.png"))

(define SPEED 3)


;; =================
;; Functions:

;; VCat -> VCat
;; start the world with (happy-cat (make-vcat 1 30)
;;
(define (happy-cat vc)
  (big-bang vc                      ; VCat
            (on-tick tock)          ; VCat -> VCat
            (to-draw render)        ; VCat -> Image
            (on-key  cat-attention) ; VCat KeyEvent -> VCat
            (stop-when unhappy?)    ; VCat -> Boolean -- added for Ex 90.
            ))


;; VCat -> VCat
;; produce the next vcat state
(check-expect (tock (make-vcat 10 50.0)) (make-vcat 13 49.9))
(check-expect (tock (make-vcat W-WIDTH 50.0)) (make-vcat 0 49.9))
(check-expect (tock (make-vcat 10 0.0)) (make-vcat 13 0.0))

(define (tock vc)
  (tock-happy (tock-x-pos vc)))

;; VCat -> VCat
;; update cat's x-pos, reset at edge of scene
(check-expect (tock-x-pos (make-vcat 10 50)) (make-vcat 13 50))
(check-expect (tock-x-pos (make-vcat W-WIDTH 50)) (make-vcat 0 50))

(define (tock-x-pos vc)
  (cond [(< (vcat-x-pos vc) W-WIDTH)
         (make-vcat (+ (vcat-x-pos vc) SPEED) (vcat-happy vc))]
        [else (make-vcat 0 (vcat-happy vc))]))

;; VCat -> VCat
;; update cat's happyness scale
;; range [0, 100]
(check-expect (tock-happy (make-vcat 10 0.0)) (make-vcat 10 0.0))
(check-expect (tock-happy (make-vcat 10 50.0)) (make-vcat 10 49.9))
(check-expect (tock-happy (make-vcat 10 101.0)) (make-vcat 10 100.0))

(define (tock-happy vc)
  (cond [(<= (vcat-happy vc) 0.0)
         (make-vcat (vcat-x-pos vc) 0.0)]
        [(> (vcat-happy vc) 100.0)
         (make-vcat (vcat-x-pos vc) 100.0)]
        [else
         (make-vcat (vcat-x-pos vc) (- (vcat-happy vc) 0.1))]))


;; VCat -> Image
;; render the cat and the happyness guage on the scene

(check-expect (render (make-vcat 0 50.0))
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CAT 0 DY MT)))

(check-expect (render (make-vcat 4 40.0))
              (place-image/align
               (rectangle (* 3 40.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CAT 4 DY MT)))

(check-expect (render (make-vcat 7 30.0))
              (place-image/align
               (rectangle (* 3 30.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CAT 7 DY MT)))

(define (render vc)
  (place-image/align
   (rectangle (* 3 (vcat-happy vc)) G-HEIGHT "solid" "red")
   5 10 "left" "top"
   (place-image CAT (vcat-x-pos vc) DY MT)))


;; VCat KeyEvent -> VCat
;; handle cat's feeding and petting
;; up arrow pets cat, down arrow feeds cat
(check-expect (cat-attention (make-vcat 10 50.0) "up")
              (make-vcat 10 50.5))
(check-expect (cat-attention (make-vcat 10 50.0) "down")
              (make-vcat 10 52.0))
(check-expect (cat-attention (make-vcat 10 50.0) "a")
              (make-vcat 10 50.0))

(define (cat-attention vc ke)
  (cond [(key=? ke "up") (pet vc)]
        [(key=? ke "down") (feed vc)]
        [else vc]))


;; VCat -> VCat
;; pet the cat
(check-expect (pet (make-vcat 30 10.0)) (make-vcat 30 10.5))

(define (pet vc)
  (make-vcat (vcat-x-pos vc) (+ (vcat-happy vc) 0.5)))


;; VCat -> VCat
;; feed the cat
(check-expect (feed (make-vcat 30 10.0)) (make-vcat 30 12.0))

(define (feed vc)
  (make-vcat (vcat-x-pos vc) (+ (vcat-happy vc) 2.0)))


;; Ex. 90:
;; Modify the happy-cat program from the preceding exercises so that it stops
;; when the cat’s happiness ever falls to 0.

;; VCat -> Boolean
(check-expect (unhappy? (make-vcat 10 50.0)) #false)
(check-expect (unhappy? (make-vcat 10 0.0)) #true)

(define (unhappy? vc)
  (<= (vcat-happy vc) 0.0))


;; Ex. 91:
;; Extend your structure type definition and data definition from exercise 88
;; to include a direction field. Adjust your happy-cat program so that the cat
;; moves in the specified direction. The program should move the cat in
;; the current direction, and it should turn the cat around when it reaches
;; either end of the scene.
;; See cat4.rkt


;; Ex. 92:
;; Design the cham program, which has the chameleon continuously walking
;; across the canvas, from left to right. When it reaches the right end of the
;; canvas, it disappears and immediately reappears on the left. Like the cat,
;; the chameleon gets hungry from all the walking and, as time passes by, this
;; hunger expresses itself as unhappiness.
;; See chameleon1.rkt

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
;; See chameleon2.rkt