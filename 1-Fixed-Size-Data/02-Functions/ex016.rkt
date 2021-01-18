;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex016) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Ex. 16:
;; Define the function image-area, which counts the number of pixels in a given image.
;; based on ex. 5

(define (image-area img)
  (* (image-height img) (image-width img)))

(image-area (rectangle 0 0 "solid" "blue"))  ; 0
(image-area (rectangle 10 20 "solid" "red")) ; 200
