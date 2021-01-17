#lang htdp/bsl

;; 1.5 The Arithmetic of Booleans

(or #true #true) ; #true
(or #true #false) ; #true
(or #false #true) ; #true
(or #false #false) ; #false

(and #true #true)  ; #true
(and #true #false) ; #false
(and #false #true) ; #false
(and #false #false) ; #false

(not #true) ; #false

;; Se exercise 7