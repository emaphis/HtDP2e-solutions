;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_04_editor_4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.4 Checking the World
;; Exercises: 114

;; Ex. 114:
;; Use the predicates from exercise 113 to check the space invader world
;; program, the virtual pet program (exercise 106), and the editor program
;; (A Graphical Editor)

;; See editor3.rkt

(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [str idx])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor s i) describes an editor
; whose visible text is s with the cursor displayed at index i

(define ED1 (make-editor "" 0)) ; Empty editor
(define ED2 (make-editor "Hello world" 0)) ; Cursor at beginning or buffuer
(define ED3 (make-editor "Hello world"  ; Cursor at end of buffer
                         (string-length "Hello world")))

; Editor -> ???
#;; template
(define (fn-for-editor e)
  (... (... (editor-str e))
       (... (editor-idx e))))


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

(check-expect (render (make-editor "" 0))
              (overlay/align "left" "center"
                             (beside (text "" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "" TEXT-SIZE TEXT-COLOR))
                             MT))

(check-expect (render (make-editor "hello world" 0))
              (overlay/align "left" "center"
                             (beside (text "" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "hello world" TEXT-SIZE TEXT-COLOR))
                             MT))

(check-expect (render (make-editor "hello world"
                                   (string-length "hello world")))
              (overlay/align "left" "center"
                             (beside (text "hello world" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "" TEXT-SIZE TEXT-COLOR))
                             MT))

(check-expect (render (make-editor "hello world" 7))
              (overlay/align "left" "center"
                             (beside (text "hello w" TEXT-SIZE TEXT-COLOR)
                                     CURSOR
                                     (text "orld" TEXT-SIZE TEXT-COLOR))
                             MT))

;(define (render ed) MT) ; stub

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
                 MT))

; Editor -> String
; return a Editor's String delimeded by Editor's index position
(check-expect (editor-pre (make-editor "hello" 0)) "")
(check-expect (editor-pre (make-editor "hello"
                                       (string-length "hello"))) "hello")
(check-expect (editor-pre (make-editor "hello" 3)) "hel")

(define (editor-pre ed)
  (substring (editor-str ed) 0 (editor-idx ed)))

; Editor -> String
; return the Editor's String from Editor's idx until end
(check-expect (editor-post (make-editor "hello" 0)) "hello")
(check-expect (editor-post (make-editor "hello"
                                        (string-length "hello"))) "")
(check-expect (editor-post (make-editor "hello" 3)) "lo")

(define (editor-post ed)
  (substring (editor-str ed) (editor-idx ed) (string-length (editor-str ed))))


; Editor KeyEvent -> Editor
; add or delete chars to the buffor or move the cursor around
(check-expect (edit (make-editor "hello" 3) "left")
              (make-editor "hello" 2))
(check-expect (edit (make-editor "hello" 3) "right")
              (make-editor "hello" 4))
(check-expect (edit (make-editor "hello" 3) "a")
              (make-editor "helalo" 4))
(check-expect (edit (make-editor "hello" 3) "\b")
              (make-editor "helo" 2))

;(define (edit ed ke) (make-editor "" 0)) ;stub

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
(check-expect (cursor-left (make-editor "hello" 4)) (make-editor "hello" 3))
(check-expect (cursor-left (make-editor "hello" 0)) (make-editor "hello" 0))

(define (cursor-left ed)
  (cond [(zero? (editor-idx ed)) ed]
        [else (make-editor (editor-str ed) (sub1 (editor-idx ed)))]))

; Editor-> Editor
; move cursor right
(check-expect (cursor-right (make-editor "hello" 3)) (make-editor "hello" 4))
(check-expect (cursor-right (make-editor "hello" (string-length "hello")))
              (make-editor "hello" (string-length "hello")))

(define (cursor-right ed)
  (cond [(= (editor-idx ed) (string-length (editor-str ed))) ed]
        [else
         (make-editor (editor-str ed) (add1 (editor-idx ed)))]))

; Editor -> Editor
; delete 1String to the left of the Cursor
(check-expect (delete-left (make-editor "hello" 3)) (make-editor "helo" 2))
(check-expect (delete-left (make-editor "hello" 0)) (make-editor "hello" 0))

(define (delete-left ed)
  (cond [(zero? (editor-idx ed))  ed]
        [else
         (make-editor (string-append (string-remove-last (editor-pre ed))
                                     (editor-post ed))
                      (sub1 (editor-idx ed)))]))

; Editor 1String -> Editor
; add 1String to the right of the Cursor
(check-expect (add-right (make-editor "hello" 3) "d")
              (make-editor "heldlo" 4))

(define (add-right ed c)
  (make-editor (string-append (editor-pre ed) c (editor-post ed))
               (add1 (editor-idx ed))))

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


;;;;;;;;;;
; Any -> Booelean
; is the editor's index a proper coordinate
(check-expect (good-idx? (make-editor "hello" 0)) #true)
(check-expect (good-idx? (make-editor "hello" 3)) #true)
(check-expect (good-idx? (make-editor "hello" 5)) #true)

(check-expect (good-idx? (make-editor "hello" -1)) #false)
(check-expect (good-idx? (make-editor "hello" 6)) #false)
(check-expect (good-idx? (make-editor "hello" "world")) #false)

(define (good-idx? e)
  (and (number? (editor-idx e))
       (>= (string-length (editor-str e))
           (editor-idx e))
       (>= (editor-idx e) 0)))


; Editor -> Editor
; start with: (run (make-editor "hello world" 0)
(define (run ed)
  (big-bang ed                     ; Editor
            [check-with good-idx?] ; Any -> Boolean
            [to-draw   render]     ; Editor -> Image
            [on-key edit]))        ; Editor KeyEvent -> Editor