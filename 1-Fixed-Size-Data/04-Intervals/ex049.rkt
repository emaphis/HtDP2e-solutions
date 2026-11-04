#lang htdp/bsl
;; Ex. 49:
;; (- 200 (cond [(> y 200) 0] [else y]))
;; Use the stepper to evaluate the expression for y as 100 and 210.

(- 200 (cond [(> 100 200) 0] [else 100]))
(- 200 (cond [#false 0] [else 100]))
(- 200 (cond [else 100]))
(- 200 100)
100

(- 200 (cond [(> 210 200) 0] [else 210]))
(- 200 (cond [#true 0] [else 210]))
(- 200 0)
200
