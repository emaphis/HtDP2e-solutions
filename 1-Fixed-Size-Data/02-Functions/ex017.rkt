;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex017) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Ex. 17:
;; Define the function image-classify, which consumes an image and produces
;; "tall" if the image is taller than wide, "wide" if it is wider than tall,
;; or "square" if its width and height are the same.
;; based on ex. 8

(define (image-classify img)
  (if (> (image-height img) (image-width img))
    "tall"
    (if (= (image-height img) (image-width img))
        "square"
        "wide")))

(define TALL   (rectangle 10 20 "solid" "blue"))
(define WIDE   (rectangle 20 10 "solid" "blue"))
(define SQUARE (rectangle 20 20 "solid" "blue"))

(image-classify TALL) ; "tall"
(image-classify WIDE) ; "wide"
(image-classify SQUARE) ; "square"
