;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 109_finite_sm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.2 Mixing up Worlds
;; Exercises: 106

;; Ex. 106:
;; Design a world program that recognizes a pattern in a sequence of KeyEvents.
;; Initially the program shows a 100 by 100 white rectangle. Once your program
;; has encountered the first desired letter, it displays a yellow rectangle of
;; the same size. After encountering the final letter, the color of the
;; rectangle turns green. If any “bad” key event occurs, the program displays
;; a red rectangle.


; a finite state machine

(require 2htdp/image)
(require 2htdp/universe)


; graphical consatnts

(define WIDTH 200)
(define HEIGHT 200)
(define H-WIDTH (/ WIDTH 2))
(define H-HEIGHT (/ HEIGHT 2))

(define TEXT-SIZE 10)
(define TEXT-CLR "black")
(define TEXT-CLR-ER "white")

(define CLR-START "white")
(define CLR-GOOD  "yellow")
(define CLR-END   "green")
(define CLR-ERROR  "red")

(define MT (empty-scene WIDTH HEIGHT "white"))



;;;;;;;;;;;;;;;;;;;;
;; data defintitions

; ExpectsToSee is one of:
; - AA
; - BC
; - DD
; - ER

(define AA "start, expect to see an 'a' next")
(define BC "expect to see: 'b', 'c' or 'd'")
(define DD "encountered a 'd', finished")
(define ER "error, user pressed illegal key")

; ExpectsToSee -> ???
#; ; template
(define (fn-for-ets ets)
  (cond [(string=? AA ets) (... ets)]
        [(string=? BC ets) (... ets)]
        [(string=? DD ets) (... ets)]
        [(string=? ER ets) (... ets)]))


;; mock up

(define AA1 (place-image/align
             (text AA TEXT-SIZE TEXT-CLR)
             H-WIDTH H-HEIGHT "center" "center"
             (overlay
              (rectangle WIDTH HEIGHT "solid" CLR-START) MT)))


;;;;;;;;;;;;;;;;;;;;;;
;; function definitions

; ExpectsToSee -> Image
(check-expect (render AA) (render-ets AA CLR-START))
(check-expect (render BC) (render-ets BC CLR-GOOD))
(check-expect (render DD) (render-ets DD CLR-END))
(check-expect (render ER) (render-ets ER CLR-ERROR))

;(define (render ets) MT) ; stub

(define (render ets)
  (cond [(string=? AA ets) (render-ets ets CLR-START)]
        [(string=? BC ets) (render-ets ets CLR-GOOD)]
        [(string=? DD ets) (render-ets ets CLR-END)]
        [(string=? ER ets) (render-ets ets CLR-ERROR)]))


; ExpectsToSee Color -> Image
; render an ExpectsToSee on an empty scene

(check-expect (render-ets AA CLR-START)
              (place-image/align
               (text AA TEXT-SIZE TEXT-CLR)
               H-WIDTH H-HEIGHT "center" "center"
               (overlay
                (rectangle WIDTH HEIGHT "solid" CLR-START)
                MT)))

(define (render-ets ets clr)
  (place-image/align
             (text ets TEXT-SIZE TEXT-CLR)
             H-WIDTH H-HEIGHT "center" "center"
             (overlay
              (rectangle WIDTH HEIGHT "solid" clr)
              MT)))


;; the state machine

; ExpectsToSee 1String -> ExpectsToSee
; given a state macheine and a letter, returns the next state machine
(check-expect (machine AA "a") BC)  ; start the machine

(check-expect (machine BC "b") BC)  ; normal
(check-expect (machine BC "c") BC)  ; normal

(check-expect (machine AA "n") ER)  ; error
(check-expect (machine BC "n") ER)  ; error

(check-expect (machine BC "d") DD)  ; stop the machine

(check-expect (machine ER "n") ER)  ; pass errors through

(define (machine ets lt)
  (cond [(string=? AA ets)
         (cond [(string=? lt "a") BC]
               [else ER])]
        [(string=? BC ets)
         (cond [(or (string=? lt "b")
                    (string=? lt "c")) BC]
               [(string=? lt "d") DD]
               [else ER])]
        [else ets]))  ; pass



; ExpectsToSee KeyEvent -> ExpectsToSee
; runs machine using keyboard control
(check-expect (run-machine BC "b") BC)
(check-expect (run-machine ER "n") ER)

(define (run-machine ets ke)
  (cond [(= (string-length ke) 1)
         (machine ets ke)]
        [else ets]))

; ExpectToSee -> Boolean
; stop machine on DD state
(check-expect (stop? DD) #true)
(check-expect (stop? AA) #false)
(check-expect (stop? BC) #false)
(check-expect (stop? ER) #false)

(define (stop? ets)
  (string=? DD ets))


;;;;;;;;;;;;;;;;;;;;
;; the main program
;; run: (main AA)

(define (main ets)
  (big-bang ets
            [to-draw render]     ; ExpectsToSee -> Img
            [on-key run-machine] ; ExpectsToSee KeyEvent => ExpectsToSee
            [stop-when stop?]     ; ExpectsToSee -> Boolean
            ))
