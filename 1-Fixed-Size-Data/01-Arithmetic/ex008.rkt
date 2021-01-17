#lang htdp/bsl
(require 2htdp/image)

;; Ex. 8
;; Add the following line to the definitions area:
;; (define cat <image>)
;; Create a conditional expression that computes whether the image is tall or wide.
;; An image should be labeled "tall" if its height is larger than or equal to its width;
;; otherwise it is "wide".
;; Replace the cat with a rectangle of your choice to ensure that you know the expected answer.
;; Now try the following modification.
;; Create an expression that computes whether a picture is "tall", "wide", or "square"

(define cat (bitmap "images/cat.png"))

(if (> (image-height cat) (image-width cat))
    "tall"
    (if (= (image-height cat) (image-width cat))
        "square"
        "wide")) ;=> "tall"

(define image-1 (rectangle 60 40 "solid" "red"))
;;(rectangle 60 40 "solid" "red")

(if (> (image-height image-1) (image-width image-1))
    "tall"
    (if (= (image-height image-1) (image-width image-1))
        "square"
        "wide")) ;=> "tall"