#lang htdp/bsl
;; Ex. 54:
;; Why is (string=? "resting" x) incorrect as the first condition in
;; show? Conversely, formulate a completely accurate condition, that is,
;; a Boolean expression that evaluates to #true precisely when x belongs
;; to the first sub-class of LRCD.

;; (string=? "resting" x) is inaccurate because any string can be
;; concidered a resting state also an LRCD can be any number.

;; a better test
(and (string? x) (string=? "resting" x))
