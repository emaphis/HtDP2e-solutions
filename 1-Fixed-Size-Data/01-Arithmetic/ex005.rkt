#lang htdp/bsl
(require 2htdp/image)

;; Ex. 5
;; Use the picture primitives to create the image of a simple
;; a car!
(overlay/xy 
 (rectangle 12 5 "solid" "lightblue")
 -6 5 
 (overlay/xy 
  (rectangle 25 7 "solid" "red")
  0 3
  (overlay/xy   
   (circle 4 "solid" "black")
   17 00
   (circle 4 "solid" "black"))))