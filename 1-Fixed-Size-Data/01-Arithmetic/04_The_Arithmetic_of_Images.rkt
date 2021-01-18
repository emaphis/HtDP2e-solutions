;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_The_Arithmetic_of_Images) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; 1.4  Arithmetic of Images

;; creation of basic images given size, mode, color: 
;; circle ellipse line rectangle square text triangle
;; mode: "solid" "outline"
;; color: name passed as string

(ellipse 10 20 "solid" "green")

(star 12 "solid" "green")

(regular-polygon 50 3 "outline" "red")

(regular-polygon 40 4 "outline" "blue")

(regular-polygon 20 8 "solid" "red")


;; functions returning image properties:
;; image-width, image-height

(+ (image-width (circle 10 "solid" "red"))
   (image-height (rectangle 10 20 "solid" "blue")))

;; functions that compose images:
;; overlay, overlay/xy, overlay/align

;; overlay/align x-place y-place i1 i2 is
;; x-place: left right middle center pinhole
;; y-place: top bottom, middle center baseline pinhole:

;; scene fuctions:
;; place-image, empty-scene, add-line

;; See exercises 5, 6