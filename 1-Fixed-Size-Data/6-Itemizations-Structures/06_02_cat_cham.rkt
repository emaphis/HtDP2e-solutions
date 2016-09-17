;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_02_cat_cham) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.2 Mixing up Worlds
;; Exercise: 106

;; Ex. 106:
;; In More Virtual Pets we discuss the creation of virtual pets that come with
;; happiness gauges. One of the virtual pets is a cat, the other one is a
;; chameleon. Each program is dedicated to a single pet, however.

;; Design the cat-cham world program. Given both a location and an animal,
;; it walks the latter across the canvas, starting from the given location.
;; Here is the chosen data representation for animals:

    ; A VAnimal is either
    ; – a VCat
    ; – a VCham

;; where VCat and VCham are your data definitions from exercises 88 and 92.

;; Given that VAnimal is the collection of world states, you need to design

;    a rendering function from VAnimal to Image;

;    a function for handling clock ticks, from VAnimal to VAnimal;

;    and a function for dealing with key events so that you can feed and pet
;      and colorize your pet—as applicable.

;; It remains impossible to change the color of a cat or to pet a chamele


;;;;;;;;;;;;;;;;;;;;;;;;;
;; more virtual pets

(require 2htdp/image)
(require 2htdp/universe)


; graphical constants
(define W-WIDTH 400)
(define W-HEIGHT 200)
(define DY (+  10 (/ W-HEIGHT 2)))
(define G-HEIGHT 10) ; guage height

(define CAT (bitmap "cat.png"))
(define CHAM (bitmap "chameleon.png"))

(define SPEED 3)


;; Data definitions are from 88 and 92

(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number[0,100])
; interp.  (make-vcat x h) has an 'x; postition and an 'h' happyness level

(define CAT1 (make-vcat 0 90))  ; happy cat at origin
(define CAT2 (make-vcat 50 50)) ; meh cat in middle of screen

; Cat -> ???
#;  ;template
(define (fn-for-vcat c)
  (... (... (vcat-x-pos c))
       (... (vcat-happy c))))


(define-struct vcham [x-pos happy clr])
; cham is a (make-vcham Number Number[0,100] String)
; interp.  (make-vcham x c) has an 'x' postition an 'h' happyness level
;          'c' color

(define CHAM1 (make-vcham 0 90 "blue"))  ; happy cham at origin
(define CHAM2 (make-vcham 50 50 "red")) ; meh cham in middle of screen

; Cham -> ???
#; ; template
(define (fn-for-vcham vc)
  (... (... (vcham-x-pos vc))
       (... (vcham-happy vc))
       (... (vcham-clr vc))))



; A VAnimal is either
; – a VCat
; – a VCham
; interp.  A VAnimal is one of two kinds of animals

(define VANIMAL1 (make-vcat 10 90))  ; a happy cat
(define VANIMAL2 (make-vcham 30 20 "black")) ; a somewhat unhappy chameleon

; VAnimal -> ???
#; ; VAnimal template
(define (fn-for-vanimal va)
  (cond [(vcat? va)  (... va)]
        [(vcham? va) (... va)]))



;;;;;;;;;;;;;;;;;;;;
;; Functions

;;   a rendering function from VAnimal to Image;

; VAnimal -. Image
; render a VAnimal and the happyness guage on the scene (MT)

(check-expect (render (make-vcat 150 50.0))
              (render-vanimal CAT 150 50.0 "white"))

(check-expect (render (make-vcham 150 50.0 "blue"))
              (render-vanimal CHAM 150 50.0 "blue"))

;(define (render va) (empty-scene 0 0 "white")) ;stub

(define (render va)
  (cond [(vcat? va)
         (render-vanimal CAT
                         (vcat-x-pos va)
                         (vcat-happy va)
                         "white")]
        [(vcham? va)
         (render-vanimal CHAM
                         (vcham-x-pos va)
                         (vcham-happy va)
                         (vcham-clr va))]))


;; render helper functions

; Image Number Number Color -> Image
; render a Images given the VAnimals Image, x pos, happyness

(check-expect (render-vanimal CAT 150 50.0 "white")
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "orange")
               5 10 "left" "top"
               (place-image CAT 150 DY (new-scene "white"))))

(check-expect (render-vanimal CHAM 150 50.0 "blue")
              (place-image/align
               (rectangle (* 3 50.0) G-HEIGHT "solid" "orange")
               5 10 "left" "top"
               (place-image CHAM 150 DY (new-scene "blue"))))

;(define (render-vanimal img x-pos happy clr) (empty-scene 0 0 "white")) ; stub

(define (render-vanimal img xpos hpy clr)
  (place-image/align
   (rectangle (* 3 hpy) G-HEIGHT "solid" "orange")
   5 10 "left" "top"
   (place-image img xpos DY (new-scene clr))))

;; Color -> Image
;; create a new emtpy scene with a given color
(check-expect (new-scene "red") (empty-scene W-WIDTH W-HEIGHT "red"))
(check-expect (new-scene "blue") (empty-scene W-WIDTH W-HEIGHT "blue"))

(define (new-scene cl)
  (empty-scene W-WIDTH W-HEIGHT cl))


;  a function for handling clock ticks, from VAnimal to VAnimal

; VAniamal -> VAnimal
; produces a new VAnimal state each clock tick

(check-expect (tock (make-vcat 10 50.0))
              (make-vcat (+ 10 SPEED) 49.9))
(check-expect (tock (make-vcat W-WIDTH 50.0))  ; restart
              (make-vcat 0 49.9))  ; don't update happyness on 0.0
(check-expect (tock (make-vcat 10 0.0)) (make-vcat (+ 10 SPEED) 0.0))

(check-expect (tock (make-vcham 10 50.0 "red"))
              (make-vcham (+ 10 SPEED) 49.9 "red"))

;(define (tock va) va) ; stub

(define (tock va)
  (cond [(vcat? va)
         (make-vcat (tock-x-pos (vcat-x-pos va))
                    (tock-happy (vcat-happy va)))]
        [(vcham? va)
         (make-vcham (tock-x-pos (vcham-x-pos va))
                     (tock-happy (vcham-happy va))
                     (vcham-clr va))]))

; Number -> Number
; update the given x-pos wrapping around the end of the scene
(check-expect (tock-x-pos 10) (+ 10 SPEED))
(check-expect (tock-x-pos W-WIDTH) 0) ; wrap around

;(define (tock-x-pos xpos) 0) ;stub

(define (tock-x-pos xpos)
  (cond [(< xpos W-WIDTH) (+ xpos SPEED)]
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

; VAnimal KeyEvent -> VAnimal
; feeding the cat and chameleon increase happyness. Petting cat
; increases happyness. don't pet the chameleon!

(check-expect (pay-attention (make-vcat 10 50.0) "up")
              (make-vcat 10 50.5))
(check-expect (pay-attention (make-vcat 10 50.0) "down")
              (make-vcat 10 52.0))
(check-expect (pay-attention (make-vcat 10 50.0) "a")
              (make-vcat 10 50.0))

(check-expect (pay-attention (make-vcham 10 50.0 "red") "down")
              (make-vcham 10 52.0 "red"))
(check-expect (pay-attention (make-vcham 10 50.0 "red") "a")
              (make-vcham 10 50.0 "red"))


;(define (pay-attention va ke) va) ;stub

(define (pay-attention va ke)
  (cond [(vcat? va)
         (make-vcat (vcat-x-pos va)
                    (attention "cat" (vcat-happy va) ke))]
        [(vcham? va)
         (make-vcham (vcham-x-pos va)
                     (attention "cham" (vcham-happy va) ke)
                     (vcham-clr va))]))


; pay-attention helpers:

; String Number KeyEvent -> Number
; update happyness scale given the animals type, happyness scale and, key event
(check-expect (attention "cat" 50.0 "up") 50.5)
(check-expect (attention "cham" 50.0 "up") 50.0)  ; ignore!

(check-expect (attention "cat" 50.0 "down") 52.0)
(check-expect (attention "cham" 50.0 "down") 52.0)

(check-expect (attention "cat" 50.0 "a") 50.0) ; ignore
(check-expect (attention "cham" 50.0 "a") 50.0)

; (define (attention type hpy key) hpy) ;stub

(define (attention type hpy ke)
  (cond [(key=? ke "up") (pet type hpy)]
        [(key=? ke "down") (feed hpy)]
        [else hpy])) ; ignore the key

; String Number -> Number
; upate the happyness scale, only pet the cat, ignore the chameleon!

;(define (pet type hpy) hpy) ; stub

(define (pet type hpy)
  (cond [(string=? type "cat") (+ hpy 0.5)]
        [else hpy]))

; Number -> Number
; update the happynes scale with a feeding

(define (feed hpy) (+ hpy 2.0))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; on-stop handler

;; VAnimals -> Boolean
;; test the pets's happyness
(check-expect (unhappy? (make-vcat 10 50.0)) #false)
(check-expect (unhappy? (make-vcat 10  0.0)) #true)
(check-expect (unhappy? (make-vcham  10 0.0 "blue")) #true)

(define (unhappy? va)
  (cond [(vcat? va) (<= (vcat-happy va) 0.0)]
        [(vcham? va) (<= (vcham-happy va) 0.0)]))


;;;;;;;;;;;;;;;;;;;;;
;; the main program

;; VAnimal -> VAnimal
;; start the world with: (happy-pet (make-vcat 1 30.0))
;;                   or: (happy-pet (make-vcham 1 50.0 "blue")
(define (happy-pet va)
  (big-bang va                       ; VAnimal
            (on-tick tock)           ; VAnimal -> VAnimal
            (to-draw render)         ; VAnimal -> Image
            (on-key  pay-attention)  ; VAnimal KeyEvent -> VAnimal
            (stop-when unhappy?)     ; VAnimal -> Boolean
            ))
