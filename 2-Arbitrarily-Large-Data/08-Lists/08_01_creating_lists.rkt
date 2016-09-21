;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 08_01_creating_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 8 Lists
;; 8.1 Creating Lists
;; 8.2 What Is '(), What Is cons
;; Exercises: 129-131

;; an empty list
'()

;; add to list with the "cons" operator

(cons "Mercury" '())


(cons "Venus"
      (cons "Mercury"
            '()))

(cons "Earth"
      (cons "Venus"
            (cons "Mercury"
                  '())))


;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 129:
;; Create BSL lists that represent

;  1 a list of celestial bodies, say, at least all the planets in
;    our solar system;

;  2 a list of items for a meal, for example, steak, French fries, beans,
;    bread, water, brie cheese, and ice cream; and

;  3 a list of colors.

;; Sketch box representations of these lists, similar to those in figure 43
;; and figure 44. Which of the sketches do you like better?

; a
(cons "Pluto"
      (cons "Neptune"
            (cons "Uranas"
                  (cons "Saturn"
                        (cons "Jupiter"
                              (cons "Mars"
                                    (cons "Earth"
                                          (cons "Venus"
                                                (cons "Mars"
                                                      '() )))))))))
; b
(cons "steak"
      (cons "French fries"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "brie cheese"
                                    (cons "ice cream"
                                          '() )))))))
; c
(cons "infared"
      (cons "red"
            (cons "orange"
                  (cons "yellow"
                        (cons "green"
                              (cons "cyan"
                                    (cons "blue"
                                          (cons "purple"
                                                (cons "altraviolet"
                                                      '() )))))))))


;;;;;;;;;;;;;;;;;;;;;

;; a list of numbers
(cons 0
  (cons 1
    (cons 2
      (cons 3
        (cons 4
          (cons 5
            (cons 6
              (cons 7
                (cons 8
                  (cons 9 '()))))))))))


;; three arbitrary numbers
(cons pi
  (cons e
    (cons -22.3 '())))


;; list of arbitrary type
(cons "Robbie Round"
  (cons 3
    (cons #true
      '())))


;; data defininition for a kind of list with an exact number of items

; A 3LON is a list of three numbers:
;   (cons Number (cons Number (cons Number '())))
; interpretation a point in 3-dimensional space


;; a data definition for a list with an arbitrary number of items
;; (self referential)

; A List-of-names is one of:
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

;; examples:
'()  ; – '()

(cons "Findler" '())   ; – (cons String List-of-names)

(cons "Flatt" '())
(cons "Felleisen" '())
(cons "Krishnamurthi" '())

(cons "Relleisen" (cons "Findler" '()))
;; – (cons String List-of-names)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 130:
;; Create an element of List-of-names that contains five Strings. Sketch a box
;; representation of the list similar to those found in figure 43

(cons "Maphis"
      (cons "Findler"
            (cons "Flatt"
                  (cons "Felleisen"
                        (cons "Krishnamurthi"
                              '())))))

(cons "1" (cons "2" '()))
; is a list of names because names are defined as String, and this list
; fits the pattern: (cons String List-of-names)

(cons 2 '())
; is a list of numbers not a list of names


;; Ex. 131:
;; Provide a data definition for representing lists of Boolean values. The
;; class contains all arbitrarily long lists of Booleans.

;; List-of-booleans is one of
;; - '()
;; - (cons Boolean List-of-booleans)
;; interpretation: an arbitrarily long list of Booleans

;; examples
'()   ; empty list
(cons #true '())  ; list of one
(cons #true (cons #false '())) ; arbitrary length list


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 8.2 What Is '(), What Is cons

;;'() is an atomic distinct value

;; empty? predicate to recoginize '()

; Any -> Boolean
; is the given value '()
;(define (empty? x) ...)

(empty? '())  ; #true
(empty? 5)    ; #false
(empty? "hello world")    ; #false
(empty? (cons 1 '()))     ; #false
(empty? (make-posn 0 0))  ; #false


;; "cons" is a constructor for a two file stucture, the first value can belong
;; to any class, the second value is a list type value

(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).

; Any Any -> ConsPair
(define (our-cons0 a-value a-list)
  (make-pair a-value a-list))

;; but: our-cons can except any value for a second value
(our-cons0 1 2)

;; but cons can't (in BSL)
;(cons 1 2)
;cons: second argument must be a list, but received 1 and 2

;; "cons" is a checked funtion

; A ConsOrEmpty is one of:
; – '()
; – (cons Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists

; Any ConsOrEmpty -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))


;; selectors for 'cons' are 'firs' 'rest'

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> ConsOrEmpty
; extracts the right part of athe given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-right a-list)))


;; List primitives:
; '()     - a special value, mostly to represent the empty list
; empty?  - a predicate to recognize '() and nothing else
; cons    - a checked constructor to create two-field instances
; first   - the selector to extract the last item added
; rest    - the selector to extract the extended list
; cons?   - a predicate to recognizes instances of cons
