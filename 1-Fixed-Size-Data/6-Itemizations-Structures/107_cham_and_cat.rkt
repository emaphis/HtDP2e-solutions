;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 107_cham_and_cat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.2 Mixing up Worlds
;; Exercise: 107

;; Ex. 107:
;; Design the cham-and-cat program, which deals with both a virtual cat and a
;; virtual chameleon. You need a data definition for a “zoo” containing both
;; animals and functions for dealing with it.

;; The problem statement leaves open how keys manipulate the two animals. Here
;; are two possible interpretations:

;    Each key event goes to both animals.

;    Each key event applies to only one of the two animals.

;      For this alternative, you need a data representation that specifies a
;      focus animal, that is, the animal that can currently be manipulated.
;      To switch focus, have the key-handling function interpret "k" for
;      “kitty” and "l" for lizard. Once a player hits "k", the following
;      keystrokes apply to the cat only—until the player hits "l".

;; Choose one of the alternatives and design the appropriate program. image

; I chose to use different key strokes for the animals:
; up arrow pets the cat
; down arrow feeds the cat
; right arrow feeds the chameleon

;;;;;;;;;;;;;;;;;;;;;;;;;
;; vitual zoo

(require 2htdp/image)
(require 2htdp/universe)


; graphical constants
(define W-WIDTH 400)

(define CAT (bitmap "cat.png"))
(define CHAM (bitmap "chameleon.png"))

(define CAT-HEIGHT (image-height CAT))  ; 117
(define CHAM-HEIGHT (image-height CHAM)) ; 150
 
(define G-HEIGHT 10) ; guage height

(define DY-CAT-GUAGE (+ 5 G-HEIGHT))
(define DY-CAT (+ DY-CAT-GUAGE 20 CAT-HEIGHT ))
(define DY-CHAM-GUAGE (+ DY-CAT 20 G-HEIGHT))
(define DY-CHAM (+ DY-CHAM-GUAGE 20 CHAM-HEIGHT))
(define W-HEIGHT (+ DY-CHAM 5))

(define CAT-SPEED 5)
(define CHAM-SPEED 3)
(define G-SCL 7) ; gauge scale factor


;; Mock Up:

(define MOCK-UP
  (place-image
   (rectangle (* G-SCL 100.0) G-HEIGHT "solid" "orange")
   5 DY-CAT-GUAGE
   (place-image CAT 130 (- DY-CAT (/ CAT-HEIGHT 2))
                (place-image
                 (rectangle (* G-SCL 30.0) G-HEIGHT "solid" "purple")
                 5 DY-CHAM-GUAGE
                 (place-image CHAM 45 (- DY-CHAM (/ CHAM-HEIGHT 2))
                              (empty-scene W-WIDTH W-HEIGHT))))))

  ;(place-image CHAM 150 50.0 "blue")
  ;            (place-image/align
  ;             (rectangle (* 3 50.0) G-HEIGHT "solid" "orange")
  ;             5 10 "left" "top"
   ;            (place-image CHAM 150 DY (new-scene "blue"))))

;; Data definitions are from 88 and 92

(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number[0,100])
; interp.  (make-vcat x h) has an 'x; postition and an 'h' happyness level

(define CAT1 (make-vcat 0 90))  ; happy cat at origin
(define CAT2 (make-vcat 50 50)) ; meh cat in middle of screen

; VCat -> ???
;  ;template
(define (fn-for-vcat c)
  (... (... (vcat-x-pos c))
       (... (vcat-happy c))))


(define-struct vcham [x-pos happy clr])
; cham is a (make-vcham Number Number[0,100] String)
; interp.  (make-vcham x c) has an 'x' postition an 'h' happyness level
;          'c' color

(define CHAM1 (make-vcham 0 90 "blue"))  ; happy cham at origin
(define CHAM2 (make-vcham 50 50 "red")) ; meh cham in middle of screen

; VCham -> ???
#; ; template
(define (fn-for-vcham vc)
  (... (... (vcham-x-pos vc))
       (... (vcham-happy vc))
       (... (vcham-clr vc))))



(define-struct zoo [vcat vcham])
; a Zoo is a (make-zoo (make-cat Number Number) (make-vcham Number Number)
; interp. This zoo has a cat and a chameleon

(define ZOO1 (make-zoo (make-vcat 100 50.0) (make-vcham 20 45.0 "green")))


; Zoo -> ?
#; ; template for Zoo
(define (fn-for-zoo z)
  (... (... (zoo-vcat z))
       (... (zoo-vchan z))))



;;;;;;;;;;;;;;;;;;;;
;; Functions

;;   a rendering function from VAnimal to Image;

; Zoo -> Image
; render a Zoo of animals

(check-expect (render (make-zoo (make-vcat 150 100.0)
                                (make-vcham 50 35.0 "blue")))
              (place-image
                (rectangle (* G-SCL 100.0) G-HEIGHT "solid" "orange")
                5 DY-CAT-GUAGE
                (place-image CAT 150 (- DY-CAT (/ CAT-HEIGHT 2))
                             (place-image
                              (rectangle (* G-SCL 35.0) G-HEIGHT "solid" "purple")
                              5 DY-CHAM-GUAGE
                              (place-image CHAM 50 (- DY-CHAM (/ CHAM-HEIGHT 2))
                              (empty-scene W-WIDTH W-HEIGHT))))))



;(define (render z) (empty-scene 0 0 "white")) ;stub

(define (render z)
  (place-image
   (rectangle (* G-SCL (vcat-happy (zoo-vcat z)))
              G-HEIGHT "solid" "orange")
   5 DY-CAT-GUAGE
   (place-image CAT (vcat-x-pos (zoo-vcat z))
                (- DY-CAT (/ CAT-HEIGHT 2))
                (place-image
                 (rectangle (* G-SCL (vcham-happy (zoo-vcham z)))
                            G-HEIGHT "solid" "purple")
                 5 DY-CHAM-GUAGE
                 (place-image CHAM (vcham-x-pos (zoo-vcham z))
                              (- DY-CHAM (/ CHAM-HEIGHT 2))
                              (empty-scene W-WIDTH W-HEIGHT))))))


;; render helper functions

;; Color -> Image
;; create a new emtpy scene with a given color
(check-expect (new-scene "red") (empty-scene W-WIDTH W-HEIGHT "red"))
(check-expect (new-scene "blue") (empty-scene W-WIDTH W-HEIGHT "blue"))

(define (new-scene cl)
  (empty-scene W-WIDTH W-HEIGHT cl))


;  a function for handling clock ticks, from VAnimal to VAnimal

; VAniamal -> VAnimal
; produces a new VAnimal state each clock tick

(check-expect (tock (make-zoo (make-vcat 10 50.0)
                              (make-vcham 10 50.0 "red")))
              (make-zoo (make-vcat (+ 10 CAT-SPEED) 49.9)
                        (make-vcham (+ 10 CHAM-SPEED) 49.9 "red")))

(check-expect (tock (make-zoo (make-vcat W-WIDTH 50.0)
                              (make-vcham 10 50.0 "red")))
              (make-zoo (make-vcat 0 49.9) ; restart
                        (make-vcham (+ 10 CHAM-SPEED) 49.9 "red")))

(check-expect (tock (make-zoo (make-vcat 10 0.0)  ; don't update happy on 0
                              (make-vcham 10 50.0 "red")))
              (make-zoo (make-vcat (+ 10 CAT-SPEED) 0.0)
                        (make-vcham (+ 10 CHAM-SPEED) 49.9 "red")))

;(define (tock z) z) ; stub

(define (tock z)
  (make-zoo (make-vcat (tock-x-pos (vcat-x-pos (zoo-vcat z)) CAT-SPEED)
                       (tock-happy (vcat-happy (zoo-vcat z))))
            (make-vcham (tock-x-pos (vcham-x-pos (zoo-vcham z)) CHAM-SPEED)
                        (tock-happy (vcham-happy (zoo-vcham z)))
                        (vcham-clr (zoo-vcham z)))))


; Number Number -> Number
; update the given x-pos with the given SPEED
; wrapping around the end of the scene
(check-expect (tock-x-pos 10 CAT-SPEED) (+ 10 CAT-SPEED))
(check-expect (tock-x-pos W-WIDTH CAT-SPEED) 0) ; wrap around

;(define (tock-x-pos xpos s) 0) ;stub

(define (tock-x-pos xpos sp)
  (cond [(< xpos W-WIDTH) (+ xpos sp)]
        [else 0]))

; Number -> Number
; update the happyness scale
; range [0.0, 100.0]
(check-expect (tock-happy 50.0) 49.9)
(check-expect (tock-happy 0.0) 0.0)

;(define (tock-happy hpy) 0.0) ;stub

(define (tock-happy hpy)
  (cond [(> hpy 0.0) (- hpy 0.1)]
        [else 0.0]))


;;;;;;;;;;;;;;;;;;;
;; keyboard handling

;; and a function for dealing with key events so that you can feed and pet and
;; colorize your pet—as applicable.

; Zoo KeyEvent -> Zoo
; feeding the cat and chameleon increase happyness. Petting cat
; increases happyness. don't pet the chameleon!

; up arrow pets the cat
; down arrow feeds the cat
; right arrow feeds cameleon

(check-expect (pay-attention (make-zoo (make-vcat 10 50.0)
                                       (make-vcham 10 50.0 "red"))
                             "up")
              (make-zoo (make-vcat 10 50.5)
                        (make-vcham 10 50.0 "red")))

(check-expect (pay-attention (make-zoo (make-vcat 10 50.0)
                                       (make-vcham 10 50.0 "red"))
                             "down")
              (make-zoo (make-vcat 10 52.0)
                        (make-vcham 10 50.0 "red")))

(check-expect (pay-attention (make-zoo (make-vcat 10 50.0)
                                       (make-vcham 10 50.0 "red"))
                             "right")
              (make-zoo (make-vcat 10 50.0)
                        (make-vcham 10 52.0 "red")))

(check-expect (pay-attention (make-zoo (make-vcat 10 50.0)
                                       (make-vcham 10 50.0 "red"))
                             "a")
              (make-zoo (make-vcat 10 50.0)
                        (make-vcham 10 50.0 "red")))

; (define (pay-attention z key) hpy) ;stub

(define (pay-attention z ke)
  (cond [(key=? ke "up")       ; pet the cat
         (make-zoo (make-vcat (vcat-x-pos (zoo-vcat z))
                              (pet (vcat-happy (zoo-vcat z))))
                   (make-vcham (vcham-x-pos (zoo-vcham z))
                               (vcham-happy (zoo-vcham z))
                               (vcham-clr (zoo-vcham z))))]
        [(key=? ke "down")   ; feed cat
         (make-zoo (make-vcat (vcat-x-pos (zoo-vcat z))
                              (feed (vcat-happy (zoo-vcat z))))
                   (make-vcham (vcham-x-pos (zoo-vcham z))
                               (vcham-happy (zoo-vcham z))
                               (vcham-clr (zoo-vcham z))))]
        [(key=? ke "right")  ; feed the chameleion
         (make-zoo (make-vcat (vcat-x-pos (zoo-vcat z))
                              (vcat-happy (zoo-vcat z)))
                   (make-vcham (vcham-x-pos (zoo-vcham z))
                               (feed (vcham-happy (zoo-vcham z)))
                               (vcham-clr (zoo-vcham z))))]
        [else z])) ; ignore the key

; Number -> Number
; upate the happyness scale

;(define (pet hpy) hpy) ; stub

(define (pet hpy)
  (cond [(< hpy 100.0) (+ hpy 0.5)]
        [else hpy]))

; Number -> Number
; update the happynes scale with a feeding

(define (feed hpy)
  (cond [(< hpy 100.0) (+ hpy 2.0)]
        [else hpy]))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; on-stop handler

;; Zoo -> Boolean
;; test the pets's happyness
(check-expect (unhappy? (make-zoo (make-vcat 10 50.0)
                                  (make-vcham  10 50.0 "blue")))
              #false)

(check-expect (unhappy? (make-zoo (make-vcat 10 0.0)
                                  (make-vcham 10 50.0 "blue")))
              #true)

(check-expect (unhappy? (make-zoo (make-vcat 10 50.0)
                                  (make-vcham  10 0.0 "blue")))
              #true)

(define (unhappy? z)
  (or (<= (vcat-happy (zoo-vcat z)) 0.0)
      (<= (vcham-happy (zoo-vcham z)) 0.0)))


;;;;;;;;;;;;;;;;;;;;;
;; the main program

;; Zoo -> Zoo
;; start the world with:
;; (cham-and-cat (make-zoo (make-vcat 1 30.0) (make-vcham 1 50.0 "blue")))
;;
(define (cham-and-cat va)
  (big-bang va                       ; Zoo
            (on-tick tock)           ; Zoo -> Zoo
            (to-draw render)         ; Zoo -> Image
            (on-key  pay-attention)  ; Zoo KeyEvent -> Zoo
            (stop-when unhappy?)     ; Zoo -> Boolean
            ))
