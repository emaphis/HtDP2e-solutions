;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_02_02_01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.2 Functions and programs
;; exercises 13-22
;; I'm using check-expets  early to easily show examples/
(require 2htdp/image)

;;  2.2.1 Defining funcions


(define (f x) 1)
(define (g x y) (+ 1 1))
(define (h x y z) (+ (* 2 2) 3))

(define (ff a)
  (* 10 a))

(check-expect (f 1) 1)
(check-expect (f 2) 1)
(check-expect (f "hello world") 1)
(check-expect (f true) 1)
(check-expect (f (circle 3 "solid" "red")) 1)

(check-expect (ff (+ 1 1)) 20)
(check-expect (+ (ff 3) 2) 32)
(check-expect (* (ff 4) (+ (ff 3) 2)) 1280)

(define (opening first last)
  (string-append "Dear " first ","))

(check-expect (opening "Matthew" "Krishnamurthi") "Dear Matthew,")

;; Exercise 13:
;; based on ex. 1
(define (distance x y) 
  (sqrt (+ (sqr x) (sqr y))))

(check-expect (distance 3 4) 5)

;; Exercise 14:
(define (cube-volume sd)
  (* sd sd sd))

(check-expect (cube-volume 5) 125)

;; Exercise 15: 
(define (string-first str)
  (substring str 0 1))

(check-expect (string-first "test") "t")

;; Exercise 16:
(define (string-last str)
  (substring str (- (string-length str) 1)))

(check-expect (string-last "hello world") "d")

;; Exercise 17
;; based on ex 9 -- bool imply function
(define (bool-imply p q)
  (or (not p) q))

(check-expect (bool-imply true  true)  true)  ;; truth table
(check-expect (bool-imply true  false) false)
(check-expect (bool-imply false true)  true)
(check-expect (bool-imply false false) true)

;; Exercise 18:
;; based on ex. 5
(define (image-area img)
  (* (image-height img) (image-width img)))

(check-expect (image-area (rectangle 10 20 "solid" "red")) 200)

;; Exercise 19:
;; based on ex. 10
(define (image-classify img)
  (if (> (image-height img) (image-width img))
    "tall"
    (if (= (image-height img) (image-width img))
        "square"
        "wide")))

(define TALL   (rectangle 10 20 "solid" "blue"))
(define WIDE   (rectangle 20 10 "solid" "blue"))
(define SQUARE (rectangle 20 20 "solid" "blue"))
(check-expect (image-classify TALL) "tall")
(check-expect (image-classify WIDE) "wide")
(check-expect (image-classify SQUARE) "square")

;; Exercise 20.
;; based on ex. 2
(define (string-join prefix suffix)
  (string-append prefix "_" suffix))

(check-expect (string-join "hello" "world") "hello_world")

;; Exercise 21
;; based on ex. 3
(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))

(define str "helloworld")
(define i 5)
(check-expect (string-insert "helloworld" 5) "hello_world")

;; Exercise 22
;; based on ex. 4
(define (string-delete str i)
  (string-append (substring str 0 i) (substring str (+ i 1))))

(check-expect (string-delete "helloworld" 5) "helloorld")
