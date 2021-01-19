;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex031) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 31:
;; Recall the letter program from Composing Functions.
;; Here is how to launch the program and have it write its output to the
;; interactions area: 

(require 2htdp/batch-io)

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


;; Exercise functions:

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
