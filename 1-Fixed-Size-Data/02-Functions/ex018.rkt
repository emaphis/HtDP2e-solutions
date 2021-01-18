#lang htdp/bsl

;; Ex. 18
;; Define the function string-join, which consumes two strings and
;; appends them with "_" in between.
;; based on ex. 2

(define (string-join prefix suffix)
  (string-append prefix "_" suffix))

(string-join "" "") ; "_"
(string-join "" "world") ; "_world
(string-join "hello" "world") ; "hello_world"