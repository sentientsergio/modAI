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

       PROGRAM-ID.             FAKCOMP.

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

       01  W-FAKPERS-PROG          PIC X(08)       VALUE 'FAKPERS'.
       01  W-FAKRAND-PROG          PIC X(08)       VALUE 'FAKRAND'.

       01  W-FORMAT-ENTRY          PIC X(04).
           88  W-FORMAT-ENTRY-IS-FORMAT            VALUE '  '.

       01  W-FAKER-PARAMETER.      COPY FAKERLNK
                              REPLACING ==FI-DX== BY ==W-FI-DX==.

       01  W-FAKRAND-PARAMETER.    COPY FAKRANDL.

       COPY FAKCOMPW.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY FAKERLNK.
       
       COPY FAKERLS1.

       01  L-COMPANY-TABLE-1.
           05  L-COMPANY-ENTRY-CNT-1
                                   PIC S9(4)  COMP.
           05  L-COMPANY-OCCS-1.
               10  FILLER                          OCCURS 1000
                                                   INDEXED L-A-DX-1.
                   15  L-COMPANY-ENTRY-1
                                   PIC X(14).
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

           DISPLAY 'FAKCOMP  compiled on '
               W-COMPILED-DATE-YYYY '/'
               W-COMPILED-DATE-MM   '/'
               W-COMPILED-DATE-DD   ' at '
               W-COMPILED-TIME-HH   ':'
               W-COMPILED-TIME-MM   ':'
               W-COMPILED-TIME-SS

           PERFORM SUB-1100-SUM-WEIGHTS THRU SUB-1100-EXIT
           .
       SUB-1000-EXIT.
           EXIT.
      /
       SUB-1100-SUM-WEIGHTS.
      *---------------------

           PERFORM VARYING FC-DX FROM 1 BY 1
                     UNTIL FC-DX > FORMAT-COMPANY-CNT
               ADD  FORMAT-COMPANY-WEIGHT(FC-DX)
                 TO FORMAT-COMPANY-WEIGHT-TOT
           END-PERFORM

      D    DISPLAY 'FAKCOMP weight totals: '
      D    DISPLAY '    ' FORMAT-COMPANY-WEIGHT-TOT
           .
       SUB-1100-EXIT.
           EXIT.
      /
       SUB-2000-PROCESS.
      *-----------------

           MOVE 0                  
             TO FAKER-INFO-CNT     IN L-PARAMETER
           MOVE LOW-VALUES         
             TO FAKER-INFO-OCCS    IN L-PARAMETER

           EVALUATE TRUE
             WHEN COMPANY-COMPANY  IN L-PARAMETER
               PERFORM SUB-9010-COMPANY THRU SUB-9010-EXIT

             WHEN COMPANY-SUFFIX   IN L-PARAMETER
               PERFORM SUB-9020-SUFFIX THRU SUB-9020-EXIT

             WHEN OTHER
               SET  FAKER-UNKNOWN-FUNCTION
                                   IN L-PARAMETER
                                   TO TRUE
               STRING 'Unknown FAKCOMP function "'
                       FAKER-PROVIDER-FUNCTION
                                   IN L-PARAMETER
                       '"'  DELIMITED SIZE
                                 INTO FAKER-RESPONSE-MSG
                                   IN L-PARAMETER
               GO TO SUB-2000-EXIT
           END-EVALUATE

           ADD  1                  
             TO FAKER-INFO-CNT     IN L-PARAMETER
           SET  FI-DX              
             TO FAKER-INFO-CNT     IN L-PARAMETER
           MOVE W-TABLE-1          
             TO FAKER-TABLE        IN L-PARAMETER(FI-DX)

           IF      W-TABLE-1(1:8) = 'FORMATS-'
               PERFORM SUB-2100-FORMAT THRU SUB-2100-EXIT

               IF      NOT FAKER-RESPONSE-GOOD
                                   IN L-PARAMETER
                   GO TO SUB-2000-EXIT
               END-IF
           ELSE
               PERFORM SUB-9800-FIND-RANDOM-COMPANY THRU SUB-9800-EXIT

               MOVE W-FAKER-RESULT 
                 TO FAKER-RESULT   IN L-PARAMETER
           END-IF
           .
       SUB-2000-EXIT.
           EXIT.
      /
       COPY FAKERPD1.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

      D    IF      FAKER-RESPONSE-GOOD
      D                            IN L-PARAMETER
      D        DISPLAY 'FAKCOMP completed successfully'
      D    ELSE
      D        DISPLAY 'FAKCOMP ended with error '
      D                FAKER-RESPONSE-CODE
      D                            IN L-PARAMETER
      D                ': '
      D                FAKER-RESPONSE-MSG
      D                            IN L-PARAMETER
      D    END-IF
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9000-EXAMINE-FIND-FORMAT.
      *-----------------------------

           EVALUATE W-FORMAT-ENTRY
             WHEN 'CS'
               PERFORM SUB-9020-SUFFIX THRU SUB-9020-EXIT

             WHEN 'LN'
               PERFORM SUB-9200-LAST-NAME THRU SUB-9200-EXIT

             WHEN OTHER
               MOVE SPACES         TO W-TABLE-1
               SET  FAKER-UNKNOWN-FORMAT
                                   IN L-PARAMETER
                                   TO TRUE
               STRING 'Unknown FAKCOMP format "'
                       W-FORMAT-ENTRY
                       '"'  DELIMITED SIZE
                                 INTO FAKER-RESPONSE-MSG
                                   IN L-PARAMETER
               GO TO SUB-9000-EXIT
           END-EVALUATE

           ADD  1                  
             TO FAKER-INFO-CNT     IN L-PARAMETER
           SET  FI-DX              
             TO FAKER-INFO-CNT     IN L-PARAMETER
           MOVE W-TABLE-1          
             TO FAKER-TABLE        IN L-PARAMETER(FI-DX)

           EVALUATE TRUE
             WHEN W-TABLE-1(1:8) = 'FORMATS-'
               PERFORM SUB-9700-FIND-RANDOM-FORMAT THRU SUB-9700-EXIT

             WHEN W-TABLE-1 = 'FIRST-NAME'
             OR               'LAST-NAME'
               MOVE FAKER-RESULT   IN W-FAKER-PARAMETER
                 TO W-FAKER-RESULT             

             WHEN OTHER     
               PERFORM SUB-9800-FIND-RANDOM-COMPANY THRU SUB-9800-EXIT
           END-EVALUATE
           .
       SUB-9000-EXIT.
           EXIT.
      /
       SUB-9010-COMPANY.
      *-----------------

           MOVE 'FORMATS-COMPANY'  TO W-TABLE-1            

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-COMPANY
           .
       SUB-9010-EXIT.
           EXIT.
      /
       SUB-9020-SUFFIX.
      *----------------

           MOVE 'COMPANY-SUFFIXES' TO W-TABLE-1            

           SET  ADDRESS OF L-COMPANY-TABLE-1
             TO ADDRESS OF COMPANY-SUFFIXES
           .
       SUB-9020-EXIT.
           EXIT.
      /
       SUB-9200-LAST-NAME.
      *-------------------
        
           MOVE 'LAST-NAME'        TO W-TABLE-1 
           SET  PERSON-LAST-NAME   IN W-FAKER-PARAMETER
             TO TRUE

           CALL W-FAKPERS-PROG  USING W-FAKER-PARAMETER
           .
       SUB-9200-EXIT.
           EXIT.
      /
       COPY FAKERPD2.
      /
       SUB-9800-FIND-RANDOM-COMPANY.
      *-----------------------------

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           COMPUTE W-RANDOM-SUB    =  FAKRAND-RANDOM-NO
                                      * L-COMPANY-ENTRY-CNT-1
                                      + 1

           MOVE W-RANDOM-SUB       TO FAKER-RANDOM-NO-SUB
                                        IN L-PARAMETER(FI-DX)
                                      W-FOUND-DX
                                      FAKER-TABLE-ENTRY
                                        IN L-PARAMETER(FI-DX)

           MOVE L-COMPANY-ENTRY-1(W-FOUND-DX)
                                   TO W-FAKER-RESULT
           .
       SUB-9800-EXIT.
           EXIT.
      /
       SUB-9901-CALL-FAKRAND.
      *----------------------

           CALL W-FAKRAND-PROG  USING W-FAKRAND-PARAMETER 
           .
       SUB-9901-EXIT.
           EXIT.
