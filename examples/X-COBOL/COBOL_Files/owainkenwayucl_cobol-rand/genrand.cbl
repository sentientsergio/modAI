      *> Generate random numbers to demonstrate bug with random function
      *> https://sourceforge.net/p/open-cobol/bugs/72/
      *> Ubuntu Xenial ships an OpenCobol package with this bug which 
      *> results in random numbers being skewed towards low end instead 
      *> of uniform.

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
               COMPUTE r = FUNCTION RANDOM
               DISPLAY r
           END-PERFORM

           GOBACK. 
