;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_01_164_dollars_to_euros) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.1 Functions that Produce Functions
;; Exercise: 164
;; Dollar to Euro Converter


;; Ex. 164:
;; Design the function convert-euro, which converts a list of US$ amounts into
;; a list of € amounts. Look up the current exchange rate on the web.

;; Generalize convert-euro to the function convert-euro*, which consumes an
;; exchange rate and a list of US$ amounts and converts the latter into a list
;; of € amounts.

(define DE-RATE 0.89) ; as of 24/9/2016


;; Number -> Number
;; Convert a Dollar to a Euro ammount with a given ratio
(check-expect (convert 0.0) 0.0)
(check-expect (convert 10.0) (* DE-RATE 10.0))

(define (convert d)
  (* DE-RATE d))



;; List-of-number -> List-of-number
;; produce a  list of Euros converted from a list of Dollars

(check-expect (convert-euro '()) '())
(check-expect (convert-euro (cons 0.0 (cons 10.0 (cons 15.15 '()))))
              (cons 0.0 (cons (* DE-RATE 10.0) (cons (* DE-RATE 15.15) '()))))

(define (convert-euro lod)
  (cond
    [(empty? lod) '()]
    [else (cons (convert (first lod))
                (convert-euro (rest lod)))]))


;; generalized version:

;; List-of-number Number -> List-of-number
;; produce a list of Euros converted from a list of Dollars and
;; and exchange rate

(check-expect (convert-euro* '() DE-RATE) '())
(check-expect (convert-euro* (cons 0.0 (cons 10.0 (cons 15.15 '()))) DE-RATE)
              (cons 0.0 (cons (* DE-RATE 10.0) (cons (* DE-RATE 15.15) '()))))

(define (convert-euro* lod rt)
  (cond
    [(empty? lod) '()]
    [else (cons (* (first lod) rt)
                (convert-euro (rest lod)))]))
