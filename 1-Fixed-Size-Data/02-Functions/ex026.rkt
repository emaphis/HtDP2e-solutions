;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex026) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Ex 26:
;; What do you expect as the value of this program:

(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))

;; Confirm your expectation with DrRacket and its stepper.

(string-insert "helloworld" 6)
(string-append (substring "helloworld" 0 6) "_" (substring "helloworld" 6))
(string-append "hellow" "_" (substring "helloworld" 6))
(string-append "hellow" "-" (substring "helloworld" 6))
(string-append "hellow" "-" "orld")
"hellow_orld"
