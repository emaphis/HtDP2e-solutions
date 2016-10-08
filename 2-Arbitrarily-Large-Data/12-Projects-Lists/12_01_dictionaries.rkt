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
;; Design words-by-first-letter. The function consumes a Dictionary and
;; produces a list of Dictionarys, one per Letter.

;; Re-design most-frequent from exercise 197 using this new function. Call the
;; new function most-frequent.v2. Once you have completed the design, ensure
;; that the two functions compute the same result on your computer’s
;; dictionary:

;(check-expect
; (most-frequent DICTIONARY-AS-LIST)
; (most-frequent.v2 DICTIONARY-AS-LIST))

;; Note on Design Choices For words-by-first-letter you have a choice fo
;; dealing with the situation when the given dictionary does not contain any
;; words for some letter:

;    One alternative is to exclude the resulting empty dictionaries from the
;    overall result. Doing so simplifies both the testing of the function and
;    the design of most-frequent.v2, but it also requires the design of an
;    auxiliary function.

;    The other one is to include '() as the result of looking for words of a
;    certain letter, even if there aren’t any. This alternative avoids the
;    auxiliary function needed for the first alternative but adds complexity
;    to the design of most-frequent.v2.

;; (define DICT (list "a" "aa" "ab" "b" "bb" "bc" "bcc" "c" "cc" "dd" "z" "zz"))

(list (list "a" "aa" "ab")
      (list "b" "bb" "bc" "bcc" )
      (list "c" "cc" )
      (list "dd")
      (list "z" "zz"))

; Lololc is a List-of-list-of-letter-count  (Phewww!)
; or a List-of-dictionary.

; LoL Lolc -> Lololc
; consumes a List-of-words and a dictionary and produces a list of dictionaries
; divided by first letter matching a letter in the List-of-letters

; SIMPLIFING ASSUMPTION: the letters in the Lol are in the same order as
;; the dictionary

;(check-expect (words-by-first-letter (list '())) '())

(check-expect (words-by-first-letter (list "a") (list "a" "aa" "ab"))
              (list (list "a" "aa" "ab")))
(check-expect (words-by-first-letter (list "b") (list "a" "aa" "ab"))
              (list '()))
(check-expect (words-by-first-letter (list "a" "b") (list "a" "aa" "b" "bb"))
              (list (list "a" "aa") (list "b" "bb")))
(check-expect (words-by-first-letter (list "a" "c")
                                     (list "a" "aa" "b" "bb" "c" "cc"))
              (list (list "a" "aa") (list "c" "cc")))

(check-expect (words-by-first-letter (list "a" "b" "c" "d" "e" "z") DICT)
              (list (list "a" "aa" "ab")
                    (list "b" "bb" "bc" "bcc" )
                    (list "c" "cc" )
                    (list "dd")
                    (list "z" "zz")))

;(define (words-by-first-letter lolc) (cons lolc '())) ; stub

(define (words-by-first-letter lol lolc)
  (cond [(empty? (rest lolc)) (cons lolc '())]
        [(empty? lol) (cons lolc '())]
        [else
         (cond [(string=? (first lol)(first-letter (first lolc)))
                (insert-word (first lolc) (words-by-first-letter lol (rest lolc)))]
               [(string<? (first lol) (first-letter (first lolc)))
                (words-by-first-letter (rest lol) lolc)]
               [(string>? (first lol) (first-letter (first lolc)))
                (words-by-first-letter lol (rest lolc))]
             [else
              (cons (list (first lolc)) (words-by-first-letter lol (rest lolc)))])]))

(define (first-letter wrd) (substring wrd  0 1))
; String  Lololc -> Lololc
; cons a String onto the first list of  the given
; List-of-List-of-String (List-of-dictionary)
; this saved two calls to 'words-by-first-letter' of every entry in the
; lolc list which exhibited quadratic behavior
(check-expect (insert-word "aa" (list '())) (list (list "aa")))
(check-expect (insert-word "aa" (list  (list "aaa" "ab") (list "b" "bbb")))
              (list (list "aa" "aaa" "ab") (list "b" "bbb")))

(define (insert-word wrd lololc)
  (cons (cons wrd (first lololc))
        (rest lololc)))

; String String -> Boolean
; returns #true if str1's first letter is equal to str2's first letter
(check-expect (fst-letter-eq? "apple" "address") #true)
(check-expect (fst-letter-eq? "apple" "banana") #false)

(define (fst-letter-eq? str1 str2)
  (string=? (substring str1 0 1) (substring str2 0 1)))

;; now define most-freqent.v2:

; Lol Low -> Letter-count
; returns a Letter-count of the most frequent starting letter in a dictionary
#|
(check-expect (most-frequent.v2 '() DICT) (make-letter-count "a" 0))
(check-expect (most-frequent.v2 (list "a" "b") '()) (make-letter-count "a" 0))
(check-expect (most-frequent.v2 (list "a" "b" "c") DICT)
              (make-letter-count "b" 4))

(define (most-frequent.2 lol los)
  (max-lolc (words-by-first-letter lol los)))

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
|#