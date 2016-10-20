;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname test1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#;
(check-expect (slice "e" "hllo")  (list (append "" "e"  "hllo")
                                        (append "h" "e" "llo")
                                        (append "hl" "e" "lo")
                                        (append "hll" "e" "o")
                                        (append "hllo" "e" "")))
#;
(check-expect (slice "e" (list "h" "l" "l" "o"))
              (list (list '()  (list "h" "l" "l" "o"))
                    (list (list "h")  (list "l" "l" "o"))
                    (list (list "h" "l")  (list "l" "o"))
                    (list (list "h" "l" "l")  (list "o"))
                    (list (list "h" "l" "l" "o")  '())))


(define (slice ch wrd)
  (cond [(empty? wrd) '()]
        [else
         (cons (cons ch (first wrd))
               (slice ch (rest wrd)))]))

