;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_03_lists_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 10 More on Lists
;; 10.3 Lists in Lists, Files
;; Exercises: 171-176


(require 2htdp/batch-io)

;(read-file "ttt.txt")


; String -> String
; produces the content of file f as a string
;(define (read-file f) ...)

; String -> List-of-string
; produces the content of file f as a list of strings,
; one per line
;(define (read-lines f) ...)

; String -> List-of-string
; produces the content of file f as a list of strings,
; one per word
;(define (read-words f) ...)

; String -> List-of-list-of-string
; produces the content of file f as a list of list of
; strings, one list per line and one string per word
;(define (read-words/line f) ...)

; The above functions consume the name of a file as a String
; argument. If the specified file does not exists in the
; same folder as the program, they signal an error.


;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 171:
;; You know what the data definition for List-of-strings looks like. Spell it
;; out. Make sure that you can represent Piet Hein’s poem as an instance of the
;; definition where each line is a represented as a string and another one
;; where each word is a string. Use read-lines and read-words to confirm your
;; representation choices.

;; Next develop the data definition for List-of-list-of-strings. Again,
;; represent Piet Hein’s poem as an instance of the definition where each line
;; is a represented as a list of strings, one per word, and the entire poem is
;; a list of such line representations. You may use read-words/line to confirm
;; your choice.


; A List-of-strings is one of:
; - '()
; - (cons String List-of-strings)
; interpretation: a list of strings.

(define LOL (cons "    TTT"
                  (cons ""
                        (cons "    Put up in a place"
                              '()))))
;(read-lines "ttt.txt")

(define LOW (cons "TTT"
                  (cons "Put"
                        (cons "up"
                              (cons "a"
                                    (cons "place"
                                          '()))))))

;(read-words "ttt.txt")

; A List-of-list-of-strings is one of:
; - '()
; - (cons List-of-strings List-of-list-of-string)
; interpretation: a list of list of strings

;(define LOL2
;  )

;(read-words/line "ttt.txt")


;;;;;;;;;;;;;;;;;;;;;;;

; A LLS is one of:
; – '()
; – (cons Los LLS)
; interpretation a list of lines, each is a list of Strings


;; data examples for List-of-strings:
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())

;; data examples for LLS:
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))


; LLS -> List-of-numbers
; determines the number of words on each line

(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1)
              (cons 2 (cons 0 '())))

(define (words-on-line lls)
  (cond [(empty? lls) '()]
        [else (cons (length (first lls))
                    (words-on-line (rest lls)))]))
#;
(define (words# los)
  (cond [(empty? los) 0]
        [else
         (+ 1 (words# (rest los)))]))

;;;;;;;;;;;;;;;;;;
;; a file utility

; String -> List-of-numbers
; counts the words on each line in the given file
(define (file-statistic file-name)
  (words-on-line
    (read-words/line file-name)))


;;;;;;;;;;;;;;;;;
;; Ex. 172:
;; Design the function collapse, which converts a list of lines into a string.
;; The strings should be separated by blank spaces (" "). The lines should be
;; separated with a newline ("\n").

(define LN1 (cons "This"
                  (cons "is"
                        (cons "a"
                              (cons "first"
                                    (cons "line" '()))))))
(define LN2 (cons "This"
                  (cons "is"
                        (cons "a"
                              (cons "second"
                                    (cons "line" '()))))))

(define LOL1 (cons LN1 (cons LN2 '())))

;; LLS -> String
;; convert a list of lines into a string

(check-expect (collapse '()) "")
(check-expect (collapse LOL1)
              "This is a first line\nThis is a second line")

(define (collapse lls)
  (cond [(empty? lls) ""]
        [else
         (if (= (length (rest lls)) 0)
             (append-strings (first lls))
             (string-append  (append-strings (first lls)) "\n"
                             (collapse (rest lls))))]))

;; Los -> String
;; produces a String from a List-of-strings with the individual Strings appended

(check-expect (append-strings '()) "")
(check-expect (append-strings (cons "This"
                                    (cons "is"
                                          (cons "a"
                                                (cons "LOS" '())))))
              "This is a LOS")

(define (append-strings los)
  (cond [(empty? los) ""]
        [else
         (if (= (length (rest los)) 0) (first los)
             (string-append (first los) " "
                            (append-strings (rest los))))]))

;(write-file "ttt.dat"
;              (collapse (read-words/line "ttt.txt")))



;; Ex. 173:
;; Design a program that removes all articles from a text file. The program
;; consumes the name n of a file, reads the file, removes the articles, and
;; writes the result out to a file whose name is the result of concatenating
;; "no-articles-" with n. For this exercise, an article is one of the following
;; three words: "a", "an", and "the".

;; Use read-words/line so that the transformation retains the organization of
;; the original text into lines and words. When the program is designed, run it
;; on the Piet Hein poem.

; FileName -> File
; a program that reads a given file aren produces a file with aritcles removed

(define (remove-articles-file fn)
  (write-file (string-append "no-articles-" fn)
              (collapse (remove-articles (read-words/line fn)))))

;  (remove-articles-file "ttt.txt")

; LLS -> LLS
; remove the articles from a List-list-of-strings

(check-expect (remove-articles '()) '())
(check-expect (remove-articles (cons (cons "the" '()) '())) (cons '() '()))
(check-expect (remove-articles (cons (cons "idea" '()) '()))
              (cons (cons "idea" '()) '()))

;(cons (cons "yyy" '())
;      (cons (cons "xxx" '())
;            '()))
(check-expect (remove-articles (cons (cons "the" (cons "girl" '()))
                                     (cons (cons "with" (cons "an" (cons "idea"
                                                                         '())))
                                           '())))
              (cons (cons "girl" '())
                    (cons (cons "with" (cons "idea" '())) '())))

(define (remove-articles lls)
  (cond [(empty? lls) '()]
        (else
         (cons (remove-articles-line (first lls))
               (remove-articles (rest lls))))))

; Los -> Los
; remove 'a' 'an' 'the' from a List-of-strings
(check-expect (remove-articles-line '()) '())
(check-expect (remove-articles-line (cons "a"
                                          (cons "man"
                                                (cons "and"
                                                      (cons "an"
                                                            (cons "idea"
                                                                  '()))))))
              (cons "man" (cons "and" (cons "idea" '()))))

(define (remove-articles-line los)
  (cond [(empty? los) '()]
        [else
         (if (article? (first los))
             (remove-articles-line (rest los))
             (cons (first los)
                   (remove-articles-line (rest los))))]))

; String -> Boolean
; return #true if String is an article
(check-expect (article? "and") #false)
(check-expect (article? "a") #true)
(check-expect (article? "an") #true)
(check-expect (article? "the") #true)

(define (article? s)
  (or (string=? s "a")
      (string=? s "an")
      (string=? s "the")))


;; Ex. 174:
;; Design a program that encodes text files numerically. Each letter in a word
;; should be encoded as a numeric three-letter string with a value
;; between 0 and 256.
;; Figure 65 shows our encoding function for single letters.
;; Before you start, explain these functions.

;; Hints (1) Use read-words/line to preserve the organization of the file into
;; lines and words. (2) Read up on explode again.

;; Explanation of code in figure 65:
; encode-letter (1String -> String) pads a String returned from code1 to a 3
; of length String
; code1 (1String -> String) converts a 1String to it's ascii equivalent

; 1String -> String
; converts the given 1String to a 3-letter numeric String

(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))

(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))

; 1String -> String
; convert the given 1String into a String

(check-expect (code1 "z") "122")

(define (code1 c)
  (number->string (string->int c)))

;; the main program

; FileName -> File
; a program that reads a given file aren produces a file with aritcles removed

(define (encode-file fn)
  (write-file (string-append "encoded-" fn)
              (collapse (encode-lines (read-words/line fn)))))

; (encode-file "ttt.txt")

; LLS -> LLS
; encode a List-of-list-of-strings line by line
(check-expect (encode-lines '()) '())
(check-expect (encode-lines (cons (cons "aa" '()) '()))
              (cons (cons "097097" '())    '()))
;(check-expect (encode-lines (cons (cons "aa" '()) (cons (cons "bb" '()) '()) '()))
;              (cons (cons "097097" '()) (cons (cons "098098" '()) '()) '()))

(define (encode-lines lls)
  (cond [(empty? lls) '()]
        [else
         (cons (encode-line (first lls))
               (encode-lines (rest lls)))]))

; Los -> Los
; encode a List-of-strings
(check-expect (encode-line '()) '())
(check-expect (encode-line (cons "aa" (cons "bb" '())))
              (cons "097097" (cons "098098" '())))
(define (encode-line los)
  (cond [(empty? los) '()]
        [else
         (cons (encode-word (explode (first los)))
               (encode-line (rest los)))]))

; List-of-1String -> String
; encodes a String into 3 char ascii representation
(check-expect (encode-word '()) "")
(check-expect (encode-word (cons "a" (cons "b" '()))) "097098")

(define (encode-word los)
  (cond [(empty? los) ""]
        [else
         (string-append (encode-letter (first los))
                        (encode-word (rest los)))]))


;; Ex. 175:
;; Design a BSL program that simulates the Unix command wc. The purpose of the
;; command is to count the number of 1Strings, words, and lines in a given
;; file. That is, the command consumes the name of a file and produces a value
;; that consists of three numbers.

(define-struct results [lines words letters])
; wc-results is a (make-results Number Number Number)
; interpretation: a result is a count of lines, a count of words and
;                 a count of letters.

(define RESULT0 (make-results 0 0 0)) ; no resutls
#; ; template
(define (fun-for-results res)
  (... (results-lines res)
       (results-words res)
       (results-letters res)))

; LLS -> WC-Results
(check-expect (wc '()) (make-results 0 0 0))
(check-expect (wc (cons (cons "aaa" (cons "bb" '()))
                        (cons (cons "cccc" '())
                        '())))
              (make-results 2 3 9))

(define (wc lls)
  (make-results (length lls)
                (count-words lls)
                (count-chars lls)))

; LLS -> Number
; count the words in a List-of-list-string (text)
(check-expect (count-words '()) 0)
(check-expect (count-words (cons (cons "aaa" (cons "bb" '()))
                                 (cons (cons "cccc" '())
                                       '())))
              3)

(define (count-words lls)
  (cond [(empty? lls) 0]
        [else
         (+ (length (first lls))
            (count-words (rest lls)))]))

; LLS -> Number
; count the number of 1String (char) in a List-of-list-string (text)
(check-expect (count-chars '()) 0)
(check-expect (count-chars (cons (cons "aaa" (cons "bb" '()))
                                 (cons (cons "cccc" '())
                                       '())))
              9)

(define (count-chars lls)
  (cond ([empty? lls] 0)
        [else
         (+ (chars-line (first lls))
            (count-chars (rest lls)))]))

; LOS -> Number
; count the number of 1String (char) in a List-of-string (line of text)
(check-expect (chars-line '()) 0)
(check-expect (chars-line (cons "aaa" (cons "bb" '()))) 5)

(define (chars-line los)
  (cond ([empty? los] 0)
        [else
         (+ (string-length (first los))
            (chars-line (rest los)))]))


;; Ex. 176:
;; see book.

; A Matrix is one of:
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length

; An Row is one of:
;  – '()
;  – (cons Number Row)

(define MAT2 (cons (cons 11 (cons 12 '())) ; my answer
                   (cons (cons 21 (cons 22 '()))
                         '())) )

(define MAT3 (cons  (cons 11 (cons 12 (cons 13 '())))
                    (cons    (cons 21 (cons 22 (cons 23 '())))
                             (cons    (cons 31 (cons 32 (cons 33 '())))
                                      '()))) )

; the books answer
(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

#; ; Matrix -> ???
(define (fn-for-matrix m)
  (cond [(empty? (rest m)) ...]
        [else
         (... (fn-for-row (first m))
              (fn-for-matrix (rest m)))]))

#; ; Row -> ???
(define (fn-for-row r)
  (cond [(empty? r) ...]
        [else
         (... (first r)
              (fn-for-row (rest r)))]))

; Matrix -> Matrix
; transpose the given matrix along the diagonal

(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

(check-expect (transpose mat1) tam1)

(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

; LLS -> Los
; produces the first column of a matrix
(check-expect (first* '()) '())
(check-expect (first* tam1) (cons 11 (cons 12 '())))
(check-expect (first* MAT3) (cons 11 (cons 21 (cons 31 '()))))

(define (first* lls)
  (cond [(empty? lls) '()]
        [else
         (cons (first (first lls))
               (first* (rest lls)))]))

; LLS -> LLS
; produces the rest (but first) columns of a matrix (LLS)
(check-expect (rest* '()) '())
(check-expect (rest* mat1)
              (cons (cons 12 '())
                    (cons (cons 22 '())
                          '())))
(check-expect (rest* MAT3)
              (cons (cons 12 (cons 13 '()))
                    (cons (cons 22 (cons 23 '()))
                          (cons (cons 32 (cons 33 '()))
                                '()))))

(define (rest* lls)
  (cond [(empty? lls) '()]
        [else
         (cons (rest (first lls))
               (rest* (rest lls)))]))


;; We don't have a design recipe for matrix because it really is a tree.
;; A very unusual tree in that each branch has only one brance, and each
;; branch has only equal number of items, but it is a tree of list of lists
;; We don't have have recipie for lists of lists.
