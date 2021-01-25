;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |05_09_structure_in the_world|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.9 Structure in the World
;; 5.10 Grapical Editor
;; Exercises: 83-87

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


;; 5.10 A Graphical Editor



(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
; the cursor displayed between s and t

(define ED1 (make-editor "" "")) ; Empty editor
(define ED2 (make-editor "" "Hello world")) ; Cursor at beginning or buffuer
(define ED3 (make-editor "He" "llo world")) ; Cursor after "e" in buffer


; Editor -> ???
#;; template
(define (fn-for-editor e)
  (... (... (editor-pre e))
       (... (editor-post e))))


;; Ex. 83:
;; Design the function render, which consumes an Editor and produces an image.

;; graphical constants
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

(define BUFFER-LENGTH 200) ; length of buffer display
(define BUFFER-HEIGHT 20)  ; height of buffer display

(define MT (empty-scene BUFFER-LENGTH BUFFER-HEIGHT))

(define CURSOR (rectangle 1 BUFFER-HEIGHT "solid" "red"))

; try a mock-up
(define MOCK-UP1 (overlay/align "left" "center"
                                (beside (text "hel" TEXT-SIZE TEXT-COLOR)
                                        CURSOR
                                        (text "lo world" TEXT-SIZE TEXT-COLOR))
                                MT))

; Editor -> Image
; produce an Image given and Editor

(check-expect (render (make-editor "" ""))
              (overlay/align "left" "center"
                             (beside (text "" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "" TEXT-SIZE TEXT-COLOR))
                             MT))

(check-expect (render (make-editor "hel" "lo world"))
              (overlay/align "left" "center"
                             (beside (text "hel" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "lo world" TEXT-SIZE TEXT-COLOR))
                             MT))

;(define (render ed) MT) ;stub

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
                 MT))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 84:
;; Design edit. The function consumes two inputs, an editor ed and
;; a KeyEvent ke, and it produces another editor. Its task is to add
;; a single-character KeyEvent ke to the end of the pre field of ed, unless ke
;; denotes the backspace ("\b") key. In that case, it deletes the character
;; immediately to the left of the cursor (if there are any). The function
;; ignores the tab key ("\t") and the return key ("\r").

;; The function pays attention to only two KeyEvents longer than one letter:
;; "left" and "right". The left arrow moves the cursor one character to the
;; left (if any), and the right arrow moves it one character to the right (if
;; any). All other such KeyEvents are ignored.

;; Develop a good number of examples for edit, paying attention to special
;; cases. When we solved this exercise, we created 20 examples and turned all
;; of them into tests.

;; Hint Think of this function as consuming KeyEvents, a collection that is
;; specified as an enumeration. It uses auxiliary functions to deal with the
;; Editor structure. Keep a wish list handy; you will need to design
;; additional functions for most of these auxiliary functions, such as
;; string-first, string-rest, string-last, and string-remove-last. If you
;; haven’t done so, solve the exercises in Functions.

; Editor KeyEvent -> Editor
; add or delete chars to the buffor or move the cursor around
(check-expect (edit (make-editor "hel" "lo") "left")
              (make-editor "he" "llo"))
(check-expect (edit (make-editor "" "hello") "left")
              (make-editor "" "hello"))

(check-expect (edit (make-editor "hel" "lo") "right")
              (make-editor "hell" "o"))
(check-expect (edit (make-editor "hello" "") "right")
              (make-editor "hello" ""))

(check-expect (edit (make-editor "hel" "lo") "a")
              (make-editor "hela" "lo"))

(check-expect (edit (make-editor "hel" "lo") "\b")
              (make-editor "he" "lo"))
(check-expect (edit (make-editor "" "hello") "\b")
              (make-editor "" "hello"))

(check-expect (edit (make-editor "hel" "lo") "\t")
              (make-editor "hel" "lo"))
(check-expect (edit (make-editor "hel" "lo") "\r")
              (make-editor "hel" "lo"))

;(define (edit ed ke) (make-editor "" "")) ;stub

(define (edit ed ke)
  (cond
        [(key=? ke "left")  (cursor-left ed)]
        [(key=? ke "right") (cursor-right ed)]
        [(key=? ke "\b")    (delete-left ed)]
        [(key=? ke "\t") ed]
        [(key=? ke "\r") ed]
        [(equal? (string-length ke) 1)
         (add-right ed ke)]
        [else ed])) ; ignore other key presses


;; edit string helper functions

; Editor-> Editor
; move cursor left
(check-expect (cursor-left (make-editor "hel" "lo")) (make-editor "he" "llo"))
(check-expect (cursor-left (make-editor "" "hello")) (make-editor "" "hello"))

(define (cursor-left ed)
  (cond [(string=? (editor-pre ed) "") ed]
        [else
         (make-editor (string-remove-last (editor-pre ed))
                      (string-append (string-last (editor-pre ed))
                                     (editor-post ed)))]))

; Editor-> Editor
; move cursor right
(check-expect (cursor-right (make-editor "hel" "lo")) (make-editor "hell" "o"))
(check-expect (cursor-right (make-editor "hello" "")) (make-editor "hello" ""))

(define (cursor-right ed)
  (cond [(string=? (editor-post ed) "") ed]
        [else
         (make-editor (string-append (editor-pre ed)
                                     (string-first (editor-post ed)))
                      (string-rest (editor-post ed)))]))

; Editor -> Editor
; delete 1String to the left of the Cursor
(check-expect (delete-left (make-editor "hel" "lo")) (make-editor "he" "lo"))
(check-expect (delete-left (make-editor "" "hello")) (make-editor "" "hello"))

(define (delete-left ed)
  (cond [(string=? (editor-pre ed) "")  ed]
        [else
         (make-editor (string-remove-last (editor-pre ed))
                      (editor-post ed))]))

; Editor 1String -> Editor
; add 1String to the right of the Cursor
(check-expect (add-right (make-editor "hel" "lo") "d")
              (make-editor "held" "lo"))

(define (add-right ed c)
  (make-editor (string-append (editor-pre ed) c) (editor-post ed)))

; string handling helpers

; String -> 1String
; extracts the first 1String from a non-empty string.
; Don’t worry about empty strings. (ex. 13)
(check-expect (string-first "s") "s")
(check-expect (string-first "string") "s")

(define (string-first str)
  (substring str 0 1))

; String -> String
; extracts all but the first 1String from a String
(check-expect (string-rest "b") "")
(check-expect (string-rest "string") "tring")

(define (string-rest s)
  (substring s 1 (string-length s)))

; String -> 1String
; extracts the last 1String from a non-empty string.
; Don’t worry about empty strings. (ex. 14)
(check-expect (string-last "d") "d")
(check-expect (string-last "hello world") "d")

(define (string-last str)
  (substring str (- (string-length str) 1)))

; String -> String
; remove the last 1String in a non-empty String
(check-expect (string-remove-last "b") "")
(check-expect (string-remove-last "string") "strin")

(define (string-remove-last str)
  (substring str 0 (sub1 (string-length str))))


;; Ex. 85:
;; Define the function run. It consumes a string, the pre field of an editor,
;; and launches an interactive editor, using render and edit from the preceding
;; two exercises for the to-draw and on-key clauses.

; Editor -> Editor
; start with: (run (make-editor "hello world" "")
(define (run ed)
  (big-bang ed                   ; Editor
            (to-draw   render)   ; Editor -> Image
            (on-key    edit)))   ; Editor KeyEvent -> Editor


;; Ex. 86:
;; Notice that if you type a lot, your editor program does not display all of
;; the text. Instead the text is cut off at the right margin. Modify your
;; function edit from exercise 84 so that it ignores a keystroke if adding it
;; to the end of the pre field would mean the rendered text is too wide for
;; your canvas.
;; See editor2.rkt


;; Ex. 87:
;; Develop a data representation for an editor based on our first idea, using
;; a string and an index. Then solve the preceding exercises again. Re-trace
;; the design recipe. Hint if you haven’t done so, solve the exercises in
;; Functions.
;; See editor3.rkt