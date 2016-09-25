;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_01_165_subst_robot) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.1 Functions that Produce Functions
;; Exercise: 165
;; Substitute Robot


;; Ex. 165:
;; Design the function subst-robot, which consumes a list of toy descriptions
;; (one-word strings) and replaces all occurrences of "robot" with "r2d2"; all
;; other descriptions remain the same.

;; Generalize subst-robot to substitute. The latter consumes two strings,
;; called new and old, and a list of strings. It produces a new list of strings
;; by substituting all occurrences of old with new.



;; List-of-strings -> List-of-strings
;; consumes a List of Strings and replaces "robot" with "r2d2"

(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "car" (cons "robot" (cons "doll" '()))))
              (cons "car" (cons "r2d2" (cons "doll" '()))))

(define (subst-robot lot)
  (cond
    [(empty? lot) '()]
    [else (if (string=? (first lot) "robot")
              (cons "r2d2" (subst-robot (rest lot)))
              (cons (first lot) (subst-robot (rest lot))))]))


;; generalized version:

;; List-of-strings String String -> List-of-strings
;; consumes a List of Strings and replaces 'old' String with 'new' String

(check-expect (substitute '() "robot" "r2d2") '())
(check-expect (substitute (cons "car"
                                (cons "robot"
                                      (cons "doll" '())))
                          "robot" "r2d2")
              (cons "car" (cons "r2d2" (cons "doll" '()))))

(define (substitute lot old new)
  (cond
    [(empty? lot) '()]
    [else (if (string=? (first lot) old)
              (cons new (substitute (rest lot) old new))
              (cons (first lot)
                    (substitute (rest lot) old new)))]))

