       IDENTIFICATION DIVISION.
       PROGRAM-ID. "DIDZORCHCANCELMOVIENIGHT".
       AUTHOR.     DBAUDISCH.
      *Is it saturday, and did Zorch cancel movie night again?

       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TODAY PIC 9(1) VALUE ZERO.
       01 USER-INPUT PIC A(1) VALUE SPACE.
       01 INPUT-RESULT PIC A(1) VALUE SPACE.
       01 ISMOVIENIGHT PIC A(1) VALUE "y".
       01 ISCANCELLED PIC A(1) VALUE "y".
       
       PROCEDURE DIVISION.
       START-HERE.
           ACCEPT TODAY FROM DAY-OF-WEEK
      *    6 EQUAL saturday
           IF TODAY EQUAL 6 THEN
               DISPLAY "It is saturday!"
               DISPLAY "Should there be a movie night? (y/n)"
               PERFORM RECEIVE-USER-USER-INPUT
               IF INPUT-RESULT IS NOT EQUAL SPACE AND LOW-VALUE THEN
                   MOVE INPUT-RESULT TO ISMOVIENIGHT
               END-IF

               IF ISMOVIENIGHT EQUAL 'y' THEN
                   DISPLAY "Was ist cancelled? (y/n)"
                   PERFORM RECEIVE-USER-USER-INPUT
                   IF INPUT-RESULT IS NOT EQUAL SPACE AND LOW-VALUE THEN
                       MOVE INPUT-RESULT TO ISCANCELLED
                   END-IF

                   IF ISCANCELLED EQUAL 'y' THEN
                       DISPLAY "NOT AGAIN, ZORCH! >:("
                   ELSE
                       DISPLAY "See ya at movie night! :)"
                   END-IF
               ELSE
                   DISPLAY "Then there is no movie night!"
                   DISPLAY "Try again next saturday!"
               END-IF
           ELSE
               DISPLAY "It is not saturday!"
               DISPLAY "Try again tomorrow!"
           END-IF
           STOP RUN.

       RECEIVE-USER-USER-INPUT.
           MOVE SPACE TO USER-INPUT
           MOVE SPACE TO INPUT-RESULT
           ACCEPT USER-INPUT
           MOVE FUNCTION LOWER-CASE(USER-INPUT) TO USER-INPUT
           IF USER-INPUT IS NOT EQUAL 'y' THEN
               MOVE USER-INPUT TO INPUT-RESULT
           END-IF
           EXIT.
              
       END PROGRAM DIDZORCHCANCELMOVIENIGHT.
