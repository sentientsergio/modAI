       IDENTIFICATION DIVISION.
       PROGRAM-ID. cobol-calc.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. scootys-home.
       OBJECT-COMPUTER. scootys-home.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 firstnum  PIC 9(4) USAGE PACKED-DECIMAL.
       01 oper      PIC X(1).
       01 secondnum PIC 9(4) USAGE PACKED-DECIMAL.
       01 total     PIC 9(8) USAGE DISPLAY.

       PROCEDURE DIVISION.

       BEGIN.
       ACCEPT firstnum  FROM ARGUMENT-VALUE.
       ACCEPT oper      FROM ARGUMENT-VALUE.
       ACCEPT secondnum FROM ARGUMENT-VALUE.

       DISPLAY firstnum SPACE oper SPACE secondnum.

       IF oper = '+' THEN
           COMPUTE total = firstnum + secondnum
       ELSE
           IF oper = "-" THEN
                  COMPUTE total = firstnum - secondnum
       ELSE
           IF oper = "*" THEN
                  COMPUTE total = firstnum * secondnum
       ELSE
           IF oper = "/" THEN
                  COMPUTE total = firstnum / secondnum
       ELSE
           DISPLAY "Sorry I do not know that operator"
       END-IF.

       DISPLAY 'The total is: ' total.

       STOP RUN.
