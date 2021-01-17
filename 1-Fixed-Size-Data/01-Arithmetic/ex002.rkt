#lang htdp/bsl

;; Ex. 2
;; Add the following two lines to the definitions area:
;; (define prefix "hello")
;; (define suffix "world")
;; Then use string primitives to create an expression
;; that concatenates prefix and suffix and adds "_" between them.
;; When you run this program, you will see "hello_world" in the interactions area.
s

(define prefix "hello")
(define suffix "world")
s
(string-append prefix "_" suffix) ;=> "hello_world"
