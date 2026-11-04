;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12_02_iTunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDP 2e - 12 Projects: Lists
;; 12.2 Real-world Data: iTunes
;; Exercises: 199-208

(require 2htdp/itunes)
(require 2htdp/batch-io)

; modify the following to use your chosen name
(define ITUNES-LOCATION "/home/emaphis/workspace/itunes.xml")

;LTracks
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))


;; Ex. 199:
;; While the important data definitions are already provided, the first step
;; of the design recipe is still incomplete. Make up examples of Dates, Tracks,
;; and LTracks. These examples come in handy for the following exercises
;; as inputs.

;; dates:

;(define-struct date [year month day hour minute second])
; A Date is a structure:
;    (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (1 ~ 12), day (1 ~ 31), hour (0 ~ 23),
; minute (0 ~ 59), andsecond (0 ~ 59)

(define A-DATE1 (create-date 2011 1 7 10 25 35))
(define A-DATE2 (create-date 2011 11 18 20 11 50))
(define A-DATE3 (create-date 2012 12 27 30 0 1))
(define A-DATE4 (create-date 2012 12 28 20 10 1))
(define P-DATE1 (create-date 2016 5 17 20 20 34))
(define P-DATE2 (create-date 2016 8 23 30 40 50))
(define P-DATE3 (create-date 2016 9 11 12 13 14))
(define P-DATE4 (create-date 2016 10 2 10 0 0))

;; tracks:

;(define-struct track
;  [name artist album time track# added play# played])
; A Track is a structure:
;    (make-track String Strign String N N Date N Date)
; interpretation An instance records in order: the track's title, its
; producing artist, to which album it belongs, its playing time in millisecond
; its position with the album, the date it was added, how often it has been
; played, and the date when it was last played.

(define TRACK1
  (create-track "Brass in Pocket" "Chrissie Hynde" "The Pretenders"
                37000 10 A-DATE1 12 P-DATE1))
(define TRACK2
  (create-track "I Love Rock'N Roll" "Joan Jett" "I Love Rock'N Roll"
                32000 1 A-DATE2 14 P-DATE2))
(define TRACK3
  (create-track "Suzanne" "Leonard Cohen" "Songs by Leonard Cohen"
                48000 3 A-DATE3 20 P-DATE3))
(define TRACK4
  (create-track "Crimson and Clover" "Joan Jet" "I Love Rock'N Roll"
                45000 5 A-DATE4 21 P-DATE4))
(define TRACK5
  (create-track "Precious" "Chrissie Hynde" "The Pretenders"
                35000 10 A-DATE2 10 P-DATE2))

;; List of tracks:
; An LTracks is one of:
; - '()
; - (cons Track LTracks)

(define LTRACK1 (list TRACK1))
(define LTRACK2 (list TRACK1 TRACK2 TRACK3))
(define LTRACK3 (list TRACK1 TRACK2 TRACK3 TRACK4 TRACK5))


;; Ex. 200:
;; Design the function total-time, which consumes an element of LTracks and
;; produces the total amount of play time. Once the program is done, compute
;; the total play time of your iTunes collection.

(check-expect (total-time '()) 0)
(check-expect (total-time LTRACK1) 37000)
(check-expect (total-time LTRACK2) (+ 37000 32000 48000))

(define (total-time ltr)
  (cond [(empty? ltr) 0]
        [else (+ (track-time (first ltr))
                 (total-time (rest ltr)))]))

; > (total-time itunes-tracks)
; 23900585
; Well, Ok.


;; Ex. 201:
;; Design select-all-album-titles. The function consumes an LTracks and
;; produces the list of album titles as a List-of-strings

;; Also design the function create-set. It consumes a List-of-strings and
;; constructs one that contains every String from the given list exactly once.
;; Hint If String s is at the front of the given list and occurs in the rest
;; of the list, too, create-set does not keep s

;; Finally design select-album-titles/unique, which consumes an LTracks and
;; produces a list of unique album titles. Use this function to determine all
;; album titles in your iTunes collection and also find out how many distinct
;; albums it contains.

;; A.
; LTracks -> List-of-strings
; produces a list of album titles given a List 0f tracks
(check-expect (select-all-album-titles '()) '())
(check-expect (select-all-album-titles LTRACK1) (list "The Pretenders"))
(check-expect (select-all-album-titles LTRACK2) (list "The Pretenders"
                                                      "I Love Rock'N Roll"
                                                      "Songs by Leonard Cohen"))
(define (select-all-album-titles ltr)
  (cond [(empty? ltr) '()]
        [else (cons (track-album (first ltr))
                    (select-all-album-titles (rest ltr)))]))

;; B.
; List-of-string -> List-of-string
; copy List of String with duplications removed (list as a set).
(check-expect (create-set '()) '())
(check-expect (create-set (list "aa" "bb" "cc")) (list "aa" "bb" "cc"))
(check-expect (create-set (list "aa" "aa" "cc")) (list "aa" "cc"))
(check-expect (create-set (list "aa" "aa" "bb" "aa" "cc" "bb" "cc"))
              (list  "aa" "bb" "cc"))

(define (create-set los)
  (cond [(empty? los) '()]
        [else
         (cons (first los)
               (create-set (remove-str (first los) (rest los))))]))

; String List-of-string -> List-of-string
; produce a List of String from a given List of String with str removed
(check-expect (remove-str "aa" '()) '())
(check-expect (remove-str "aa" (list "aa" "bb" "cc")) (list "bb" "cc"))
(check-expect (remove-str "bb" (list "aa" "bb" "cc")) (list "aa" "cc"))
(check-expect (remove-str "aa" (list "aa" "aa" "bb" "aa" "cc" "bb" "cc"))
              (list  "bb" "cc" "bb" "cc"))

(define (remove-str str los)
  (cond [(empty? los) '()]
        [else (if (string=? str (first los))
                  (remove-str str (rest los))
                  (cons (first los) (remove-str str (rest los))))]))

;; C.
; LTracks -> List-of-strings
; produces a unique list of album titles given a List 0f tracks
(check-expect (select-all-album-titles/unique '()) '())
(check-expect (select-all-album-titles/unique LTRACK2)
              (list "The Pretenders"
                    "I Love Rock'N Roll"
                    "Songs by Leonard Cohen"))

(check-expect (select-all-album-titles/unique
               (list TRACK1 TRACK2 TRACK1 TRACK3 TRACK2))
              (list "The Pretenders"
                    "I Love Rock'N Roll"
                    "Songs by Leonard Cohen"))

(define (select-all-album-titles/unique ltr)
  (create-set (select-all-album-titles ltr)))


;; Ex. 202:
;; Design select-album. The function consumes the title of an album and
;; an LTracks. It extracts from the latter the list of tracks that belong to
;; the given album.

; String List-of-tracks -> List-of-tracks
(check-expect (select-album "I Love Rock'N Roll" '()) '())
(check-expect (select-album "I Love Rock'N Roll" (list TRACK1 TRACK3)) '())
(check-expect (select-album "I Love Rock'N Roll" LTRACK3) (list TRACK2 TRACK4))
(check-expect (select-album "The Pretenders" LTRACK3) (list TRACK1 TRACK5))

(define (select-album title ltr)
  (cond [(empty? ltr) '()]
        [else (if (string=? title (track-album (first ltr)))
                  (cons (first ltr) (select-album title (rest ltr)))
                  (select-album title (rest ltr)))]))


;; Ex. 203:
;; Design select-album-date. The function consumes the title of an album,
;; a date, and an LTracks. It extracts from the latter the list of tracks
;; that belong to the given album and have been played after the given date.
;; Hint You must design a function that consumes two Dates and determines
;; whether the first occurs before the second.

; String Date List-of-tracs -> List-of-tracs
(check-expect (select-album-date "I Love Rock'N Roll" P-DATE1 LTRACK3)
              (list TRACK2 TRACK4))
(check-expect (select-album-date "I Love Rock'N Roll" P-DATE3 LTRACK3)
              (list TRACK4))
(check-expect (select-album-date "I Love Rock'N Roll"
                                 (create-date 2017 1 1 0 0 0) LTRACK3)
              '())

(define (select-album-date ttl dt ltr)
  (cond [(empty? ltr) '()]
        [else
         (if (and (string=? ttl (track-album (first ltr)))
                  (date<? dt (track-played (first ltr))))
             (cons (first ltr) (select-album-date ttl dt (rest ltr)))
             (select-album-date ttl dt (rest ltr)))]))


; Date Date -> Boolean
; returns #truen if first date is less than second data
(check-expect (date<? P-DATE1 P-DATE2) #true)
(check-expect (date<? P-DATE2 P-DATE1) #false)
(check-expect (date<? P-DATE1 P-DATE1) #false)  ; non-exhaustive tests.

(define (date<? dt1 dt2)
  (cond [(< (date-year dt1) (date-year dt2)) #true]
        [(> (date-year dt1) (date-year dt2)) #false]
        [else
         (cond [(< (date-month dt1) (date-month dt2)) #true]
               [(> (date-month dt1) (date-month dt2)) #false]
               [else
                (cond [(< (date-day dt1) (date-day dt2)) #true]
                      [(> (date-day dt1) (date-day dt2)) #false]
                      [else
                       (cond [(< (date-hour dt1) (date-hour dt2)) #true]
                             [(> (date-hour dt1) (date-hour dt2)) #false]
                             [else
                              (cond [(< (date-minute dt1) (date-minute dt2)) #true]
                                    [(> (date-minute dt1) (date-minute dt2)) #false]
                                    [else
                                     (cond [(< (date-second dt1) (date-second dt2)) #true]
                                           [(>= (date-second dt1) (date-second dt2)) #false])])])])])]))


;; Ex. 204:
;; Design select-albums. The function consumes an element of LTracks.
;; It produce a list of LTracks, one per album. Each album is uniquely
;; identified by its title and shows up in the result only once.
;; Hints:
;; (1) You want to use some of the solutions of the preceding exercises.
;; (2) The function that groups consumes two lists: the list of album titles
;; and the list of tracks; it considers the latter as atomic until it is
;; handed over to an auxiliary function. See exercise 196.

; LTracks -> List of LTracks
; given a LTracks produces a List of LTracs one per album.
(check-expect (select-albums '())  '())
(check-expect (select-albums LTRACK1) (list (list TRACK1)))
(check-expect (select-albums LTRACK2) (list (list TRACK1)
                                            (list TRACK2)
                                            (list TRACK3)))
(check-expect (select-albums LTRACK3) (list (list TRACK1 TRACK5)
                                            (list TRACK2 TRACK4)
                                            (list TRACK3)))
(define (select-albums ltr)
  (select-albums-aux (select-all-album-titles/unique ltr) ltr))

; Los LTracks -> List-of-ltracks
; given a list of unique title names, produce a list of list of tracks
; one per unique title
(define (select-albums-aux los ltr)
  (cond [(empty? los) '()]
        [else (cons (select-album (first los) ltr)
                    (select-albums-aux (rest los) ltr))]))


;; Ex. 205:
;; Develop examples of LAssoc and LLists, that is, the list representation of
;; tracks and lists of such tracks.

; An Association is a list of two items:
; (cons String (cons BSDN '()))

; A BSDN is one of:
; - Boolean
; - Number
; - String
; - Date

;; helpers to create associations: (* blech *)
;  BSDN -> (list "label" BSDN)

; BSDN/String -> Association
; produce a name association
(define (create-name str)
  (list "name" str))

; BSDN/String -> Association
; produce an artist association
(define (create-artist str)
  (list "artist" str))

; BSDN/String -> Association
; produce an album title association
(define (create-album str)
  (list "album" str))

; BSDN/Number -> Association
; produce a track duration association
(define (create-time num)
  (list "time" num))

; BSDN/Number -> Association
; produce a track number association
(define (create-track# num)
  (list "track#" num))

; BSDN/Date -> Association
; produce a  date added association
(define (create-added dt)
  (list "added" dt))

; BSDN/Number -> Association
; produce number or times played association
(define (create-play# num)
  (list "play#" num))

; BSDN/Date -> Association
; produce date the the track was last played
(define (create-played dt)
  (list "played" dt))


;; Tracks as association lists:
; An LAssoc is one of:
; - '()
; - (cons Association LAssoc)

(define A-TRACK1
  (list (create-name "Brass in Pocket")
        (create-artist "Chrissie Hynde")
        (create-album "The Pretenders")
        (create-time 37000)
        (create-track# 10)
        (create-added A-DATE1)
        (create-play# 12)
        (create-played  P-DATE1)))

(define A-TRACK2
  (list (create-name "I Love Rock'N Roll")
        (create-artist "Joan Jett" )
        (create-album "I Love Rock'N Roll")
        (create-time 32000)
        (create-track# 1)
        (create-added A-DATE2)
        (create-play# 14)
        (create-played P-DATE2)))

(define A-TRACK3
  (list (create-name "Suzanne")
        (create-artist "Leonard Cohen")
        (create-album "Songs by Leonard Cohen")
        (create-time 48000)
        (create-track# 3)
        (create-added A-DATE3)
        (create-play# 20)
        (create-played P-DATE3)))

(define A-TRACK4
  (list (create-name "Crimson and Clover")
        (create-artist "Joan Jet")
        (create-album "I Love Rock'N Roll")
        (create-time 45000)
        (create-track# 5)
        (create-added A-DATE4)
        (create-play# 21)
        (create-played P-DATE4)))

(define A-TRACK5
  (list (create-name "Precious")
        (create-artist "Chrissie Hynde")
        (create-album "The Pretenders")
        (create-time 35000)
        (create-track# 10)
        (create-added A-DATE2)
        (create-play# 10)
        (create-played  P-DATE2)))

;; list of tracks:

; An LLists is one of:
; - '()
; - (cons LAssoc LLists)

(define LATRACK1 (list A-TRACK1))
(define LATRACK2 (list A-TRACK1 A-TRACK2 A-TRACK3))
(define LATRACK3 (list A-TRACK1 A-TRACK2 A-TRACK3 A-TRACK4 A-TRACK5))

; LLists
;(define list-tracks
;  (read-itunes-as-lists ITUNES-LOCATION))


;; Ex. 206:
;; Design the function find-association. It consumes three arguments: a String
;; called key; an LAssoc; and an element of Any called default. It produces
;; the first Association whose first item is equal to key or default if there
;; is no such Association.

;; Note Read up on assoc after you have designed this function. image

; Key LAssoc Any -> Association
; produces the first Association the equals the given Key, if the Key is in
; the passed LAssoc, produces def in nothing is found
(check-expect (find-association "name" A-TRACK1 "nothing")
              (list "name" "Brass in Pocket"))
(check-expect (find-association "album" A-TRACK1 "nothing")
              (list "album" "The Pretenders"))
(check-expect (find-association "play#" A-TRACK1 0)
              (list "play#" 12))
(check-expect (find-association "oops" A-TRACK1 "nothing") "nothing")

(define (find-association key las def)
  (cond [(empty? las) def]
        [else (if (string=? key (first (first las)))
                  (list key (second (first las)))
                  (find-association key (rest las) def))]))

;; Ex. 207:
;; Design total-time/list, which consumes an LLists and produces the total
;; amount of play time. Hint Solve exercise 206 first.

;; Once you have completed the design, compute the total play time of your
;; iTunes collection. Compare this result with the time that the total-time
;; function from exercise 200 computes. Why is there a difference?

; LList -> Number
; produces the total play time of a given List of Tracks
(check-expect (total-time/list '()) 0)
(check-expect (total-time/list LATRACK1) 37000)
(check-expect (total-time/list LATRACK2 ) (+ 37000 32000 48000))

(define (total-time/list llst)
  (cond [(empty? llst) 0]
        [else (+ (second (find-association "time" (first llst) 0))
                 (total-time/list (rest llst)))]))

;> (total-time/list LATRACK3)
;197000
;> (total-time LTRACK3)
;197000

;> (total-time/list LATRACK2)
;117000
;> (total-time LTRACK2)
;117000


;; Ex. 208:
;; Design boolean-attributes. The function consumes an LLists and produces the
;; Strings that are associated with a Boolean attribute. Hint Use create-set
;; from exercise 201.

;; Once you are done, determine how many Boolean-valued attributes your iTunes
;; library employs for its tracks. Do they make sense?

; LList -> List of String
; produce a list of keys that have boolean attriburs in
; a List of Association list
(check-expect (boolean-attributes '()) '())
(check-expect (boolean-attributes (list (list (list "aa" "bb"))
                                        (list (list "aa" "bb"))))
              '())
(check-expect (boolean-attributes (list (list (list "aa" "bb")
                                              (list "cc" #true))
                                        (list (list "aa" "bb")
                                              (list "cc" #false)
                                              (list "dd" #true))))
              (list "cc" "dd"))

(define (boolean-attributes llst)
  (create-set
   (cond [(empty? llst) '()]
         [else (append (find-booleans (first llst))
                       (boolean-attributes (rest llst)))])))

; LAssoc -> List-of-string
; produce a list of keys (String) for any attribute in a LTrack is a boolean
(check-expect (find-booleans '()) '())
(check-expect (find-booleans (list (list "aa" "bb"))) '())
(check-expect (find-booleans (list (list "aa" "bb")
                                   (list "cc" #true)
                                   (list "dd" 3)
                                   (list "ee" #false)))
              (list "cc" "ee"))

(define (find-booleans las)
  (cond [(empty? las) '()]
        [else (if (boolean? (second (first las)))
                  (cons (first (first las))
                        (find-booleans (rest las)))
                  (find-booleans (rest las)))]))

;> (boolean-attributes list-tracks)
;(list
; "Part Of Gapless Album"
; "Protected"
; "Purchased"
; "Podcast"
; "Unplayed"
; "Has Video"
; "HD"
; "TV Show"
; "Movie"
; "iTunesU")
