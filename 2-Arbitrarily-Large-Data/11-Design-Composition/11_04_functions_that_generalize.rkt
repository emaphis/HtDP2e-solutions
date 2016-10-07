;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11_04_functions_that_generalize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 11 Design by Composition
;; 11.4 Auxiliary Functions that Generalize
;; Exercises: 191-194

;; Sample Problem Design a function that adds a polygon to a given scene.

;; A polygon is a planar figure with at least three points connected by
;; three straight sides.

; in 2htdp/image a polygon could be represented by a List-of-Posn, with at
; least 3 Posn's

; this definition works better with rest of book's example
(define triangle-p
  (list
    (make-posn 20 0)
    (make-posn 10 10)
    (make-posn 30 10)))

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)
; interp: a list Posn describing a closed plane figure in a scene


(require 2htdp/image)

; a plain background image
(define MT (empty-scene 50 50))


; Image Polygon -> Image
; renders the given polygon p into img

(check-expect
  (render-poly MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 0 10 10 "red")
      10 10 30 10 "red")
    30 10 20 0 "red"))

(check-expect
  (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))

#; ; first attempt from the recipe
(define (render-poly img p)
  (cond [(empty? (rest (rest (rest p))))
         (render-line
          (render-line
           (render-line MT (first p) (second p))
           (second p) (third p))
          (third p) (first p))]
        [else (render-line (render-poly img (rest p))
                           (first p)
                           (second p))]))

(define (render-poly img p)
  (render-line (connect-dots img p)
               (first p)
               (last p)))


; Image Posn Posn -> Image
; draws a red line from Posn p to Posn q into img
(check-expect (render-line MT (make-posn 10 10) (make-posn 20 30))
              (scene+line MT 10 10 20 30 "red"))
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p) (posn-x q) (posn-y q)
   "red"))

;; The error suggests we need a more genral solution

; A NELop is one of:
; - (cons Posn '())
; - (cons Posn NELop)

; Image NELoP -> Image
(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 0 10 10 "red")
               10 10 30 10 "red"))

;; Ex. 191:
;; Adapt the second example for the render-poly function to connect-dots. 

(check-expect (connect-dots MT square-p)
              (scene+line
               (scene+line
                (scene+line MT 10 10 20 10 "red")
                20 10 20 20 "red")
               20 20 10 20 "red"))

; connects the dots in p by rendering lines in img
; (define (connect-dots img p) MT) ;stub

(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else (render-line
           (connect-dots img (rest p))
           (first p)
           (second p))]))


; NELop -> Posn
; extracts the last item from p
;(define (last p)
;  (first p))

; Q: Why is it acceptable to use first for the stub definition of last?
; A: last take an NELop as a parameters so there is atleas on item
; on the list.  It is really the answer to the base casee question.

;; Ex 192:
;; Argue why it is acceptable to use last on Polygons. Also argue why
;; you may adapt the template for connect-dots to last:
#;
(define (last p)
  (cond
    [(empty? (rest p)) (... (first p) ...)]
    [else (... (first p) ... (last (rest p)) ...)]))

;; Finally, develop examples for last, turn them into tests, and ensure that
;; the definition of last in figure 69 works on your examples.

; A: that template is acceptable base for 'last' becuase it is a template
; for at least on item on a list.  You don't want to call last on an
; empty list.

; examples:
;(check-expect (last (list "a")) "a")  ; the base case
(check-expect (last triangle-p) (make-posn 30 10))
(check-expect (last square-p) (make-posn 10 20))
#; ; my defintion
(define (last p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last (rest p))]))

; the books defintion:
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex 193:
;; Here are two more ideas for defining render-poly:

;; a: render-poly could cons the last item of p onto p and then call
;; connect-dots.

;; b: render-poly could add the first item of p to the end of p via a version of
;; add-at-end that works on Polygons.

;; a:
(check-expect (render-poly-cons MT triangle-p)
              (scene+line
               (scene+line
                (scene+line MT 20 0 10 10 "red")
                10 10 30 10 "red")
               30 10 20 0 "red"))

(check-expect (render-poly-cons MT square-p)
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

(define (render-poly-cons img p)
  (connect-dots img (cons (last p) p)))

; b:
(check-expect (render-poly-end MT triangle-p)
              (scene+line
               (scene+line
                (scene+line MT 20 0 10 10 "red")
                10 10 30 10 "red")
               30 10 20 0 "red"))

(check-expect (render-poly-end MT square-p)
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

(define (render-poly-end img p)
  (connect-dots img (add-at-end (first p) p)))


; List-of-Posn Posn -> List-of-Posn
; add p at end of lst
(check-expect (add-at-end  (make-posn 10 10) '())
              (list (make-posn 10 10)))
(check-expect (add-at-end (make-posn 10 10)
                          (list (make-posn 20 20) (make-posn 30 30)))
              (list (make-posn 20 20) (make-posn 30 30) (make-posn 10 10)))

(define (add-at-end p lop)
  (append lop (cons p '())))


;; Ex 194:
;; Modify connect-dots so that it consumes an additional Posn to which the last
;; Posn is connected. Then modify render-poly to use this new version of
;; connect-dots.

(check-expect (render-poly.v3 MT triangle-p)
              (scene+line
               (scene+line
                (scene+line MT 20 0 10 10 "red")
                10 10 30 10 "red")
               30 10 20 0 "red"))

(check-expect (render-poly.v3 MT square-p)
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

(define (render-poly.v3 img p)
  (connect-dots.v2 img p (first p)))

; Image NELoP Posn -> Image
; connects the Posns in p in an image
(check-expect (connect-dots.v2 MT triangle-p (first triangle-p))
              (scene+line
               (scene+line
                (scene+line MT 20 0 10 10 "red")
                10 10 30 10 "red")
               30 10 20 0 "red"))

(check-expect (connect-dots.v2 MT square-p (first square-p))
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

(define (connect-dots.v2 img p psn)
  (cond
    [(empty? (rest p)) (render-line img (first p) psn)]
    [else (render-line
           (connect-dots.v2 img (rest p) psn)
           (first p)
           (second p))]))

;; But, now connect-dots.v2 isn't as general as the original.