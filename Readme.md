# HtDP 2e Solutions

## Spoiler Alert!

Here are my solutions for the exercises in "How to Design Programs 2nd Edition".
HTDP is still the best method to learn basic programming for motivated people. It's also a great intoduction to functional programming and Lispy languages.

The book: (<https://htdp.org/>)

I've completed Exercises 1-214 so far.

You owe it to yourself to work through your own solutions first before you look at mine.  If for no other reason than my solutions being an examples of how not to do it, and it may corrupt your style. :-)

The design recipe us presented by Gregor Kiczales:

<https://s3.amazonaws.com/edx-course-spdx-kiczales/HTC/Pages/design-recipes.html>

<https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#HtDF>

NOTE:
As of January 2021 (now 2022), Im refactoring this repository for two main reasons:

1 I followed a beta version of the book, so exercises and examples have chnaged.  So, I'm reviewing my solutions and examples.

2 I'm refactoring my code repository to make it more organized and to have information easier to find.  Book examples and notes will be in book.rkt files under their repsective section directories. Intermezzos will go under their own directory  I'll put each exercise in it's own file. I'm also going to use text format files Instead of DrRacket specific file format.

NOTE:
Don't try to use Emacs to do the exercises, even with Greg Hundershott's excelletn
racket-mode for Emacs, there is just too much impedence mismatch with editing 
Beginning Student language. Just use DrRacket, it's not too bad.

I just may complet the rest of the exercises given time.

Have fun.

## Index

   Directory                              Exercises

## 0-Prologue

    book.rkt                              Ex.

## 1-Fixed-Size-Data

  01-Arithmetic

    01_The_Arithmetic_of_Numbers          Ex. 1

    02_The_Arithmetic_of_Strings          Ex. 2

    03_Mixing_It_Up                       Ex. 3,4

    04_The_Arithmetic_of_Images           Ex. 5,6

    05_The_Arithmetic_of_Booleans         Ex. 7

    06_Mixing_it_Up_with_Booleans         Ex. 8

    07_Predicates_Know_Thy_Data           Ex. 9,10

  02-Functions and programs               Ex. 11-32

    01_Functions                          Ex. 11-20

    02_Computing                          Ex. 21-26

    03_Composting_Functions               Ex. 27-29

    04_Global_Constants                   Ex. 30

    05_Programs                           Ex. 31, 32, first.rkt

  03-HtDP

    01_Designing_Function                 Ex. 33

    02_Finger_Exercises_Functions         Ex. 34-38

    05_On_Testing                         Ex.

    06_Desinging_World_Programs           Ex. 39-44

    07_Virtual_Pet_World                  Ex. 45,46,47

  04-Intervals

    01_Programming_with_Conditionals

    02_Computing_Conditionaly             Ex. 48,49
    
    03_Enumerations                       Ex. 50,51

    04_Intervals                          Ex. 52

    04_Ufo

    05_Itemizations                       Ex. 53-57

    rocketlaunch.rkt

    06_Designing_with_Itemizations        Ex. 58

    07_Finite_State_Worlds                Ex. 59-62

  05-Adding-Structure

    01_From_Positions_to_posn_Structures

    02_Computing_with_posns

    03_Programming_with_posn              Ex. 63,64

    04_Defining_Structure_Types           Ex. 65-68

    05_Computing_with_Structures          Ex. 69-71

    06_Programming_with_Structures        Ex. 72-75

    07_Universe_of_Data                   Ex. 76-79

    08_Designing_with_Structures          Ex. 80-82

    09_Structure_in_the_World

    10_A_Graphical_Editor                 Ex. 83-87

    11_More_Virtual_Pets                  Ex. 89-93

  06-Itemizations-Structures

    01_Desinging_with_Itemizations_A      Ex.  94-100

    01_Desinging_with_Itemizations_B      Ex. 101-102

    01_Desinging_with_Itemizations_C      Ex. 103-105

    02_Mixing_Up_Worlds                   Ex. 106-109

    03_Input_Errors                       Ex. 110-113

    05_Equality_Predicates                Ex. 115

  07-Intermezzo-BSL

    intermezzo-BSL                        Ex. 116-128

## 2-Arbitrarily-Large-Data

  08-Lists

    08_01_creating_lists               Ex. 129-131

    08_03_programming_lists            Ex. 132-134

    08_04_computing_lists              Ex. 135-136

  09-Designing-Self-Referential

    09_01_designing_self_ref           Ex. 137-142

    09_02_non_empty_lists              Ex. 143-148

    09_03_natural_numbers              Ex. 149-152

    09_03_153_lecture_hall             Ex. 153

    09_04_russian_dolls                Ex. 154, 155

    09_05_lists_and_world              Ex. 156-159

    09_05_156_shot_world1              Ex. 156

    09_05_157_shot_world2              Ex. 157

    09_05_158_shot_world3              Ex. 158

    09_05_159_lecture_hall2            Ex. 159

    09_06_note_on_lists_sets           Ex. 160


  10-More-on-Lists

    10_01_producing_lists              Ex. 161-165

    10_01_161_wages1                   Ex. 161

    10_01_162_wages2                   Ex. 162

    10_01_163_FTC                      Ex. 163

    10_01_164_dollars_to_euros         Ex. 164

    10_01_165_subst_robot              Ex. 165

    10_02_structures_in_lists          Ex. 166-170

    10_02_166a_Employees3              Ex. 166a

    10_02_166b_Employees4              Ex. 166b

    10_03_lists_in_lists               Ex. 171-176

    10_04_graphical_editor_revisited   Ex. 177-180

  11-Design-Composition

    11_01_the_list_function            Ex. 181-185

    11_03_functions_that_recur         Ex. 186-190

    11_03_187_game_player1             Ex. 187

    11_03_188_email1                   Ex. 188

    11_04_functions_that_generalize    Ex. 191-194

  12-Projects-Lists

    12_01_dictionaries                 Ex. 195-198

    12_01_198_word_count               Ex. 198

    12_02_iTunes                       Ex. 199-208

    12_03_word_games_composition       Ex. 209-214

Ok.
