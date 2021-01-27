;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex085) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 85:
;; Define the function run. It consumes a string, the pre field of an editor,
;; and launches an interactive editor, using render and edit from the preceding
;; two exercises for the to-draw and on-key clauses.


(require 2htdp/image)
(require 2htdp/universe)

;; data definition - the editor

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
; the cursor displayed between s and t

(define ED1 (make-editor "" "")) ; Empty editor
(define ED2 (make-editor "" "Hello world")) ; Cursor at beginning or buffuer
(define ED3 (make-editor "He" "llo world")) ; Cursor after "e" in buffer


;; graphical constants

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

(define BUFFER-LENGTH 200) ; length of buffer display
(define BUFFER-HEIGHT 20)  ; height of buffer display

(define MT (empty-scene BUFFER-LENGTH BUFFER-HEIGHT))

(define CURSOR-COLOR "red")
(define CURSOR (rectangle 1 BUFFER-HEIGHT "solid" CURSOR-COLOR))


; String -> Image
; Render text with default properties
(check-expect (render-text "")
              (text "" TEXT-SIZE TEXT-COLOR))
(check-expect (render-text "hello")
              (text "hello" TEXT-SIZE TEXT-COLOR))

(define (render-text txt)
  (text txt TEXT-SIZE TEXT-COLOR))


; try a mock-up
(define MOCK-UP1 (overlay/align "left" "center"
                                (beside (render-text "hel")
                                        CURSOR
                                        (render-text "lo world"))
                                MT))



; Editor -> Image
; produce an Image of text given an Editor

(check-expect (render (make-editor "" ""))
              (overlay/align "left" "center"
                             (beside (render-text "")
                                     CURSOR
                                     (render-text ""))
                             MT))

(check-expect (render (make-editor "hel" "lo world"))
              (overlay/align "left" "center"
                             (beside (render-text "hel")
                                     CURSOR
                                     (render-text "lo world"))
                             MT))

;(define (render ed) MT) ;stub

(define (render ed)
  (overlay/align "left" "center"
                 (beside (render-text (editor-pre ed))
                         CURSOR
                         (render-text (editor-post ed)))
                 MT))


;;; Editor functionality

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
        [(key=? ke "\t") ed] ; ignore
        [(key=? ke "\r") ed] ; ignore
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
(check-expect (string-first "") "")
(check-expect (string-first "s") "s")
(check-expect (string-first "string") "s")

(define (string-first str)
  (if (> (string-length str) 0)
      (substring str 0 1)
      str))


; String -> String
; extracts all but the first 1String from a String
(check-expect (string-rest "") "")
(check-expect (string-rest "b") "")
(check-expect (string-rest "string") "tring")

(define (string-rest str)
  (if (> (string-length str) 0)
      (substring str 1)
      str))


; String -> 1String
; extracts the last 1String from a non-empty string.
(check-expect (string-last "") "")
(check-expect (string-last "d") "d")
(check-expect (string-last "hello world") "d")

(define (string-last str)
  (if (> (string-length str) 0)
      (substring str (- (string-length str) 1))
      str))


; String -> String
; remove the last 1String in a non-empty String
(check-expect (string-remove-last "") "")
(check-expect (string-remove-last "b") "")
(check-expect (string-remove-last "string") "strin")

(define (string-remove-last str)
  (if (> (string-length str) 0)
      (substring str 0 (sub1 (string-length str)))
      str))


;;  ex 85 :

; Editor -> Editor
; start with: (run (make-editor "hello world" ""))
(define (run ed)
  (big-bang ed                   ; Editor
            (to-draw   render)   ; Editor -> Image
            (on-key    edit)))   ; Editor KeyEvent -> Editor

;; test example
;(run (make-editor "hello world" ""))
