;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex036) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 36:
;; Design the function image-area, which counts the number of pixels in a
;; given image.

;; Image represents the image we want to anylize
;; Number represent the area of an image

(require 2htdp/image)

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
