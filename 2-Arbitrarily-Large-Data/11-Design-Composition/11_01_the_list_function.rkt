;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11_01_the_list_function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 11 Design by Composition
;; 11.1 The list Function
;; Exercises: 181-185

;; Graduated from BSL to BSL with List Abreviations -- Yay!!

; (list exp-1 ... exp-n) == (cons exp-1 ... (cons exp-n '()))


;;;;;;;;;;;;;;;;;;;;;
;; Ex. 181:
;; Use list to construct the equivalent of these lists:

(check-expect (cons "a" (cons "b" (cons "c" (cons "d" '()))))
              (list "a" "b" "c" "d"))

(check-expect (cons (cons 1 (cons 2 '())) '())
              (list (list 1 2)))

(check-expect (cons "a" (cons (cons 1 '()) (cons #false '())))
              (list "a" (list 1) #false))

(check-expect (cons (cons "a" (cons 2 '())) (cons "hello" '()))
              (list (list "a" 2) "hello"))

;; Also try your hands at this one:

(check-expect (cons (cons 1 (cons 2 '()))
                    (cons (cons 2 '())
                          '()))
              (list (list 1 2)
                    (list 2)))

;; Start by determining how many items each list and each nested list contains.
;; Use check-expect to express your answers; this ensures that your
;; abbreviations are really the same as the long-hand.


;; Ex. 182:
;; Use cons and '() to form the equivalent of these lists:

(check-expect (list 0 1 2 3 4 5)
              (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))

(check-expect (list (list "he" 0) (list "it" 1) (list "lui" 14))
              (cons (cons "he" (cons 0 '()))
                    (cons (cons "it" (cons 1 '()))
                          (cons (cons "lui" (cons 14 '())) '()))))

(check-expect (list 1 (list 1 2) (list 1 2 3))
              (cons 1
                    (cons (cons 1 (cons 2 '()))
                          (cons (cons 1 (cons 2 (cons 3 '()))) '()))))

;; Use check-expect to express your answers.


;; Ex. 183:
;; On some occasions lists are formed with cons and list.

;; Reformulate each of the following expressions using only cons or only list.
;; Use check-expect to check your answers.

(check-expect (cons "a" (list 0 #false))
              (cons "a" (cons 0 (cons #false '()))))
(check-expect (cons "a" (list 0 #false))
              (list "a" 0 #false))


(check-expect (list (cons 1 (cons 13 '())))
              (cons (cons 1 (cons 13 '())) '()))
(check-expect (list (cons 1 (cons 13 '())))
              (list (list 1 13)))


(check-expect (cons (list 1 (list 13 '())) '())
              (cons (cons 1 (cons (cons 13 (cons '() '())) '())) '()))
(check-expect (cons (list 1 (list 13 '())) '())
              (list (list 1 (list 13 '()))))

(check-expect (list '() '() (cons 1 '()))
              (cons '() (cons '() (cons (cons 1 '()) '()))))
(check-expect (list '() '() (cons 1 '()))
              (list '() '() (list 1)))

(check-expect (cons "a" (cons (list 1) (list #false '())))
              (cons "a" (cons (cons 1 '()) (cons #false (cons '() '())) )))
(check-expect (cons "a" (cons (list 1) (list #false '())))
              (list "a"  (list 1) #false '()))


;; Ex. 184:
;; Determine the values of the following expressions:
;; Use check-expect to express your answers.

(check-expect (list (string=? "a" "b") #false)
              (list #false #false))

(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 1/2))

(check-expect (list "dana" "jane" "mary" "laura")
              (list "dana" "jane" "mary" "laura"))


;; Ex. 185:
;; You know about first and rest from BSL, but BSL+ comes with even more
;; selectors than that. Determine the values of the following expressions: 
;; Find out from the documentation whether third and fourth exist.

(check-expect (first (list 1 2 3))
              1)

(check-expect (rest (list 1 2 3))
              (list 2 3))

(check-expect (second (list 1 2 3))
              2)

;; third and fourth do exist along with first -> ninth and a bunck of
;; car and cdr based functions:

(check-expect (third (list 1 2 3 4))
              3)

(check-expect (fourth (list 1 2 3 4))
              4)
