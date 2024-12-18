;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex005) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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