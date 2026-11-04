;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12_01_198_word_count) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 12 Projects: Lists
;; 12.1 Real-world Data: Dictionaries
;; Exercises: 198

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

(require 2htdp/batch-io)

; On Ubuntu 16.04:
(define DICTIONARY-LOCATION "/usr/share/dict/words")

; A Dictionary is a List-of-strings.
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))


; A Letter is one of the following 1Strings:
; – "a"
; – ...
; – "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))
;; experiments in walking two lists at the same time

; Lol is a List-of-Letters
; Los is a List-of-Strings

(define-struct letter-count [letter count])
; Letter-Count is a pair: (make-letter-count String Number)
; interpretation: letter is the letter being counted and count is the
;  number counted

; LoLC is a List-of-Letter-count

(define DICT (list "a" "aa" "ab" "b" "ba" "bb" "bc" "c" "ca" "cb" "cc" "cd" "ff"))
(define LODICT (list (list "a" "aa" "ab")
                    (list "b" "ba" "bb" "bc")
                    (list "c" "ca" "cb" "cc" "cd")
                    (list "ff")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; design words-by-first-letter:

; List-of-words -> List-of-list-of-words (lolow)
; split a list of words in a list of list of words by first letter
(check-expect (words-by-first-letter DICT) LODICT)
(check-expect (words-by-first-letter (list "a")) (list (list "a")))
(check-expect (words-by-first-letter (list "a" "b"))
              (list (list "a") (list "b")))
(check-expect (words-by-first-letter (list "a" "b" "bb" "c" "cc" "ccd"))
              (list (list "a") (list "b" "bb") (list "c" "cc" "ccd")))
(check-expect (words-by-first-letter (list "a" "b" "bb" "c" "cc" "dd"))
              (list (list "a") (list "b" "bb") (list "c" "cc") (list "dd")))

(define (words-by-first-letter low)
  (cond [(empty? (rest low)) (cons low '())]
        [(string=? (first-letter (first low)) (first-letter (second low)))
         (insert-word (first low) (words-by-first-letter (rest low)))]
        [else
         (cons (list (first low)) (words-by-first-letter (rest low)))]))


; Word -> Letter
; return the first Letter of a given Word
(check-expect (first-letter "abc") "a")
(define (first-letter wrd)
  (substring wrd 0 1))


; Word List-of-list-of-words -> List-of-list-of-words (lolow)
; insert Word into the first list of a List of List of Words
; note: prevents calling recursive function on lolow twice per call
;       exhibiting quadratic behaviour.
(check-expect (insert-word "aa" (list (list "ab" "ac")))
              (list (list "aa" "ab" "ac")))

(define (insert-word wrd lolow)
  (cons (cons wrd (first lolow))
        (rest lolow)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Re-design most-frequent from exercise 197 using this new function. Call the
;; new function most-frequent.v2. Once you have completed the design, ensure
;; that the two functions compute the same result on your computer’s
;; dictionary:

; Lol Low -> Letter-count
; returns a Letter-count of the most frequent starting letter in a dictionary
(check-expect (most-frequent.v2 '() DICT) (make-letter-count "a" 0))
(check-expect (most-frequent.v2 (list "a" "b") DICT)
              (make-letter-count "b" 4))
(check-expect (most-frequent.v2 (list "a" "c") DICT)
              (make-letter-count "c" 5))
(check-expect (most-frequent.v2 LETTERS DICT)
              (make-letter-count "c" 5))

(define (most-frequent.v2 lol low)
  (max-lolc (count-by-letter lol (words-by-first-letter low))))

;; Again, on my Ubuntu system:
; > (most-frequent.v2 LETTERS DICTIONARY-AS-LIST)
; (make-letter-count "s" 9933)


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


; list-of-list-or-words -> List-of-Letter-count
; produce a list of (make-letter-count) per first letter given a list of words
(check-expect (count-by-letter '() LODICT) '())
(check-expect (count-by-letter (list "a") LODICT)
              (list (make-letter-count "a" 3)))
(check-expect (count-by-letter (list "a" "b") LODICT)
              (list (make-letter-count "a" 3)
                    (make-letter-count "b" 4)))
(check-expect (count-by-letter (list "a" "c") LODICT)
              (list (make-letter-count "a" 3)
                    (make-letter-count "c" 5)))
(check-expect (count-by-letter (list "a" "b" "c") LODICT)
              (list (make-letter-count "a" 3)
                    (make-letter-count "b" 4)
                    (make-letter-count "c" 5)))

(define (count-by-letter lol lolow)
  (cond [(empty? lolow) '()]
        [(empty? lol) '()]
        [(string=? (first lol) (first-letter (first (first lolow))))
         (cons (make-letter-count  (first lol) (length (first lolow)))
               (count-by-letter (rest lol) (rest lolow)))]
        [(string>? (first lol) (first-letter (first (first lolow))))
         (count-by-letter lol (rest lolow))]
        [(string<? (first lol) (first-letter (first (first lolow))))
         (count-by-letter (rest lol) lolow)]))

