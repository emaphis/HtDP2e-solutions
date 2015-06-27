;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04-04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 4.4  Designing Conditional Functions

;; DepositAmount is 1 of 3:
;; - Natural(0, 1000]
;; - Natural(1000, 5000]
;; - Natural(> 5000)
;; interp. 3 differnt intervals each giving differen interest rates
(define RS1   500)
(define RS2  2800)
(define RS3 15000)

#;; template
(define (fn-for-deposit-amount da)
  (cond [(<= da 1000) (... da)]
        [(<= da 5000) (... da)]
        [else (... da)]))
;; Template rules used:
;; - one of: 3 cases
;; - atomic non-distinct Natural[0,1000]
;; - atomic non-distinct Natural(1000, 5000]
;; - atomic non-distinct Natural(> 5000)

;; Exercise 4.4.1.
;; Develop the function interest. Like interest-rate, it consumes a
;; deposit amount. Instead of the rate, it produces the actual amount of
;; interest that the money earns in a year.
;; The bank pays
;; a flat 4% for deposits of up to $1,000,
;; a flat 4.5% per year for deposits of up to $5,000, and
;; a flat 5% for deposits of more than $5,000.

;; interest: DepositAmount -> Number
;; calculates interest on a given deposit amount (da)
(check-expect (interest   500)  20.0)
(check-expect (interest  2800) 126.0)
(check-expect (interest 15000) 750.0)

(define (interest da)
  (cond [(<= da 1000) (* 0.040 da)]
        [(<= da 5000) (* 0.045 da)]
        [else (* 0.050 da)]))



;; Exercise 4.4.2.
;; Develop the function tax, which consumes the gross pay and produces
;; the amount of tax owed.
;; For a gross pay of $240 or less, the tax is 0%;
;; for over $240 and $480 or less, the tax rate is 15%;
;; and for any pay over $480, the tax rate is 28%.

;; GrossPay is one of:
;; - Natural[0,240]
;; - Natural(240, 480]
;; - Natural(> 480)
;; interp. first has a tax rate 0%, second rate 15%
;;         third radt 28%
(define PY1 100) ; 1st level
(define PY2 300) ; 2nd level
(define PY3 500) ; highest level
#;
(define (fn-for-gross-pay gp)
  (cond [(<= gp 240.0) (... gp)]
        [(<= gp 480.0) (... gp)]
        [else (... gp)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic non-distinct: Natural[0,240]
;; - atomic non-distinct: Natural(240, 480]
;; - atomic non-distinct: Natural(> 480)


;; tax : GrossPay -> Number
;; calculates tax given gross pay
(check-expect (tax 100) 0.0)
(check-expect (tax 300) 45.0)
(check-expect (tax 500) (* 5 28))
; template from GrossPay>
(define (tax gp)
  (cond [(<= gp 240.0) (* 0.00 gp)]
        [(<= gp 480.0) (* 0.15 gp)]
        [else (* 0.28 gp)]))


;; Also develop netpay. The function determines the net pay of an
;; employee from the number of hours worked.
;; The net pay is the gross pay minus the tax.
;; Assume the hourly pay rate is $12.

;; Hint: Remember to develop auxiliary functions when a definition
;; becomes too large or too complex to manage.

;; netpay : Natural -> Number
;; calculate net pay from hours worked
(check-expect (netpay 1) 12)
(check-expect (netpay 40) 408)

(define (netpay hrs)
  (- (gross-pay hrs)
     (tax (gross-pay hrs))))

;; gross-pay:  Natural -> Number
;; calculates gross pay given hours of work
(check-expect (gross-pay 0) 0)
(check-expect (gross-pay 10) 120.00)

(define (gross-pay hrs)
  (* PAY-PER-HOUR hrs))

(define PAY-PER-HOUR 12.0)



;; Exercise 4.4.3.
;; Some credit card companies pay back a small portion of the charges a
;; customer makes over a year. One company returns
;; 1. .25% for the first $500 of charges,
;; 2. .50% for the next $1000 (that is, the portion between $500 and $1500),
;; 3. .75% for the next $1000 (that is, the portion between $1500 and $2500),
;; 4. and 1.0% for everything above $2500.
;; Thus, a customer who charges $400 a year receives $1.00, which is 0.25 · 1/100 · 400,
;; and one who charges $1,400 a year receives $5.75, which is 1.25 = 0.25 · 1/100 · 500 for the first $500
;; and 0.50 · 1/100 · 900 = 4.50 for the next $900.
;; Determine by hand the pay-backs for a customer who charged $2000 and one who charged $2600
;; Define the function pay-back, which consumes a charge amount and computes the corresponding pay-back amount

;; ChargeAmount is 1 of 3
;; - Natural[0,500]      -  .25%
;; - Natural(500, 1500]  -  .50%
;; - Natural(1500, 2500] -  .75%
;; - Natural(> 2500)     - 1.00%
#;
(define (fn-for-charge-amount ca)
  (cond [(<= ca  500) (... ca)]
        [(<= ca 1500) (... ca)]
        [(<= ca 2500) (... ca)]
        [else (... ca)]))

;; pay-back : ChargeAmount -> Number
;; calculates the payback amount given the charge amount
(define (pay-back ca)
  (cond [(<= ca  500)
         (+ (* 0.0025 (- ca    0))  ; base case
                         0)]
        [(<= ca 1500)
         (+ (* 0.0050 (- ca  500))
                         (pay-back  500))]
        [(<= ca 2500)
         (+ (* 0.0075 (- ca 1500))
                         (pay-back 1500))]
        [else
         (+ (* 0.0100 (- ca 2500))
                         (pay-back 2500))] ))

(check-expect (pay-back  400)  1.00)
(check-expect (pay-back 1400)  5.75)
(check-expect (pay-back 2000) 10.00)
(check-expect (pay-back 2600) 14.75)

;; much much too recursive for this stage of the game.