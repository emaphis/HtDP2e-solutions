;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex083) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 83:
;; Design the function render, which consumes an Editor and produces an image.

(require 2htdp/image)
(require 2htdp/universe)

;; data definition

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

;; test examples
;(render ED1)
;(render ED2)
;(render ED3)
