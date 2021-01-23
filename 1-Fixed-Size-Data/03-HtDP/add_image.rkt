;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname add_image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; example from Figure 20.

(require 2htdp/image)

;; Number String Image -> Image
;; adds s to img, y pixels from top, 10 pixels to the left
;; given: 
;;    5 for y, 
;;    "hello" for s, and
;;    (empty-scene 100 100) for img
;; expected: 
;;    (place-image (text "hello" 10 "red") 10 5 ...)
;;    where ... is (empty-scene 100 100)
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))
