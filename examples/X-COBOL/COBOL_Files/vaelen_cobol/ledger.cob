      * The MIT License (MIT)
      *
      * Copyright (c) 2019 Andrew C. Young
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

      ****************************************
      * This is a simple accounting ledger.  *
      *                                      *
      * I wrote this in memory of my mother, *
      * Roberta Young, and the many hours    *
      * she spent sitting in front of a      *
      * green screen terminal entering COBOL *
      * programs when I was a kid.           *
      ****************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEDGER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT OPTIONAL ACCOUNT-FILE
               ASSIGN TO "account.dat"
               ORGANIZATION IS RELATIVE
               RELATIVE KEY IS ACCOUNT-ID
               ACCESS MODE IS DYNAMIC
               FILE STATUS IS FILE-STATUS.

           SELECT OPTIONAL LEDGER-FILE
               ASSIGN TO LEDGER-FILE-NAME
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FILE-STATUS.

           SELECT OPTIONAL CONTROL-FILE
               ASSIGN TO "control.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FILE-STATUS.

           SELECT REPORT-FILE
               ASSIGN TO PRINTER PRINTER-NAME
               ORGANIZATION IS LINE SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
       
       FD  ACCOUNT-FILE.
       01  ACCOUNT-RECORD.
           05  ACCOUNT-COMPANY            PIC X(8)       VALUE SPACES.
           05  ACCOUNT-NUMBER             PIC X(20)      VALUE SPACES.
           05  ACCOUNT-TYPE               PIC X(10)      VALUE SPACES.
           05  ACCOUNT-DESCRIPTION        PIC X(50)      VALUE SPACES.
           05  ACCOUNT-STATUS             PIC X(1)       VALUE SPACE.
           05  ACCOUNT-VALUE              PIC S9(9)V9(2) VALUE ZEROS.

       FD  LEDGER-FILE.
       01  LEDGER-RECORD.
           05  LEDGER-DATE-TIME.
               10  LEDGER-DATE.
                   15  LEDGER-DATE-YEAR   PIC 9(4)       VALUE ZEROS.
                   15  LEDGER-DATE-MONTH  PIC 9(2)       VALUE ZEROS.
                   15  LEDGER-DATE-DAY    PIC 9(2)       VALUE ZEROS.
               10  LEDGER-TIME.
                   15  LEDGER-TIME-HOUR   PIC 9(2)       VALUE ZEROS.
                   15  LEDGER-TIME-MIN    PIC 9(2)       VALUE ZEROS.
                   15  LEDGER-TIME-SEC    PIC 9(2)       VALUE ZEROS.
           05  LEDGER-DESCRIPTION         PIC X(30)      VALUE SPACES.
           05  LEDGER-AMOUNT              PIC S9(9)V9(2) VALUE ZEROS.
           05  LEDGER-STATUS              PIC X(1)       VALUE SPACE.

       FD  CONTROL-FILE.
       01  CONTROL-RECORD.
           05  NEXT-ACCOUNT-ID            PIC 9(10)      VALUE ZEROS.

       FD  REPORT-FILE.
       01  GENERIC-REPORT.
           05  GENERIC-REPORT-LINE        PIC X(120)     VALUE SPACES.

       01  ACCOUNT-REPORT-HEADER.
           05  AH-COMPANY                 PIC X(8)       VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AH-NUMBER                  PIC X(20)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AH-TYPE                    PIC X(10)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AH-STATUS                  PIC X(1)       VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AH-VALUE                   PIC X(16)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AH-DESCRIPTION             PIC X(50)      VALUE SPACES.

       01  ACCOUNT-REPORT-LINE.
           05  AR-COMPANY                 PIC X(8)       VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AR-NUMBER                  PIC X(20)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AR-TYPE                    PIC X(10)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AR-STATUS                  PIC X(1)       VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AR-VALUE                   PIC -$$$$,$$$,$$0.00
                                          VALUE ZEROS.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  AR-DESCRIPTION             PIC X(50)      VALUE SPACES.

       01  LEDGER-REPORT-HEADER.
           05  LH-DATE-TIME               PIC X(20)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  LH-DESCRIPTION             PIC X(30)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  LH-STATUS                  PIC X(1)       VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  LH-AMOUNT                  PIC X(16)      VALUE SPACES.

       01  LEDGER-REPORT-LINE.
           05  LR-DATE-TIME               PIC X(20)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  LR-DESCRIPTION             PIC X(30)      VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  LR-STATUS                  PIC X(1)       VALUE SPACES.
           05  FILLER                     PIC X(1)       VALUE SPACES.
           05  LR-AMOUNT                  PIC -$$$$,$$$,$$0.00
                                          VALUE ZEROS.
           
       WORKING-STORAGE SECTION.

       01  MENU-OPTION                    PIC 9(1)       VALUE ZERO.
       01  END-OF-FILE                    PIC X(1)       VALUE SPACE.
       01  CURRENT-LINE                   PIC 9(3)       VALUE ZEROS.
       01  CONTINUE-KEY                   PIC X(1)       VALUE SPACE.
       01  LEDGER-FILE-NAME.
           05  ACCOUNT-ID                 PIC 9(8)       VALUE ZEROS.
           05  LEDGER-FN-EXT              PIC X(4)       VALUE ".dat".
       01  FILE-STATUS                    PIC 9(2)       VALUE ZEROS.
       01  FILE-NOT-FOUND                 PIC 9(2)       VALUE 05.
       01  ACCOUNT-LOADED                 PIC X(1)       VALUE "N".
       01  NOW.
           05  NOW-DATE-TIME.
               10  NOW-DATE.
                   15  NOW-YEAR           PIC 9(4)       VALUE ZEROS.
                   15  NOW-MONTH          PIC 9(2)       VALUE ZEROS.
                   15  NOW-DAY            PIC 9(2)       VALUE ZEROS.
               10  NOW-TIME.
                   15  NOW-HOUR           PIC 9(2)       VALUE ZEROS.
                   15  NOW-MINUTE         PIC 9(2)       VALUE ZEROS.
                   15  NOW-SECOND         PIC 9(2)       VALUE ZEROS.
           05  NOW-MS                     PIC 9(2)       VALUE ZEROS.
       01  DISPLAY-DATE-TIME.
           05  DISPLAY-DATE.
               10  DISPLAY-YEAR           PIC 9(4)       VALUE ZEROS.
               10  FILLER                 PIC X(1)       VALUE "/".
               10  DISPLAY-MONTH          PIC 9(2)       VALUE ZEROS.
               10  FILLER                 PIC X(1)       VALUE "/".
               10  DISPLAY-DAY            PIC 9(2)       VALUE ZEROS.
           05  FILLER                     PIC X(1)       VALUE " ".
           05  DISPLAY-TIME.
               10  DISPLAY-HOUR           PIC 9(2)       VALUE ZEROS.
               10  FILLER                 PIC X(1)       VALUE ":".
               10  DISPLAY-MINUTE         PIC 9(2)       VALUE ZEROS.
               10  FILLER                 PIC X(1)       VALUE ":".
               10  DISPLAY-SECOND         PIC 9(2)       VALUE ZEROS.
       01  PRINTER-NAME                   PIC X(60)
                                        VALUE "report.txt".
       01  PRINTER-ROWS                   PIC 9(3)       VALUE 55.
       01  SCREEN-ROWS                    PIC 9(3)       VALUE 23.
           
       SCREEN SECTION.

       01  MAIN-MENU-SCREEN.
           05  BLANK SCREEN.
           05  LINE 1  COLUMN 1  VALUE "Main Menu:".
           05  LINE 3  COLUMN 3  VALUE "1) List Accounts".
           05  LINE 4  COLUMN 3  VALUE "2) Account Ledger".
           05  LINE 5  COLUMN 3  VALUE "3) Update Accounts".
           05  LINE 6  COLUMN 3  VALUE "4) Add Account".
           05  LINE 7  COLUMN 3  VALUE "5) Account Report".
           05  LINE 8  COLUMN 3  VALUE "9) Exit".
           05  LINE 10 COLUMN 1  VALUE "Selecton => ".
           05  LINE 10 COLUMN 13 PIC Z USING MENU-OPTION AUTO.

       01  LOAD-ACCOUNT-SCREEN.
           05  BLANK SCREEN.
           05  LINE 1  COLUMN 1  VALUE "Account: ".
           05  LINE 1  COLUMN 10 PIC Z(8) USING ACCOUNT-ID.

       01  LEDGER-MENU-SCREEN.
           05  LINE 5  COLUMN 1  VALUE "Ledger Menu:".
           05  LINE 7  COLUMN 3  VALUE "1) Show Ledger".
           05  LINE 8  COLUMN 3  VALUE "2) Add Ledger Entry".
           05  LINE 9  COLUMN 3  VALUE "3) Update Account".
           05  LINE 10 COLUMN 3  VALUE "4) Ledger Report".
           05  LINE 11 COLUMN 3  VALUE "9) Exit".
           05  LINE 13 COLUMN 1  VALUE "Selecton => ".
           05  LINE 13 COLUMN 13 PIC Z USING MENU-OPTION AUTO.

       01  ADD-ACCOUNT-SCREEN.
           05  BLANK SCREEN.
           05  LINE 1  COLUMN 1  VALUE "Add Account:"
           05  LINE 3  COLUMN 1  VALUE "         ID: ".
           05  LINE 3  COLUMN 14  PIC Z(7)9 FROM ACCOUNT-ID.
           05  LINE 4  COLUMN 1  VALUE "    Company: ".
           05  LINE 4  COLUMN 14 PIC X(8) USING ACCOUNT-COMPANY.
           05  LINE 5  COLUMN 1  VALUE "     Number: ".
           05  LINE 5  COLUMN 14 PIC X(20) USING ACCOUNT-NUMBER.
           05  LINE 6  COLUMN 1  VALUE "      Value: ".
           05  LINE 6  COLUMN 14 PIC -$$$$$$$$$$.$$ USING ACCOUNT-VALUE.
           05  LINE 7  COLUMN 1  VALUE "       Type: ".
           05  LINE 7  COLUMN 14  PIC X(10) USING ACCOUNT-TYPE.
           05  LINE 8  COLUMN 1  VALUE "     Status: ".
           05  LINE 8  COLUMN 14 PIC X(1) USING ACCOUNT-STATUS.
           05  LINE 9  COLUMN 1  VALUE "Description: ".
           05  LINE 9  COLUMN 14 PIC X(50) USING ACCOUNT-DESCRIPTION.

       01  ADD-ACCOUNT-PROMPT.
           05  LINE 11  COLUMN 1  VALUE "Add Account? (Y/N)".
           05  LINE 11  COLUMN 20 PIC Z USING CONTINUE-KEY AUTO.
           
       01  LIST-ACCOUNT-SCREEN.
           05  BLANK SCREEN.
           05  LINE 1  COLUMN 1  VALUE "ID".
           05  LINE 1  COLUMN 10 VALUE "Company".
           05  LINE 1  COLUMN 19 VALUE "Number".
           05  LINE 1  COLUMN 40 VALUE "Type".
           05  LINE 1  COLUMN 51 VALUE "S".
           05  LINE 1  COLUMN 53 VALUE "Value".
           05  LINE 2  COLUMN 1  VALUE "--------".
           05  LINE 2  COLUMN 10 VALUE "--------".
           05  LINE 2  COLUMN 19 VALUE "--------------------".
           05  LINE 2  COLUMN 40 VALUE "----------".
           05  LINE 2  COLUMN 51 VALUE "-".
           05  LINE 2  COLUMN 53 VALUE "----------------".

       01  ACCOUNT-LIST-ROW.
           05  LINE CURRENT-LINE COLUMN 1  PIC Z(7)9
                                        FROM ACCOUNT-ID.
           05  LINE CURRENT-LINE COLUMN 10 PIC X(8)
                                        FROM ACCOUNT-COMPANY.
           05  LINE CURRENT-LINE COLUMN 19 PIC X(20)
                                        FROM ACCOUNT-NUMBER.
           05  LINE CURRENT-LINE COLUMN 40 PIC X(10)
                                        FROM ACCOUNT-TYPE.
           05  LINE CURRENT-LINE COLUMN 51 PIC X(1)
                                        FROM ACCOUNT-STATUS.
           05  LINE CURRENT-LINE COLUMN 53 PIC -$$$$,$$$,$$9.99
                                        FROM ACCOUNT-VALUE.

       01  CONTINUE-PROMPT.
           05  LINE CURRENT-LINE COLUMN 1
                                 VALUE "PRESS ANY KEY TO CONTINUE.".
           05  LINE CURRENT-LINE COLUMN 28 PIC Z
                                        USING CONTINUE-KEY AUTO.

       01  LIST-LEDGER-SCREEN.
           05  LINE 5  COLUMN 1  VALUE "Date".
           05  LINE 5  COLUMN 21 VALUE "S".
           05  LINE 5  COLUMN 23 VALUE "Amount".
           05  LINE 5  COLUMN 41 VALUE "Description".
           05  LINE 6  COLUMN 1  VALUE "-------------------".
           05  LINE 6  COLUMN 21 VALUE "-".
           05  LINE 6  COLUMN 23 VALUE "----------------".
           05  LINE 6  COLUMN 41
              VALUE "-----------------------------".

       01  LEDGER-LIST-ROW.
           05  LINE CURRENT-LINE COLUMN 1  PIC X(19)
                                        FROM DISPLAY-DATE-TIME.
           05  LINE CURRENT-LINE COLUMN 21 PIC X(1)
                                        FROM LEDGER-STATUS.
           05  LINE CURRENT-LINE COLUMN 23 PIC -$$$$,$$$,$$9.99
                                        FROM LEDGER-AMOUNT.
           05  LINE CURRENT-LINE COLUMN 41 PIC X(30)
                                        FROM LEDGER-DESCRIPTION.

       01  ADD-LEDGER-SCREEN.
           05  LINE 5  COLUMN 1  VALUE "       Date: ".
           05  LINE 5  COLUMN 15 PIC X(20) FROM DISPLAY-DATE-TIME.
           05  LINE 6  COLUMN 1  VALUE "     Amount: ".
           05  LINE 6  COLUMN 15 PIC -$$$$,$$$,$$$.$$
                                 USING LEDGER-AMOUNT.
           05  LINE 7  COLUMN 1  VALUE "Description: ".
           05  LINE 7  COLUMN 15 PIC X(30) USING LEDGER-DESCRIPTION.
           05  LINE 8  COLUMN 1  VALUE "     Status: ".
           05  LINE 8  COLUMN 15 PIC X(1) USING LEDGER-STATUS.

       01  ADD-LEDGER-PROMPT.
           05  LINE 10 COLUMN 1  VALUE "Add Ledger Entry? (Y/N)".
           05  LINE 10 COLUMN 25 PIC Z USING CONTINUE-KEY AUTO.

       01  REPORT-FILE-SCREEN.
           05  BLANK SCREEN.
           05  LINE 1  COLUMN 1  VALUE "Report Filename:".
           05  LINE 1  COLUMN 19 PIC X(60) USING PRINTER-NAME.

       01  REPORT-FILE-PROMPT.
           05  LINE 3  COLUMN 1  VALUE "Print Report? (Y/N)".
           05  LINE 3  COLUMN 21 PIC Z USING CONTINUE-KEY AUTO.
           
       01  DEBUG-SCREEN.
           05  LINE CURRENT-LINE COLUMN 1  VALUE "File Status: ".
           05  LINE CURRENT-LINE COLUMN 15 PIC 9(2) FROM FILE-STATUS.
           05  LINE CURRENT-LINE COLUMN 20 PIC Z
                                        USING CONTINUE-KEY AUTO.
           
       PROCEDURE DIVISION.
      
       PROGRAM-BEGIN.
           PERFORM LOAD-CONTROL-FILE.
           PERFORM MAIN-PROCESS.
      
       PROGRAM-DONE.
           PERFORM WRITE-CONTROL-FILE.
           STOP RUN.

       MAIN-PROCESS.
           MOVE "N" TO END-OF-FILE.
           PERFORM INIT-ACCOUNT-RECORD.
           PERFORM INIT-LEDGER-RECORD.
           PERFORM MAIN-MENU.

       INIT-ACCOUNT-RECORD.
           MOVE SPACES TO ACCOUNT-RECORD.
           MOVE ZEROS TO ACCOUNT-ID.
           MOVE ZEROS TO ACCOUNT-VALUE.

       INIT-LEDGER-RECORD.
           MOVE ZEROS TO LEDGER-RECORD.
           MOVE SPACES TO LEDGER-DESCRIPTION.
           MOVE SPACE TO LEDGER-STATUS.

       INIT-CONTROL-RECORD.
           MOVE 1 TO NEXT-ACCOUNT-ID.

       GET-CURRENT-TIME.
           MOVE FUNCTION CURRENT-DATE TO NOW.
           MOVE NOW-YEAR TO DISPLAY-YEAR.
           MOVE NOW-MONTH TO DISPLAY-MONTH.
           MOVE NOW-DAY TO DISPLAY-DAY.
           MOVE NOW-HOUR TO DISPLAY-HOUR.
           MOVE NOW-MINUTE TO DISPLAY-MINUTE.
           MOVE NOW-SECOND TO DISPLAY-SECOND.

       LOAD-CONTROL-FILE.
           PERFORM INIT-CONTROL-RECORD.
           MOVE "N" TO END-OF-FILE.
           OPEN INPUT CONTROL-FILE.
           READ CONTROL-FILE NEXT RECORD
               AT END MOVE "Y" TO END-OF-FILE.
           CLOSE CONTROL-FILE.

       WRITE-CONTROL-FILE.
           OPEN OUTPUT CONTROL-FILE.
           WRITE CONTROL-RECORD.
           CLOSE CONTROL-FILE.
           
       MAIN-MENU.
           PERFORM MAIN-MENU-LOOP
               UNTIL MENU-OPTION IS EQUAL TO 9.

       MAIN-MENU-LOOP.
           MOVE ZERO TO MENU-OPTION.
           DISPLAY MAIN-MENU-SCREEN.
           ACCEPT MAIN-MENU-SCREEN.
           IF MENU-OPTION IS EQUAL TO 1
               PERFORM LIST-ACCOUNTS
           ELSE IF MENU-OPTION IS EQUAL TO 2
               PERFORM LEDGER-MENU
           ELSE IF MENU-OPTION IS EQUAL TO 3
               PERFORM UPDATE-ACCOUNTS
           ELSE IF MENU-OPTION IS EQUAL TO 4
               PERFORM ADD-ACCOUNT
           ELSE IF MENU-OPTION IS EQUAL TO 5
               PERFORM ACCOUNT-REPORT.

       DISPLAY-REPORT-PROMPT.
           DISPLAY REPORT-FILE-SCREEN.
           ACCEPT REPORT-FILE-SCREEN.
           DISPLAY REPORT-FILE-SCREEN.
           MOVE SPACES TO CONTINUE-KEY.
           PERFORM SHOW-REPORT-FILE-PROMPT
               UNTIL CONTINUE-KEY EQUALS "Y" OR "y"
               OR "N" OR "n".

       SHOW-REPORT-FILE-PROMPT.
           DISPLAY REPORT-FILE-PROMPT.
           ACCEPT REPORT-FILE-PROMPT.
               
       LIST-ACCOUNTS.
           MOVE "N" TO END-OF-FILE.
           OPEN INPUT ACCOUNT-FILE.
           DISPLAY LIST-ACCOUNT-SCREEN.
           MOVE 3 TO CURRENT-LINE.
           PERFORM RESET-ACCOUNT-FILE-POSITION.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               PERFORM DISPLAY-NEXT-ACCOUNT-LIST-ROW
                   UNTIL END-OF-FILE IS EQUAL TO "Y"
               ADD 1 TO CURRENT-LINE
               DISPLAY CONTINUE-PROMPT
               ACCEPT CONTINUE-PROMPT
           END-IF.
           CLOSE ACCOUNT-FILE.

       ACCOUNT-REPORT.
           PERFORM DISPLAY-REPORT-PROMPT.
           IF CONTINUE-KEY EQUALS "Y" OR "y"
               PERFORM PRINT-ACCOUNT-REPORT.

       PRINT-ACCOUNT-REPORT.
           MOVE "N" TO END-OF-FILE.
           OPEN INPUT ACCOUNT-FILE.
           PERFORM RESET-ACCOUNT-FILE-POSITION.
           OPEN OUTPUT REPORT-FILE.
           PERFORM WRITE-ACCOUNT-REPORT-HEADER.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               PERFORM WRITE-NEXT-ACCOUNT-REPORT-LINE
                   UNTIL END-OF-FILE IS EQUAL TO "Y".
           CLOSE REPORT-FILE.
           CLOSE ACCOUNT-FILE.

       WRITE-ACCOUNT-REPORT-HEADER.
           MOVE SPACES TO GENERIC-REPORT-LINE.
           PERFORM GET-CURRENT-TIME.
           MOVE FUNCTION CONCATENATE("Account Report - ",
               DISPLAY-DATE-TIME) TO GENERIC-REPORT-LINE.
           WRITE GENERIC-REPORT BEFORE ADVANCING 2.
           PERFORM WRITE-ACCOUNT-REPORT-SUB-HEADER.
           MOVE 5 TO CURRENT-LINE.

       WRITE-ACCOUNT-REPORT-SUB-HEADER.
           MOVE SPACES TO ACCOUNT-REPORT-HEADER.
           MOVE "Company" TO AH-COMPANY.
           MOVE "Number"  TO AH-NUMBER.
           MOVE "Type" TO AH-TYPE.
           MOVE "S" TO AH-STATUS.
           MOVE "Value" TO AH-VALUE.
           MOVE "Description" TO AH-DESCRIPTION.
           WRITE ACCOUNT-REPORT-HEADER BEFORE ADVANCING 1.
           MOVE ALL '-' TO AH-COMPANY.
           MOVE ALL "-" TO AH-NUMBER.
           MOVE ALL "-" TO AH-TYPE.
           MOVE ALL "-" TO AH-STATUS.
           MOVE ALL "-" TO AH-VALUE.
           MOVE ALL "-" TO AH-DESCRIPTION.
           WRITE ACCOUNT-REPORT-HEADER BEFORE ADVANCING 1.

       WRITE-ACCOUNT-REPORT-FOOTER.
           MOVE SPACES TO GENERIC-REPORT-LINE.
           WRITE GENERIC-REPORT BEFORE ADVANCING PAGE.
           
       WRITE-NEXT-ACCOUNT-REPORT-LINE.
           PERFORM READ-NEXT-ACCOUNT-RECORD.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               IF CURRENT-LINE IS GREATER THAN PRINTER-ROWS
                   PERFORM WRITE-ACCOUNT-REPORT-FOOTER
                   PERFORM WRITE-ACCOUNT-REPORT-HEADER
               END-IF
               PERFORM WRITE-ACCOUNT-REPORT-LINE
           END-IF.           
           
       WRITE-ACCOUNT-REPORT-LINE.
           MOVE SPACES TO ACCOUNT-REPORT-LINE.
           MOVE ZEROS TO AR-VALUE.
           MOVE ACCOUNT-COMPANY TO AR-COMPANY.
           MOVE ACCOUNT-NUMBER TO AR-NUMBER.
           MOVE ACCOUNT-TYPE TO AR-TYPE.
           MOVE ACCOUNT-DESCRIPTION TO AR-DESCRIPTION.
           MOVE ACCOUNT-STATUS TO AR-STATUS.
           MOVE ACCOUNT-VALUE TO AR-VALUE.
           WRITE ACCOUNT-REPORT-LINE BEFORE ADVANCING 1.
           ADD 1 TO CURRENT-LINE.
           
       RESET-ACCOUNT-FILE-POSITION.
           MOVE 1 TO ACCOUNT-ID.
           MOVE "N" TO END-OF-FILE.
           START ACCOUNT-FILE
               KEY IS GREATER THAN OR EQUAL TO ACCOUNT-ID
               INVALID KEY MOVE "Y" TO END-OF-FILE.

       DISPLAY-NEXT-ACCOUNT-LIST-ROW.
           PERFORM READ-NEXT-ACCOUNT-RECORD.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               IF CURRENT-LINE IS GREATER THAN SCREEN-ROWS
                   ADD 1 TO CURRENT-LINE
                   DISPLAY CONTINUE-PROMPT
                   ACCEPT CONTINUE-PROMPT
                   DISPLAY LIST-ACCOUNT-SCREEN
                   MOVE 3 TO CURRENT-LINE
               END-IF
               DISPLAY ACCOUNT-LIST-ROW
               ADD 1 TO CURRENT-LINE
           END-IF.
           
       READ-NEXT-ACCOUNT-RECORD.
           READ ACCOUNT-FILE NEXT RECORD
               AT END MOVE "Y" TO END-OF-FILE.
           
       SHOW-ADD-ACCOUNT-PROMPT.        
           DISPLAY ADD-ACCOUNT-PROMPT.
           ACCEPT ADD-ACCOUNT-PROMPT.
           
       ADD-ACCOUNT.
           PERFORM INIT-ACCOUNT-RECORD.
           MOVE NEXT-ACCOUNT-ID TO ACCOUNT-ID.
           DISPLAY ADD-ACCOUNT-SCREEN.
           ACCEPT ADD-ACCOUNT-SCREEN.
           DISPLAY ADD-ACCOUNT-SCREEN.
           MOVE SPACES TO CONTINUE-KEY.
           PERFORM SHOW-ADD-ACCOUNT-PROMPT
               UNTIL CONTINUE-KEY EQUALS "Y" OR "y"
               OR "N" OR "n".
           IF CONTINUE-KEY EQUALS "Y" OR "y"
               PERFORM WRITE-ACCOUNT
               PERFORM CREATE-LEDGER-FILE
               ADD 1 TO NEXT-ACCOUNT-ID
               PERFORM WRITE-CONTROL-FILE
           END-IF.

       WRITE-ACCOUNT.
           OPEN I-O ACCOUNT-FILE.
           IF FILE-STATUS IS EQUAL TO FILE-NOT-FOUND
               CLOSE ACCOUNT-FILE
               OPEN OUTPUT ACCOUNT-FILE
           END-IF.
           WRITE ACCOUNT-RECORD
               INVALID KEY REWRITE ACCOUNT-RECORD.
           CLOSE ACCOUNT-FILE.
               
       UPDATE-ACCOUNTS.
           MOVE "N" TO END-OF-FILE.
           OPEN I-O ACCOUNT-FILE.
           PERFORM RESET-ACCOUNT-FILE-POSITION.
           PERFORM UPDATE-NEXT-ACCOUNT
               UNTIL END-OF-FILE IS EQUAL TO "Y".

       UPDATE-NEXT-ACCOUNT.
           PERFORM READ-NEXT-ACCOUNT-RECORD.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               PERFORM UPDATE-CURRENT-ACCOUNT
               REWRITE ACCOUNT-RECORD
           END-IF.

       UPDATE-CURRENT-ACCOUNT.
           MOVE ZEROS TO ACCOUNT-VALUE.
           MOVE SPACE TO ACCOUNT-STATUS.
           MOVE "N" TO END-OF-FILE.
           OPEN INPUT LEDGER-FILE.
           PERFORM UPDATE-CURRENT-ACCOUNT-LOOP
               UNTIL END-OF-FILE IS EQUAL TO "Y".
           CLOSE LEDGER-FILE.
           MOVE "N" TO END-OF-FILE.

       UPDATE-CURRENT-ACCOUNT-LOOP.
           PERFORM READ-NEXT-LEDGER-RECORD.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               PERFORM UPDATE-ACCOUNT-FROM-LEDGER.

       UPDATE-ACCOUNT-FROM-LEDGER.
           ADD LEDGER-AMOUNT TO ACCOUNT-VALUE.
           IF LEDGER-STATUS IS NOT EQUAL TO SPACE
               MOVE LEDGER-STATUS TO ACCOUNT-STATUS.
               
       LOAD-ACCOUNT.
           PERFORM INIT-ACCOUNT-RECORD.
           MOVE "N" TO ACCOUNT-LOADED.
           MOVE 0 to ACCOUNT-ID.
           DISPLAY LOAD-ACCOUNT-SCREEN.
           ACCEPT LOAD-ACCOUNT-SCREEN.
           DISPLAY LOAD-ACCOUNT-SCREEN.
           IF ACCOUNT-ID IS NOT EQUAL TO 0
               OPEN INPUT ACCOUNT-FILE
               IF FILE-STATUS IS NOT EQUAL TO FILE-NOT-FOUND
                   MOVE "Y" TO ACCOUNT-LOADED
                   READ ACCOUNT-FILE
                       INVALID KEY MOVE "N" TO ACCOUNT-LOADED
                   END-READ
               END-IF
               CLOSE ACCOUNT-FILE
           END-IF.

       LEDGER-MENU.
           PERFORM LOAD-ACCOUNT.
           IF ACCOUNT-LOADED IS EQUAL TO "Y"
               MOVE ZERO TO MENU-OPTION
               PERFORM LEDGER-MENU-LOOP
                   UNTIL MENU-OPTION IS EQUAL TO 9
           END-IF.
           MOVE ZERO TO MENU-OPTION.

       LEDGER-MENU-LOOP.
           MOVE ZERO TO MENU-OPTION.
           PERFORM DISPLAY-LEDGER-ACCOUNT-HEADER.
           DISPLAY LEDGER-MENU-SCREEN.
           ACCEPT LEDGER-MENU-SCREEN.
           IF MENU-OPTION IS EQUAL TO 1
               PERFORM LIST-LEDGER
           ELSE IF MENU-OPTION IS EQUAL TO 2
               PERFORM ADD-LEDGER
           ELSE IF MENU-OPTION IS EQUAL TO 3
               PERFORM UPDATE-CURRENT-ACCOUNT
               PERFORM WRITE-ACCOUNT
           ELSE IF MENU-OPTION IS EQUAL TO 4
               PERFORM LEDGER-REPORT.    

       DISPLAY-LEDGER-ACCOUNT-HEADER.
           DISPLAY LIST-ACCOUNT-SCREEN.
           MOVE 3 TO CURRENT-LINE.
           DISPLAY ACCOUNT-LIST-ROW.
               
       CREATE-LEDGER-FILE.
           OPEN OUTPUT LEDGER-FILE.
           PERFORM INIT-LEDGER-RECORD.
           PERFORM CURRENT-TIME-TO-LEDGER-TIME.
           MOVE "Initial Balance" TO LEDGER-DESCRIPTION.
           MOVE ACCOUNT-VALUE TO LEDGER-AMOUNT.
           MOVE ACCOUNT-STATUS TO LEDGER-STATUS.
           WRITE LEDGER-RECORD.
           CLOSE LEDGER-FILE.

       READ-NEXT-LEDGER-RECORD.
           READ LEDGER-FILE NEXT RECORD
               AT END MOVE "Y" TO END-OF-FILE.
           PERFORM LEDGER-DATE-TO-DISPLAY-DATE.

       CURRENT-TIME-TO-LEDGER-TIME.
           PERFORM GET-CURRENT-TIME.
           MOVE NOW-DATE-TIME TO LEDGER-DATE-TIME.
           
       LEDGER-DATE-TO-DISPLAY-DATE.
           MOVE LEDGER-DATE-YEAR TO DISPLAY-YEAR.
           MOVE LEDGER-DATE-MONTH TO DISPLAY-MONTH.
           MOVE LEDGER-DATE-DAY TO DISPLAY-DAY.
           MOVE LEDGER-TIME-HOUR TO DISPLAY-HOUR.
           MOVE LEDGER-TIME-MIN TO DISPLAY-MINUTE.
           MOVE LEDGER-TIME-SEC TO DISPLAY-SECOND.
                                  
       LIST-LEDGER.
           OPEN INPUT LEDGER-FILE.
           MOVE "N" TO END-OF-FILE.
           PERFORM DISPLAY-LEDGER-HEADER.
           PERFORM DISPLAY-NEXT-LEDGER-ROW
               UNTIL END-OF-FILE EQUALS "Y".
           CLOSE LEDGER-FILE.
           ADD 1 TO CURRENT-LINE.
           DISPLAY CONTINUE-PROMPT.
           ACCEPT CONTINUE-PROMPT.

       DISPLAY-LEDGER-HEADER.
           PERFORM DISPLAY-LEDGER-ACCOUNT-HEADER.
           DISPLAY LIST-LEDGER-SCREEN.
           MOVE 7 TO CURRENT-LINE.

       DISPLAY-NEXT-LEDGER-ROW.
           PERFORM READ-NEXT-LEDGER-RECORD.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               IF CURRENT-LINE IS GREATER THAN SCREEN-ROWS
                   ADD 1 TO CURRENT-LINE
                   DISPLAY CONTINUE-PROMPT
                   ACCEPT CONTINUE-PROMPT
                   PERFORM DISPLAY-LEDGER-HEADER
               END-IF
               DISPLAY LEDGER-LIST-ROW
               ADD 1 TO CURRENT-LINE
           END-IF.

       LEDGER-REPORT.
           PERFORM DISPLAY-REPORT-PROMPT.
           IF CONTINUE-KEY EQUALS "Y" OR "y"
               PERFORM PRINT-LEDGER-REPORT.

       PRINT-LEDGER-REPORT.
           MOVE "N" TO END-OF-FILE.
           OPEN INPUT LEDGER-FILE.
           OPEN OUTPUT REPORT-FILE.
           PERFORM WRITE-LEDGER-REPORT-HEADER.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               PERFORM WRITE-NEXT-LEDGER-REPORT-LINE
                   UNTIL END-OF-FILE IS EQUAL TO "Y".
           CLOSE REPORT-FILE.
           CLOSE LEDGER-FILE.

       WRITE-LEDGER-REPORT-HEADER.
           MOVE SPACES TO GENERIC-REPORT-LINE.
           PERFORM GET-CURRENT-TIME.
           MOVE FUNCTION CONCATENATE("Ledger Report - ",
               DISPLAY-DATE-TIME) TO GENERIC-REPORT-LINE.
           WRITE GENERIC-REPORT BEFORE ADVANCING 2.
           PERFORM WRITE-ACCOUNT-REPORT-SUB-HEADER.
           MOVE 5 TO CURRENT-LINE.
           PERFORM WRITE-ACCOUNT-REPORT-LINE.
           MOVE SPACES TO LEDGER-REPORT-HEADER.
           WRITE LEDGER-REPORT-HEADER BEFORE ADVANCING 1.
           MOVE "Date" TO LH-DATE-TIME.
           MOVE "Description" TO LH-DESCRIPTION.
           MOVE "S" TO LH-STATUS.
           MOVE "Value" TO LH-AMOUNT.
           WRITE LEDGER-REPORT-HEADER BEFORE ADVANCING 1.
           MOVE ALL '-' TO LH-DATE-TIME.
           MOVE ALL "-" TO LH-DESCRIPTION.
           MOVE ALL "-" TO LH-STATUS.
           MOVE ALL "-" TO LH-AMOUNT.
           WRITE LEDGER-REPORT-HEADER BEFORE ADVANCING 1.
           MOVE 8 TO CURRENT-LINE.

       WRITE-LEDGER-REPORT-FOOTER.
           MOVE SPACES TO GENERIC-REPORT-LINE.
           WRITE GENERIC-REPORT BEFORE ADVANCING PAGE.
           
       WRITE-NEXT-LEDGER-REPORT-LINE.
           PERFORM READ-NEXT-LEDGER-RECORD.
           IF END-OF-FILE IS NOT EQUAL TO "Y"
               IF CURRENT-LINE IS GREATER THAN PRINTER-ROWS
                   PERFORM WRITE-LEDGER-REPORT-FOOTER
                   PERFORM WRITE-LEDGER-REPORT-HEADER
               END-IF
               PERFORM WRITE-LEDGER-REPORT-LINE
           END-IF.           
           
       WRITE-LEDGER-REPORT-LINE.
           MOVE SPACES TO LEDGER-REPORT-LINE.
           MOVE ZEROS TO LR-AMOUNT.
           PERFORM LEDGER-DATE-TO-DISPLAY-DATE.
           MOVE DISPLAY-DATE-TIME TO LR-DATE-TIME.
           MOVE LEDGER-DESCRIPTION TO LR-DESCRIPTION.
           MOVE LEDGER-STATUS TO LR-STATUS.
           MOVE LEDGER-AMOUNT TO LR-AMOUNT.
           WRITE LEDGER-REPORT-LINE BEFORE ADVANCING 1.
           ADD 1 TO CURRENT-LINE.
           
       ADD-LEDGER.
           PERFORM DISPLAY-LEDGER-ACCOUNT-HEADER.
           PERFORM INIT-LEDGER-RECORD.
           DISPLAY ADD-LEDGER-SCREEN.
           ACCEPT ADD-LEDGER-SCREEN.
           PERFORM CURRENT-TIME-TO-LEDGER-TIME.
           PERFORM LEDGER-DATE-TO-DISPLAY-DATE.
           DISPLAY ADD-LEDGER-SCREEN.
           MOVE SPACES TO CONTINUE-KEY.
           PERFORM SHOW-ADD-LEDGER-PROMPT
               UNTIL CONTINUE-KEY EQUALS "Y" OR "y"
               OR "N" OR "n".
           IF CONTINUE-KEY EQUALS "Y" OR "y"
               OPEN EXTEND LEDGER-FILE
               WRITE LEDGER-RECORD
               CLOSE LEDGER-FILE
               PERFORM UPDATE-ACCOUNT-FROM-LEDGER
               PERFORM WRITE-ACCOUNT
           END-IF.

       SHOW-ADD-LEDGER-PROMPT.        
           DISPLAY ADD-LEDGER-PROMPT.
           ACCEPT ADD-LEDGER-PROMPT.        
