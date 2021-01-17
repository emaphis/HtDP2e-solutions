#lang htdp/bsl
(require 2htdp/image)

;; Ex. 6  -- cat image
;; Create an expression that counts the number of pixels in the image.

(define cat (bitmap "images/cat.png"))

(image-height cat)
(image-width cat)

;; expression
(* (image-height cat) (image-width cat)) ;=> 8775