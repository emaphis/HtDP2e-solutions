#lang htdp/bsl
;; Ex. 80
;; Create templates for functions that consume instances of the following
;; structure types:

(define-struct movie [title director year])

; Movie -> ???
(define (fn-for-movie m)
  (... (movie-title m))
  (... (movie-director m))
  (... (movie-year m)))


(define-struct person [name hair eyes phone])

; Person -> ???
(define (fn-for-person p)
  (... (person-name p))
  (... (person-hair p))
  (... (person-eyes p))
  (... (person-phone p)))


(define-struct pet [name number])

; Pet -> ???
(define (fn-for-pet p)
  (... (pet-name p))
  (... (pet-number p)))


(define-struct CD [artist title price])

; CD -> ???
(define (fn-for-CD cd)
  (... (CD-artist cd))
  (... (CD-title cd))
  (... (CD-price cd)))


(define-struct sweater [material size color])

; Sweater -> ???
(define (fn-for-sweater s)
  (... (sweater-material s))
  (... (sweater-size s))
  (... (sweater-color s)))
