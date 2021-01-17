;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname editor2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.10 Grapical Editor
;; Exercises: 86

;; Ex. 86:
;; Notice that if you type a lot, your editor program does not display all of
;; the text. Instead the text is cut off at the right margin. Modify your
;; function edit from exercise 84 so that it ignores a keystroke if adding it
;; to the end of the pre field would mean the rendered text is too wide for
;; your canvas.

(require 2htdp/image)
(require 2htdp/universe)

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


(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
                 MT))


; Editor KeyEvent -> Editor
; add or delete chars to the buffor or move the cursor around
(check-expect (edit (make-editor "hel" "lo") "left")
              (make-editor "he" "llo"))
(check-expect (edit (make-editor "hel" "lo") "right")
              (make-editor "hell" "o"))
(check-expect (edit (make-editor "hel" "lo") "a")
              (make-editor "hela" "lo"))
(check-expect (edit (make-editor "hel" "lo") "\b")
              (make-editor "he" "lo"))

;(define (edit ed ke) (make-editor "" "")) ;stub

(define (edit ed ke)
  (cond
        [(key=? ke "left")  (cursor-left ed)]
        [(key=? ke "right") (cursor-right ed)]
        [(key=? ke "\b")    (delete-left ed)]
        [(equal? (string-length ke) 1)
         (add-right-limit ed ke)]
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

; Editor 1String -> Editor
; add 1String to String until buffer limit
; BLECH: this feels kind of hackish.
(define (add-right-limit ed c)
  (cond
    [(> (image-width (render (add-right ed c))) BUFFER-LENGTH) ed]
    [else (add-right ed c)]))


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


; Editor -> Editor
; start with: (run (make-editor "hello world" "")
(define (run ed)
  (big-bang ed                   ; Editor
            (to-draw   render)   ; Editor -> Image
            (on-key    edit)))   ; Editor KeyEvent -> Editor
