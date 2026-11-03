#lang htdp/bsl
(require 2htdp/image)

;; Ex 25
;;Take a look at this attempt to solve exercise 17:

(define (image-classify img)
  (cond
    [(>= (image-height img) (image-width img))
     "tall"]
    [(= (image-height img) (image-width img))
     "square"]
    [(<= (image-height img) (image-width img))
     "wide"]))

(image-classify (circle 3 "solid" "red"))

;; Does stepping through an application suggest a fix?

; Ans: Yes the "=" clause should come first since it's more specific.

;; fixed
(define (image-classify-fixed img)
  (cond
    [(= (image-height img) (image-width img))
     "square"]
    [(>= (image-height img) (image-width img))
     "tall"]
    [(<= (image-height img) (image-width img))
     "wide"]))

(image-classify-fixed (circle 3 "solid" "red"))
