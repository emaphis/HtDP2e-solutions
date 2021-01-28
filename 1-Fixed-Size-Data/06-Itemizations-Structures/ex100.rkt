;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex100) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.1 Designing with Itemizations, Again
;; Exercise: 100

;; space invader simulation

(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;
;; Physical Constants

(define WIDTH 200)
(define HEIGHT 200)
(define SCENE (empty-scene WIDTH HEIGHT "skyblue"))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO (overlay  (circle (/ UFO-HEIGHT 2) "solid" "purple")
             (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "blue")))

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "olive"))

(define MISSILE-WIDTH 1)
(define MISSILE-HEIGHT 15)
(define MISSILE
  (rectangle MISSILE-WIDTH MISSILE-HEIGHT "solid" "red"))

;; starting positions
(define UFO-X 100)
(define UFO-Y 50)
(define TANK-X 150)
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))

(define TANK-SPEED 3)
(define UFO-SPEED 7)
(define MISSILE-SPEED 10)
(define JUMP 7) ; UFO randomly jumps by this amount


;; a mock-up
(define MOCK-UP
  (place-image UFO
               UFO-X UFO-Y
               (place-image TANK
                            TANK-X TANK-Y
                            SCENE)))


;;;;;;;;;;;;;;;;;;;;;;;
;; data definitions:

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define UFO-POSN1 (make-posn 10 60))


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number).
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define TANK1 (make-tank 50 10))


; A Missile is a Posn.
; interpretation (make-posn x y) is the missile's place

(define MISSILE1 (make-posn 20 80))


; the time period when the player is trying to get the tank in position
; for a shot,
(define-struct aim [ufo tank])

;; example
(define AIM0 (make-aim (make-posn 100 120)
                       (make-tank 50 3)))


; States after the missile is fired. Before we can formulate a data definition
; for the complete game state
(define-struct fired [ufo tank missile])

(define FIRED1 (make-fired (make-posn 100 120)
                           (make-tank 50 3)
                           (make-posn 20 150)))


; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

; an instance that describes the tank maneuvering into position to fire:
; the missile:
(define AIM1
  (make-aim (make-posn 20 10)
            (make-tank 28 -3)))

; just like the previous one but the missile has been fired:
(define FIRE1
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 (- HEIGHT TANK-HEIGHT))))

; one where the missile is about to collide with the UFO:
(define FIRE2
  (make-fired (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions:

;; a rendering function

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to
; the SCENE

;(define (si-render s) SCENE) ;stub

;; Examples figure 36

#; ;template for si-render
(define (si-render-templ s)
  (cond [(aim? s)
         (... (aim-tank s) .. (aim-ufo s) ... SCENE)]
        [(fired? s)
         (... (fired-tank s) ... (fired-ufo x)
          ... (fired-missile s) ... SCENE)]))


;; Figure 37: The complete rendering function
(define (si-render s)
  (cond [(aim? s)
         (tank-render (aim-tank s)
              (ufo-render (aim-ufo s)
                          SCENE))]
        [(fired? s)
         (tank-render (fired-tank s)
                      (ufo-render (fired-ufo s)
                                  (missile-render (fired-missile s)
                                                 SCENE)))]))


; Tank Image -> Image
; adds t to the given image im
(check-expect (tank-render (make-tank 28 -3) SCENE)
              (place-image TANK 28 TANK-Y SCENE))

;(define (tank-render t im) im) ;stub

(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))


; UFO Image -> Image
; adds u to the given image im
(check-expect (ufo-render (make-posn 20 100) SCENE)
              (place-image UFO 20 100 SCENE))

;(define (ufo-render u im) im) ;stub

(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))


; Missle Image -> Image
; adds m to the given image im
(check-expect (missile-render (make-posn 28 30) SCENE)
              (place-image MISSILE 28 30 SCENE))

;(define (missile-render u im) im) ;stub

(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))


; SIGS -> Boolean
; returns #true if the UFO has landed or if the Missile is in
; proximity of the UFO
(check-expect (si-game-over?    ; not landed, no missle
               (make-aim (make-posn 20 100)
                         (make-tank 10 3)))
              #false)

(check-expect (si-game-over?   ; landed, no missle
               (make-aim (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                         (make-tank 10 3)))
              #true)

(check-expect (si-game-over?   ; landed, no hit
               (make-fired (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                           (make-tank 10 3) (make-posn 10 10)))
              #true)

(check-expect (si-game-over?   ; not landed, no hit
               (make-fired (make-posn 20 100)
                           (make-tank 10 3) (make-posn 10 10)))
              #false)

(check-expect (si-game-over?   ; not landed, hit!
               (make-fired (make-posn 20 100)
                           (make-tank 10 3) (make-posn 20 100)))
              #true)


;(define (si-game=over? s) #false) ;stub

(define (si-game-over? s)
  (cond [(aim? s)
         (ufo-landed? (aim-ufo s))]
        [(fired? s)
         (or
          (ufo-landed? (fired-ufo s))
          (ufo-hit? (fired-ufo s)
                    (fired-missile s)))]))


; UFO -> Boolean
; #true if the UFO has landed -- you loose
(check-expect (ufo-landed?    ; not landed
               (make-posn 20 100))
              #false)
(check-expect (ufo-landed?   ; landed
               (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2))))
              #true)

;(define (ufo-landed? u) #false) ;stub

(define (ufo-landed? u)
  (>= (posn-y u) (- HEIGHT (/ UFO-HEIGHT 2))))


; UFO  Missile -> Boolean
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

;(define (ufo-hit? u m) #false) ;stub

(define (ufo-hit? u m)
  (and (<= (abs (- (posn-x u) (posn-x m)))
           (+ (/ UFO-WIDTH 2) (/ MISSILE-WIDTH 2)))
       (<= (abs (- (posn-y u) (posn-y m)))
           (+ (/ UFO-HEIGHT 2) (/ MISSILE-HEIGHT 2)))))


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

(check-expect (si-move-proper (make-aim (make-posn 10 20)
                                        (make-tank 50 0))
                              0)
              (make-aim (make-posn 10 (+ 20 (- UFO-SPEED JUMP)))
                        (make-tank 50 0)))

(check-expect (si-move-proper (make-aim (make-posn 10 20)
                                        (make-tank 50 3))
                              1)
              (make-aim (make-posn (- 10 JUMP) (+ 20 UFO-SPEED))
                        (make-tank 53 3)))
(check-expect (si-move-proper (make-aim (make-posn 10 20)
                                        (make-tank 50 3))
                              2)
              (make-aim (make-posn (+ 10 JUMP) (+ 20 UFO-SPEED))
                        (make-tank 53 3)))

(check-expect (si-move-proper (make-fired (make-posn 10 20)
                                          (make-tank 50 3)
                                          (make-posn 20 30))
                              0)
              (make-fired (make-posn 10 (+ 20 (- UFO-SPEED JUMP)))
                          (make-tank 53 3)
                          (make-posn 20 (- 30 MISSILE-SPEED))))

;(define (si-move-proper w r)
;  w)

(define (si-move-proper s r)
  (cond [(aim? s)
         (make-aim (update-ufo (aim-ufo s) r)
                   (update-tank (aim-tank s)))]
        [(fired? s)
         (make-fired (update-ufo (fired-ufo s) r)
                     (update-tank (fired-tank s))
                     (update-missile (fired-missile s)))]))

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


; Missile -> Missile
; update Missle's y position on tock
(check-expect (update-missile (make-posn 20 30))
              (make-posn 20 (- 30 MISSILE-SPEED)))

(define (update-missile m)
  (make-posn (posn-x m) (- (posn-y m) MISSILE-SPEED)))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 100:
;; Design the function si-control, which plays the role of the key event
;; handler. As such, it consumes a game state and a KeyEvent and produces
;; a new game state. It reacts to three different keys:

;    pressing the left arrow ensures that the tank moves left;

;    pressing the right arrow ensures that the tank moves right; and

;    pressing the space bar fires the missile if it hasn’t been launched yet.

;; Once you have this function, you can define the si-main function, which
;; uses big-bang to spawn the game-playing window. Enjoy!

; SIGS KeyEvent -> SIG
(define (si-control sg ke)
  (cond [(key=? ke "left") (tank-left sg)]
        [(key=? ke "right") (tank-right sg)]
        [(key=? ke " ") (fire-missile sg)]
        [else sg])) ; ignore rest

; SIGS -> SIGS
; turn tank right (set velocity -)
(check-expect (tank-left (make-aim (make-posn 10 50) (make-tank 30 3)))
              (make-aim (make-posn 10 50) (make-tank 30 -3)))
(check-expect (tank-left (make-aim (make-posn 10 50) (make-tank 30 -3)))
              (make-aim (make-posn 10 50) (make-tank 30 -3)))

(check-expect (tank-left (make-fired (make-posn 10 50)
                                     (make-tank 30 3)
                                     (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 -3)
                          (make-posn 30 30)))
(check-expect (tank-left (make-fired (make-posn 10 50)
                                     (make-tank 30 -3)
                                     (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 -3)
                          (make-posn 30 30)))

;(define (tank-left s) s)  ;stub

(define (tank-left s)
  (cond [(aim? s)
         (make-aim (aim-ufo s)
                   (tank-turn-left (aim-tank s)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (tank-turn-left (fired-tank s))
                     (fired-missile s))]))

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
(check-expect (tank-right (make-aim (make-posn 10 50) (make-tank 30 3)))
              (make-aim (make-posn 10 50) (make-tank 30 3)))
(check-expect (tank-right (make-aim (make-posn 10 50) (make-tank 30 -3)))
              (make-aim (make-posn 10 50) (make-tank 30 3)))

(check-expect (tank-right (make-fired (make-posn 10 50)
                                      (make-tank 30 3)
                                      (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 3)
                          (make-posn 30 30)))
(check-expect (tank-right (make-fired (make-posn 10 50)
                                      (make-tank 30 -3)
                                      (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 3)
                          (make-posn 30 30)))

;(define (tank-right s) s)  ;stub

(define (tank-right s)
  (cond [(aim? s)
         (make-aim (aim-ufo s)
                   (tank-turn-right (aim-tank s)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (tank-turn-right (fired-tank s))
                     (fired-missile s))]))

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
; fire a missile (convert an Aim to a Fired)
(check-expect (fire-missile (make-aim (make-posn 25 30)
                                      (make-tank 20 3)))
              (make-fired (make-posn 25 30)
                          (make-tank 20 3)
                          (make-posn (+ 20 3) (- HEIGHT (/ TANK-HEIGHT 2)))))

(check-expect (fire-missile (make-fired (make-posn 25 30)
                                        (make-tank 20 3)
                                        (make-posn 40 10)))
              (make-fired (make-posn 25 30)
                          (make-tank 20 3)
                          (make-posn (+ 20 3) (- HEIGHT (/ TANK-HEIGHT 2)))))

; (define (fire-missile s) s)  ;stub

(define (fire-missile s)
  (cond [(aim? s)
         (make-fired (aim-ufo s)
                     (aim-tank s)
                     (make-posn (+ (tank-loc (aim-tank s))
                                   (tank-vel (aim-tank s)))
                                (- HEIGHT (/ TANK-HEIGHT 2))))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (fired-tank s)
                     (make-posn (+ (tank-loc (fired-tank s))
                                   (tank-vel (fired-tank s)))
                                (- HEIGHT (/ TANK-HEIGHT 2))))]))

;; SIGS -> SIGS
;; start the world with (main (make-aim (make-posn 50 00) (make-tank 20 3)))

(define (main ws)
  (big-bang ws                        ; SIGS
            (on-tick   si-move 0.2)   ; SIGS -> SIGS
            (to-draw   si-render)     ; SiGS -> Image
            (stop-when si-game-over?) ; SIGS -> Boolean
            ;(on-mouse  ...)          ; SIGS Integer Integer MouseEvent -> SIGS
            (on-key    si-control)))  ; SIGS KeyEvent -> SIGS
