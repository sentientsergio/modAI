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

       PROGRAM-ID.             FAKPERS.

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

       01  W-POINT                 PIC S9(4)  COMP.
       01  W-FAKRAND-PROG          PIC X(08)       VALUE 'FAKRAND'.

       01  W-FORMAT-ENTRY          PIC X(04).
           88  W-FORMAT-ENTRY-IS-FORMAT            VALUE '  '.

       01  W-FAKRAND-PARAMETER.    COPY FAKRANDL.

       COPY FAKPERSW.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY FAKERLNK.
       
       COPY FAKERLS1.

       01  L-PERSON-TABLE-1.
           05  L-PERSON-ENTRY-CNT-1
                                   PIC S9(4)  COMP.
           05  L-PERSON-WEIGHT-TOT-1
                                   PIC S99V9(9)
                                              COMP.
           05  L-PERSON-OCCS-1.
               10  FILLER                          OCCURS 1000
                                                   INDEXED L-P-DX-1.
                   15  L-PERSON-ENTRY-1
                                   PIC X(12).
                   15  L-PERSON-WEIGHT-1
                                   PIC SV9(9) COMP.

       01  L-PERSON-TABLE-2.
           05  L-PERSON-ENTRY-CNT-2 
                                   PIC S9(4)  COMP.
           05  L-PERSON-WEIGHT-TOT-2
                                   PIC S99V9(9)
                                              COMP.
           05  L-PERSON-OCCS-2.
               10  FILLER                          OCCURS 1000
                                                   INDEXED L-P-DX-2.
                   15  L-PERSON-ENTRY-2
                                   PIC X(12).
                   15  L-PERSON-WEIGHT-2 
                                   PIC SV9(9) COMP.
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

           DISPLAY 'FAKPERS  compiled on '
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

           PERFORM VARYING FF-DX FROM 1 BY 1
                     UNTIL FF-DX > FORMAT-FEMALE-CNT
               ADD  FORMAT-FEMALE-WEIGHT(FF-DX)
                 TO FORMAT-FEMALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING FM-DX FROM 1 BY 1
                     UNTIL FM-DX > FORMAT-MALE-CNT
               ADD  FORMAT-MALE-WEIGHT(FM-DX)
                 TO FORMAT-MALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING FNF-DX FROM 1 BY 1
                     UNTIL FNF-DX > FIRST-NAME-FEMALE-CNT
               ADD  FIRST-NAME-FEMALE-WEIGHT(FNF-DX)
                 TO FIRST-NAME-FEMALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING FNM-DX FROM 1 BY 1
                     UNTIL FNM-DX > FIRST-NAME-MALE-CNT
               ADD  FIRST-NAME-MALE-WEIGHT(FNM-DX)
                 TO FIRST-NAME-MALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING LN-DX FROM 1 BY 1
                     UNTIL LN-DX > LAST-NAME-CNT
               ADD  LAST-NAME-WEIGHT(LN-DX)
                 TO LAST-NAME-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING PF-DX FROM 1 BY 1
                     UNTIL PF-DX > PREFIX-FEMALE-CNT
               ADD  PREFIX-FEMALE-WEIGHT(PF-DX)
                 TO PREFIX-FEMALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING PM-DX FROM 1 BY 1
                     UNTIL PM-DX > PREFIX-MALE-CNT
               ADD  PREFIX-MALE-WEIGHT(PM-DX)
                 TO PREFIX-MALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING SF-DX FROM 1 BY 1
                     UNTIL SF-DX > SUFFIX-FEMALE-CNT
               ADD  SUFFIX-FEMALE-WEIGHT(SF-DX)
                 TO SUFFIX-FEMALE-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING SM-DX FROM 1 BY 1
                     UNTIL SM-DX > SUFFIX-MALE-CNT
               ADD  SUFFIX-MALE-WEIGHT(SM-DX)
                 TO SUFFIX-MALE-WEIGHT-TOT
           END-PERFORM

      D    DISPLAY 'FAKPERS weight totals: '
      D    DISPLAY '    ' FORMAT-FEMALE-WEIGHT-TOT
      D    DISPLAY '    ' FORMAT-MALE-WEIGHT-TOT
      D    DISPLAY '    ' FIRST-NAME-FEMALE-WEIGHT-TOT
      D    DISPLAY '    ' FIRST-NAME-MALE-WEIGHT-TOT
      D    DISPLAY '    ' LAST-NAME-WEIGHT-TOT
      D    DISPLAY '    ' PREFIX-FEMALE-WEIGHT-TOT
      D    DISPLAY '    ' PREFIX-MALE-WEIGHT-TOT
      D    DISPLAY '    ' SUFFIX-FEMALE-WEIGHT-TOT
      D    DISPLAY '    ' SUFFIX-MALE-WEIGHT-TOT
           .
       SUB-1100-EXIT.
           EXIT.
      /
       SUB-2000-PROCESS.
      *-----------------

           MOVE 0                  TO FAKER-INFO-CNT
           MOVE LOW-VALUES         TO FAKER-INFO-OCCS
           MOVE SPACES             TO W-TABLE-2

           EVALUATE TRUE
             WHEN PERSON-FIRST-NAME       
               PERFORM SUB-9010-FIRST-NAME THRU SUB-9010-EXIT

             WHEN PERSON-FIRST-NAME-MALE  
               PERFORM SUB-9020-FIRST-NAME-MALE THRU SUB-9020-EXIT

             WHEN PERSON-FIRST-NAME-FEMALE
               PERFORM SUB-9030-FIRST-NAME-FEMALE THRU SUB-9030-EXIT

             WHEN PERSON-LAST-NAME        
             WHEN PERSON-LAST-NAME-MALE   
             WHEN PERSON-LAST-NAME-FEMALE 
               PERFORM SUB-9040-LAST-NAME THRU SUB-9040-EXIT

             WHEN PERSON-NAME 
               PERFORM SUB-9050-NAME THRU SUB-9050-EXIT

             WHEN PERSON-NAME-MALE        
               PERFORM SUB-9060-NAME-MALE THRU SUB-9060-EXIT

             WHEN PERSON-NAME-FEMALE      
               PERFORM SUB-9070-NAME-FEMALE THRU SUB-9070-EXIT

             WHEN PERSON-PREFIX           
               PERFORM SUB-9080-PREFIX THRU SUB-9080-EXIT

             WHEN PERSON-PREFIX-MALE      
               PERFORM SUB-9090-PREFIX-MALE THRU SUB-9090-EXIT

             WHEN PERSON-PREFIX-FEMALE    
               PERFORM SUB-9100-PREFIX-FEMALE THRU SUB-9100-EXIT

             WHEN PERSON-SUFFIX           
               PERFORM SUB-9110-SUFFIX THRU SUB-9110-EXIT

             WHEN PERSON-SUFFIX-MALE      
               PERFORM SUB-9120-SUFFIX-MALE THRU SUB-9120-EXIT

             WHEN PERSON-SUFFIX-FEMALE    
               PERFORM SUB-9130-SUFFIX-FEMALE THRU SUB-9130-EXIT

             WHEN OTHER
               SET  FAKER-UNKNOWN-FUNCTION
                                   TO TRUE
               STRING 'Unknown FAKPERS function "'
                       FAKER-PROVIDER-FUNCTION
                       '"'  DELIMITED SIZE
                                 INTO FAKER-RESPONSE-MSG
               GO TO SUB-2000-EXIT
           END-EVALUATE

           ADD  1                  TO FAKER-INFO-CNT
           SET  FI-DX              TO FAKER-INFO-CNT
           MOVE W-TABLE-1          TO FAKER-TABLE(FI-DX)   

           IF      W-TABLE-1(1:8) = 'FORMATS-'
               PERFORM SUB-2100-FORMAT THRU SUB-2100-EXIT

               IF      NOT FAKER-RESPONSE-GOOD
                                   IN L-PARAMETER
                   GO TO SUB-2000-EXIT
               END-IF
           ELSE
               PERFORM SUB-9300-FIND-RANDOM-PERSON THRU SUB-9300-EXIT

               MOVE W-FAKER-RESULT TO FAKER-RESULT
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
      D        DISPLAY 'FAKPERS completed successfully'
      D    ELSE
      D        DISPLAY 'FAKPERS ended with error '
      D                FAKER-RESPONSE-CODE
      D                ': '
      D                FAKER-RESPONSE-MSG
      D    END-IF
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9000-EXAMINE-FIND-FORMAT.
      *-----------------------------

           MOVE SPACES             TO W-TABLE-2

           EVALUATE W-FORMAT-ENTRY
             WHEN 'FM'
               PERFORM SUB-9020-FIRST-NAME-MALE THRU SUB-9020-EXIT

             WHEN 'FF'
               PERFORM SUB-9030-FIRST-NAME-FEMALE THRU SUB-9030-EXIT

             WHEN 'LN'
               PERFORM SUB-9040-LAST-NAME THRU SUB-9040-EXIT

             WHEN 'PM'
               PERFORM SUB-9090-PREFIX-MALE THRU SUB-9090-EXIT

             WHEN 'PF'
               PERFORM SUB-9100-PREFIX-FEMALE THRU SUB-9100-EXIT

             WHEN 'SM'
               PERFORM SUB-9120-SUFFIX-MALE THRU SUB-9120-EXIT

             WHEN 'SF'
               PERFORM SUB-9130-SUFFIX-FEMALE THRU SUB-9130-EXIT

             WHEN OTHER
               MOVE SPACES         TO W-TABLE-1
               SET  FAKER-UNKNOWN-FORMAT
                                   TO TRUE
               STRING 'Unknown FAKPERS format "'
                       W-FORMAT-ENTRY
                       '"'  DELIMITED SIZE
                                 INTO FAKER-RESPONSE-MSG
               GO TO SUB-9000-EXIT
           END-EVALUATE

           ADD  1                  TO FAKER-INFO-CNT     
           SET  FI-DX              TO FAKER-INFO-CNT     
           MOVE W-TABLE-1          TO FAKER-TABLE(FI-DX)

           IF      W-TABLE-1(1:8) = 'FORMATS-'
               PERFORM SUB-9700-FIND-RANDOM-FORMAT THRU SUB-9700-EXIT
           ELSE
               PERFORM SUB-9300-FIND-RANDOM-PERSON THRU SUB-9300-EXIT
           END-IF
           .
       SUB-9000-EXIT.
           EXIT.
      /
       SUB-9010-FIRST-NAME.
      *--------------------

           MOVE 'FIRST-NAMES-MALE' TO W-TABLE-1            
           MOVE 'FIRST-NAMES-FEMALE'
                                   TO W-TABLE-2            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF FIRST-NAMES-MALE
           SET  ADDRESS OF L-PERSON-TABLE-2
             TO ADDRESS OF FIRST-NAMES-FEMALE
           .
       SUB-9010-EXIT.
           EXIT.
      /
       SUB-9020-FIRST-NAME-MALE.
      *-------------------------

           MOVE 'FIRST-NAMES-MALE' TO W-TABLE-1 

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF FIRST-NAMES-MALE
           .
       SUB-9020-EXIT.
           EXIT.
      /
       SUB-9030-FIRST-NAME-FEMALE.
      *---------------------------

           MOVE 'FIRST-NAMES-FEMALE' 
                                   TO W-TABLE-1 

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF FIRST-NAMES-FEMALE
           .
       SUB-9030-EXIT.
           EXIT.
      /
       SUB-9040-LAST-NAME.
      *-------------------

           MOVE 'LAST-NAMES'       TO W-TABLE-1            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF LAST-NAMES
           .
       SUB-9040-EXIT.
           EXIT.
      /
       SUB-9050-NAME.
      *--------------

           MOVE 'FORMATS-MALE'     TO W-TABLE-1            
           MOVE 'FORMATS-FEMALE'   TO W-TABLE-2            

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-MALE
           SET  ADDRESS OF L-FORMAT-TABLE-2
             TO ADDRESS OF FORMATS-FEMALE
           .
       SUB-9050-EXIT.
           EXIT.
      /
       SUB-9060-NAME-MALE.
      *-------------------
        
           MOVE 'FORMATS-MALE'     TO W-TABLE-1  

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-MALE
           .
       SUB-9060-EXIT.
           EXIT.
      /
       SUB-9070-NAME-FEMALE.
      *---------------------

           MOVE 'FORMATS-FEMALE'   TO W-TABLE-1  

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-FEMALE
           .
       SUB-9070-EXIT.
           EXIT.
      /
       SUB-9080-PREFIX.
      *----------------

           MOVE 'PREFIXES-MALE'    TO W-TABLE-1            
           MOVE 'PREFIXES-FEMALE'  TO W-TABLE-2  

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF PREFIXES-MALE
           SET  ADDRESS OF L-PERSON-TABLE-2
             TO ADDRESS OF PREFIXES-FEMALE
           .
       SUB-9080-EXIT.
           EXIT.
      /
       SUB-9090-PREFIX-MALE.
      *---------------------

           MOVE 'PREFIXES-MALE'    TO W-TABLE-1            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF PREFIXES-MALE
           .
       SUB-9090-EXIT.
           EXIT.
      /
       SUB-9100-PREFIX-FEMALE.
      *-----------------------

           MOVE 'PREFIXES-FEMALE'  TO W-TABLE-1            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF PREFIXES-FEMALE
           .
       SUB-9100-EXIT.
           EXIT.
      /
       SUB-9110-SUFFIX.
      *----------------

           MOVE 'SUFFIXES-MALE'    TO W-TABLE-1            
           MOVE 'SUFFIXES-FEMALE'  TO W-TABLE-2            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF SUFFIXES-MALE
           SET  ADDRESS OF L-PERSON-TABLE-2
             TO ADDRESS OF SUFFIXES-FEMALE
           .
       SUB-9110-EXIT.
           EXIT.
      /
       SUB-9120-SUFFIX-MALE.
      *---------------------

           MOVE 'SUFFIXES-MALE'    TO W-TABLE-1            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF SUFFIXES-MALE 
           .
       SUB-9120-EXIT.
           EXIT.
      /
       SUB-9130-SUFFIX-FEMALE.
      *-----------------------

           MOVE 'SUFFIXES-FEMALE'  TO W-TABLE-1            

           SET  ADDRESS OF L-PERSON-TABLE-1
             TO ADDRESS OF SUFFIXES-FEMALE
           .
       SUB-9130-EXIT.
           EXIT.
      /
       COPY FAKERPD2.
      /
       SUB-9300-FIND-RANDOM-PERSON.
      *----------------------------

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           IF      W-TABLE-2 = SPACES
               COMPUTE W-RANDOM-NO = FAKRAND-RANDOM-NO
                                      * L-PERSON-WEIGHT-TOT-1
           ELSE
               COMPUTE W-RANDOM-NO = FAKRAND-RANDOM-NO
                                      * (L-PERSON-WEIGHT-TOT-1 +
                                         L-PERSON-WEIGHT-TOT-2)
           END-IF

           MOVE W-RANDOM-NO        TO FAKER-RANDOM-NO-SUB(FI-DX)
           MOVE 0                  TO W-FOUND-DX

           PERFORM SUB-9310-FIND-PERSON THRU SUB-9310-EXIT
               VARYING L-P-DX-1 FROM 1 BY 1
                 UNTIL W-FOUND-DX > 0
                 OR    L-P-DX-1 > L-PERSON-ENTRY-CNT-1

           EVALUATE TRUE
             WHEN W-FOUND-DX > 0
               MOVE L-PERSON-ENTRY-1(W-FOUND-DX)
                                   TO W-FAKER-RESULT

             WHEN W-TABLE-2 NOT = SPACES
               ADD  1              TO FAKER-INFO-CNT
               SET  FI-DX          TO FAKER-INFO-CNT
               MOVE W-TABLE-2      TO FAKER-TABLE(FI-DX)
               MOVE W-RANDOM-NO    TO FAKER-RANDOM-NO-SUB(FI-DX)

               MOVE 0              TO W-FOUND-DX

               PERFORM SUB-9320-FIND-PERSON THRU SUB-9320-EXIT
                   VARYING L-P-DX-2 FROM 1 BY 1
                     UNTIL W-FOUND-DX > 0
                     OR    L-P-DX-2 > L-PERSON-ENTRY-CNT-2

               IF      W-FOUND-DX > 0
                   MOVE L-PERSON-ENTRY-2(W-FOUND-DX)
                                   TO W-FAKER-RESULT
               ELSE
                   MOVE 'Random item not found'
                                   TO W-FAKER-RESULT
               END-IF

             WHEN OTHER
               MOVE 'Random item not found'
                                   TO W-FAKER-RESULT
           END-EVALUATE

           IF      PERSON-NAME
           OR      PERSON-NAME-MALE
           OR      PERSON-NAME-FEMALE
               PERFORM SUB-9330-SEPARATE-FIELDS THRU SUB-9330-EXIT
           END-IF
           .
       SUB-9300-EXIT.
           EXIT.
      /
       SUB-9310-FIND-PERSON.
      *---------------------
      
           IF      W-RANDOM-NO <= L-PERSON-WEIGHT-1(L-P-DX-1)
               SET  W-FOUND-DX     TO L-P-DX-1
               MOVE W-FOUND-DX     TO FAKER-TABLE-ENTRY(FI-DX)
           ELSE
               SUBTRACT L-PERSON-WEIGHT-1(L-P-DX-1)
                                 FROM W-RANDOM-NO
           END-IF
           .
       SUB-9310-EXIT.
           EXIT.
      /
       SUB-9320-FIND-PERSON.
      *---------------------
      
           IF      W-RANDOM-NO <= L-PERSON-WEIGHT-2(L-P-DX-2)
               SET  W-FOUND-DX     TO L-P-DX-2
               MOVE W-FOUND-DX     TO FAKER-TABLE-ENTRY(FI-DX)
           ELSE
               SUBTRACT L-PERSON-WEIGHT-2(L-P-DX-2)
                                 FROM W-RANDOM-NO
           END-IF
           .
       SUB-9320-EXIT.
           EXIT.
      /
       SUB-9330-SEPARATE-FIELDS.
      *-------------------------

           EVALUATE FAKER-TABLE(FI-DX)
             WHEN 'PREFIXES-MALE'
             WHEN 'PREFIXES-FEMALE'
               MOVE W-FAKER-RESULT TO FAKER-PERSON-PREFIX

             WHEN 'FIRST-NAMES-MALE'
             WHEN 'FIRST-NAMES-FEMALE'
               MOVE W-FAKER-RESULT TO FAKER-PERSON-FIRST-NAME

             WHEN 'LAST-NAMES'
               IF      FAKER-PERSON-LAST-NAME = SPACES
                   MOVE W-FAKER-RESULT 
                                   TO FAKER-PERSON-LAST-NAME
               ELSE
                   MOVE 1          TO W-POINT
                   INSPECT FAKER-PERSON-LAST-NAME
                             TALLYING W-POINT
                                  FOR CHARACTERS
                               BEFORE SPACE
                   STRING '-' 
                          W-FAKER-RESULT 
                            DELIMITED SIZE
                                 INTO FAKER-PERSON-LAST-NAME
                              POINTER W-POINT
               END-IF

             WHEN 'SUFFIXES-MALE'
             WHEN 'SUFFIXES-FEMALE'
               MOVE W-FAKER-RESULT TO FAKER-PERSON-SUFFIX
           END-EVALUATE    
           .
       SUB-9330-EXIT.
           EXIT.
      /
       SUB-9901-CALL-FAKRAND.
      *----------------------
           
           CALL W-FAKRAND-PROG  USING W-FAKRAND-PARAMETER 
           .
       SUB-9901-EXIT.
           EXIT.
