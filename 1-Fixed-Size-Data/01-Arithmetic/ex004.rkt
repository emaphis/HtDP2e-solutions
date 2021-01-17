#lang htdp/bsl

;; Ex. 4
;; Use the same setup as in exercise 3 to create an expression that deletes the ith position from str.
;; Clearly this expression creates a shorter string than the given one.
;; Which values for i are legitimate?

(define str "helloworld")
(define i 5)

;; delete i'th character
(string-append (substring str 0 i) (substring str (+ i 1)))
;=>"helloorld"

;; range 0 to 9 will work

