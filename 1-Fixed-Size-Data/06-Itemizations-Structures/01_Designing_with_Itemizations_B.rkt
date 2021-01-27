;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_01_space_invader_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.1 Designing with Itemizations, Again
;; Exercises: 100-102

;; space invader simulation v2

(require 2htdp/image)
(require 2htdp/universe)


;; physical constants:

(define WIDTH 200) ; world constants
(define HEIGHT 200)

(define TANK-SPEED 3)
(define UFO-SPEED 7)
(define MISSILE-SPEED 10)
(define JUMP 7) ; UFO randomly jumps by this amount


; graphical constants

(define UFO (overlay (rectangle 20 2 "solid" "blue")
             (ellipse 15 10 "solid" "purple")))

(define UFO-HEIGHT (image-height UFO))
(define UFO-WIDTH (image-width UFO))
(define H-UFO-HEIGHT (/ UFO-HEIGHT 2))
(define H-UFO-WIDTH (/ UFO-WIDTH 2))

(define TANK (rectangle 15 10 "solid" "olive"))
(define TANK-HEIGHT (image-height TANK))
(define H-TANK-HEIGHT (/ TANK-HEIGHT 2))
(define TANK-Y (- HEIGHT H-TANK-HEIGHT))  ; Y pos never changes for tank

(define MISSILE
  (rectangle 1 15 "solid" "red"))

(define MISSILE-HEIGHT (image-height MISSILE))
(define MISSILE-WIDTH (image-width MISSILE))
(define H-MISSILE-HEIGHT (/ MISSILE-HEIGHT 2))
(define H-MISSILE-WIDTH (/ MISSILE-WIDTH 2))


(define BACKGROUND (empty-scene WIDTH HEIGHT "lightblue"))


;; a mock-up
(define MOCK-UP
  (place-image MISSILE 140 (- HEIGHT 120)
               (place-image TANK 100 TANK-Y
                            (place-image UFO 150 (- HEIGHT 160)
                                         BACKGROUND))))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; data definitions

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define UFO1 (make-posn 10 60))

; UFO -> ???
#; ;template for UFO
(define (fn-for-ufo u)
  (... (... (posn-x u))   ; Number
       (... (posn-y u)))) ; Number


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number).
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define TANK1 (make-tank 50 10))

; Tank -> ???
#; ;template for Tank
(define (fn-for-tank t)
  (... (... (tank-loc t))   ; Number
       (... (tank-vel t)))) ; Number


; A Missile is a Posn.
; interpretation (make-posn x y) is the missile's place

(define MISSILE1 (make-posn 20 80))

; Missile -> ???
#; ;template for Missile
(define (fn-for-missile m)
  (... (... (posn-x m))   ; Number
       (... (posn-y m)))) ; Number



(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game

(define AIM1 (make-sigs (make-posn 100 120)
                        (make-tank 50 3)
                        #false))

(define FIRED1 (make-sigs (make-posn 100 120)
                          (make-tank 50 3)
                          (make-posn 20 150)))

; Fired -> ???
#; ;template for SIGS
(define (fn-for-sigs s)
  (... (fn-for-ufo (fired-ufo s))                  ; UFO
       (fn-for-tank (fired-tank s))                ; Tank
       (fn-for-missile-or-not (fired-missile s)))) ; MissileOrNot


; A MissileOrNot is one of:
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location.

(define MISSILE2 (make-posn 20 80))
(define NOT1 #false)

; MissileOrNot -> ??
#; ; template for MissileOrNot
(define (fn-for-missile-not mn)
  (cond
    [(boolean? mn) ...]  ; Not
    [(posn? mn) ...]))   ; Missile



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Function definitions

;;;;;;;;;;;;;;;;;;;;
;; Ex. 101:
;; Turn the examples into test cases.

(check-expect (si-render.v2 (make-sigs (make-posn 20 10)
                                       (make-tank 28 3)
                                       #false))
              (place-image TANK 28 TANK-Y
                           (place-image UFO 20 10
                                        BACKGROUND)))

(check-expect (si-render.v2 (make-sigs (make-posn 20 10)
                                       (make-tank 28 3)
                                       (make-posn 30 (- HEIGHT
                                                        TANK-HEIGHT
                                                        10))))
              (place-image TANK 28 TANK-Y
                           (place-image UFO 20 10
                                        (place-image MISSILE 30
                                                     (- HEIGHT TANK-HEIGHT 10)
                                                     BACKGROUND))))

; SIGS.v2 -> Image
; renders the given game state on top of BACKGROUND
(define (si-render.v2 s)
  (tank-render (sigs-tank s)
               (ufo-render (sigs-ufo s)
                           (missile-render.v2 (sigs-missile s)
                                              BACKGROUND))))


; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 (make-posn 28 (- HEIGHT
                                                  TANK-HEIGHT
                                                  30))
                                 BACKGROUND)
              (place-image MISSILE 28 (- HEIGHT TANK-HEIGHT 30) BACKGROUND))

;(define (missile-render.v2 m s) s) ; stub

(define (missile-render.v2 m im)
  (cond
    [(boolean? m) im]
    [(posn? m)
     (place-image MISSILE (posn-x m) (posn-y m) im)]))


;; Ex. 102:
;; Design all other functions that are needed to complete the game for this
;; second data definition

; Tank Image -> Image
; adds t to the given image im
(check-expect (tank-render (make-tank 28 -3) BACKGROUND)
              (place-image TANK 28 TANK-Y BACKGROUND))

;(define (tank-render t im) im) ;stub

(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))



; UFO Image -> Image
; adds u to the given image im
(check-expect (ufo-render (make-posn 20 100) BACKGROUND)
              (place-image UFO 20 100 BACKGROUND))

;(define (ufo-render u im) im) ;stub

(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))


;;;;;;;;;;;;;;;;;;;;;
;; state functions

; SIGS -> Boolean
; returns #true if the UFO has landed or if the Missile is in
; proximity of the UFO


(check-expect (si-game-over?    ; not landed, no missle
               (make-sigs (make-posn 20 100)
                          (make-tank 10 3)
                          #false))
              #false)

(check-expect (si-game-over?   ; landed, no missle
               (make-sigs (make-posn 20 (- HEIGHT H-UFO-HEIGHT))
                          (make-tank 10 3)
                          #false))
              #true)

(check-expect (si-game-over?   ; landed, no hit
               (make-sigs (make-posn 20 (- HEIGHT H-UFO-HEIGHT))
                          (make-tank 10 3)
                          (make-posn 10 10)))
              #true)

(check-expect (si-game-over?   ; not landed, no hit
               (make-sigs (make-posn 20 100)
                          (make-tank 10 3)
                          (make-posn 10 10)))
              #false)

(check-expect (si-game-over?   ; not landed, hit!
               (make-sigs (make-posn 20 100)
                          (make-tank 10 3)
                          (make-posn 20 100)))
              #true)


;(define (si-game=over? s) #false) ;stub

(define (si-game-over? s)
  (or
   (ufo-landed? (sigs-ufo s))
   (ufo-hit? (sigs-ufo s)
             (sigs-missile s))))

; UFO -> Boolean
; #true if the UFO has landed -- you loose
(check-expect (ufo-landed?    ; not landed
               (make-posn 20 100))
              #false)
(check-expect (ufo-landed?   ; landed
               (make-posn 20 (- HEIGHT H-UFO-HEIGHT)))
              #true)

;(define (ufo-landed? u) #false) ;stub

(define (ufo-landed? u)
  (>= (posn-y u) (- HEIGHT H-UFO-HEIGHT)))


; UFO  MissileOrNot -> Boolean
; #true if the UFO was hit by the Missle -- you win
(check-expect (ufo-hit?   ; landed, no hit
               (make-posn 20 (- HEIGHT UFO-HEIGHT))
               (make-posn 10 10))
              #false)

(check-expect (ufo-hit?   ; not landed, no hit
               (make-posn 20 100)
               (make-posn 10 10))
              #false)

(check-expect (ufo-hit?   ; not landed, hit!
               (make-posn 20 100)
               (make-posn 20 100))
              #true)

(check-expect (ufo-hit?  ; no missile, no hit
               (make-posn 20 100)
               #false)
              #false)

;(define (ufo-hit? u m) #false) ;stub

(define (ufo-hit? u m)
 (cond
   [(boolean? m) #false]
   [(posn? m)
    (and (<= (abs (- (posn-x u) (posn-x m)))
             (+ H-UFO-WIDTH H-MISSILE-WIDTH))
         (<= (abs (- (posn-y u) (posn-y m)))
             (+ H-UFO-HEIGHT H-MISSILE-HEIGHT)))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; on-tock handler


;; Assumption:
;; 'si-move-proper' will move the Missile (if exists),the UFO andd the Tank
;; each 'tock'
;; 'si-move' adds a random element to UFO move
;; (Random 3) results:
;; 0 - subtract JUMP from UFO-SPEED
;; 1 - move JUMP (-) in x direction
;; 2 - move JUMP (+) in x direction

; SIGS -> SIGS
; update the SIGS with random UFO adustment state every tock

(define (si-move w)
  (si-move-proper w (random 3)))

; SIGS -> SIGS
; move the UFO objects predictably
; 0 - subtract 1 from UFO-SPEED
; 1 - move -1 in x direction
; 2 - move 1 in x direction

(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 0)
                                         #false)
                              0)
              (make-sigs (make-posn 10 (+ 20 (- UFO-SPEED JUMP)))
                         (make-tank 50 0)
                         #false))

(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 3)
                                         #false)
                              1)
              (make-sigs (make-posn (- 10 JUMP) (+ 20 UFO-SPEED))
                         (make-tank 53 3)
                         #false))
(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 3)
                                         #false)
                              2)
              (make-sigs (make-posn (+ 10 JUMP) (+ 20 UFO-SPEED))
                         (make-tank 53 3)
                         #false))

(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 3)
                                         (make-posn 20 30))
                              0)
              (make-sigs (make-posn 10 (+ 20 (- UFO-SPEED JUMP)))
                         (make-tank 53 3)
                         (make-posn 20 (- 30 MISSILE-SPEED))))

;(define (si-move-proper w r)
;  w)

(define (si-move-proper s r)
  (make-sigs (update-ufo (sigs-ufo s) r)
             (update-tank (sigs-tank s))
             (update-missile (sigs-missile s))))


; Ufo Number -> Ufo
; update a UFO with a random adustment on tock
; 0 - subtract JUMP from UFO-SPEED
; 1 - move JUMP (-) in x direction
; 2 - move JUMP (+) in x direction

(check-expect (update-ufo (make-posn 20 30) 0)
              (make-posn 20 (+ 30 (- UFO-SPEED JUMP))))
(check-expect (update-ufo (make-posn 20 30) 1)
              (make-posn (- 20 JUMP) (+ 30 UFO-SPEED)))
(check-expect (update-ufo (make-posn 20 30) 2)
              (make-posn (+ 20 JUMP) (+ 30 UFO-SPEED)))

(define (update-ufo u r)
  (cond [(= r 0) (make-posn (posn-x u) (+ (posn-y u) (- UFO-SPEED JUMP)))]
        [(= r 1) (make-posn (- (posn-x u) JUMP) (+ (posn-y u) UFO-SPEED))]
        [(= r 2) (make-posn (+ (posn-x u) JUMP) (+ (posn-y u) UFO-SPEED))]))


; Tank -> Tank
; update tank x postion with tank velocity on tock
(check-expect (update-tank (make-tank 10 3)) (make-tank 13 3))

(define (update-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t)))


; MissileOrNot -> MissileOrNot
; update Missle's y position or skips non-Missiel on tock
(check-expect (update-missile (make-posn 20 30))
              (make-posn 20 (- 30 MISSILE-SPEED)))
(check-expect (update-missile #false) #false)

(define (update-missile m)
  (cond [(boolean? m) #false]
        [(posn? m)
         (make-posn (posn-x m) (- (posn-y m) MISSILE-SPEED))]))


;;;;;;;;;;;;;;;;;;;;
;; event handlers

; SIGS KeyEvent -> SIG
(define (si-control sg ke)
  (cond [(key=? ke "left") (tank-left sg)]
        [(key=? ke "right") (tank-right sg)]
        [(key=? ke " ") (fire-missile sg)]
        [else sg])) ; ignore rest

; SIGS -> SIGS
; turn tank right (set velocity -)
(check-expect (tank-left (make-sigs (make-posn 10 50) (make-tank 30 3) #false))
              (make-sigs (make-posn 10 50) (make-tank 30 -3) #false))
(check-expect (tank-left (make-sigs (make-posn 10 50) (make-tank 30 -3) #false))
              (make-sigs (make-posn 10 50) (make-tank 30 -3) #false))

(check-expect (tank-left (make-sigs (make-posn 10 50)
                                    (make-tank 30 3)
                                    (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 -3)
                         (make-posn 30 30)))
(check-expect (tank-left (make-sigs (make-posn 10 50)
                                    (make-tank 30 -3)
                                    (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 -3)
                         (make-posn 30 30)))

;(define (tank-left s) s)  ;stub

(define (tank-left s)
  (make-sigs (sigs-ufo s)
             (tank-turn-left (sigs-tank s))
             (sigs-missile s)))

; Tank -> Tank
; turn Tank right (+)
(check-expect (tank-turn-left (make-tank 30 -3))
              (make-tank 30 -3))
(check-expect (tank-turn-left (make-tank 30 3))
              (make-tank 30 -3))

(define (tank-turn-left t)
  (cond [(<= 0 (tank-vel t))
         (make-tank (tank-loc t) (- 0 (tank-vel t)))]
        [else t]))


; SIGS -> SIGS
; turn tank right (set velocity +)
(check-expect (tank-right (make-sigs (make-posn 10 50)
                                     (make-tank 30 3)
                                     #false))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 3)
                         #false))
(check-expect (tank-right (make-sigs (make-posn 10 50)
                                     (make-tank 30 -3)
                                     #false))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 3)
                         #false))

(check-expect (tank-right (make-sigs (make-posn 10 50)
                                     (make-tank 30 3)
                                     (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 3)
                         (make-posn 30 30)))
(check-expect (tank-right (make-sigs (make-posn 10 50)
                                     (make-tank 30 -3)
                                     (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 3)
                         (make-posn 30 30)))

;(define (tank-right s) s)  ;stub

(define (tank-right s)
  (make-sigs (sigs-ufo s)
             (tank-turn-right (sigs-tank s))
             (sigs-missile s)))

; Tank -> Tank
; turn Tank right (+)
(check-expect (tank-turn-right (make-tank 30 -3))
              (make-tank 30 3))
(check-expect (tank-turn-right (make-tank 30 3))
              (make-tank 30 3))

(define (tank-turn-right t)
  (cond [(< (tank-vel t) 0)
         (make-tank (tank-loc t) (- 0 (tank-vel t)))]
        [else t]))


; SIGS -> SIGS
; fire a missile (create a missile)
(check-expect (fire-missile (make-sigs (make-posn 25 30)
                                       (make-tank 20 3)
                                       #false))
              (make-sigs (make-posn 25 30)
                         (make-tank 20 3)
                         (make-posn (+ 20 3) (- HEIGHT H-TANK-HEIGHT))))

(check-expect (fire-missile (make-sigs (make-posn 25 30)  ; a new missile
                                       (make-tank 20 3)
                                       (make-posn 40 10)))
              (make-sigs (make-posn 25 30)
                         (make-tank 20 3)
                         (make-posn (+ 20 3) (- HEIGHT H-TANK-HEIGHT))))

; (define (fire-missile s) s)  ;stub

(define (fire-missile s)
  (make-sigs (sigs-ufo s)
             (sigs-tank s)
             (make-posn (+ (tank-loc (sigs-tank s))
                           (tank-vel (sigs-tank s)))
                        (- HEIGHT H-TANK-HEIGHT))))

;; SIGS -> SIGS
;; start the world with

(define (main ws)
  (big-bang ws                        ; SIGS
            (on-tick   si-move 0.2)   ; SIGS -> SIGS
            (to-draw   si-render.v2)  ; SiGS -> Image
            (stop-when si-game-over?) ; SIGS -> Boolean
            ;(on-mouse  ...)          ; SIGS Integer Integer MouseEvent -> SIGS
            (on-key    si-control)))  ; SIGS KeyEvent -> SIGS

