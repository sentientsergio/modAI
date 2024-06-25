      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-11  1.0.1    Add BANK numbers
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.             FAKBANK.

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

       01  W-HASH                  PIC X(01)       VALUE '#'.
       01  W-PERCENT               PIC X(01)       VALUE '%'.
       01  W-FAKRAND-PROG          PIC X(8)        VALUE 'FAKRAND'.
       01  W-PRODUCTS              PIC S9(09) COMP.
       01  W-QUOTIENT              PIC S9(09) COMP.
       01  W-REMAINDER             PIC S9(09) COMP.
       01  W-CHECK-DIGIT           PIC S9(09) COMP.

       01  W-BANK-ROUTING          PIC X(09).
       01  FILLER REDEFINES W-BANK-ROUTING.
           05  W-BANK-ROUTING-DIG  PIC 9(01)       OCCURS 9.

       01  W-FAKRAND-PARAMETER.    COPY FAKRANDL.

       COPY FAKBANKW.
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

           DISPLAY 'FAKBANK  compiled on '
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

           EVALUATE TRUE
             WHEN BANK-ACCOUNT
               PERFORM SUB-9010-ACCOUNT THRU SUB-9010-EXIT

             WHEN BANK-ROUTING
               PERFORM SUB-9020-ROUTING THRU SUB-9020-EXIT

             WHEN OTHER
               SET  FAKER-UNKNOWN-FUNCTION
                                   IN L-PARAMETER
                                   TO TRUE
               STRING 'Unknown FAKBANK function "'
                       FAKER-PROVIDER-FUNCTION
                                   IN L-PARAMETER
                       '"'  DELIMITED SIZE
                                 INTO FAKER-RESPONSE-MSG
                                   IN L-PARAMETER   
               GO TO SUB-2000-EXIT
           END-EVALUATE

           SET  FAKER-INFO-CNT     TO FI-DX 

           MOVE W-FAKER-RESULT     TO FAKER-RESULT
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

      D    IF      FAKER-RESPONSE-GOOD
      D        DISPLAY 'FAKBANK completed successfully'
      D    ELSE
      D        DISPLAY 'FAKBANK ended with error '
      D                FAKER-RESPONSE-CODE
      D                ': '
      D                FAKER-RESPONSE-MSG
      D    END-IF
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9010-ACCOUNT.
      *-----------------

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           COMPUTE W-RANDOM-SUB    =  FAKRAND-RANDOM-NO
                                      * BANK-ACCOUNT-FORMAT-CNT
                                      + 1

           SET  FI-DX           UP BY 1
           MOVE 'BANK-ACCOUNT'     TO FAKER-TABLE(FI-DX)
           MOVE FAKRAND-RANDOM-NO  TO FAKER-RANDOM-NO-SUB(FI-DX)
           MOVE W-RANDOM-SUB       TO FAKER-TABLE-ENTRY(FI-DX)

           MOVE BANK-ACCOUNT-FORMAT(W-RANDOM-SUB)
                                   TO W-FAKER-RESULT

           PERFORM SUB-9810-REPLACE-DIGIT THRU SUB-9810-EXIT
               VARYING W-SUB-D FROM 1 BY 1
                 UNTIL W-SUB-D > LENGTH OF BANK-ACCOUNT-FORMAT
           .
       SUB-9010-EXIT.
           EXIT.
      /
       SUB-9020-ROUTING.
      *-----------------

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           COMPUTE W-RANDOM-SUB    =  FAKRAND-RANDOM-NO
                                      * BANK-ROUTING-FORMAT-CNT
                                      + 1

           SET  FI-DX           UP BY 1
           MOVE 'BANK-ROUTING'     TO FAKER-TABLE(FI-DX)
           MOVE FAKRAND-RANDOM-NO  TO FAKER-RANDOM-NO-SUB(FI-DX)
           MOVE W-RANDOM-SUB       TO FAKER-TABLE-ENTRY(FI-DX)

           MOVE BANK-ROUTING-FORMAT(W-RANDOM-SUB)
                                   TO W-FAKER-RESULT

           PERFORM SUB-9810-REPLACE-DIGIT THRU SUB-9810-EXIT
               VARYING W-SUB-D FROM 1 BY 1
                 UNTIL W-SUB-D > LENGTH OF BANK-ACCOUNT-FORMAT

           MOVE W-FAKER-RESULT     TO W-BANK-ROUTING

           COMPUTE W-PRODUCTS      =  ( W-BANK-ROUTING-DIG(1)
                                      + W-BANK-ROUTING-DIG(4)
                                      + W-BANK-ROUTING-DIG(7)) * 3
                                      + 
                                      ( W-BANK-ROUTING-DIG(2)
                                      + W-BANK-ROUTING-DIG(5)
                                      + W-BANK-ROUTING-DIG(8)) * 7
                                      +
                                        W-BANK-ROUTING-DIG(3)
                                      + W-BANK-ROUTING-DIG(6)

           DIVIDE W-PRODUCTS       BY 10
                               GIVING W-QUOTIENT
                            REMAINDER W-REMAINDER

           IF      W-REMAINDER = 0
               MOVE 0              TO W-CHECK-DIGIT
           ELSE    
               SUBTRACT W-REMAINDER
                                 FROM 10 
                               GIVING W-CHECK-DIGIT
           END-IF    

           MOVE W-CHECK-DIGIT      TO W-BANK-ROUTING-DIG(9)
           MOVE W-BANK-ROUTING     TO W-FAKER-RESULT
           .
       SUB-9020-EXIT.
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
