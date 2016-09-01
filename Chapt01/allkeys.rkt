;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname allkeys) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.3.6 Designing World Programs
;; allkeys example
;; Exercise 36

(require 2htdp/image)
(require 2htdp/universe)

;; My world program  (make this more specific)

;; =================


;; Constants:

;; physical constants: 
(define WIDTH 100) 
(define HEIGHT 50) 
  
;; graphical constant: 
(define MT (empty-scene WIDTH HEIGHT)) 


;; =================
;; Data definitions:

;; AllKeys is a String.  
;; interp. the sequence of keys pressed since  
;; big-bang created the canvas 


;; =================
;; Functions:

;; AllKeys -> AllKeys
;; start the world with (main "")
;; 
(define (main ak)
  (big-bang ak                        ; AllKeys
            (to-draw   show)          ; AllKeys -> Image
            (on-key    remember)))    ; AllKeys KeyEvent -> AllKeys

;; AllKeys -> AllKeys
;; produce the next ...
;; !!!
;(define (tock ak) ...)


;; AllKeys -> Image
;; render the string as a text and place it into MT
(check-expect 
 (show "hello") (place-image (text "hello" 11 "red") 10 20 MT)) 
(check-expect 
 (show "mark") (place-image (text "mark" 11 "red") 10 20 MT)) 
  
;(define (show ak) MT) ;stub

(define (show ak) 
  (place-image (text ak 11 "red") 10 20 MT)) 



; AllKeys String -> AllKeys   
; add ke to ak, the state of the world   
(check-expect (remember "hello" " ") "hello ") 
(check-expect (remember "hello " "w") "hello w") 

;(define (remember ak ke) ak) ;stub
(define (remember ak ke)
  (cond [(or (string=? ke "\t") (string=? ke "\r")) ak]
        [(= (string-length ke) 1) 
         (string-append ak ke)]
        [else ak]))