      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-11  1.0.1    Add TELEPHONE numbers
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.             FAKPHON.

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

       COPY FAKERWS1.

       01  W-POINTER               PIC S9(4)  COMP.
       01  W-HASH                  PIC X(01)       VALUE '#'.
       01  W-PERCENT               PIC X(01)       VALUE '%'.
       01  W-FAKRAND-PROG          PIC X(8)        VALUE 'FAKRAND'.

       01  W-FAKRAND-PARAMETER.    COPY FAKRANDL.

       COPY FAKPHONW.
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

           IF      W-NOT-FIRST-CALL
               GO TO SUB-1000-EXIT
           END-IF

           SET W-NOT-FIRST-CALL    TO TRUE
           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'FAKPHON  compiled on '
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

           MOVE 0                  TO FAKER-INFO-CNT
           SET  FI-DX              TO FAKER-INFO-CNT
           MOVE LOW-VALUES         TO FAKER-INFO-OCCS

           PERFORM SUB-9010-TELEPHONE THRU SUB-9010-EXIT

           SET  FAKER-INFO-CNT     TO FI-DX 

           MOVE W-FAKER-RESULT     TO FAKER-RESULT

           PERFORM SUB-2100-SEPARATE-FIELDS THRU SUB-2100-EXIT
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-2100-SEPARATE-FIELDS.
      *-------------------------

           IF      FAKER-RESULT(1 : 1) = '('
               MOVE 2              TO W-POINTER
           ELSE
               MOVE 1              TO W-POINTER
           END-IF

           UNSTRING FAKER-RESULT
                            DELIMITED ')' OR '-' OR ' X'
                                 INTO FAKER-TELEPHONE-AREA-CODE
                                      FAKER-TELEPHONE-PREFIX
                                      FAKER-TELEPHONE-SUFFIX
                                      FAKER-TELEPHONE-EXTENSION
                              POINTER W-POINTER
           .
       SUB-2100-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

      D    IF      FAKER-RESPONSE-GOOD
      D        DISPLAY 'FAKPHON completed successfully'
      D    ELSE
      D        DISPLAY 'FAKPHON ended with error '
      D                FAKER-RESPONSE-CODE
      D                ': '
      D                FAKER-RESPONSE-MSG
      D    END-IF
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9010-TELEPHONE.
      *-------------------

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           COMPUTE W-RANDOM-SUB    =  FAKRAND-RANDOM-NO
                                      * TELEPHONE-NUMBER-FORMAT-CNT
                                      + 1

           SET  FI-DX           UP BY 1
           MOVE 'TELEPHONE'        TO FAKER-TABLE(FI-DX)
           MOVE FAKRAND-RANDOM-NO  TO FAKER-RANDOM-NO-SUB(FI-DX)
           MOVE W-RANDOM-SUB       TO FAKER-TABLE-ENTRY(FI-DX)

           MOVE TELEPHONE-NUMBER-FORMAT(W-RANDOM-SUB)
                                   TO W-FAKER-RESULT

           PERFORM SUB-9810-REPLACE-DIGIT THRU SUB-9810-EXIT
               VARYING W-SUB-D FROM 1 BY 1
                 UNTIL W-SUB-D > LENGTH OF TELEPHONE-NUMBER-FORMAT
           .
       SUB-9010-EXIT.
           EXIT.
      /
       SUB-9810-REPLACE-DIGIT.
      *-----------------------

           IF      W-FAKER-RESULT(W-SUB-D : 1) NOT = W-HASH
           AND                                       W-PERCENT
               GO TO SUB-9810-EXIT
           END-IF

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           IF      W-FAKER-RESULT(W-SUB-D : 1) = W-PERCENT
               COMPUTE W-RANDOM-DIG
                                   =  FAKRAND-RANDOM-NO
                                      * 9
                                      + 1
           ELSE       
               COMPUTE W-RANDOM-DIG
                                   =  FAKRAND-RANDOM-NO
                                      * 10
           END-IF

           MOVE W-RANDOM-DIG       TO W-FAKER-RESULT(W-SUB-D : 1)
           .
       SUB-9810-EXIT.
           EXIT.
      /
       SUB-9901-CALL-FAKRAND.
      *----------------------

           CALL W-FAKRAND-PROG  USING W-FAKRAND-PARAMETER 
           .
       SUB-9901-EXIT.
           EXIT.
