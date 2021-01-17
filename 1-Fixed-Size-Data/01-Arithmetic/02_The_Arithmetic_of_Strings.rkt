#lang htdp/bsl

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

;; Exercise 2.