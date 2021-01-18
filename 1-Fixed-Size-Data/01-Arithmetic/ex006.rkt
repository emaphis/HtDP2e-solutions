;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex006) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Ex. 6  -- cat image
;; Create an expression that counts the number of pixels in the image.

(define cat (bitmap "images/cat.png"))

(image-height cat)
(image-width cat)

;; expression
(* (image-height cat) (image-width cat)) ;=> 8775
