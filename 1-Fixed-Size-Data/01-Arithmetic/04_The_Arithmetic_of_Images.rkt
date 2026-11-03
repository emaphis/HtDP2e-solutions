#lang htdp/bsl
(require 2htdp/image)

;; 1.4  Arithmetic of Images

;; creation of basic images given size, mode, color: 
;; circle ellipse line rectangle square text triangle
;; mode: "solid" "outline"
;; color: name passed as string

(circle 10 "solid" "green")

(rectangle 10 20 "solid" "blue")

(star 12 "solid" "gray")

;; Stop!
(text "Hello, World!" 36 "purple")

;; functions returning image properties:
;; image-width, image-height

(image-width (circle 10 "solid" "red"))

(image-height (rectangle 10 20 "solid" "blue"))

;; Stop!
(+ (image-width (circle 10 "solid" "red"))
   (image-height (rectangle 10 20 "solid" "blue")))
;; it evaluates each expression in the parentheses working
;; inside out.

;; functions that compose images:
;; overlay, overlay/xy, overlay/align

;; overlay/align x-place y-place i1 i2 is
;; x-place: left right middle center pinhole
;; y-place: top bottom, middle center baseline pinhole:

;; scene fuctions:
;; place-image, empty-scene, add-line

;; See exercises 5, 6
