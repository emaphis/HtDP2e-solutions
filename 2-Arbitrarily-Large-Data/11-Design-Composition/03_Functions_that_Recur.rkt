;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11_03_functions_that_recur) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 11 Design by Composition
;; 11.2 Composing Functions
;; 11.3 Auxiliary Functions that Recur
;; Exercises: 186-190

; programs are collections of definitions: structures, data, constants,
; functions  (and don't forget tests!)

; Auxiliary function guidelines:

; Design one function per task. Formulate auxiliary function definitions for
; every dependency between quantities in the problem.

; and now:

; Design one template per data definition. Formulate auxiliary function
; definitions when one data definition points to a second data definition

; the wish list:



;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auxiliary Functions that Recur

;; Sample Problem Design a function that sorts a list of reals.

; List-of-numbers -> List-of-numbers
; rearrange alon in descending order
(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))

(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))


; wish list entry for a function that insert in proper place:

; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 1 (list 3 2)) (list 3 2 1))
(check-expect (insert 3 (list 2 1)) (list 3 2 1))
(check-expect (insert 12 (list 20 -5))
              (list 20 12 -5))

(define (insert n alon)
  (cond
    [(empty? alon) (list n)]
    [else (if (>= n (first alon))
              (cons n alon)
              (cons (first alon) (insert n (rest alon))))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 186:
;; Take a second look at Intermezzo: BSL, the intermezzo that presents BSL
;; and its ways of formulating tests. One of the latter is check-satisfied,
;; which determines whether an expression satisfies a certain property.
;; Use sorted>? from exercise 145 to re-formulate the tests for sort> with
;; check-satisfied.

;(check-satisfied (sort> '()) sorted>?) ; must be not empty
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)

; NEList-of-Numbers -> Boolean
; produce #true is NEList-of-Numbers is sorted in desending order
; NE = Not Empty -- from exercise 145

(check-expect (sorted>? (list 3)) #true)
(check-expect (sorted>? (list 1 2 3)) #false)
(check-expect (sorted>? (list 3 2 1)) #true)

(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else
     (and (> (first ne-l) (first (rest ne-l)))
          (sorted>? (rest ne-l)))]))


;Now consider this function definition:

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/bad l)
  '(9 8 7 6 5 4 3 2 1 0))

; Can you formulate a test case that shows sort>/bad is not a sorting function?
; Can you use check-satisfied to formulate this test case?

; Yes, since the function actually just returns a constant list, any other
; example should fail:
; (check-expect (sort>/bad (list 3 1 2)) (list 3 2 1))

; even an already sorted:
;(check-expect (sort>/bad (list 3 2 1)) (list 3 2 1))

; check-satisfied, need to create a length predicate, sorted>? will fail
; to catch the bad sort function:
;(define (length-3? lst)  (= 3 (length lst)))
;(check-satisfied (sort>/bad (list 3 1 2)) length-3?)


;; Ex 187:
;; See 11_03_187_game_player1.rkt


;; Ex 188:
;; see 11_03_188_email1.rkt


;; Ex. 189:
;; Here is the function search:

; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

(check-expect (search 1 '()) #false)
(check-expect (search 1 (list 1)) #true)
(check-expect (search 3 (list 4 6 8 1 2)) #false)
(check-expect (search 3 (list 4 6 3 8 2 1)) #true)

;; It determines whether some number occurs in a list of numbers. The function
;; may have to traverse the entire list to find out that the number of interest
;; isn’t contained in the list.

;; Develop the function search-sorted, which determines whether a number occurs
;; in a sorted list of numbers. The function must take advantage of the fact
;; that the list is sorted.

; the search on sorted version uses the fact that it doesn't have to search
; the rest of the list after the numbers on the list are larger

; Number List-of-numbers -> Boolean
(define (search-sort n s-alon)
  (cond
    [(empty? s-alon) #false]
    [(< n (first s-alon)) #false] ; skip rest and return false
    [else (or (= (first s-alon) n)
              (search n (rest s-alon)))]))

(check-expect (search-sort 1 '()) #false)
(check-expect (search-sort 3 (list 1 2 4 5)) #false)
(check-expect (search-sort 3 (list 1 2 3 4 5)) #true)


;; Ex. 190:
;; Design the prefixes function, which consumes a list of 1Strings and produces
;; the list of all prefixes. A list p is a prefix of l if p and l are the same
;; up through all items in p. For example, (list "a" "b" "c") is a prefix of
;; itself and (list "a" "b" "c" "d").

;; Design the function suffixes, which consumes a list of 1Strings and produces
;; all suffixes. A list s is a suffix of l if p and l are the same from the
;; end, up through all items in s. For example, (list "b" "c" "d") is a suffix
;; of itself and (list "a" "b" "c" "d").

; LOLO1S is a List of LO1S

;; LO1S -> LOLO1S

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a") (list "a" "b")))
(check-expect (prefixes (list "a" "b" "c"))
              (list (list "a") (list "a" "b") (list "a" "b" "c")))

(define (prefixes lo1s) (prefixes-aux lo1s lo1s))

; I created a cheesy helper function becuase I need to save the original list.
(define (prefixes-aux lo1s save)
  (cond [(empty? lo1s) '()]
        [else
         (cons (copy-until (first lo1s) save)
               (prefixes-aux (rest lo1s) save))]))

;; 1String  LOsS -> LO1S
;; copy elements ofLO1S until a given 1String
;; assume: 1String will be found in given LO1S therefore
;;         LO1S also must have at least one 1String
(check-expect (copy-until "a" (list "a")) (list "a"))
(check-expect (copy-until "b" (list "a" "b")) (list "a" "b"))
(check-expect (copy-until "b" (list "a" "b" "c" "d")) (list "a" "b"))

(define (copy-until 1s lo1s)
  (cond [(string=? 1s (first lo1s)) (list 1s)]
        [else
         (cons (first lo1s) (copy-until 1s (rest lo1s)))]))


; LO1S -> LOLO1S
; produce all of the suffixes from a given LO1S
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect  (suffixes (list "a" "b")) (list (list "b") (list "b" "a")))
(check-expect (suffixes (list "a" "b" "c"))
              (list (list "c") (list "c" "b") (list "c" "b" "a")))

(define (suffixes lo1s)
  (prefixes (rev lo1s)))

; List -> List
; reverse any generic list (kinda expensive, I guess)
(check-expect (rev '()) '())
(check-expect (rev (list "a")) (list "a"))
(check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))

(define (rev lst)
  (cond [(empty? lst) '()]
        [else
         (append (rev (rest lst))
                 (cons (first lst) '()))]))