;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_02_02_03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.2 Functions
;; 2.2.3 Programs
(require 2htdp/image)
(require 2htdp/batch-io)
(require 2htdp/universe)

;; Batch Programs

;; Letter sample -- function composition
;; defined last section

(define (letter fst lst signature-name) 
  (string-append
   (opening fst) 
   "\n" 
   (body fst lst) 
   "\n" 
   (closing signature-name))) 

(define (opening fst) 
  (string-append "Dear " fst ",")) 

(define (body fst lst) 
  (string-append 
   "We have discovered that all people with the last name " 
   "\n" 
   lst " have won our lottery. So, " fst ", " 
   "\n" 
   "hurry and pick up your prize.")) 

(define (closing signature-name) 
  (string-append 
   "Sincerely," 
   "\n" 
   signature-name)) 

;(letter "Robby" "Flatt" "Felleisen")
;(letter "Christopher" "Columbus" "Felleisen")
;(letter "ZC" "Krishnamurthi" "Felleisen")

;(write-file "Matthew-Krishnamurthi.txt" 
;            (letter "Matthew" "Krishnamurthi" "Felleisen")) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (f2c f)
  (* 5/9 (- f 32)))

(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)
(check-expect (f2c -40) -40)

#;
(define (convert in out)
  (write-file out
    (number->string
      (f2c
        (string->number (read-file in))))))


;(convert "sample.dat" "out.dat")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interactive Programs

(define (render t)
  (text (number->string t) 12 "red"))

(big-bang 100
          (on-tick sub1)
          (to-draw render)
          (stop-when zero?))

