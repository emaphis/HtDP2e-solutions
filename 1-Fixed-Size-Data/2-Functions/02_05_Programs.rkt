;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chp1_02_5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 2.2 Functions
;; 2.2.4 Programs
;; Ex 33,34
(require 2htdp/batch-io)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Batch Programs

;> (write-file "sample.dat" "212")
;"sample.dat"

;> (read-file "sample.dat")
;"212"


(define (C f)
  (* 5/9 (- f 32)))

(check-expect (C 32) 0)
(check-expect (C 212) 100)
(check-expect (C -40) -40)


(define (convert in out)
  (write-file out
              (string-append
               (number->string
                (C
                 (string->number
                  (read-file in))))
               "\n")))

;> (write-file "sample.dat" "212")
;"sample.dat"

;> (convert "sample.dat" 'stdout)
;100
;'stdout

;> (convert "sample.dat" "out.dat")
;"out.dat"

;> (read-file "out.dat")
;"100"


;; Ex. 33:
;; 33. Recall the letter program from Composing Functions.
;; Here is how to launch the program and have it write its output to the interactions area: 

;; Letter sample -- function composition
;; defined last section

(define (letter fst lst signature-name) 
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst) 
   "\n\n"
   (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append 
   "We have discovered that all people with the"  "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

;; Here is a letter-writing batch program that reads names from three files
;; and writes a letter to one:
(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

;(write-file "first.dat" "Matt")
;(write-file "last.dat" "Johnson")
;(write-file "sig.dat" "Edward")

;(main "first.dat" "last.dat" "sig.dat"  "letter.dat")

;(read-file "letter.dat")

;(letter "Robby" "Flatt" "Felleisen")
;(letter "Christopher" "Columbus" "Felleisen")
;(letter "ZC" "Krishnamurthi" "Felleisen")

;(write-file "Matthew-Krishnamurthi.txt" 
;            (letter "Matthew" "Krishnamurthi" "Felleisen")) 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interactive Programs

(require 2htdp/image)
(require 2htdp/universe)

;; Ex 34:

;; Tem different events varius interactive programs will have to deal with:
;; Eye movements, skin temperature, heart rate, screan touches, car speeds, car postions,
;; incomming messages.


;; first basic definitions:
(define (number->square s)
  (square s "solid" "red"))

; > (big-bang 100 [to-draw number->square])

;(big-bang 100
;          [to-draw number->square]
;          [on-tick sub1]
;          [stop-when zero?])

(define (reset s ke)
  100)

;(big-bang 100
;    [to-draw number->square]
;    [on-tick sub1]
;    [stop-when zero?]
;    [on-key reset])

;; See "first.rkt" for first interactive program from figure 17: