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

       PROGRAM-ID.             FAKRAND.

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

       01  W-MAX-SEED-NO           PIC 9(9)   COMP VALUE 2147483645.
       01  W-SEED-NO               PIC 9(9)   COMP.
       01  W-RANDOM-NO             PIC V9(9)  COMP.
       01  W-SUB                   PIC S9(04) COMP.
       01  W-CRC32-PROG            PIC X(08)       VALUE 'CRC32'.

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

       01  W-CURRENT-DATE.
           05  W-CURRENT-YYYY-MM-DD
                                   PIC 9(08).
           05  W-CURRENT-HH-MM-SS-HS
                                   PIC 9(08).
           05  FILLER              PIC X(05).

       01  W-CRC32-PARAMETER.      COPY CRC32L.
      /
       LINKAGE SECTION.
      *----------------
      
       01  L-PARAMETER.          COPY FAKRANDL.
      /
       PROCEDURE DIVISION USING L-PARAMETER.
      *==================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT
           .
       MAIN-EXIT.
           GOBACK.
      /
       SUB-1000-START-UP.
      *------------------
      
           IF      W-NOT-FIRST-CALL
               GO TO SUB-1000-EXIT
           END-IF

           SET  W-NOT-FIRST-CALL   TO TRUE
           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'FAKRAND  compiled on '
               W-COMPILED-DATE-YYYY '/'
               W-COMPILED-DATE-MM   '/'
               W-COMPILED-DATE-DD   ' at '
               W-COMPILED-TIME-HH   ':'
               W-COMPILED-TIME-MM   ':'
               W-COMPILED-TIME-SS

           MOVE FUNCTION CURRENT-DATE
                                   TO W-CURRENT-DATE
           COMPUTE W-RANDOM-NO = FUNCTION RANDOM(W-CURRENT-HH-MM-SS-HS)
                                  * 999999999
           .
       SUB-1000-EXIT.
           EXIT.
      /
       SUB-2000-PROCESS.
      *-----------------

           MOVE 0                  TO W-SEED-NO

           EVALUATE TRUE
             WHEN FAKRAND-SEED-NO > 0
               MOVE FAKRAND-SEED-NO
                                   TO W-SEED-NO

             WHEN FAKRAND-SEED-TEXT NOT = SPACES
               PERFORM SUB-2100-HASH-SEED-TEXT THRU SUB-2100-EXIT
           END-EVALUATE

           IF      W-SEED-NO = 0
               MOVE FUNCTION RANDOM
                                   TO FAKRAND-RANDOM-NO 
           ELSE
               MOVE FUNCTION RANDOM(W-SEED-NO)
                                   TO FAKRAND-RANDOM-NO 
           END-IF

           MOVE 0                  TO FAKRAND-SEED-NO
           MOVE SPACES             TO FAKRAND-SEED-TEXT
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-2100-HASH-SEED-TEXT.
      *------------------------

           SET  CRC-STAGE-START-END
                                   TO TRUE 
           SET  CRC-BUFFER-PTR     TO ADDRESS OF FAKRAND-SEED-TEXT

           PERFORM VARYING CRC-BUFFER-LEN 
                      FROM LENGTH OF FAKRAND-SEED-TEXT
                        BY -1
                     UNTIL FAKRAND-SEED-TEXT(CRC-BUFFER-LEN : 1)
                           NOT = SPACE
               CONTINUE
           END-PERFORM

           CALL W-CRC32-PROG    USING W-CRC32-PARAMETER

           MOVE CRC-CHECKSUM       TO W-SEED-NO

           IF      W-SEED-NO > W-MAX-SEED-NO
               SUBTRACT W-MAX-SEED-NO
                                 FROM W-SEED-NO
           END-IF

      D     DISPLAY 'FAKRAND hashed seed of '''
      D             FAKRAND-SEED-TEXT(1 : CRC-BUFFER-LEN)
      D             ''' is '
      D             W-SEED-NO
           .
       SUB-2100-EXIT.
           EXIT.
