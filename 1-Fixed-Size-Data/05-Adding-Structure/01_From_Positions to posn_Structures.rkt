;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |01_From_Positions to posn_Structures|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 5 Adding Structure
;; 5.1 From Positions to posn Structures

(require 2htdp/image)

;; A Position on a world canvas is defined by two pieces of data
;; x-coordinate - the distance from the left margin
;; y-coordinate - the distance from the top margin

(make-posn 3 4)

(define one-posn (make-posn 8 6))
