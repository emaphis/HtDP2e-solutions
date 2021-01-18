;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex004) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
