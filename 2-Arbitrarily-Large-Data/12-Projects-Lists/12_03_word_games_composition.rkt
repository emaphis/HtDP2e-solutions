;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12_03_word_games_composition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 12 Projects: Lists
;; 12.3 Word Games, Composition Illustrated
;; 12.4 Word Games, the Heart of the Problem
;; Exercises: 209-214

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

(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))

(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)

(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))


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
        [else (if (find-word? (first los) DICTIONARY-AS-LIST) ;could use member?
                  (cons (first los) (in-dictionary (rest los)))
                  (in-dictionary (rest los)))]))
;;(define (in-dictionary los) los) ;stub

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 12.4 Word Games, the heart the problem

;; Ex. 212:
;; Write down the data definition for List-of-words. Make up examples of Words
;; and List-of-words. Finally, formulate the functional example from above with
;; check-expect. Instead of the full example, consider working with a word of
;; just two letters, say "d" and "e".

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a String as a list of 1Strings (letters)

(define W-ED (list  "e" "d"))
(define W-CAT (list "c" "a" "t"))

; A List-of-words is one of:
; - '() or
; - (cons Word List-of-words)
; interpretation a list that consisit of Word.

(define L-ED (list (list "e" "d")
                   (list "d" "e")))

(define L-CAT (list (list "c" "a" "t")
                    (list "a" "c" "t")
                    (list "a" "t" "c")
                    (list "c" "t" "a")
                    (list "t" "c" "a")
                    (list "t" "a" "c")))


(check-expect (arrangements '()) (list '()))
(check-expect (arrangements W-ED) L-ED)
(check-expect (arrangements W-CAT) L-CAT)


; Word -> List-of-words
; creates all re-arrangements of letters in w
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
                    (arrangements (rest w)))]))


;; Ex. 213:
;; Design insert-everywhere/in-all-words. It consumes a 1String and a list of
;; words. The result is a list of words like its second argument, but with the
;; first argument inserted at the beginning, between all letters, and at the
;; end of all words of the given list.

;; Start with a complete wish list entry. Supplement it with tests for empty
;; lists, a list with a one-letter word and another list with a two-letter
;; word, etc. Before you continue, study the following three hints carefully.

;; Hints:
;; (1) Reconsider the example from above. It says that "d" needs to be inserted
;; into the words (list "e" "r") and (list "r" "e"). The following application
;; is therefore one natural candidate for an example:

;    (insert-everywhere/in-all-words "d"
;      (cons (list "e" "r")
;        (cons (list "r" "e")
;          '())))

;; (2) You want to use the BSL+ operation append, which consumes two lists and
;; produces the concatenation of the two lists:

;    > (append (list "a" "b" "c") (list "d" "e"))
;
;    (list "a" "b" "c" "d" "e")

;; The development of functions like append is the subject of Simultaneous
;; Processing.

;; (3) This solution of this exercise is a series of functions. Patiently stick
;;to the design recipe and systematically work through your wish list.

;; Lolo1s is a List of Words

; 1String Lolo1s -> Lolo1s
(check-expect (insert-everywhere/in-all-words "a" (list '())) (list (list "a")))
(check-expect (insert-everywhere/in-all-words "c" (list (list "a" "t")
                                                        (list "t" "a")))
              (list
               (list "c" "a" "t")
               (list "a" "c" "t")
               (list "a" "t" "c")
               (list "c" "t" "a")
               (list "t" "c" "a")
               (list "t" "a" "c")))

(define (insert-everywhere/in-all-words ch low)
  (cond [(empty? low) '()]
        [else
         (append (insert-everywhere '() ch (first low))
                 (insert-everywhere/in-all-words ch (rest low)))]))

; Lo1s 1String Lo1s  -> LoLo1s
; takes a word char and a word and returns a list of words with char inserted
(check-expect (insert-everywhere (list "h") "e" (list "l" "l" "o"))
              (list (list "h" "e" "l" "l" "o")
                    (list "h" "l" "e" "l" "o")
                    (list "h" "l" "l" "e" "o")
                    (list "h" "l" "l" "o" "e")))

(define (insert-everywhere pre ch post)
  (cond [(empty? post) (list (append pre (list ch)))]
        [else
         (append (list (append pre (list ch) post))
                 (insert-everywhere (append pre (list (first post)))
                                    ch
                                    (rest post)))]))


;; Ex. 214:
;; Integrate arrangements with the partial program from Word Games, Composition
;; Illustrated. After making sure that the entire suite of tests passes, run it
;; on some of your favorite examples.

;;; TODO: this needs more work.  Duplicate items looked up in dictionary.
;; Poor performance on medium sized words.
