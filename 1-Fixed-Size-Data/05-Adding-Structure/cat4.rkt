;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cat4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.11 More Virtual Pets
;; Exercise: 91

(require 2htdp/image)
(require 2htdp/universe)


;; Ex. 91:
;; Extend your structure type definition and data definition from exercise 88
;; to include a direction field. Adjust your happy-cat program so that the cat
;; moves in the specified direction.
;; The program should move the cat in the current direction, and it should
;; turn the cat around when it reaches either end of the scene.
;; See cat4.rkt


; happy cat simulation

(define-struct vcat [x-pos happy right])
; cat is a (make-vcat Number Number[0,100] Boolean)
; interp.  (make-vcat x h t) has an 'x; postition and an 'h' happyness level
;           if t is #true cat is traveling right else left

(define CAT1 (make-vcat 0 90 #true))  ; happy cat at origin
(define CAT2 (make-vcat 50 50 #false)) ; meh cat in middle of screen

; Cat -> ???
(define (fn-for-cat vc)
  (... (... (cat-x-pos vc))
       (... (cat-happy vc))
       (... (cat-right vc))))


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
(check-expect (tock (make-vcat 10 50.0 #true)) ; right
              (make-vcat 13 49.9 #true))
(check-expect (tock (make-vcat 10 50.0 #false)) ; left
              (make-vcat 7 49.9 #false))
(check-expect (tock (make-vcat 10 0.0 #true)) ; test happy
              (make-vcat 13 0.0 #true))
(check-expect (tock (make-vcat W-WIDTH 50.0 #true)) ; bump left
              (make-vcat (- W-WIDTH SPEED) 49.9 #false))
(check-expect (tock (make-vcat 0 50.0 #false)) ; bump right
              (make-vcat (+ 0 SPEED) 49.9 #true))

(define (tock vc)
  (tock-happy (tock-x-pos (tock-right vc))))

;; VCat -> VCat
;; update cat's x-pos, reset at edge of scene
(check-expect (tock-x-pos (make-vcat 10 50.0 #true))
              (make-vcat 13 50.0 #true))
(check-expect (tock-x-pos (make-vcat W-WIDTH 50.0 #true))
              (make-vcat (+ W-WIDTH SPEED) 50.0 #true))

(define (tock-x-pos vc)
  (make-vcat (update-x vc)
             (vcat-happy vc)
             (vcat-right vc)))

;; VCat -> Number
;; update postion based on direction
(check-expect (update-x (make-vcat 100 50.0 #true))  (+ 100 SPEED))
(check-expect (update-x (make-vcat 100 50.0 #false)) (- 100 SPEED))

(define (update-x vc)
  (cond [(vcat-right vc)
         (+ (vcat-x-pos vc) SPEED)]
        [else
         (- (vcat-x-pos vc) SPEED)]))

;; VCat -> VCat
;; update cat's happyness scale on tock
;; range [0, 100]
(check-expect (tock-happy (make-vcat 10 0.0 #true))
              (make-vcat 10 0.0 #true))
(check-expect (tock-happy (make-vcat 10 50.0 #true))
              (make-vcat 10 49.9 #true))
(check-expect (tock-happy (make-vcat 10 101.0 #true))
              (make-vcat 10 100.0 #true))

(define (tock-happy vc)
  (cond [(<= (vcat-happy vc) 0.0)
         (make-vcat (vcat-x-pos vc) 0.0 (vcat-right vc))]
        [(> (vcat-happy vc) 100.0)
         (make-vcat (vcat-x-pos vc) 100.0 (vcat-right vc))]
        [else
         (make-vcat (vcat-x-pos vc)
                    (- (vcat-happy vc) 0.1)
                    (vcat-right vc))]))

;; VCat -> VCat
;; update cat's direction on tock
;; range [0, W-WIDTH]
(check-expect (tock-right (make-vcat 30 50.0 #true))
              (make-vcat 30 50.0 #true))
(check-expect (tock-right (make-vcat 30 50.0 #false))
              (make-vcat 30 50.0 #false))
(check-expect (tock-right (make-vcat  0 50.0 #false))
              (make-vcat  0  50.0 #true))
(check-expect (tock-right (make-vcat W-WIDTH 50.0 #true))
              (make-vcat  W-WIDTH 50.0 #false))

(define (tock-right vc)
  (cond [(and (vcat-right vc) (>= (vcat-x-pos vc) W-WIDTH))
         (make-vcat (vcat-x-pos vc) ; bounce right?
                    (vcat-happy vc)
                    #false)]
        [(and (not (vcat-right vc)) (<= (vcat-x-pos vc) 0))
         (make-vcat (vcat-x-pos vc)  ; bounce left?
                    (vcat-happy vc)
                    #true)]
        [else vc]))


;; VCat -> Image
;; render the cat and the happyness guage on the scene

(check-expect (render (make-vcat 0 50.0 #true))
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CAT 0 DY MT)))

(check-expect (render (make-vcat 4 40.0 #true))
              (place-image/align
               (rectangle (* 3 40.0) G-HEIGHT "solid" "red")
               5 10 "left" "top"
               (place-image CAT 4 DY MT)))

(check-expect (render (make-vcat 7 30.0 #true))
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
(check-expect (cat-attention (make-vcat 10 50.0 #true) "up")
              (make-vcat 10 50.5 #true))
(check-expect (cat-attention (make-vcat 10 50.0 #true) "down")
              (make-vcat 10 52.0 #true))
(check-expect (cat-attention (make-vcat 10 50.0 #true) "a")
              (make-vcat 10 50.0 #true))

(define (cat-attention vc ke)
  (cond [(key=? ke "up") (pet vc)]
        [(key=? ke "down") (feed vc)]
        [else vc]))


;; VCat -> VCat
;; pet the cat
(check-expect (pet (make-vcat 30 10.0 #true))
              (make-vcat 30 10.5 #true))

(define (pet vc)
  (make-vcat (vcat-x-pos vc)
             (+ (vcat-happy vc) 0.5)
             (vcat-right vc)))


;; VCat -> VCat
;; feed the cat
(check-expect (feed (make-vcat 30 10.0 #true))
              (make-vcat 30 12.0 #true))

(define (feed vc)
  (make-vcat (vcat-x-pos vc)
             (+ (vcat-happy vc) 2.0)
             (vcat-right vc)))


;; VCat -> Boolean
;; test the cat's happyness
(check-expect (unhappy? (make-vcat 10 50.0 #true)) #false)
(check-expect (unhappy? (make-vcat 10  0.0 #true)) #true)

(define (unhappy? vc)
  (<= (vcat-happy vc) 0.0))