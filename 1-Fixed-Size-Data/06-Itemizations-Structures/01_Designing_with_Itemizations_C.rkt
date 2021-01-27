;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06_01_designing_itemizations_3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 6 Itemizations and Structures
;; 6.1 Designing with Itemizations, Again
;; Exercises: 103-105


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; More exerces

;; Ex 103:
;; Develop a data representation for the following four kinds of zoo animals:

;    spiders, whose relevant attributes are the number of remaining legs
;      (we assume that spiders can lose legs in accidents) and the space they
;      need in case of transport;

;    elephants, whose only attributes are the space they need in case
;      of transport;

;    boa constrictor, whose attributes include length and girth; and

;    armadillo, for whom you must determine appropriate attributes, including
;      one that determine the space needed for transportation.

; Develop a template for functions that consume zoo animals.

;; Design fits?. The function consumes a zoo animal and the volume of a cage.
;; It determines whether the cage is large enough for the animal.

(define-struct spider [legs space])
; Spider is a (make-spider Number Numbers)
; interp. legs is number of legs the spider has left
;         space is the apount of space spider takes up

(define SPIDER1 (make-spider 8 0.10))

; Spider -> ???
#; ; template for Spider
(define (fn-for-spider s)
  (... (... (spider-legs s))
       (... (spider-space s))))

(define-struct elephant [space])
; Elephant is a (make-elephant Number)
; interp. space is the space the Elephant takes up.

(define ELEPHANT1 (make-elephant 5000.0))

; Elephant -> ???
#; ; template for Elephant
(define (fn-for-elephant e)
  (... (... (elephant-space e))))


(define-struct boa-constrictor [length girth])
; Boa-Constrictor is a (make-boa-constrictor Number Number)
; interp. length of the Boa-Constrictor and girth of the Boa-Constrictor

(define BOA1 (make-boa-constrictor 12 6))

; Boa-Constrictor -> ???
#; ; tempate for Boa-Constrictor
(define (fn-for-boa b)
  (... (... (boa-constrictor-length b))
       (... (boa-constrictor-girth b))))


(define-struct armadillo [hardness space])
; Armadillo is a (make-armadillo Number Number)
; interp. hardness is the hardness of the Armadillo's shell
;         space is the space the Armadillos takes up.

(define ARMADILLO1 (make-armadillo 70 10.0))

; Armadillo -> ???
#; ; template for Armadillo
(define (fn-for-armadillo a)
  (... (... (armadillo-hardness a))
       (... (armadillo-space a))))


; Zoo-Animal is one of:
; - Spider
; - Elephant
; - Boa-Constrictor
; - Armadillo
; interp one a variaty of animals

(define ANIMAL1 (make-elephant 6000.0))
(define ANIMAL2 (make-armadillo 100 5.0))

; Zoo-Animal -> ???
#; ; template for Zoo-Animal
(define (fn-for-zoo-animal za)
  (cond [(spider? za) (... za)]
        [(elephant? za) (... za)]
        [(boa-constrictor? za) (... za)]
        [(armadillo? za) (... za)]))


; Zoo-Animal Number -> Boolean
; returns #true if a given Zoo-Animal fits in a given cage
(check-expect (fits? SPIDER1 20.0) #true)
(check-expect (fits? ELEPHANT1 20.0) #false)
(check-expect (fits? BOA1 20.0) #false)
(check-expect (fits? BOA1 73.0) #true)
(check-expect (fits? ARMADILLO1 20.0) #true)

;(define (fits? za s) #true) ; stub

(define (fits? za s)
  (cond [(spider? za) (< (spider-space za) s)]
        [(elephant? za) (< (elephant-space za) s)]
        [(boa-constrictor? za) (< (* (boa-constrictor-length za)
                                     (boa-constrictor-girth za)) s)]
        [(armadillo? za) (< (armadillo-space za) s)]))


;;;;;;;;;;;;;;;;;;;;
;; Ex. 105:
;; Some program contains the following data definition:

; A Coordinate is one of:
; – a NegativeNumber
; interpretation on the y axis, distance from top
; – a PositiveNumber
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

;; Make up at least two data examples per clause in the data definition.
;; For each of the examples, explain its meaning with a sketch of a canvas.

(define Y-COORD1 10)  ; (0,10)

(define Y-COORD2 20)   ; (0,20)

(define X-COORD1 -15)  ; (15,0)

(define X-COORD2 -10)  ; (10,0)

(define XY-COORD1 (make-posn 20 10)) ; (20,10)

(define XY-COORD2 (make-posn 5 15))  ; (5, 15)

#;
(define (fn-for-coorindate c)
  (cond [(posn? c) (... c)]
        [(>= c 0) (... c)]
        [(< c 0)] (... c)))
