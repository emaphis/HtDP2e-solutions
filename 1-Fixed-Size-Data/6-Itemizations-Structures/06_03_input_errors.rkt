;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_03_input_errors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.3 Input Error
;; Exercises: 110-113

(require 2htdp/image)
(require 2htdp/universe)

;; using predicates to protect programs from inappropriate input.

;; A demo:

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))


; Any BSL value is one of:
; – Number
; – Boolean
; – String
; – Image
; – (make-posn Any Any)
; ...
; – (make-tank Any Any)
; ...

; template of a checked function:

; Any -> ???
#;
(define (checked-f v)
  (cond
    [(number? v) ...]
    [(boolean? v) ...]
    [(string? v) ...]
    [(image? v) ...]
    [(posn? v) (...(posn-x v) ... (posn-y v) ...)]
    ;[...]
    ; which selectors are needed in the next clause?
    [(tank? v) ...]
    ;[...]
    ))


; a checked definition of checked-area-of-disk

; Any -> Number
; computes the area of a disk with radius v
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "area-of-disk: number expected")]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;

;; Ex. 110:
;; A checked version of area-of-disk can also enforce that the arguments to
;; the function are positive numbers, not just arbitrary numbers. Modify
;; checked-area-of-disk in this way.

; Any -> Number
; computes the area of a disk with radius v
; if v is a number
(define (checked-area-of-disk-2 v)
  (cond
    [(and (number? v) (>= v 0))
     (area-of-disk v)]
    [else (error "area-of-disk: positive number expected")]))


;; Ex. 111
;; Develop the function checked-make-vec, which is to be understood as a
;; checked version of the primitive operation make-vec. It ensures that the
;; arguments to make-vec are positive numbers. In other words, checked-make-vec
;; enforces our informal data definition.

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; Any Any -> Vec
; creates a vec from two checked parameters

(define (checked-make-vec n1 n2)
  (cond [(and (number? n1)
              (>= n1 0))
         (cond [(and (number? n2)
                     (>= n2 0))
                (make-vec n1 n2)]
               [else
                (error "make-vec: second parameter must be a positve number")])]
        [else
         (error "make-vec: first parameter must be a positive number")]))

;;;;;;;;;;;;;;;
;; how can we design out own predicates

(define-struct XYZ [a b])

;; checke functions have the shape of:

; Any -> ...
; checks that a is a proper input for function g
(define (checked-g a)
  (cond
    [(XYZ? a) (g a)]
    [else (error "g: bad input")]))

; where g is defined as:

; XYZ -> ???
(define (g some-x) ...)


;; from missle launch example

; Any -> Boolean
; is a an element of the MissileOrNot collection

;(define (missile-or-not? a) #false)  ;stub

(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)

(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? 10) #false)
(check-expect (missile-or-not? empty-image) #false)

; a missile is either a #false or a posn, so #true 10 and images aren't missile

#; ; template
(define (missile-or-not? v)
  (cond
    [(boolean? v) ...]
    [(posn? v) (... (posn-x v) ... (posn-y v) ...)]
    [else #false]))


(define (missile-or-not? v)
  (cond [(boolean? v) (boolean=? #false v)]
        [(posn? v) #true]
        [else #false]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 112:
;; Reformulate the predicate now using an or expression.

; Any -> Boolean
; is a an element of the MissileOrNot collection

;(define (missile-or-not? a) #false)  ;stub

(check-expect (missile-or-not-2? #false) #true)
(check-expect (missile-or-not-2? (make-posn 9 2)) #true)
(check-expect (missile-or-not-2? "yellow") #false)

(check-expect (missile-or-not-2? #true) #false)
(check-expect (missile-or-not-2? 10) #false)
(check-expect (missile-or-not-2? empty-image) #false)

(define (missile-or-not-2? v)
  (or (false? v) (posn? v)))


;; Ex. 113:
;; Design predicates for the following data definitions from the preceding
;; section: SIGS, Coordinate (exercise 105), and VAnimal.

;; SIGS

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define UFO (make-posn 10 30))

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number).
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn.
; interpretation (make-posn x y) is the missile's place

(define-struct aim [ufo tank ])
(define-struct fired [ufo tank missle])
; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

; Any -> Boolean
; is any a SIGS?

(check-expect (SIGS? (make-aim (make-posn 10 10)
                               (make-tank 20 3)))
              #true)
(check-expect (SIGS? (make-fired (make-posn 10 10)
                                 (make-tank 20 2)
                                 (make-posn 10 20)))
              #true)
(check-expect (SIGS? "SIGS") #false)
(check-expect (SIGS? #true) #false)
(check-expect (SIGS? 10) #false)
(check-expect (SIGS? (make-posn 10 20)) #false)

(define (SIGS? v)
  (or (aim? v) (fired? v)))


;;  Coordinate
;; see editor3.rkt

; A Coordinate is one of:
; – a NegativeNumber
; interpretation on the y axis, distance from top
; – a PositiveNumber
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; Any -> Boolean
; is any a Coorinate

(check-expect (coordinate? (make-posn 10 10)) #true)
(check-expect (coordinate? 10) #true)
(check-expect (coordinate? -10) #true)

(check-expect (coordinate? "coord") #false)
(check-expect (coordinate? #false) #false)

(define (coordinate? v)
  (or (posn? v) (number? v)))


;; VAnimal


(define-struct vcat [x-pos happy])
; cat is a (make-vcat Number Number[0,100])
; interp.  (make-vcat x h) has an 'x; postition and an 'h' happyness level

(define-struct vcham [x-pos happy clr])
; cham is a (make-vcham Number Number[0,100] String)
; interp.  (make-vcham x c) has an 'x' postition an 'h' happyness level
;          'c' color

; A VAnimal is either
; – a VCat
; – a VCham


;; Any -> Boolean
;; is the given parameter a VCat or a VCham

(check-expect (vanimal? (make-vcat 100 50)) #true)
(check-expect (vanimal? (make-vcham 100 50 "blue")) #true)

(check-expect (vanimal? 20) #false)
(check-expect (vanimal? "fluffy") #false)
(check-expect (vanimal? (make-posn 10 30)) #false)

(define (vanimal? v)
  (or (vcat? v) (vcham? v)))
