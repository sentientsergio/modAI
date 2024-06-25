      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      * 2020-02-11  1.0.1    Add BANK and PHONE numbers
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.             FAKER.

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
      /
       DATA DIVISION.
      *==============

       FILE SECTION.
      *-------------

       WORKING-STORAGE SECTION.
      *------------------------

       01  W-FAKER-PROVIDER        PIC X(12).
       01  W-FAKRAND-PROG          PIC X(08)       VALUE 'FAKRAND'.
       01  W-FAKADDR-PROG          PIC X(08)       VALUE 'FAKADDR'.
       01  W-FAKBANK-PROG          PIC X(08)       VALUE 'FAKBANK'.
       01  W-FAKCOMP-PROG          PIC X(08)       VALUE 'FAKCOMP'.
       01  W-FAKPERS-PROG          PIC X(08)       VALUE 'FAKPERS'.
       01  W-FAKPHON-PROG          PIC X(08)       VALUE 'FAKPHON'.
       01  W-FAKTXID-PROG          PIC X(08)       VALUE 'FAKTXID'.

       01  FILLER                  PIC X(01)       VALUE 'Y'.
           88  W-FIRST-CALL                        VALUE 'Y'.
           88  W-NOT-FIRST-CALL                    VALUE 'N'.

       01  W-COMPILED-DATE.
           05  W-COMPILED-DATE-YYYY
                                   PIC X(04).
           05  W-COMPILED-DATE-MM  PIC X(02).
           05  W-COMPILED-DATE-DD  PIC X(02).
           05  W-COMPILED-TIME-HH  PIC X(02).
           05  W-COMPILED-TIME-MM  PIC X(02).
           05  W-COMPILED-TIME-SS  PIC X(02).
           05  FILLER              PIC X(07).

       01  W-FAKRAND-PARAMETER.    COPY FAKRANDL.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY FAKERLNK.
      /
       PROCEDURE DIVISION USING L-PARAMETER.
      *==================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT

           PERFORM SUB-3000-SHUT-DOWN THRU SUB-3000-EXIT
           .
       MAIN-EXIT.
           GOBACK.
      /
       SUB-1000-START-UP.
      *------------------

           SET  FAKER-RESPONSE-GOOD
                                   TO TRUE
           MOVE SPACES             TO FAKER-RESPONSE-MSG
                                      FAKER-RESULT
                                      FAKER-RESULT-FIELDS
           MOVE 0                  TO FAKER-INFO-CNT
           MOVE LOW-VALUES         TO FAKER-INFO-OCCS

           IF      FAKER-SEED-NO > 0
           OR      FAKER-SEED-TEXT NOT = SPACES
               PERFORM SUB-9100-CALL-FAKRAND THRU SUB-9100-EXIT
           END-IF

           IF      W-NOT-FIRST-CALL
               GO TO SUB-1000-EXIT
           END-IF

           SET W-NOT-FIRST-CALL    TO TRUE
           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'FAKER    compiled on '
               W-COMPILED-DATE-YYYY '/'
               W-COMPILED-DATE-MM   '/'
               W-COMPILED-DATE-DD   ' at '
               W-COMPILED-TIME-HH   ':'
               W-COMPILED-TIME-MM   ':'
               W-COMPILED-TIME-SS
           .
       SUB-1000-EXIT.
           EXIT.
      /
       SUB-2000-PROCESS.
      *-----------------
           
           UNSTRING FAKER-PROVIDER-FUNCTION
                            DELIMITED '-'
                                 INTO W-FAKER-PROVIDER

           EVALUATE W-FAKER-PROVIDER
             WHEN 'ADDRESS'
               CALL W-FAKADDR-PROG
                                USING L-PARAMETER
             WHEN 'BANK'
               CALL W-FAKBANK-PROG
                                USING L-PARAMETER
             WHEN 'COMPANY'
               CALL W-FAKCOMP-PROG
                                USING L-PARAMETER
             WHEN 'PERSON'
               CALL W-FAKPERS-PROG
                                USING L-PARAMETER
             WHEN 'TAXID'
               CALL W-FAKTXID-PROG
                                USING L-PARAMETER
             WHEN 'TELEPHONE'
               CALL W-FAKPHON-PROG
                                USING L-PARAMETER
             WHEN OTHER
               SET  FAKER-UNKNOWN-PROVIDER
                                   TO TRUE
               STRING 'Unknown FAKER provider "'
                       W-FAKER-PROVIDER
                       '"'  DELIMITED SIZE
                                 INTO FAKER-RESPONSE-MSG
           END-EVALUATE
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

      D    IF      FAKER-RESPONSE-GOOD
      D        DISPLAY 'FAKER completed successfully'
      D    ELSE
      D        DISPLAY 'FAKER ended with error '
      D                FAKER-RESPONSE-CODE
      D                ': '
      D                FAKER-RESPONSE-MSG
      D    END-IF
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9100-CALL-FAKRAND.
      *----------------------

           MOVE FAKER-SEED-NO      TO FAKRAND-SEED-NO
           MOVE FAKER-SEED-TEXT    TO FAKRAND-SEED-TEXT

           CALL W-FAKRAND-PROG  USING W-FAKRAND-PARAMETER 

           MOVE 0                  TO FAKER-SEED-NO
           MOVE SPACES             TO FAKER-SEED-TEXT
           .
       SUB-9100-EXIT.
           EXIT.
