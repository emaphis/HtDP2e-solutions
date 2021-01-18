#lang htdp/bsl
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
