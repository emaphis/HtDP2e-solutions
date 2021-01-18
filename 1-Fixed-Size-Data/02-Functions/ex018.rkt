;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex018) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 18
;; Define the function string-join, which consumes two strings and
;; appends them with "_" in between.
;; based on ex. 2

(define (string-join prefix suffix)
  (string-append prefix "_" suffix))

(string-join "" "") ; "_"
(string-join "" "world") ; "_world
(string-join "hello" "world") ; "hello_world"