;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_The_Arithmetic_of_Booleans) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 1.5 The Arithmetic of Booleans

(or #true #true) ; #true
(or #true #false) ; #true
(or #false #true) ; #true
(or #false #false) ; #false

(and #true #true)  ; #true
(and #true #false) ; #false
(and #false #true) ; #false
(and #false #false) ; #false

(not #true) ; #false

;; Se exercise 7