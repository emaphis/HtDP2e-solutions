;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex013) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 13:
;; Define the function string-first, which extracts the first 1String from a
;; non-empty string. Don’t worry about empty strings. 

(define (string-first str)
  (substring str 0 1))

(string-first "s")  ; "s"
(string-first "string")  ; "s"
