;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_Programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 2.2 Functions
;; 2.5 Programs
;; Ex 33,34

;; We are now ready to create simple programs.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Batch Programs

;; reading and writing batch data to and from disk
(require 2htdp/batch-io)

;>(write-file "sample.dat" "212");
;"sample.dat"

;>(read-file "sample.dat")
;"212"

;; You can read and write to standard input and output

;> (write-file 'stdout "212\n")
;212
;'stdout


;;; Example batch program that calulates temperatures

;; Formulat for calculating Celsius from Fahrenheit
(define (C f)
  (* 5/9 (- f 32)))

(C 32)  ; 0
(C 212) ; 100
(C -40) ; -40

;; main program
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

;; See exercise 31


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interactive Programs

;; See Exercise 42
