;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_02_structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.2 Structures in Lists
;; Exercises: 166-170


;; using a structure to represent employee work weeks.

(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name
; with the pay rate r and the number of hours h

(define WORK1 (make-work "Robby" 11.95 39))

; Low (short for list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the
; hours worked for a number of employees

(define LOW0 '())
(define LOW1 (cons (make-work "Robby" 11.95 39)
                   '()))
(define LOW3 (cons (make-work "Matthew" 12.95 45)
                   (cons (make-work "Robby" 11.95 39)
                         '())))

(define LOW4 (cons (make-work "Elain" 13.50 30)
                   (cons (make-work "Jerry" 22.40 40)
                         (cons (make-work "George" 8.30 20)
                               '()))))
(define LOW2 (cons (make-work "Krammer" 30.00 5) '()))


; Low -> List-of-numbers
; computes the weekly wages for the given records
(check-expect (wage*.v2 '()) '())
(check-expect (wage*.v2 (cons (make-work "Robby" 11.95 39)
                   '()))
               (cons (* 11.95 39) '()))


(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low)
     (cons (wage.v2 (first an-low))
           (wage*.v2 (rest an-low)))]))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))


;; Ex. 166:
;; version 3
;; see 10_02_166a_Employees3.rkt
;; version 4
;; see 10_02_166b_Employees4.rkt



;; Ex. 167:
;; Design the function sum, which consumes a list of Posns and produces the
;; sum of all of its x-coordinates.

;; List-of-Posn -> Number
;; consumes a list of Posns and produces the sum of all of its x-coordinates

(check-expect (sum-x '()) 0)
(check-expect (sum-x (cons (make-posn 10 20)
                           (cons (make-posn 20 40)
                                 (cons (make-posn 30 50) '()))))
              60)

(define (sum-x lop)
  (cond [(empty? lop) 0]
        [else
         (+ (posn-x (first lop))
            (sum-x (rest lop)))]))


;; Ex. 168:
;; Design the function translate. It consumes and produces lists of Posns. For
;; each (make-posn x y) in the former, the latter contains
;; (make-posn x (+ y 1)).—We borrow the word “translate” from geometry, where
;; the movement of a point by a constant distance along a straight line is
;; called a translation.

;; List-of-Posns -> List-of-Posns
;; translate a List of Posns adding 1 to the posn-y

(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 0 0)
                               (cons (make-posn 10 20)
                                     (cons (make-posn 30 40) '()))))
              (cons (make-posn 0 1)
                    (cons (make-posn 10 21)
                          (cons (make-posn 30 41) '()))))

(define (translate lop)
  (cond [(empty? lop) '()]
        [else
         (cons (trans-posn (first lop))
               (translate (rest lop)))]))

;; Posn -> Posn
;; translate a single Posn adding one unit to posn-y
(check-expect (trans-posn (make-posn 30 40)) (make-posn 30 41))

(define (trans-posn ps)
  (make-posn (posn-x ps) (add1 (posn-y ps))))


;; Ex. 169:
;; Design the function legal. Like translate from exercise 168 the function
;; consumes and produces a list of Posns. The result contains all those Posns
;; whose x-coordinates are between 0 and 100 and whose y-coordinates are
;; between 0 and 200.

;; List-of-Posn -> List-of-Posn
;; return a new List of Posn with illegal Posns filtered out

(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 50 50)
                           (cons (make-posn 150 50)
                                 (cons (make-posn 50 -50)
                                       (cons (make-posn 100 100) '())))))
              (cons (make-posn 50 50)
                    (cons (make-posn 100 100) '())))

(define (legal lop)
  (cond [(empty? lop) '()]
        [else
         (if (legal? (first lop))
             (cons (first lop) (legal (rest lop)))
             (legal (rest lop)))]))

;; Posn -> Boolean
;; return #true if given Posn in legal range

(check-expect (legal? (make-posn 50 50)) #true)
(check-expect (legal? (make-posn -1 50)) #false)
(check-expect (legal? (make-posn 101 50)) #false)
(check-expect (legal? (make-posn 50 -1)) #false)
(check-expect (legal? (make-posn 50 201)) #false)

(define (legal? p)
  (and (<= 1 (posn-x p) 100)
       (<= 1 (posn-y p) 200)))


;; Ex. 170:
;; Here is one way to represent a phone number:

;; Design the function replace. It consumes a list of Phones and produces one.
;; It replaces all occurrence of area code 713 with 281. image

(define-struct phone [area switch four])
; A Phone is a structure:
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999.
; A Four is a Number between 1000 and 9999.

(define PHONE1 (make-phone 555 123 4444))

#; ;tempate
(define (fun-for-phone p)
  (... (phone-area p)
       (phone-switch p)
       (phone-four p)))


;; List-of-Phones -> List-of-Phones
;; returns a new List of Phone numbers with area code 713 with 281

(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 555 123 4444)
                             (cons (make-phone 713 123 5555)
                                   (cons (make-phone 216 544 1234) '()))))
              (cons (make-phone 555 123 4444)
                    (cons (make-phone 281 123 5555)
                          (cons (make-phone 216 544 1234) '()))))

(define (replace lop)
  (cond [(empty? lop) '()]
        [else
         (cons (filter-phone (first lop))
               (replace (rest lop)))]))

;; Phone -> Phone
;; return a Phone with new area code 281 if area code = 713

(check-expect (filter-phone (make-phone 713 123 5555))
              (make-phone 281 123 5555))
(check-expect (filter-phone (make-phone 216 123 5555))
              (make-phone 216 123 5555))

(define (filter-phone p)
  (if (equal? (phone-area p) 713)
      (make-phone 281 (phone-switch p) (phone-four p))
      p))