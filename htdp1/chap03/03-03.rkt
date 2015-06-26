;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 3.3  Finger Exercises on Composing Functions


;; Exercise 3.3.1.
;; Develop the functions inches->cm, feet->inches, yards->feet,
;; rods->yards, furlongs->rods, and miles->furlongs

(define IN-CM 2.54)
(define FT-IN 12)
(define YD-FT 3)
(define RD-YD 5.5)
(define FL-RD 40)
(define ML-FL 8)

;; inches->cm : Number -> Number
;; Returns centimeters given inches
(define (inches->cm in)
  (* IN-CM in))

;; feet->inches : Number -> Number
;; Returns inches given feet
(define (feet->inches ft)
  (* FT-IN ft))

;; yards->feet : Number -> Number
;; Returns feet given yards
(define (yards->feet yd)
  (* YD-FT yd))

;; rods->yards : Number -> Number
;; Returns yards given rods
(define (rods->yards rd)
  (* RD-YD rd))

;; furlongs->rods : Number -> Number
;; Returns rods given furlongs
(define (furlongs->rods fl)
  (* FL-RD fl))

;; miles->furlongs : Number -> Number
;; Returns furlongs given miles
(define (miles->furlongs ml)
  (* ML-FL ml))

;; Then develop the functions feet->cm, yards->cm, rods->inches,
;; and miles->feet.

;; Hint: Reuse functions as much as possible. Use variable definitions
;; to specify constants.

;; feet->cm : Number -> Number
;; Returns centimeters given feet
(define (feet->cm ft)
  (inches->cm
   (feet->inches ft)))

;; yards->cm : Number -> Number
;; Returns feet given yards
(define (yards->cm yd)
  (feet->cm
   (yards->feet yd)))

;; rods->inches : Number -> Number
;; Returns inches given rods
(define (rods->inches rd)
  (feet->inches
   (yards->feet
    (rods->yards rd))))

;; miles->feet : Number -> Number
;; Returns feet given miles
(define (miles->feet ml)
  (yards->feet
   (rods->yards
    (furlongs->rods
     (miles->furlongs ml)))))

;; tests bummed from the aswer key
(check-expect (inches->cm 1) 2.54)
(check-expect (inches->cm 3) 7.62)

(check-expect (feet->inches 1) 12)
(check-expect (feet->inches 3/2) 18)

(check-expect (yards->feet 1) 3)
(check-expect (yards->feet 12) 36)

(check-expect (rods->inches 1) 198)
(check-expect (rods->inches 3/2) 297)

(check-expect (furlongs->rods 1) 40)
(check-expect (furlongs->rods 7) 280)

(check-expect (miles->furlongs 1) 8)
(check-expect (miles->furlongs 10) 80)

(check-expect (feet->cm 1) 30.48)
(check-expect (feet->cm 4) 121.92)

(check-expect (yards->cm 1) 91.44)
(check-expect (yards->cm 2) 182.88)

(check-expect (rods->inches 1) 198)
(check-expect (rods->inches 3.5) 693)

(check-expect (miles->feet 1) 5280)
(check-expect (miles->feet 4) 21120)

;; now that was tedius  :-)


;; Exercise 3.3.2.
;; Develop the program volume-cylinder. It consumes the radius of a cylinder's
;; base disk and its height; it computes the volume of the cylinder.

;; volume-cylinder : Number Number -> Number
;; Produces volume of a cylinder given radius and hight
;;   essentially  Base X Hieght
(define {volume-cylinder radius height}
  (* (area-circle radius) height))

(check-expect (volume-cylinder 1 1) 3.14)
(check-expect (volume-cylinder 5 5) (* 78.5 5))

;; area-circle : Number -> Number
;; Produces area of a circle given radious
(define (area-circle radius)
  (* 3.14 radius radius))

(check-expect (area-circle 1) 3.14)
(check-expect (area-circle 5) 78.5)


;; Exercise 3.3.3.
;; Develop area-cylinder. The program consumes the radius of the cylinder's base
;; disk and its height. Its result is the surface area of the cylinder.

;; (2 * Base) + (Circumfrence * Height)

;; area-cylinder : Number Number -> Number
;; Produces the surface area of a cylinder give the radious of it's base and it's height

(define (area-cylinder radius height)
  (+ (* 2 (area-circle radius))
     (* (circumference radius) height)))

(check-expect (area-cylinder 1 1) 12.56)
(check-expect (area-cylinder 2 3) 62.8)
(check-expect (area-cylinder 3 4) 131.88)


;; circumference-circle : Number -> Number
;; produces circumference of a circle given the radius

(define (circumference radius)
  (* 2 3.14 radius))

(check-expect (circumference 1) 6.28)


;; Exercise 3.3.4.
;; Develop the function area-pipe. It computes the surface area of a pipe, which
;; is an open cylinder. The program consumes three values: the pipe's inner radius,
;; its length, and the thickness of its wall.

;; Develop two versions: a program that consists of a single definition and a program
;; that consists of several function definitions. Which one evokes more confidence?

;; area-pipe : Number Number -> Number
;; produces the surface of area of a pipe given inner radius, length, thickness of wall
(define (area-pipe radius length thickness)
  (+                                                      ; the sum of
   (* length (circumference radius))               ; the inside area
   (* length (circumference (+ radius thickness))) ; the outside area
   (* 2 (area-doughnut radius (+ radius thickness)))))    ; and the two end piece areea

(check-expect (area-pipe 2 3 4)  351.68)

;; area-doughnut ; Number Number -> Number
;; Produce the area of the outside circle minus the inside area
(define (area-doughnut inner outer)
  (- (area-circle outer)
     (area-circle inner)))

(check-expect (area-doughnut 3 5)  50.24)

;; <circle-area from earlier problem>

;; area-pipe : Number Number -> Number
;; produces the surface of area of a pipe given inner radius, length, thickness of wall
(define (area-pipe-2 radius length thickness)
  (+
   (* length (* 2 3.14 radius))
   (* length (* 2 3.14 (+ radius thickness)))
   (* 2 (- (* 3.14 (+ radius thickness) (+ radius thickness))
           (* 3.14 radius radius)))
   ))

(check-expect (area-pipe-2 2 3 4)  351.68)


;; Exercise 3.3.5.
;; Develop the program height, which computes the height that a
;; rocket reaches in a given amount of time. If the rocket
;; accelerates at a constant rate g, it reaches a speed of
;; g · t in t time units and a height of 1/2 * v * t where v
;; is the speed at t.

;;  height = 1/2 * v * t
;;  speed (v) =  g · t

(define G 10)

(define (height t)
  (* 1/2 (speed t) t))

(define (speed t)
  (* G t))

(check-expect (speed 10) 100)
(check-expect (height 10) 500)


;; Exercise 3.3.6.
;; Recall the program Fahrenheit->Celsius from exercise 2.2.1.
;; The program consumes a temperature measured in Fahrenheit
;; and produces the Celsius equivalent.

;; Develop the program Celsius->Fahrenheit, which consumes a
;; temperature measured in Celsius and produces the Fahrenheit
;; equivalent.

;; fahrenheit->celsius : Number -> Number
;; Produces celsius remperature given temp in fahrenheit
(define (fahrenheit->celsius tmp)
  (* 5/9 (- tmp 32)))

(check-expect (fahrenheit->celsius 32) 0)
(check-expect (fahrenheit->celsius 212) 100)

;; celsius->fahrenheit : Number -> Number
;; Produces farenheit temp given temp in celcius
(define (celsius->fahrenheit tmp)
  (+ (* 9/5 tmp) 32))

(check-expect (celsius->fahrenheit 0) 32)
(check-expect (celsius->fahrenheit 100) 212)

;; Now consider the function

;; I : number  ->  number
;; to convert a Fahrenheit temperature to Celsius and back
(define (I f)
  (celsius->fahrenheit (fahrenheit->celsius f)))

(check-expect (I 100) 100)
(check-expect (I 0) 0)

;; Evaluate (I 32) by hand and using DrScheme's stepper. What does this suggest about the composition of the two functions?

;; composing inverse functions produces the identity function
