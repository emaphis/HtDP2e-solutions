;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09_Structure_in_the_World) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
1`;; HtDP 2e - 5 Adding Structure
;; 5.9 Structure in the World

(require 2htdp/image)
(require 2htdp/universe)


;; 5.9 Stucture in the World

;; for world programs use stuctures to hold more than one piece of changing
;; data


;; data type to hold tank and ufo info.

(define-struct space-game [ufo tank])
; space-game is a (make-space-game Number Number)
; interp. a game state with ufo at y pos and a tank at x pos

(define GAME-STATE-1 (make-space-game 100 0))

; Space-game -> ???
#;; template
(define (fn-for-space-game g)
  (... (... (space-game-ufo g))
       (... (space-game-tank g))))

; A SpaceGame is a structure:
;   (make-space-game Posn Number).
; interpretation (make-space-game (make-posn ux uy) tx)
; describes a configuration where the UFO is
; at (ux,uy) and the tank's x-coordinate is tx
