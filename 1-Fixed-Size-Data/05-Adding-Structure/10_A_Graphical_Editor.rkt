;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_A_Graphical_Editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.10 A Graphical Editor
;; Exercises: 83-87


;; 5.10 A Graphical Editor

;; An editor needs to keep track of two items: the text entered so far, and
;; the cursor positon.


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


;; See exercise 83, 84, 85, 86, 87
