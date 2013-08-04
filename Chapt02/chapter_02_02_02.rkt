;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_02_02_02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; HtDP 2e 2.2 Functions
;; 2.2.2 Composing Functions
;; Exercises 23-15
(require 2htdp/image)

;; Sample program
;; Attendee's example and Letter example

;; Letter sample -- function composition

(define (letter fst lst signature-name) 
  (string-appen25
   (opening fst) 
   "\n" 
   (body fst lst) 
   "\n" 
   (closing signature-name))) 

(define (opening fst) 
  (string-append "Dear " fst ",")) 

(define (body fst lst) 
  (string-append 
   "we have discovered that all people with the last name " 
   "\n" 
   lst " have won our lottery. So, " fst ", " 
   "\n" 
   "hurry and pick up your prize.")) 

(define (closing signature-name) 
  (string-append 
   "Sincerely," 
   "\n" 
   signature-name)) 

(check-expect (letter "Matthew" "Krishnamurthi" "Felleisen")
              "Dear Matthew,\nwe have discovered that all people with the last name \nKrishnamurthi have won our lottery. So, Matthew, \nhurry and pick up your prize.\nSincerely,\nFelleisen")


;; Attendees example
#;
(define (attendees ticket-price)
  (+ 120 (* (/ 15 0.1) (- 5.0 ticket-price))))
#;
(define (revenue ticket-price)
  (*  (attendees ticket-price) ticket-price))
#;
(define (cost ticket-price)
  (+ 180 (* 0.04 (attendees ticket-price))))
#;
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; Exercise 23:
(define START-ATTENDEES 120)
(define START-PRICE 5.00)
(define INCREASE-ATTENDENCE 15)
(define INCREASED-PRICE 0.10)
(define FIXED-COST 180.00)
(define PRICE-PER-ATTENDEE 0.04)

(define (attendees ticket-price)
  (+ START-ATTENDEES 
     (* (/ INCREASE-ATTENDENCE INCREASED-PRICE) 
        (- START-PRICE ticket-price))))

(define (revenue ticket-price)
  (*  (attendees ticket-price) ticket-price))

(define (cost ticket-price)
  (+ FIXED-COST 
     (* PRICE-PER-ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; Exercise 24:
;; a:
(check-expect (profit 1.00)  511.20)
(check-expect (profit 2.00)  937.20)
(check-expect (profit 3.00) 1063.20)
(check-expect (profit 4.00)  889.20)
(check-expect (profit 5.00)  415.20)

;; b. Highest profit
(check-expect (profit 2.80) 1062.00)
(check-expect (profit 2.90) 1064.10) ;; Highest profit!!!
(check-expect (profit 3.00) 1063.20)

;; c. Complex definition
(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.10)
              (- 5.00 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

(check-expect (profit2 1.00) (profit2 1.00))
(check-expect (profit2 2.00) (profit2 2.00))
(check-expect (profit2 3.00) (profit2 3.00))
(check-expect (profit2 4.00) (profit2 4.00))
(check-expect (profit2 5.00) (profit2 5.00))


;; Exercise 25: 
;; new fixed cost per attendee schedule

;; a. well factored program
(define FIXED-COST-PER-ATTENDEE 1.50)

(define (attendees3 ticket-price)
  (+ START-ATTENDEES
     (* (/ INCREASE-ATTENDENCE INCREASED-PRICE) 
        (- START-PRICE ticket-price))))

(define (revenue3 ticket-price)
  (*  (attendees3 ticket-price) ticket-price))

(define (cost3 ticket-price)
  (* FIXED-COST-PER-ATTENDEE 
     (attendees3 ticket-price)))

(define (profit3 ticket-price)
  (- (revenue3 ticket-price)
     (cost3 ticket-price)))

(check-expect (profit3 1.00) -360)
(check-expect (profit3 2.00)  285)
(check-expect (profit3 3.00)  630) 
(check-expect (profit3 4.00)  675) ;; Highest
(check-expect (profit3 5.00)  420)


;; b. complex program
(define (profit4 price)
  (- (* (+ 120
	   (* (/ 15 0.10)
	      (- 5.00 price)))
	price)
     (* 1.50
	(+ 120
	   (* (/ 15 0.10)
	      (- 5.00 price))))))

(check-expect (profit4 1.00) (profit3 1.00))
(check-expect (profit4 2.00) (profit3 2.00))
(check-expect (profit4 3.00) (profit3 3.00)) ;; Highest
(check-expect (profit4 4.00) (profit3 4.00))
(check-expect (profit4 5.00) (profit3 5.00))

