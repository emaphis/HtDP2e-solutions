;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_The_Arithmetic_of_Strings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; 1.2 The Arithmetic of Strings

;; examples
"hello"
"world"
"blue"
"red"

;; 1Strings: - lenth of one
"r"
"e"
"d"

;; string-append consumes and produces strings
(string-append "what a " "lovely " "day" " 4 BSL")
;;=> "what a lovely day 4 BSL"
;; string-append is analogous to '+' for numbers.

;; See exercise 2.