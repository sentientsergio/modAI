      * The MIT License (MIT)
      *
      * Copyright (c) 2015 Andrew Young
      *
      * Permission is hereby granted, free of charge, to any person
      * obtaining a copy of this software and associated documentation
      * files (the "Software"), to deal in the Software without
      * restriction, including without limitation the rights to use,
      * copy, modify, merge, publish, distribute, sublicense, and/or
      * sell copies of the Software, and to permit persons to whom the
      * Software is furnished to do so, subject to the following
      * conditions:
      *
      * The above copyright notice and this permission notice shall be
      * included in all copies or substantial portions of the Software.
      *
      * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
      * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
      * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
      * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
      * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
      * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
      * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
      * OTHER DEALINGS IN THE SOFTWARE.
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GUESS.
       AUTHOR. Andrew Young.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
      
       WORKING-STORAGE SECTION.
      
       01  ANSWER         PIC  9(2) VALUE IS ZEROES.
       01  THE-GUESS      PIC S9(2) VALUE IS -1.
            88 VALID-GUESS            VALUE IS 0 THROUGH 99.
            88 USER-GIVES-UP          VALUE IS 0.
       01  DELTA          PIC S9(2) VALUE IS ZEROES.
       01  TRIES          PIC  9(2) VALUE IS ZEROES.
       01  DONE           PIC X     VALUE IS SPACES.
            88 PROGRAM-FINISHED       VALUE IS "Y".
       01  YES            PIC X     VALUE IS "Y".
      
       01  SEED-TIME.
            05 SEED         PIC 9(8) VALUE IS ZEROES.
      
       PROCEDURE DIVISION.
      
       PROGRAM-BEGIN.
            DISPLAY "Welcome! Let's play a game.".
            PERFORM SEED-RANDOM.
            PERFORM SELECT-NUMBER.
            PERFORM MAIN-LOOP
              UNTIL PROGRAM-FINISHED.
      
       PROGRAM-DONE.
            STOP RUN.
      
       MAIN-LOOP.
            PERFORM PROMPT-USER
              UNTIL VALID-GUESS.
            PERFORM CHECK-GUESS.
            MOVE -1 TO THE-GUESS.
      
       SEED-RANDOM.
            ACCEPT SEED-TIME FROM TIME.
            COMPUTE ANSWER = FUNCTION RANDOM(SEED).
      
       SELECT-NUMBER.
            MOVE 0 TO TRIES.
            COMPUTE ANSWER = (FUNCTION RANDOM * 99) + 1.
      
       PROMPT-USER.
            DISPLAY "Guess what number I'm thinking of between 1 and 99
      -       ". (Enter 0 to give up.)".
            ACCEPT THE-GUESS.
      
       CHECK-GUESS.
            IF USER-GIVES-UP
              PERFORM GIVE-UP
            ELSE
              PERFORM SHOW-HINT.
      
       GIVE-UP.
            DISPLAY "It was " ANSWER "!"
            MOVE YES TO DONE.
      
       SHOW-HINT.
            ADD 1 TO TRIES.
            COMPUTE DELTA = THE-GUESS - ANSWER.
      
            IF DELTA = 0
              DISPLAY "Correct! You guessed it in " TRIES " tries!"
              MOVE YES TO DONE.
      
            IF DELTA < 0
              DISPLAY "Too low, guess again!".
      
            IF DELTA > 0
              DISPLAY "Too high, guess again!".
      
            IF TRIES = 99
              DISPLAY "You've guessed too many times!"
              DISPLAY "The answer was " ANSWER "."
              MOVE YES TO DONE
            ELSE
              DISPLAY "You've guessed " TRIES " times.".
      
