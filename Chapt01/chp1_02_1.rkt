;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chp1_02_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e 1.2 Functions and programs
;; exercises 13-22
;; I'm using check-expets  early to easily show examples/
(require 2htdp/image)

;; I.2
;; Primatives provide a arithmetic of programming, functions
;; provide am algerbra of programming
;; Notions: variable, function, definition, function application and
;; function composition

;;  1.2.1 Defining funcions

;; Definitions examples

;; Silly functions that don't use the parameters
(define (f x) 1)
(define (g x y) (+ 1 1))
(define (h x y z) (+ (* 2 2) 3))

;; a useful funtion
(define (ff a)
  (* 10 a))

(check-expect (f 1) 1)  ;; doesn't use it's parameter
(check-expect (f 2) 1)
(check-expect (f "hello world") 1)
(check-expect (f true) 1)
(check-expect (f (circle 3 "solid" "red")) 1)

(check-expect (ff (+ 1 1)) 20)
(check-expect (+ (ff 3) 2) 32)
(check-expect (* (ff 4) (+ (ff 3) 2)) 1280)
(check-expect (ff (ff 1)) 100)

(define (opening first last)
  (string-append "Dear " first ","))

(check-expect (opening "Matthew" "Krishnamurthi") "Dear Matthew,")


;; Ex. 13:
;; Define a function that consumes two numbers, x and y, and that
;; computes the distance of point (x,y) to the origin.
;; based on ex. 1
(define (distance x y) 
  (sqrt (+ (sqr x) (sqr y))))

(check-expect (distance 0 0) 0)
(check-expect (distance 3 4) 5)


;; Ex. 14:
;; Define the function cvolume, which accepts the length of a side of
;; an equilateral cube and computes its volume. If you have time, consider
;; defining csurface, too.
(define (cvolume sd)
  (* sd sd sd))

(check-expect (cvolume 0) 0)
(check-expect (cvolume 1) 1)
(check-expect (cvolume 5) 125)

(define (csurface s)
  (* 6 (sqr s)))

(check-expect (csurface 0) 0)
(check-expect (csurface 1) 6)
(check-expect (csurface 2) (* 4 6))


;; Ex. 15:
;;  Define the function string-last, which extracts the last 1String from
;; a non-empty string. Don’t worry about empty strings. image
(define (string-first str)
  (substring str 0 1))

(check-expect (string-first "s") "s")
(check-expect (string-first "string") "s")


;; Ex. 16:
;; Define the function string-last, which extracts the last 1String from
;; a non-empty string. Don’t worry about empty strings.
(define (string-last str)
  (substring str (- (string-length str) 1)))

(check-expect (string-last "d") "d")
(check-expect (string-last "hello world") "d")


;; Ex. 17
;; Define ==>. The function consumes two Boolean values, call them sunny
;; and friday. Its answer is #true if sunny is false or friday is true.
;; Note Logicians call this Boolean operation implication, and they use the
;; notation sunny => friday for this purpose. image
;; based on ex 9 -- bool imply function
(define (==> p q)
  (or (not p) q))

(check-expect (==> #true  #true)  #true)  ;; truth table
(check-expect (==> #true  #false) #false)
(check-expect (==> #false #true)  #true)
(check-expect (==> #false #false) #true)


;; Ex. 18:
;; Define the function image-area, which counts the number of pixels in a given image.
;; based on ex. 7
(define (image-area img)
  (* (image-height img) (image-width img)))

(check-expect (image-area (rectangle 0 0 "solid" "blue")) 0)
(check-expect (image-area (rectangle 10 20 "solid" "red")) 200)


;; Ex. 19:
;; Define the function image-classify, which consumes an image and produces
;; "tall" if the image is taller than wide, "wide" if it is wider than tall,
;; or "square" if its width and height are the same.
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


;; Ex. 20
;; Define the function string-join, which consumes two strings and
;; appends them with "_" in between.
;; based on ex. 4
(define (string-join prefix suffix)
  (string-append prefix "_" suffix))

(check-expect (string-join "" "") "_")
(check-expect (string-join "hello" "world") "hello_world")


;; Exercise 21
;; Define the function string-insert, which consumes a string str plus
;; a number i and inserts "_" at the ith position of str. Assume i is
;; a number between 0 and the length of the given string (inclusive).
;; based on ex. 5
(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))

(define str "helloworld")
(define i 5)
(check-expect (string-insert "helloworld" 5) "hello_world")

(check-expect (string-insert "" 0) "_")


;; Exercise 22
;; Define the function string-delete, which consumes a string plus a number
;; i and deletes the ith position from str. Assume i is a number between 0
;; (inclusive) and the length of the given string (exclusive).
;; Can string-delete deal with empty strings?
;; based on ex. 6
(define (string-delete str i)
  (string-append (substring str 0 i) (substring str (+ i 1))))

(check-expect (string-delete "helloworld" 5) "helloorld")

;; Cant handle 0 length strings -- starting index out of range
