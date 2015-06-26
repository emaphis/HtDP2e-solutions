;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Programs are Function Plus Variable Definitions

;; 3.1  Composing Functions

;; Imagine the owner of a movie theater who has complete freedom in
;; setting ticket prices. The more he charges, the fewer the people
;; who can afford tickets. In a recent experiment the owner determined
;; a precise relationship between the price of a ticket and average
;; attendance. At a price of $5.00 per ticket, 120 people attend a
;; performance. Decreasing the price by a dime ($.10) increases
;; attendance by 15. Unfortunately, the increased attendance also comes
;; at an increased cost. Every performance costs the owner $180. Each
;; attendee costs another four cents ($0.04). The owner would like to
;; know the exact relationship between profit and ticket price so that
;; he can determine the price at which he can make the highest profit.

;; profit : number  ->  number
;; to compute the profit as the difference between revenue and costs
;; at some given ticket-price
;(define (profit ticket-price) ...)

;; revenue : number  ->  number
;; to compute the revenue, given ticket-price
;(define (revenue ticket-price) ...)

;; cost : number  ->  number
;; to compute the costs, given ticket-price
;(define (cost ticket-price) ...)

;; attendees : number  ->  number
;; to compute the number of attendees, given ticket-price
;(define (attendees ticket-price) ...)

;; Exercise 3.1.1.
;; The next step is to make up examples for each of the functions.
;; Determine how many attendees can afford a show at a ticket price
;; of $3.00, $4.00, and $5.00. Use the examples to formulate a general
;; rule that shows how to compute the number of attendees from the ticket
;; price. Make up more examples if needed.

;; attendees : number  ->  number
;; to compute the number of attendees, given ticket-price
;; increase 150 for every $1 ticket price decrease
(define (attendance price)
  (+ 120 (* 150 (- 5.00 price))))

(check-expect (attendance 5.00) 120)
(check-expect (attendance 4.00) 270)
(check-expect (attendance 3.00) 420)

;; Exercise 3.1.2.
;; Use the results of exercise 3.1.1 to determine how much it costs to
;; run a show at $3.00, $4.00, and $5.00. Also determine how much revenue
;; each show produces at those prices. Finally, figure out how much profit
;; the monopolistic movie owner can make with each show. Which is the best
;; price (of these three) for maximizing the profit?

;; cost : number  ->  number
;; to compute the costs, given ticket-price
(define (cost price)
  (+ 180.00 (* (attendance price) 0.04)))

(check-expect (cost 5.00) 184.80)
(check-expect (cost 4.00) 190.80)
(check-expect (cost 3.00) 196.80)

;; revenue : number  ->  number
;; to compute the revenue, given ticket-price
(define (revenue price)
  (* price (attendance price)))

(check-expect (revenue 5.00)  600.00)
(check-expect (revenue 4.00) 1080.00)
(check-expect (revenue 3.00) 1260.00)

;; profit : number  ->  number
;; to compute the profit as the difference between revenue and costs
;; at some given ticket price
(define (profit price)
  (- (revenue price) (cost price)))

(check-expect (profit 5.00)  415.20)
(check-expect (profit 4.00)  889.20)
(check-expect (profit 3.00) 1063.20)


;; Exercise 3.1.3.
;; Determine the profit that the movie owner makes at $3.00, $4.00,
;; and $5.00 using the program definitions in both columns. Make sure
;; that the results are the same as those predicted in exercise

;; How not to design a program
(define (profit-2 price)
  (- (* (+ 120
	   (* (/ 15 .10)
	      (- 5.00 price)))
	price)
     (+ 180
	(* .04
	   (+ 120
	      (* (/ 15 .10)
		 (- 5.00 price)))))))

(check-expect (profit 5.00) (profit-2 5.00))
(check-expect (profit 4.00) (profit-2 4.00))
(check-expect (profit 3.00) (profit-2 3.00))

