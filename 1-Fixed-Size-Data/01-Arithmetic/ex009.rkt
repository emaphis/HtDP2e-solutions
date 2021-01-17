#lang htdp/bsl
(require 2htdp/image)

;; Ex. 9
;; Add the following line to the definitions area of DrRacket:
;; (define in ...)
;; Then create an expression that converts the value of in to a positive number.
;; For a String, it determines how long the String is;
;; for an Image, it uses the area;
;; for a Number, it decrements the number by 1, unless it is already 0 or negative;
;; for #true it uses 10 and for #false 20.

;;(define in "hello")
;;(define in (square 10 "outline" "green"))
;;(define in 100)
(define in #false)

(if (string? in) 
    (string-length in)
    (if (image? in) 
        (* (image-height in) (image-width in))
        (if (number? in)
            (if (> in 0) 
                (- in 1)
                (abs in))
            (if (boolean? in) 
                (if in
                    10
                    20)
                (error "Unknown data type")))))
