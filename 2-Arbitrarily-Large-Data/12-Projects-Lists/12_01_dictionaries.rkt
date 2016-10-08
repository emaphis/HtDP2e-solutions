;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12_01_dictionaries) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 12 Projects: Lists
;; 12.1 Real-world Data: Dictionaries
;; Exercises: 195-198

(require 2htdp/batch-io)
;(require 2htdp/image)

; On Ubuntu 16.04:
(define DICTIONARY-LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend

; A Dictionary is a List-of-strings.
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

; on my Ubuntu 16.04 system:
;> (length DICTIONARY-AS-LIST)
;99171

; A Letter is one of the following 1Strings:
; – "a"
; – ...
; – "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Any -> Boolean
; returns #true if l is one of LETTERS
(check-expect (letter? "a") #true)
(check-expect (letter? "5") #false)
(check-expect (letter? "aa") #false)
(check-expect (letter? 5) #false)
(check-expect (letter? '()) #false)

(define (letter? l)
  (member? l LETTERS))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ex. 195:
;; Design the function starts-with#, which consumes a Letter and Dictionary
;; andthen counts how many words in the given Dictionary start with the given
;; Letter. Once you know that your function works, determine how many words
;; start with "e" in your computer’s dictionary and how many with "z".

(define DICT (list "a" "aa" "ab" "b" "bb" "bc" "bcc" "c" "cc" "dd" "z" "zz"))

;; List-of-String Letter -> Number
(check-expect (starts-with# "a" '()) 0)  ; base case
(check-expect (starts-with# "a" DICT) 3)
(check-expect (starts-with# "j" DICT) 0)

(define (starts-with# lt los)
  (cond [(empty? los) 0]
        [else
         (if (starts-with? lt (first los))
             (add1 (starts-with# lt (rest los)))
             (starts-with# lt (rest los)))]))

;; Letter String -> Boolean
; returns #true if the first letter in a String is lt
; ASSUME: a non-empty string
(check-expect (starts-with? "a" "a") #true)
(check-expect (starts-with? "a" "abc") #true)
(check-expect (starts-with? "j" "abc") #false)

(define (starts-with? lt str)
  (string=? lt (substring str 0 1)))

;; On my Ubuntu system:
; > (starts-with# "e" DICTIONARY-AS-LIST)
; 3275
; > (starts-with# "z" DICTIONARY-AS-LIST)
; 143


;; Ex. 196:
;; Design count-by-letter. The function consumes a list of Letters and
;; a Dictionary. It produces a list of Letter-Counts, that is, pairs of Letters
;; and Ns. In such a pair, the latter says how many words occur in the given
;; Dictionary with the former as the first letter. Once your function is
;;  designed, determine how many words appear for all letters in your
;; computer’s dictionary

; Lol is a List-of-Letters
; Los is a List-of-Strings

(define-struct letter-count [letter count])
; Letter-Count is a pair: (make-letter-count String Number)
; interpretation: letter is the letter being counted and count is the
;  number counted

; LoLC is a List-of-Letter-count

; LoL Los -> LoLC
; Counts the words in a given dictionary that that begin with a letter in a
; given list of letters, one count per letter
(check-expect (count-by-letter '() DICT) '())
(check-expect (count-by-letter (list "a" "b") '())
              (list (make-letter-count "a" 0) (make-letter-count "b" 0)))
(check-expect (count-by-letter (list "a" "b") DICT)
              (list (make-letter-count "a" 3) (make-letter-count "b" 4)))

(define (count-by-letter lol los)
  (cond [(empty? lol) '()]
        [else
         (cons (make-letter-count (first lol)
                                  (starts-with# (first lol) los))
               (count-by-letter (rest lol) los))]))

;; on my Ubuntu system:
;> (count-by-letter (list "a" "b" "c") DICTIONARY-AS-LIST)
;(list
; (make-letter-count "a" 4667)
; (make-letter-count "b" 4849)
; (make-letter-count "c" 8170))

;> (count-by-letter LETTERS DICTIONARY-AS-LIST)
;(list
; (make-letter-count "a" 4667)
; (make-letter-count "b" 4849)
; (make-letter-count "c" 8170)
; (make-letter-count "d" 5122)
; (make-letter-count "e" 3275)
; (make-letter-count "f" 3689)
; (make-letter-count "g" 2757)
; (make-letter-count "h" 3066)
; (make-letter-count "i" 3352)
; (make-letter-count "j" 771)
; (make-letter-count "k" 604)
; (make-letter-count "l" 2587)
; (make-letter-count "m" 4397)
; (make-letter-count "n" 1523)
; (make-letter-count "o" 1937)
; (make-letter-count "p" 6772)
; (make-letter-count "q" 410)
; (make-letter-count "r" 4674)
; (make-letter-count "s" 9933)
; (make-letter-count "t" 4299)
; (make-letter-count "u" 1816)
; (make-letter-count "v" 1262)
; (make-letter-count "w" 2297)
; (make-letter-count "x" 17)
; (make-letter-count "y" 282)
; (make-letter-count "z" 143))


;; Ex. 197:
;; Design most-frequent. The function consumes a Dictionary and produces the
;; Letter-Count for the letter that is most frequently used as the first one
;; in the words of the given Dictionary.

;; What is the most frequently used letter in your computer’s dictionary and
;; how often is it used?

;; Note on Design Choices This exercise calls for the composition of the
;; solution to the preceding exercise with a function that picks the correct
;; pairing of a letter with a count. There are two ways to design this function:

;    Design a function that picks the pair with the maximum count.
;    (use max)

;    Design a function that selects the first from a list of pairs.
;   (use  first (sort)) ??

;; Consider designing both. Which one do you prefer? Why?


;; (a) most-frequent using max:

; Lol Low -> Letter-count
; returns a Letter-count of the most frequent starting letter in a dictionary
(check-expect (most-frequent.a '() DICT) (make-letter-count "a" 0))
(check-expect (most-frequent.a (list "a" "b") '()) (make-letter-count "a" 0))
(check-expect (most-frequent.a (list "a" "b" "c") DICT)
              (make-letter-count "b" 4))

(define (most-frequent.a lol los)
  (max-lolc (count-by-letter lol los)))

; Lolc -> Letter-count
; returns the Letter-count with the highest count from a List-of-Letter-count
(check-expect (max-lolc '()) (make-letter-count "a" 0))
(check-expect (max-lolc (list (make-letter-count "a" 4)
                              (make-letter-count "b" 10)
                              (make-letter-count "c" 4)))
              (make-letter-count "b" 10))

(define (max-lolc lolc) (max-lolc-acc lolc (make-letter-count "a" 0)))

(define (max-lolc-acc lolc acc)
  (cond [(empty? lolc) acc]
        [else (if (lc>? (first lolc) acc)
                  (max-lolc-acc (rest lolc) (first lolc))
                  (max-lolc-acc (rest lolc) acc))]))

; Letter-count Letter-count -> Boolean
; returns #true if lc1 count is larger than lc2 count
(check-expect (lc>? (make-letter-count "a" 4)
                    (make-letter-count "b" 10))
              #false)
(check-expect (lc>? (make-letter-count "b" 10)
                    (make-letter-count "a" 4))
              #true)
(define (lc>? lc1 lc2)
  (> (letter-count-count lc1)
     (letter-count-count lc2)))

; > (most-frequent.a LETTERS DICTIONARY-AS-LIST)
; (make-letter-count "s" 9933)

;; (b) most-frequent using sort:

; Lol Low -> Letter-count
; returns a Letter-count of the most frequent starting letter in a dictionary
;(check-expect (most-frequent.b '() DICT) (make-letter-count "a" 0))
(check-expect (most-frequent.b (list "a" "b") '()) (make-letter-count "b" 0))
(check-expect (most-frequent.b (list "a" "b" "c") DICT)
              (make-letter-count "b" 4))

(define (most-frequent.b lol los)
  (first (sort-lc> (count-by-letter lol los))))


; Lolc -> Lolc
; sorts a List-of-letter-count descending by Letter-count-count

(define LCA (make-letter-count "a" 10))
(define LCB (make-letter-count "b" 5))
(define LCC (make-letter-count "c" 1))

(check-expect (sort-lc> '()) '())
(check-expect (sort-lc> (list LCA LCB LCC)) (list LCA LCB LCC))
(check-expect (sort-lc> (list LCC LCB LCA)) (list LCA LCB LCC))
(check-expect (sort-lc> (list LCA LCC LCB)) (list LCA LCB LCC))

(define (sort-lc> lolc)
  (cond [(empty? lolc) '()]
        [else
         (insert (first lolc) (sort-lc> (rest lolc)))]))

; Letter-count Lolc -> Lolc
; inert a Letter-count into a sorted List-of-letter-count
(check-expect (insert LCA '()) (list LCA))
(check-expect (insert LCA (list LCB)) (list LCA LCB))
(check-expect (insert LCB (list LCA)) (list LCA LCB))
(check-expect (insert LCA (list LCB LCC)) (list LCA LCB LCC))
(check-expect (insert LCB (list LCA LCC)) (list LCA LCB LCC))

(define (insert lc lolc)
  (cond [(empty? lolc) (cons lc '())]
        [else (if (lc>? lc (first lolc))
                  (cons lc lolc)
                  (cons (first lolc) (insert lc (rest lolc))))]))

; > (most-frequent.b LETTERS DICTIONARY-AS-LIST)
; (make-letter-count "s" 9933)

;; I prefer the version developed with max, max function was much simpler to
;; develop than the sort fucntion, the max function version seems to be more
;; robust in handling empty list situations.



;; Ex. 198:
;; See: 12_01_198_word_count.rkt
