;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex052) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 52.
;; Which integers are contained in the four intervals above? 

; [3,5] => 3,4,5
; (3,5] => 4,5
; [3,5) => 3,4
; (3,5) => 4
