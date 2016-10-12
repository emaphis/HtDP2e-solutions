;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12_03_word_games_composition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 12 Projects: Lists
;; 12.3 Word Games, Composition Illustrated
;; Exercises: 209-211

(require 2htdp/batch-io)

;; Sample Problem
;; Given a word, find all words that are made up from some letters. For
;; example “cat” also spells “act.”

; String -> List-of-strings
; find all words that use the same letters as s
;(define (alternative-words s)
;  ...)

; String -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))

; String -> List-of-strings
; find all words that the letters of some given word spell

;(check-member-of (alternative-words "cat")
;                 (list "act" "cat")
;                 (list "cat" "act"))

;(check-satisfied (alternative-words "rat")
;                 all-words-from-rat?)

(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))

(define (arrangements lo1s) lo1s) ; stub


;; Ex. 209:
;;  The above leaves us with two additional “wishes:” a function that consumes
;; a String and produces its corresponding Word and a function for the opposite
;; direction. Here are the wish-list entries:

;; Look up the data definition for Word in the next section and complete the
;; definitions of string->word and word->string.
;; Hint You may wish to look in the list of functions that BSL provides.

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a String as a list of 1Strings (letters)

; String -> Word
; convert s to the chosen word representation
(check-expect (string->word "") '())
(check-expect (string->word "a") (list "a"))
(check-expect (string->word "apple") (list "a" "p" "p" "l" "e"))

(define (string->word s)
  (cond [(string=? "" s) '()]
        [else (cons (substring s 0 1)
                    (string->word (substring s 1)))]))


; Word -> String
; convert w to a string
(check-expect (word->string '()) "")
(check-expect (word->string (list "a" "p" "p" "l" "e")) "apple")

(define (word->string w)
  (cond [(empty? w) ""]
        [else (string-append (first w)
                             (word->string (rest w)))]))


;; Ex. 210:
;; Complete the design of the words->strings function specified in figure 74.
;; Hint Use your solution to exercise 209.

; List-of-words -> List-of-strings
; turn all Words in low into Strings
(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "a" "p" "p" "l" "e")
                                   (list "g" "r" "a" "p" "e")))
              (list "apple" "grape"))

(define (words->strings low)
  (cond [(empty? low) '()]
        [else (cons (word->string (first low))
                    (words->strings (rest low)))]))


;; Ex. 211:
;; Complete the design of in-dictionary, specified in figure 74.
;; Hint See Real-world Data: Dictionaries for how to read a dictionary.

; On Ubuntu 16.04:
(define DICTIONARY-LOCATION "/usr/share/dict/words")

; A Dictionary is a List-of-strings.
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "apple")) (list "apple"))
(check-expect (in-dictionary (list "blerg")) '())
(check-expect (in-dictionary (list "apple" "grape")) (list "apple" "grape"))
(check-expect (in-dictionary (list "apple" "blerg" "grape"))
              (list "apple" "grape"))

(define (in-dictionary los)
  (cond [(empty? los) '()]
        [else (if (find-word? (first los) DICTIONARY-AS-LIST)
                  (cons (first los) (in-dictionary (rest los)))
                  (in-dictionary (rest los)))]))

; String List-of-string -> Boolean
; returns #true is a String is found in a given List of Strings
(check-expect (find-word? "apple" (list "apple" "grape")) #true)
(check-expect (find-word? "grape" (list  "apple" "grape")) #true)
(check-expect (find-word? "blerg" (list "apple" "grape")) #false)

(define (find-word? str los)
  (cond [(empty? los) #false]
        [else (if (string=? str (first los))
                  #true
                  (find-word? str (rest los)))]))
