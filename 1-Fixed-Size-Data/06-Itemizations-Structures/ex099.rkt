;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex099) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions form 99:
;;  Design si-move. This function is called for every clock tick to determine
;; to which position the objects move now. Accordingly it consumes an element
;; of SIGS and produces another one.

;; Constants

(define TANK-SPEED 3)
(define UFO-SPEED 7)
(define MISSILE-SPEED 10)
(define JUMP 7) ; UFO randomly jumps by this amount


;;; data definitions

(define-struct aim [ufo tank])

(define-struct fired [ufo tank missile])

(define-struct tank [loc vel])

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
