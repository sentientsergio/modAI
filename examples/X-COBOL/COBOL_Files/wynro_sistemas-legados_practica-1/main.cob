       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAINHRMS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CRT STATUS IS CRT-STATUS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 CHOICE PIC 9.
       77 CRT-STATUS PIC 9(4).

       PROCEDURE DIVISION.
       MAIN-PARA.
           COPY CLEAR-SCREEN.
   *>>D    DISPLAY "DEBUG MODE" AT 0101.
           DISPLAY "*******************************************"
                AT 0315.
           DISPLAY "     HUMAN RESOURCE MANAGEMENT SYSTEM      "
                AT 0515.
           DISPLAY "*******************************************"
                AT 0715.
           DISPLAY "1. HRMS WRITE" AT 1025.
           DISPLAY "2. HRMS READ" AT 1225.
           DISPLAY "3. LIST BRANCH FILE" AT 1425.
           DISPLAY "4. EXIT" AT 1625.
           DISPLAY "ENTER YOUR CHOICE:" AT 1825.
           ACCEPT CHOICE AT 1844.
           IF CHOICE = 1 OR CRT-STATUS = 1001
               CALL "EMPWRITE"
               CANCEL "EMPWRITE"
               GO TO MAIN-PARA
           ELSE
               IF CHOICE = 2 OR CRT-STATUS = 1002
                   CALL "EMPREAD"
                   CANCEL "EMPREAD"
                   GO TO MAIN-PARA
               ELSE
                   IF CHOICE = 3 OR CRT-STATUS = 1003
                       CALL "BRANCHLIST"
                       CANCEL "BRANCHLIST"
                       GO TO MAIN-PARA
                   ELSE
                       IF  CHOICE = 9 OR CRT-STATUS = 1009
                           CALL "TESTS"
                           CANCEL "TESTS"
                           GO TO MAIN-PARA
                       ELSE
                           STOP RUN.
