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
       PROGRAM-ID. PHONE.
       AUTHOR. Andrew Young.

      ***********************************************************
      * This program maintains a simple phone number data file. *
      ***********************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT OPTIONAL PHONE-FILE
                   ASSIGN TO "phone"
                   ORGANIZATION IS INDEXED
                   RECORD KEY IS PHONE-ID
                   ACCESS MODE IS DYNAMIC.

       DATA DIVISION.
       FILE SECTION.

       FD  PHONE-FILE
           LABEL RECORDS ARE STANDARD.
       01  PHONE-RECORD.
           05 PHONE-ID                  PIC 9(4) VALUE ZEROS.
           05 PHONE-LAST-NAME           PIC X(20) VALUE SPACES.
           05 PHONE-FIRST-NAME          PIC X(15) VALUE SPACES.
           05 PHONE-NUMBER              PIC X(15) VALUE SPACES.

       WORKING-STORAGE SECTION.
       01  DISPLAY-LINE.
           05  DISPLAY-PHONE-ID         PIC 9(4) VALUE ZEROS.
           05  FILLER                   PIC X(1) VALUE SPACES.
           05  PROMPT-LAST-NAME         PIC X(11) VALUE
               "Last Name: ".
           05  DISPLAY-LAST-NAME        PIC X(20) VALUE SPACES.
           05  FILLER                   PIC X(1) VALUE SPACES.
           05  PROMPT-FIRST-NAME        PIC X(12) VALUE
               "First Name: ".
           05  DISPLAY-FIRST-NAME       PIC X(15) VALUE SPACES.
           05  FILLER                   PIC X(1) VALUE SPACES.
           05  PROMPT-NUMBER            PIC X(8) VALUE "Number: ".
           05  DISPLAY-NUMBER           PIC X(15) VALUE SPACES.

       01  PROMPT-PHONE-ID              PIC X(15) VALUE
           "Record Number: ".

       01  PROMPT-DELETE                PIC X(21) VALUE
           "Delete Record? (Y/N) ".

       01  PAGER                        PIC X(13) VALUE
           "[Press Enter]".

       01  COMMAND-PROMPT               PIC X(65) VALUE
           "Command ([A]dd, [R]emove, [U]pdate, [L]ist, [D]isplay,
      -    " [Q]uit): ".
       01  CMD                          PIC X VALUE SPACES.
       01  ENTRY-OK                     PIC X VALUE SPACES.
       01  CONFIRM-DELETE               PIC X VALUE SPACES.
       01  END-OF-FILE                  PIC X VALUE SPACES.
       01  MAX-SCREEN-LINES             PIC 999 VALUE 24.
       01  SCREEN-LINES                 PIC 999 VALUE ZEROS.
       01  ANY-KEY                      PIC X VALUE SPACES.
       01  MAX-PHONE-ID                 PIC 9(4) VALUE ZEROS.
       01  DUPLICATE-FLAG               PIC X VALUE SPACES.
       01  RECORD-NOT-FOUND             PIC X VALUE SPACES.
       01  REWRITE-ERROR                PIC X VALUE SPACES.
       01  DELETE-ERROR                 PIC X VALUE SPACES.

       01  MSG-COMMAND-NOT-FOUND        PIC X(17) VALUE
           "Command Not Found".
       01  MSG-NOT-IMPLEMENTED          PIC X(15) VALUE
           "Not Implemented".
       01  MSG-LAST-NAME-REQUIRED       PIC X(25) VALUE
           "Error: Last Name Required".
       01  MSG-RECORD-NOT-FOUND         PIC X(23) VALUE
           "Error: Record Not Found".
       01  MSG-REWRITE-ERROR            PIC X(21) VALUE
           "Error: Rewrite Failed".
       01  MSG-DELETE-ERROR             PIC X(20) VALUE
           "Error: Delete Failed".
       01  MSG-START-ERROR              PIC X(30) VALUE
           "Error: Could Not Restart File.".

       PROCEDURE DIVISION.

       MAIN-LOGIC SECTION.
       PROGRAM-BEGIN.
           PERFORM OPEN-FILES.
           PERFORM LIST-RECORDS.
           MOVE SPACES TO CMD
           PERFORM COMMAND-LOOP
                UNTIL CMD IS EQUAL TO "Q".
           PERFORM CLOSE-FILES.

       PROGRAM-DONE.
           STOP RUN.

       OPEN-FILES.
           OPEN I-O PHONE-FILE.

       CLOSE-FILES.
           CLOSE PHONE-FILE.

       COMMAND-LOOP.
           DISPLAY COMMAND-PROMPT.
           ACCEPT CMD.
           IF CMD IS EQUAL TO "A" OR "a"
                PERFORM ADD-RECORD
           ELSE IF CMD IS EQUAL TO "R" OR "r"
                PERFORM REMOVE-RECORD
           ELSE IF CMD IS EQUAL TO "U" OR "u"
                PERFORM UPDATE-RECORD
           ELSE IF CMD IS EQUAL TO "L" OR "l"
                PERFORM LIST-RECORDS
           ELSE IF CMD IS EQUAL TO "D" OR "d"
                PERFORM DISPLAY-RECORD
           ELSE IF CMD IS EQUAL TO "Q" OR "q"
                MOVE "Q" TO CMD
           ELSE
                DISPLAY MSG-COMMAND-NOT-FOUND.

       LIST-RECORDS.
           MOVE ZEROS TO SCREEN-LINES.
           MOVE "N" TO END-OF-FILE.
           PERFORM RESET-FILE-POSITION.
           PERFORM READ-NEXT-RECORD.
           PERFORM DISPLAY-RECORDS
                UNTIL END-OF-FILE IS EQUAL TO "Y".

       DISPLAY-RECORDS.
           IF SCREEN-LINES IS EQUAL TO MAX-SCREEN-LINES
                PERFORM PRESS-ENTER.
           PERFORM DISPLAY-CURRENT-RECORD.
           ADD 1 TO SCREEN-LINES.
           PERFORM READ-NEXT-RECORD.

       DISPLAY-CURRENT-RECORD.
           MOVE PHONE-ID TO DISPLAY-PHONE-ID.
           MOVE PHONE-LAST-NAME to DISPLAY-LAST-NAME.
           MOVE PHONE-FIRST-NAME TO DISPLAY-FIRST-NAME.
           MOVE PHONE-NUMBER TO DISPLAY-NUMBER.
           DISPLAY DISPLAY-LINE.

       RESET-FILE-POSITION.
           MOVE ZEROS TO PHONE-ID.
           START PHONE-FILE KEY IS GREATER THAN OR EQUAL TO PHONE-ID
                INVALID KEY
                   DISPLAY MSG-START-ERROR.

       UPDATE-MAX-PHONE-ID.
           IF PHONE-ID IS GREATER THAN MAX-PHONE-ID THEN
                MOVE PHONE-ID TO MAX-PHONE-ID.

       READ-NEXT-RECORD.
           READ PHONE-FILE NEXT RECORD
                AT END MOVE "Y" TO END-OF-FILE.
           PERFORM UPDATE-MAX-PHONE-ID.

       PRESS-ENTER.
           DISPLAY PAGER.
           ACCEPT ANY-KEY.
           MOVE ZEROES TO SCREEN-LINES.

       ADD-RECORD.
           MOVE "N" TO ENTRY-OK.
           MOVE SPACE TO PHONE-RECORD.
           MOVE MAX-PHONE-ID TO PHONE-ID.
           PERFORM GET-FIELDS.
           IF ENTRY-OK IS EQUAL TO "Y"
                MOVE "Y" TO DUPLICATE-FLAG
                PERFORM WRITE-NEW-RECORD
                   UNTIL DUPLICATE-FLAG IS NOT EQUAL TO "Y".

       WRITE-NEW-RECORD.
           ADD 1 TO PHONE-ID.
           PERFORM WRITE-RECORD.

       GET-FIELDS.
           DISPLAY PROMPT-LAST-NAME.
           ACCEPT PHONE-LAST-NAME.
           DISPLAY PROMPT-FIRST-NAME.
           ACCEPT PHONE-FIRST-NAME.
           DISPLAY PROMPT-NUMBER.
           ACCEPT PHONE-NUMBER.
           PERFORM VALIDATE-FIELDS.

       VALIDATE-FIELDS.
           MOVE "Y" TO ENTRY-OK.
           IF PHONE-LAST-NAME IS EQUAL TO SPACES
                DISPLAY MSG-LAST-NAME-REQUIRED
                MOVE "N" TO ENTRY-OK.

       WRITE-RECORD.
           MOVE "N" TO DUPLICATE-FLAG.
           WRITE PHONE-RECORD
                INVALID KEY
                   MOVE "Y" TO DUPLICATE-FLAG.
           IF DUPLICATE-FLAG IS NOT EQUAL TO "Y" THEN
                PERFORM UPDATE-MAX-PHONE-ID.

       REWRITE-RECORD.
           MOVE "N" TO REWRITE-ERROR.
           REWRITE PHONE-RECORD
                INVALID KEY
                   MOVE "Y" TO REWRITE-ERROR.
           IF REWRITE-ERROR IS EQUAL TO "Y" THEN
                DISPLAY MSG-REWRITE-ERROR
           ELSE
                PERFORM UPDATE-MAX-PHONE-ID.

       DELETE-RECORD.
           MOVE "N" TO DELETE-ERROR.
           DELETE PHONE-FILE
                INVALID KEY
                   MOVE "Y" TO DELETE-ERROR.
           IF DELETE-ERROR IS EQUAL TO "Y" THEN
                DISPLAY MSG-DELETE-ERROR.

       CONFIRM-DELETE-RECORD.
           MOVE SPACES TO CONFIRM-DELETE.
           PERFORM DISPLAY-CURRENT-RECORD.
           PERFORM PROMPT-CONFIRM-DELETE
                UNTIL CONFIRM-DELETE IS EQUAL TO "Y" OR "N".
           IF CONFIRM-DELETE IS EQUAL TO "Y" THEN
                PERFORM DELETE-RECORD.

       PROMPT-CONFIRM-DELETE.
           DISPLAY PROMPT-DELETE.
           ACCEPT CONFIRM-DELETE.
           IF CONFIRM-DELETE IS EQUAL TO "y" THEN
                MOVE "Y" TO CONFIRM-DELETE.
           IF CONFIRM-DELETE IS EQUAL TO "n" THEN
                MOVE "N" TO CONFIRM-DELETE.

       LOAD-RECORD.
           MOVE "N" TO RECORD-NOT-FOUND.
           DISPLAY PROMPT-PHONE-ID.
           ACCEPT PHONE-ID.
           READ PHONE-FILE RECORD
                INVALID KEY
                   MOVE "Y" TO RECORD-NOT-FOUND
                   DISPLAY MSG-RECORD-NOT-FOUND.

       DISPLAY-RECORD.
           PERFORM LOAD-RECORD.
           IF RECORD-NOT-FOUND IS NOT EQUAL TO "Y" THEN
                PERFORM DISPLAY-CURRENT-RECORD.

       REMOVE-RECORD.
           PERFORM LOAD-RECORD.
           IF RECORD-NOT-FOUND IS NOT EQUAL TO "Y" THEN
                PERFORM CONFIRM-DELETE-RECORD.

       UPDATE-RECORD.
           PERFORM LOAD-RECORD.
           IF RECORD-NOT-FOUND IS NOT EQUAL TO "Y" THEN
                PERFORM GET-FIELDS
                IF ENTRY-OK IS EQUAL TO "Y"
                   PERFORM REWRITE-RECORD.
