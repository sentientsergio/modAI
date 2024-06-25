      *> Generate random numbers to demonstrate bug with random function
      *> This version calles a Fortran subroutine to generate random
      *> Numbers.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. genrand.
       AUTHOR. Owain Kenway.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 samples USAGE IS BINARY-LONG UNSIGNED VALUE 10000000.
           01 r       USAGE IS FLOAT-LONG.
          
       PROCEDURE DIVISION.

      *> Print a heading for our table (makes life in R better).
           DISPLAY "r" 
           PERFORM samples TIMES
               CALL "genrand_" USING r END-CALL
               DISPLAY r 
           END-PERFORM

      *> For some reason above messes with the return code?
           MOVE 0 TO RETURN-CODE

           GOBACK. 

