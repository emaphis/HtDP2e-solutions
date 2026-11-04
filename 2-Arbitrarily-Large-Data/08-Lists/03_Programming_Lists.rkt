;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 08_03_programming_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 8 Lists
;; 8.3 Programming with Lists
;; Exercises: 132-134

;; Sample Problem:
;; You are working on the contact list for some new cell phone. The phone’s
;; owner updates and consults this list on various occasions. For now, you are
;; assigned the task of designing a function that consumes this list of
;; contacts and determines whether it contains the name “Flatt.”


; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names

(check-expect (contains-flatt? '()) #false)

(check-expect (contains-flatt? (cons "Find" '()))
              #false)
(check-expect (contains-flatt? (cons "Flatt" '()))
              #true)

(check-expect
  (contains-flatt?
    (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)

(check-expect
  (contains-flatt?
    (cons "A" (cons "Find" (cons "C" '()))))
  #false)


(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))


;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 132:
;; Use DrRacket to run contains-flatt? in this example:

(check-expect
 (contains-flatt?
  (cons "Fagan"
        (cons "Findler"
              (cons "Fisler"
                    (cons "Flanagan"
                          (cons "Flatt"
                                (cons "Felleisen"
                                      (cons "Friedman" '()))))))))
 #true) ; my expectation

;; What answer do you expect?


;; Ex. 133:
;; Here is another way of formulating the second cond clause in
;; contains-flatt?:

;    ... (cond
;          [(string=? (first alon) "Flatt") #true]
;          [else (contains-flatt? (rest alon))]) ...
;

(define (contains-flatt?-V2 alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) "Flatt") #true]
       [else (contains-flatt?-V2 (rest alon))])]))

;; Explain why this expression produces the same answers as the or expression
;; in the version of figure 46. Which version is better? Explain.

;; 'or' short circuits if the first clause is true, cond does the smame thing.
;; the first version seems simpler to me.


;; Ex. 134:
;; Develop the function contains?. It determines whether some given string
;; occurs on a given list of strings.

;; Note BSL actually comes with member?, a function that consumes two values
;; and checks whether the first occurs in the second, a list:

;    > (member? "Flatt" (cons "b" (cons "Flatt" '())))
;    #true

;; Don’t use member? to define the contains? function.



;; String List-of-String -> Boolean
;; returns #true if a givens string is contained in a given list

(check-expect (contains-string? "Flatt" '()) #false)

(check-expect
  (contains-string? "Flatt"
    (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)

(check-expect
  (contains-string? "Flatt"
    (cons "A" (cons "Find" (cons "C" '()))))
  #false)

;(define (contains-string? str los) #false)  ; stub

(define (contains-string? str los)
  (cond
    [(empty? los) #false]
    [else
        (or (string=? (first los) str)
            (contains-string? str (rest los)))]))