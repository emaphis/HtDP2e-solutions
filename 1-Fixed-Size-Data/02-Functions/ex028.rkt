;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex028) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Ex. 28:
;; Determine the potential profit for these ticket prices: $1, $2, $3, $4, and $5.
;; Which price should the owner of the movie theater choose to maximize his profits?
;; Determine the best ticket price to a dime.
;; monolith version

(define (profit price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

;; examples
(profit 2.00) ; 937.2
(profit 2.90) ; 1064.1
(profit 3.00) ; 1063.2
(profit 4.00) ; 889.2

