;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex054) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex. 54:
;; Why is (string=? "resting" x) incorrect as the first condition in
;; show? Conversely, formulate a completely accurate condition, that is,
;; a Boolean expression that evaluates to #true precisely when x belongs
;; to the first sub-class of LRCD.

;; (string=? "resting" x) is inaccurate because any string can be
;; concidered a resting state also an LRCD can be any number.
.
;; a better test
(and (string? x) (string=? "resting" x))

