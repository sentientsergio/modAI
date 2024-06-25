      * FizzBuzz program
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIZZBUZZ.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  LS-INPUT               PIC 9(2).
       01  LS-RESULT              PIC X(8).
       01  LS-REMAINDER           PIC 9(2).
       01  LS-DIVISION            PIC 9(2).

       PROCEDURE DIVISION.

       0000-MAIN.
           PERFORM 1000-PRINT-FIZZBUZZ VARYING LS-INPUT 
           FROM 1 BY 1 UNTIL LS-INPUT=15. 
       
       1000-PRINT-FIZZBUZZ.
          PERFORM 2000-FIZZBUZZ.
          DISPLAY LS-INPUT ": " LS-RESULT. 


       2000-FIZZBUZZ.
           DIVIDE LS-INPUT BY 3 GIVING LS-DIVISION 
           REMAINDER LS-REMAINDER.

           IF LS-REMAINDER EQUAL 0 THEN

             MOVE 'Fizz' TO LS-RESULT

           ELSE

             DIVIDE LS-INPUT BY 5 GIVING LS-DIVISION
             REMAINDER LS-REMAINDER

             IF LS-REMAINDER EQUAL 0 THEN
               MOVE 'Buzz' TO LS-RESULT
             ELSE
               MOVE LS-INPUT TO LS-RESULT
             END-IF

           END-IF.
