#lang htdp/bsl
(require 2htdp/image)
;; Ex. 36:
;; Design the function image-area, which counts the number of pixels in a
;; given image.

;; Image represents the image we want to anylize
;; Number represent the area of an image

;; Image -> Number
;; Given an image return area of image in pixils
;; Given: (square 0 "solid" "blue" expect: 0
;; Given: (square 10 "solid" "red" expect: 100
;(define (image-area img) 0) ; stub

;(define (image-area img)  ; template
;  (... img ...))

(define (image-area img)
  (* (image-height img) (image-width img)))

(image-area (square 0 "solid" "blue")) ; 0
(image-area (square 10 "solid" "red")) ; 100
