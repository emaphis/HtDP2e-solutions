;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex089) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 89:
;; Design the happy-cat world program, which manages a walking cat and its
;; happiness level. Let’s assume that the cat starts out with perfect happiness.

(require 2htdp/image)
(require 2htdp/universe)

;;;; happy cat simulation

;;=================================
;; data definition
(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number[0,100])
; interp.  (make-vcat x h) has an 'x; postition and an 'h' happyness level

(define CAT1 (make-vcat 0 90))  ; happy cat at origin
(define CAT2 (make-vcat 50 50)) ; meh cat in middle of screen

; Cat -> ???
(define (fn-for-cat c)
  (... (... (cat-x-pos c))
       (... (cat-happy c))))


;;======================
; graphical constants
(define W-WIDTH 400)
(define W-HEIGHT 150)
(define DY (+  10 (/ W-HEIGHT 2)))
(define G-HEIGHT 10)
(define MT (empty-scene W-WIDTH W-HEIGHT))

(define CAT (bitmap "images/cat.png"))

(define SPEED 3)


;; =================
;; Functions:

;; I discovered later on that when dealing with stuctures it's best to build
;; early in the call chain rather then pass half built structs around.

;; VCat -> VCat
;; produce the next vcat state
(check-expect (tock (make-vcat 10 50.0)) (make-vcat 13 49.9))
(check-expect (tock (make-vcat W-WIDTH 50.0)) (make-vcat 0 49.9))
(check-expect (tock (make-vcat 10 0.0)) (make-vcat 13 0.0))

(define (tock vc)
  (make-vcat (tock-x-pos (vcat-x-pos vc))
             (tock-happy (vcat-happy vc))))

;; Number -> Number
;; update the x-pos, reset at edge of scene
(check-expect (tock-x-pos 10) (+ 10 SPEED))
(check-expect (tock-x-pos W-WIDTH) 0)

(define (tock-x-pos xpos)
  (cond [(< xpos W-WIDTH) (+ xpos SPEED)]
        [else 0]))  ; reset


;; Number -> Number
;; update the given happyness scale
;; range [0, 100]
(check-expect (tock-happy  0.0) 0.0) ; can't get any unhappier.
(check-expect (tock-happy 50.0) 49.9)

(define (tock-happy hpy)
  (cond [(> hpy 0.0) (- hpy 0.1)]
        [else 0.0]))


;; VCat -> Image
;; render the cat and the happyness guage on the scene

(check-expect (render (make-vcat 150 50.0))
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CAT 150 DY MT)))

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

;; VCat -> VCat
;; start the world with (happy-cat (make-vcat 1 30))
;;
(define (happy-cat vc)
  (big-bang vc                      ; VCat
            (on-tick tock)          ; VCat -> VCat
            (to-draw render)        ; VCat -> Image
            (on-key  cat-attention) ; VCat KeyEvent -> VCat
            ))
