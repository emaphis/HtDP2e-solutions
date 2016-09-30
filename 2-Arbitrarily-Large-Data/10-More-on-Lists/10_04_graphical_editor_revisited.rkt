;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_04_graphical_editor_revisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.4 A Graphical Editor, Revisited
;; Exercises: 177-180


; a third alternative for an Editor structure

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S)
; interpretation:
;    pre the letters in pre precede the cursor in reverse order.
;    post: the letters after the cursor

; An Lo1S is one of:
; – '()
; – (cons 1String Lo1S)

; some data examples

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))

; data example 1:
(define EDITOR (make-editor all good))

; data example 2:
(define REV-EDITOR (make-editor lla good))


; Editor -> String
; retreave the Editor's text
(check-expect (get-text (make-editor lla good)) "allgood")

(define (get-text ed)
  (string-append (implode (rev (editor-pre ed)))
                 (implode (editor-post ed))))


; My first attempt a 'rev':
; Lo1s -> Lo1s
; reverses a List of 1Strings
(check-expect (rev2 (cons "a" (cons "b" (cons "c" '()))))
              (cons "c" (cons "b" (cons "a" '()))))

(define (rev2 lst)
  (cond [(empty? lst) '()]
        [else
         (append (rev (rest lst))
                 (cons (first lst) '()))]))


; Lo1s -> Lo1s
; reverse a list of 1String
(check-expect (rev (cons "a" (cons "b" (cons "c" '()))))
              (cons "c" (cons "b" (cons "a" '()))))

(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
(check-expect (add-at-end '() "a") (cons "a" '()))
(check-expect (add-at-end (cons "c" (cons "b" '())) "a")
              (cons "c" (cons "b" (cons "a" '()))))

(define (add-at-end l s)
  (cond [(empty? l) (cons s l)] ; the base case does the actual work
        [else (cons (first l)
                    (add-at-end (rest l) s))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 177:
;; Design the function create-editor. The function consumes two strings and
;; produces an Editor. The first string is the text to the left of the cursor
;; and the second string is the text to the right of the cursor. The rest of
;; the section relies on this function.


; String String -> Editor
; creates an editor given a String the represents text before the cursor
; and a string after the cursor
(check-expect (create-editor "all" "good") (make-editor lla good))

(define (create-editor pre post)
  (make-editor (rev (explode pre))
               (explode post)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; editor world program

(require 2htdp/image)
(require 2htdp/universe)


;; graphical constants
(define HEIGHT 20) ; the height of the editor
(define WIDTH 200) ; its width
(define FONT-SIZE 16) ; the font size
(define FONT-COLOR "black") ; the font color

(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))


;; world event handlers:

; Editor KeyEvent -> Editor
; deals with a key event, given some editor

(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))

(check-expect (editor-kh (create-editor "" "fgh") "\b")
              (create-editor "" "fgh"))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "\b")
  (create-editor "c" "fgh"))

(check-expect (editor-kh (create-editor "" "fgh") "left")
              (create-editor "" "fgh"))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "left")
  (create-editor "c" "dfgh"))

(check-expect (editor-kh (create-editor "cde" "") "right")
              (create-editor "cde" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "right")
  (create-editor "cdf" "gh"))

;; do nothing
(check-expect (editor-kh (create-editor "cd" "fgh") "\t")
              (create-editor "cd" "fgh"))
(check-expect (editor-kh (create-editor "cd" "fgh") "\r")
              (create-editor "cd" "fgh"))
(check-expect (editor-kh (create-editor "cd" "fgh") "up")
              (create-editor "cd" "fgh"))

(define (editor-kh ed ke)
  (cond
    [(key=? ke "left") (editor-lft ed)]
    [(key=? ke "right") (editor-rgt ed)]
    [(key=? ke "\b") (editor-del ed)]
    [(key=? ke "\r") ed]
    [(key=? ke "\t") ed]
    [(= (string-length ke) 1) (editor-ins ed ke)]
    [else ed]))


;;;;;;;;;;;;;;;;;;;
;; Ex. 178:
;; Explain why the template for editor-kh deals with "\t" and "\r" before it
;; checks for strings of length 1.

;; '\t' '\r' show up as 1Strings, the '\' is an escapre char to represent
;; unprintable characters.

;;;;;;;;;;;;;;;;;;;;;;


; Editor 1String -> Editor
; insert the 1String k between pre and post
(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '()))

(check-expect
  (editor-ins
    (make-editor (cons "d" '())
                 (cons "f" (cons "g" '())))
    "e")
  (make-editor (cons "e" (cons "d" '()))
               (cons "f" (cons "g" '()))))

(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

;; Q1: Use the interpretation of Editor and explain abstractly why this
;; function performs the insertion.


; A: The structure contains two lists of chars representing a complete string of
; text divided by a cursor.  Since the first is a list in reverse cons adds
; elements to the end.

;; Q2: And if this isn’t enough, you may wish to compare this simple definition
;; with the one from exercise 84 and figure out why the other one needs an
;; auxiliary function while our definition here doesn’t.

; I didn't use an auxiliary function rather, this one used cons to build lists
; while the earlier version used string-append.


;; Ex. 179:
;; Design the rest of the keyboard handler functions.
;; Again, it is critical that you work through a good range of examples.


; Editor -> Editor
; moves the cursor position one 1String left,
; if possible

(check-expect (editor-lft (create-editor "" "fgh"))
              (create-editor "" "fgh"))
(check-expect
  (editor-lft (create-editor "cd" "fgh"))
  (create-editor "c" "dfgh"))

(define (editor-lft ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else
     (make-editor (rest (editor-pre ed))
                  (cons (first (editor-pre ed))
                        (editor-post ed)))]))


; Editor -> Editor
; moves the cursor position one 1String right,
; if possible

(check-expect (editor-rgt (create-editor "cde" ""))
              (create-editor "cde" ""))
(check-expect
  (editor-rgt (create-editor "cd" "fgh"))
  (create-editor "cdf" "gh"))

(define (editor-rgt ed)
  (cond [(empty? (editor-post ed)) ed]
        [else
         (make-editor (cons (first (editor-post ed))
                            (editor-pre ed))
                      (rest (editor-post ed)))]))


; Editor -> Editor
; deletes a 1String to the left of the cursor
; if possible

(check-expect (editor-del (create-editor "" "fgh"))
              (create-editor "" "fgh"))
(check-expect
  (editor-del (create-editor "cd" "fgh"))
  (create-editor "c" "fgh"))

(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else
     (make-editor (rest (editor-pre ed))
                  (editor-post ed))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the rendering function

;; Mock up:
; (create-editor "pre" "post")
(define MOCK-UP (place-image/align
                 (beside (text "pre" FONT-SIZE FONT-COLOR)
                         CURSOR
                         (text "post" FONT-SIZE FONT-COLOR))
                 1 1
                 "left" "top"
                 MT))


; Editor -> Image
; renders an editor as an image of the two texts
; separated by the cursor
(define (editor-render e)
  (place-image/align
   (beside (editor-text (rev (editor-pre e)))
           CURSOR
           (editor-text (editor-post e)))
   1 1
   "left" "top"
   MT))



; Lo1s -> Image
; renders a list of 1String as a text image
(check-expect (editor-text '()) (text "" FONT-SIZE FONT-COLOR))
(check-expect (editor-text good) (text "good" FONT-SIZE FONT-COLOR))
(check-expect (editor-text
               (cons "p" (cons "o" (cons "s" (cons "t" '())))))
              (text "post" FONT-SIZE FONT-COLOR))

#;
(define (editor-text s)
  (cond
    [(empty? s) ...]
    [else (... (first s)
           ... (editor-text (rest s)) ...)]))

(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))

; an 'implode' example
(check-expect
 (implode (cons "p" (cons "o" (cons "s" (cons "t" '())))))
 "post")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 180:
;; Design editor-text without using implode.

; Lo1s -> Image
; renders a list of 1String as a text image
(check-expect (editor-text.v2 '()) (text "" FONT-SIZE FONT-COLOR))
(check-expect (editor-text.v2 good) (text "good" FONT-SIZE FONT-COLOR))
(check-expect (editor-text.v2
               (cons "p" (cons "o" (cons "s" (cons "t" '())))))
              (text "post" FONT-SIZE FONT-COLOR))

(define (editor-text.v2 s)
  (text (conses s) FONT-SIZE FONT-COLOR))

; Lo1s -> String
; conses a List-of-1String into a String
(check-expect (conses '()) "")
(check-expect (conses (cons "p" (cons "o" (cons "s" (cons "t" '())))))
              "post")

(define (conses s)
  (cond
    [(empty? s) ""]
    [else
     (string-append (first s)
                    (conses (rest s)))]))


;; The main program:

; main : String -> Editor
; launches the editor given some initial string
; run with: (main "hello world")
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))
