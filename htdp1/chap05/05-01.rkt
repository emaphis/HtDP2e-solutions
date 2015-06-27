;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05-01) (read-case-sensitive #t) (teachpacks ((lib "guess.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "guess.rkt" "teachpack" "htdp")))))
;; Symbolic Information


;; Greeting is 1 of:
;; - 'GoodMorning
;; - 'HowAreYou?
;; - 'GoodAfternoon
;; - 'GoodEvening
;; interp. Variour polite greetings

;; <examples are redundant for enumerations>
#;
(define (fn-for-greating gt)
  (cond [(symbol=? gt 'GoodMorning) (...)]
        [(symbol=? gt 'HowAreYou?) (...)]
        [(symbol=? gt 'GoodAfternoon) (...)]
        [(symbol=? gt 'GoodEvening) (...)]))


;; reply : symbol  ->  symbol
;; to determine a reply for the greeting s
(define (reply s)
  (cond [(symbol=? s 'GoodMorning) 'Hi]
        [(symbol=? s 'HowAreYou?) 'Fine]
        [(symbol=? s 'GoodAfternoon) 'INeedANap]
        [(symbol=? s 'GoodEvening) 'BoyAmITired]))

(check-expect (reply 'GoodMorning) 'Hi)
(check-expect (reply 'HowAreYou?) 'Fine)
(check-expect (reply 'GoodAfternoon) 'INeedANap)
(check-expect (reply 'GoodEvening) 'BoyAmITired)


;; Symbolic information can also include strings and images


;; 5.1  Finger Exercises with Symbols

;; Exercise 5.1.1.
;; Evaluate (reply 'HowAreYou?) by hand and with DrScheme's stepper. Formulate a
;; complete set of examples for reply as boolean expressions (using symbol=?).

(reply 'HowAreYou?)
(cond [(symbol=? 'HowAreYou? 'GoodMorning) 'Hi]
      [(symbol=? 'HowAreYou? 'HowAreYou?) 'Fine]
      [(symbol=? 'HowAreYou? 'GoodAfternoon) 'INeedANap]
      [(symbol=? 'HowAreYou? 'GoodEvening) 'BoyAmITired])
(cond [false 'Hi]
      [(symbol=? 'HowAreYou? 'HowAreYou?) 'Fine]
      [(symbol=? 'HowAreYou? 'GoodAfternoon) 'INeedANap]
      [(symbol=? 'HowAreYou? 'GoodEvening) 'BoyAmITired])
(cond [(symbol=? 'HowAreYou? 'HowAreYou?) 'Fine]
      [(symbol=? 'HowAreYou? 'GoodAfternoon) 'INeedANap]
      [(symbol=? 'HowAreYou? 'GoodEvening) 'BoyAmITired])
(cond [true 'Fine]
      [(symbol=? 'HowAreYou? 'GoodAfternoon) 'INeedANap]
      [(symbol=? 'HowAreYou? 'GoodEvening) 'BoyAmITired])
'Fine


;; Exercise 5.1.2.
;; Develop the function check-guess. It consumes two numbers, guess and target.
;; Depending on how guess relates to target, the function produces one of the
;; following three answers: 'TooSmall, 'Perfect, or 'TooLarge.

;; GuessAnswer is one of
;; - 'TooSmall
;; - 'Perfect
;; - 'TooLarge
;; interp. answers in a number guessing game
#;
(define (fn-for-guess-answer ans)
  (cond [(symbol=? ans 'TooSmall) (...)]
        [(symbol=? ans 'Perfect) (...)]
        [(symbol=? ans 'TooLarge) (...)]))


;; check-guess : Number Number -> GuessAnswer
;; returns a symbol depending on the comparison of guess number and a target number

(check-expect (check-guess 1.0 2.0) 'TooSmall)
(check-expect (check-guess 1.0 1.0) 'Perfect)
(check-expect (check-guess 2.0 1.0) 'TooLarge)

(define (check-guess guess target)
  (cond [(> guess target)  'TooLarge]
        [(= guess target) 'Perfect]
        [else 'TooSmall]))

;; Exercise 5.1.3.
;; Develop the function check-guess3. It implements a larger portion of the number
;; guessing game of exercise 5.1.2 than the function check-guess. Now the teachpack
;; hands over the digits that the user guesses, not the number that they form.

;; check-guess3 : Natural Natural Nutural Natural -> GuessAnswer
(check-expect (check-guess3 3 2 1 125) 'TooSmall)
(check-expect (check-guess3 5 2 1 125) 'Perfect)
(check-expect (check-guess3 8 2 1 125) 'TooLarge)

;(define (check-guess3 g1 g2 g3 target) 'BadAnswer) ; stub

(define (check-guess3 g1 g2 g3 target)
  (check-guess (+ (* g3 100) (* g2 10) g1) target))


;; Exercise 5.1.4.
;; Develop what-kind. The function consumes the coefficients a, b, and c of a
;; quadratic equation. It then determines whether the equation is degenerate and,
;; if not, how many solutions the equation has. The function produces one of four
;; symbols: 'degenerate, 'two, 'one, or 'none.

;; how-many : number number number -> symbol
;; computes the number of solutions a quadratic equation with
;; coefficients a, b, and c.
(check-expect (how-many 1 0 -1) 'two)
(check-expect (how-many 2 4  2) 'one)
(check-expect (how-many 2 4  3) 'none)
(check-expect (how-many 0 1  1) 'degenerate)

(define (how-many a b c)
  (cond
    [(= a 0) 'degenerate]   ; check first
    [(> (discriminant a b c) 0) 'two]
    [(= (discriminant a b c) 0) 'one]
    [(< (discriminant a b c) 0) 'none]))


;; discriminant : Integer Integer Integer -> Natural
;; computes the discrimanent of a quadratic equation given coefficients a b c
;; copied from 4.4.4

(check-expect (discriminant 1 0 -1)  4)
(check-expect (discriminant 2 4  2)  0)
(check-expect (discriminant 2 4  3) -8)
(check-expect (discriminant 0 1  1)  1)  ; degenerate

(define (discriminant a b c)
  (- (* b b) (* 4 a c)))


;; Exercise 5.1.5.
;; Develop the function check-color. It implements a key portion of a color guessing
;; game. One player picks two colors for two squares; we call those targets. The
;; other one tries to guess which color is assigned to which square; they are
;; guesses. The first player's response to a guess is to check the colors and to
;; produce one of the following answers:

;; 1.'Perfect, if the first target is equal to the first guess and the second
;; target is equal to the second guess;

;; 2.'OneColorAtCorrectPosition, if the first guess is equal to the first target or
;; the second guess is equal to the second target;

;; 3.'OneColorOccurs, if either guess is one of the two targets; and

;; 4.'NothingCorrect, otherwise.

(check-expect (check-color 'blue 'red 'blue 'red)    'Perfect)
(check-expect (check-color 'blue 'red 'blue 'green)  'OneColorAtCorrectPosition)
(check-expect (check-color 'red  'blue 'green 'red)  'OneColorOccurs)
(check-expect (check-color 'blue 'red 'red 'green)   'OneColorOccurs)
(check-expect (check-color 'black 'red 'blue 'green) 'NothingCorrect)


(define (check-color targ1 targ2 guess1 guess2)
  (cond
    [(and (symbol=? targ1 guess1) (symbol=? targ2 guess2))
     'Perfect]
    [(or  (symbol=? targ1 guess1) (symbol=? targ2 guess2))
     'OneColorAtCorrectPosition]
    [(or  (symbol=? targ2 guess1) (symbol=? targ1 guess2))
     'OneColorOccurs]
    [else
     'NothingCorrect]))
