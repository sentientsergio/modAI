      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.             FAKERTST.

       ENVIRONMENT DIVISION.
      *=====================

       CONFIGURATION SECTION.
      *----------------------

       SOURCE-COMPUTER.
           IBM-Z15.
      *    IBM-Z15 DEBUGGING MODE.

       INPUT-OUTPUT SECTION.
      *---------------------

       FILE-CONTROL.
           SELECT TESTINPT             ASSIGN 'Data\FAKERTST Input.txt'
                                       ORGANIZATION LINE SEQUENTIAL. 

           SELECT TESTOUTP             ASSIGN 'Data\FAKERTST Output.txt'
                                       ORGANIZATION LINE SEQUENTIAL. 
      /
       DATA DIVISION.
      *==============

       FILE SECTION.
      *-------------

       FD  TESTINPT.

       01  TESTINPT-REC.
           05  TI-PROVIDER-FUNCTION
                                   PIC X(30).
           05  TI-COUNT            PIC 9(06). 

       FD  TESTOUTP.

       01  TESTOUTP-REC.
           05  TO-PROVIDER-FUNCTION
                                   PIC X(30).
           05  TO-COLON            PIC X(02). 
           05  TO-FAKER-RESULT     PIC X(80). 

       WORKING-STORAGE SECTION.
      *------------------------

       01  W-TESTINPT-RECS         PIC 9(09)  COMP VALUE 0.
       01  W-TESTOUTP-RECS         PIC 9(09)  COMP VALUE 0.
       01  W-TEST-CNT              PIC 9(09)  COMP.
       01  W-DISP-NUM              PIC ZZ,ZZ9.
       01  W-FAKER-PROG            PIC X(08)       VALUE 'FAKER'.

       01  W-ERROR-MSG             PIC X(21)       VALUE
           '**** FAKERTST error: '.

       01  FILLER                  PIC X(01)       VALUE 'N'.
           88  W-EOF                               VALUE 'Y'.

       01  W-COMPILED-DATE.
           05  W-COMPILED-DATE-YYYY
                                   PIC X(04).
           05  W-COMPILED-DATE-MM  PIC X(02).
           05  W-COMPILED-DATE-DD  PIC X(02).
           05  W-COMPILED-TIME-HH  PIC X(02).
           05  W-COMPILED-TIME-MM  PIC X(02).
           05  W-COMPILED-TIME-SS  PIC X(02).
           05  FILLER              PIC X(07).

       01  W-FAKER-PARAMETER.      COPY FAKERLNK.
      /
       PROCEDURE DIVISION.
      *===================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-9100-READ-TESTINPT THRU SUB-9100-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT
               UNTIL W-EOF

           PERFORM SUB-3000-SHUT-DOWN THRU SUB-3000-EXIT
           .
       MAIN-EXIT.
           STOP RUN.
      /
       SUB-1000-START-UP.
      *------------------

           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'FAKERTST compiled on '
               W-COMPILED-DATE-YYYY '/'
               W-COMPILED-DATE-MM   '/'
               W-COMPILED-DATE-DD   ' at '
               W-COMPILED-TIME-HH   ':'
               W-COMPILED-TIME-MM   ':'
               W-COMPILED-TIME-SS

           OPEN INPUT  TESTINPT
                OUTPUT TESTOUTP
           .
       SUB-1000-EXIT.
           EXIT.
      /
       SUB-2000-PROCESS.
      *-----------------

           MOVE TI-PROVIDER-FUNCTION
                                   TO FAKER-PROVIDER-FUNCTION

           IF      TI-COUNT NUMERIC
               MOVE TI-COUNT       TO W-TEST-CNT
           ELSE
               MOVE 1              TO W-TEST-CNT
           END-IF
           
           PERFORM SUB-2100-CALL-FAKER THRU SUB-2100-EXIT
               W-TEST-CNT TIMES
           .
       SUB-2000-READ.

           PERFORM SUB-9100-READ-TESTINPT THRU SUB-9100-EXIT
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-2100-CALL-FAKER.
      *--------------------

           CALL W-FAKER-PROG    USING W-FAKER-PARAMETER 

           IF      FAKER-RESPONSE-GOOD
               MOVE TI-PROVIDER-FUNCTION
                                   TO TO-PROVIDER-FUNCTION
               MOVE ': '           TO TO-COLON
               MOVE FAKER-RESULT   TO TO-FAKER-RESULT

               PERFORM SUB-9200-WRITE-TESTOUTP THRU SUB-9200-EXIT

               IF      ADDRESS-ADDRESS
               OR      PERSON-NAME
               OR      PERSON-NAME-MALE
               OR      PERSON-NAME-FEMALE
                   MOVE SPACES     TO TO-PROVIDER-FUNCTION
                   MOVE ': '       TO TO-COLON
                   MOVE FAKER-RESULT-FIELDS
                                   TO TO-FAKER-RESULT

                   PERFORM SUB-9200-WRITE-TESTOUTP THRU SUB-9200-EXIT
               END-IF
           ELSE
               DISPLAY W-ERROR-MSG
                       FAKER-RESPONSE-CODE
                       ' - '
                       FAKER-RESPONSE-MSG
           END-IF

      D    PERFORM VARYING FI-DX FROM 1 BY 1
      D              UNTIL FI-DX > FAKER-INFO-CNT
      D        DISPLAY '    INFO: '
      D                FAKER-TABLE(FI-DX)
      D                ': '
      D                FAKER-RANDOM-NO-SUB(FI-DX)
      D                ', '
      D                FAKER-TABLE-ENTRY(FI-DX)
      D    END-PERFORM
           .
       SUB-2100-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------
      
           CLOSE TESTINPT
                 TESTOUTP

           MOVE W-TESTINPT-RECS    TO W-DISP-NUM
           DISPLAY 'TESTINPT records read:    '
                   W-DISP-NUM

           MOVE W-TESTOUTP-RECS    TO W-DISP-NUM
           DISPLAY 'TESTOUTP records written: '
                   W-DISP-NUM

           DISPLAY 'FAKERTST completed'
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9100-READ-TESTINPT.
      *-----------------------
      
           READ TESTINPT
               AT END
                   SET  W-EOF      TO TRUE
               NOT AT END
                   ADD  1          TO W-TESTINPT-RECS
           END-READ
           .
       SUB-9100-EXIT.
           EXIT.
      /
       SUB-9200-WRITE-TESTOUTP.
      *------------------------
      
           WRITE TESTOUTP-REC

           ADD  1                  TO W-TESTOUTP-RECS
           .
       SUB-9200-EXIT.
           EXIT.
