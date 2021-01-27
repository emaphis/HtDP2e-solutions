;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex080) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


