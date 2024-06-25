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

       PROGRAM-ID.             FAKADDR.

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
       01  W-POSTCODE              PIC 9(05).
       01  W-HASH                  PIC X(01)       VALUE '#'.
       01  W-PERCENT               PIC X(01)       VALUE '%'.
       01  W-FAKPERS-PROG          PIC X(08)       VALUE 'FAKPERS'.
       01  W-FAKRAND-PROG          PIC X(08)       VALUE 'FAKRAND'.

       01  W-FORMAT-ENTRY          PIC X(04).
           88  W-FORMAT-ENTRY-IS-FORMAT            VALUE 'CT'
                                                         'SA'
                                                         'SN'.

       01  W-FAKER-PARAMETER.      COPY FAKERLNK
                              REPLACING ==FI-DX== BY ==W-FI-DX==.

       01  W-FAKRAND-PARAMETER.    COPY FAKRANDL.

       COPY FAKADDRW.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY FAKERLNK.
       
       COPY FAKERLS1.

       01  L-ADDRESS-TABLE-1.
           05  L-ADDRESS-ENTRY-CNT-1
                                   PIC S9(4)  COMP.
           05  L-ADDRESS-OCCS-1.
               10  FILLER                          OCCURS 1000
                                                   INDEXED L-A-DX-1.
                   15  L-ADDRESS-ENTRY-1
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

           DISPLAY 'FAKADDR  compiled on '
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
                     UNTIL FC-DX > FORMAT-CITY-CNT
               ADD  FORMAT-CITY-WEIGHT(FC-DX)
                 TO FORMAT-CITY-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING FSN-DX FROM 1 BY 1
                     UNTIL FSN-DX > FORMAT-STREET-NAME-CNT
               ADD  FORMAT-STREET-NAME-WEIGHT(FSN-DX)
                 TO FORMAT-STREET-NAME-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING FSA-DX FROM 1 BY 1
                     UNTIL FSA-DX > FORMAT-STREET-ADDR-CNT
               ADD  FORMAT-STREET-ADDR-WEIGHT(FSA-DX)
                 TO FORMAT-STREET-ADDR-WEIGHT-TOT
           END-PERFORM

           PERFORM VARYING FA-DX FROM 1 BY 1
                     UNTIL FA-DX > FORMAT-ADDRESS-CNT
               ADD  FORMAT-ADDRESS-WEIGHT(FA-DX)
                 TO FORMAT-ADDRESS-WEIGHT-TOT
           END-PERFORM

      D    DISPLAY 'FAKADDR weight totals: '
      D    DISPLAY '    ' FORMAT-CITY-WEIGHT-TOT
      D    DISPLAY '    ' FORMAT-STREET-NAME-WEIGHT-TOT
      D    DISPLAY '    ' FORMAT-STREET-ADDR-WEIGHT-TOT
      D    DISPLAY '    ' FORMAT-ADDRESS-WEIGHT-TOT
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
             WHEN ADDRESS-ADDRESS  IN L-PARAMETER
               PERFORM SUB-9010-ADDRESS THRU SUB-9010-EXIT

             WHEN ADDRESS-BUILDING-NO
                                   IN L-PARAMETER
               PERFORM SUB-9020-BUILDING-NO THRU SUB-9020-EXIT

             WHEN ADDRESS-CITY     IN L-PARAMETER  
               PERFORM SUB-9030-CITY THRU SUB-9030-EXIT

             WHEN ADDRESS-CITY-PREFIX
                                   IN L-PARAMETER        
               PERFORM SUB-9040-CITY-PREFIX THRU SUB-9040-EXIT

             WHEN ADDRESS-CITY-SUFFIX
                                   IN L-PARAMETER        
               PERFORM SUB-9050-CITY-SUFFIX THRU SUB-9050-EXIT

             WHEN ADDRESS-MILITARY-APO
                                   IN L-PARAMETER        
               PERFORM SUB-9060-MILITARY-APO THRU SUB-9060-EXIT

             WHEN ADDRESS-MILITARY-DPO
                                   IN L-PARAMETER        
               PERFORM SUB-9070-MILITARY-DPO THRU SUB-9070-EXIT

             WHEN ADDRESS-MILITARY-SHIP-PREFIX
                                   IN L-PARAMETER        
               PERFORM SUB-9080-MILITARY-SHIP-PREFIX THRU SUB-9080-EXIT

             WHEN ADDRESS-MILITARY-STATE-ABBR
                                   IN L-PARAMETER        
               PERFORM SUB-9090-MILITARY-STATE-ABBR THRU SUB-9090-EXIT

             WHEN ADDRESS-POSTCODE IN L-PARAMETER       
               PERFORM SUB-9100-POSTCODE THRU SUB-9100-EXIT

             WHEN ADDRESS-SECONDARY-ADDRESS 
                                   IN L-PARAMETER     
               PERFORM SUB-9110-SECONDARY-ADDRESS THRU SUB-9110-EXIT

             WHEN ADDRESS-STATE    IN L-PARAMETER  
               PERFORM SUB-9120-STATE THRU SUB-9120-EXIT

             WHEN ADDRESS-STATE-ABBR  
                                   IN L-PARAMETER    
               PERFORM SUB-9130-STATE-ABBR THRU SUB-9130-EXIT

             WHEN ADDRESS-STATE-POSTCODE
                                   IN L-PARAMETER        
               PERFORM SUB-9140-STATE-POSTCODE THRU SUB-9140-EXIT

             WHEN ADDRESS-STREET-ADDRESS  
                                   IN L-PARAMETER    
               PERFORM SUB-9150-STREET-ADDRESS THRU SUB-9150-EXIT

             WHEN ADDRESS-STREET-NAME
                                   IN L-PARAMETER  
               PERFORM SUB-9160-STREET-NAME THRU SUB-9160-EXIT

             WHEN ADDRESS-STREET-SUFFIX
                                   IN L-PARAMETER
               PERFORM SUB-9170-STREET-SUFFIX THRU SUB-9170-EXIT

             WHEN ADDRESS-TERRITORY-ABBR  
                                   IN L-PARAMETER    
               PERFORM SUB-9180-TERRITORY-ABBR THRU SUB-9180-EXIT

             WHEN OTHER
               SET  FAKER-UNKNOWN-FUNCTION
                                   IN L-PARAMETER
                                   TO TRUE
               STRING 'Unknown FAKADDR function "'
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

               IF      ADDRESS-ADDRESS
                                   IN L-PARAMETER
                   PERFORM SUB-2200-SEPARATE-FIELDS THRU SUB-2200-EXIT
               END-IF
           ELSE
               PERFORM SUB-9800-FIND-RANDOM-ADDRESS THRU SUB-9800-EXIT

               MOVE W-FAKER-RESULT 
                 TO FAKER-RESULT   IN L-PARAMETER
           END-IF
           .
       SUB-2000-EXIT.
           EXIT.
      /
       COPY FAKERPD1.
      /
       SUB-2200-SEPARATE-FIELDS.
      *------------------------

           MOVE 1                  TO W-POINTER

           UNSTRING FAKER-RESULT   IN L-PARAMETER
                            DELIMITED '\n'
                                 INTO FAKER-ADDRESS-STREET
                                       IN L-PARAMETER
                              POINTER W-POINTER

           UNSTRING FAKER-RESULT   IN L-PARAMETER
                            DELIMITED ', '
                                 INTO FAKER-ADDRESS-CITY
                                       IN L-PARAMETER
                              POINTER W-POINTER

           UNSTRING FAKER-RESULT   IN L-PARAMETER
                            DELIMITED ' '
                                 INTO FAKER-ADDRESS-STATE
                                       IN L-PARAMETER
                                      FAKER-ADDRESS-POSTCODE
                                       IN L-PARAMETER
                              POINTER W-POINTER
           .
       SUB-2200-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

      D    IF      FAKER-RESPONSE-GOOD
      D                            IN L-PARAMETER
      D        DISPLAY 'FAKADDR completed successfully'
      D    ELSE
      D        DISPLAY 'FAKADDR ended with error '
      D                FAKER-RESPONSE-CODE
      D                            IN L-PARAMETER
      D                ': '
      D                FAKER-RESPONSE-MSG
      D                             IN L-PARAMETER
      D    END-IF
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9000-EXAMINE-FIND-FORMAT.
      *-----------------------------

           EVALUATE W-FORMAT-ENTRY
             WHEN 'BN'
               PERFORM SUB-9020-BUILDING-NO THRU SUB-9020-EXIT

             WHEN 'CT'
               PERFORM SUB-9030-CITY THRU SUB-9030-EXIT

             WHEN 'CP'
               PERFORM SUB-9040-CITY-PREFIX THRU SUB-9040-EXIT

             WHEN 'CS'
               PERFORM SUB-9050-CITY-SUFFIX THRU SUB-9050-EXIT

             WHEN 'MA'
               PERFORM SUB-9060-MILITARY-APO THRU SUB-9060-EXIT

             WHEN 'MD'
               PERFORM SUB-9070-MILITARY-DPO THRU SUB-9070-EXIT

             WHEN 'M$'
               PERFORM SUB-9080-MILITARY-SHIP-PREFIX THRU SUB-9080-EXIT

             WHEN 'MS'
               PERFORM SUB-9090-MILITARY-STATE-ABBR THRU SUB-9090-EXIT

             WHEN 'PC'
               PERFORM SUB-9100-POSTCODE THRU SUB-9100-EXIT

             WHEN '2A'
               PERFORM SUB-9110-SECONDARY-ADDRESS THRU SUB-9110-EXIT

             WHEN 'ST'
               PERFORM SUB-9130-STATE-ABBR THRU SUB-9130-EXIT

             WHEN 'SP'
               PERFORM SUB-9140-STATE-POSTCODE THRU SUB-9140-EXIT

             WHEN 'SA'
               PERFORM SUB-9150-STREET-ADDRESS THRU SUB-9150-EXIT

             WHEN 'SN'
               PERFORM SUB-9160-STREET-NAME THRU SUB-9160-EXIT

             WHEN 'SS'
               PERFORM SUB-9170-STREET-SUFFIX THRU SUB-9170-EXIT

             WHEN 'FN'
               PERFORM SUB-9190-FIRST-NAME THRU SUB-9190-EXIT

             WHEN 'LN'
               PERFORM SUB-9200-LAST-NAME THRU SUB-9200-EXIT

             WHEN OTHER
               MOVE SPACES         TO W-TABLE-1
               SET  FAKER-UNKNOWN-FORMAT
                                   IN L-PARAMETER
                                   TO TRUE
               STRING 'Unknown FAKADDR format "'
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
               PERFORM SUB-9800-FIND-RANDOM-ADDRESS THRU SUB-9800-EXIT
           END-EVALUATE
           .
       SUB-9000-EXIT.
           EXIT.
      /
       SUB-9010-ADDRESS.
      *-----------------

           MOVE 'FORMATS-ADDRESS'  TO W-TABLE-1            

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-ADDRESS
           .
       SUB-9010-EXIT.
           EXIT.
      /
       SUB-9020-BUILDING-NO.
      *---------------------

           MOVE 'BUILDING-NUMBER-FORMATS' 
                                   TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF BUILDING-NUMBER-FORMATS
           .
       SUB-9020-EXIT.
           EXIT.
      /
       SUB-9030-CITY.
      *--------------

           MOVE 'FORMATS-CITY'     TO W-TABLE-1            

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-CITY
           .
       SUB-9030-EXIT.
           EXIT.
      /
       SUB-9040-CITY-PREFIX.
      *---------------------

           MOVE 'CITY-PREFIXES'    TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF CITY-PREFIXES
           .
       SUB-9040-EXIT.
           EXIT.
      /
       SUB-9050-CITY-SUFFIX.
      *---------------------

           MOVE 'CITY-SUFFIXES'    TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF CITY-SUFFIXES
           .
       SUB-9050-EXIT.
           EXIT.
      /
       SUB-9060-MILITARY-APO.
      *----------------------

           MOVE 'MILITARY-APO-FORMATS'
                                   TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF MILITARY-APO-FORMATS
           .
       SUB-9060-EXIT.
           EXIT.
      /
       SUB-9070-MILITARY-DPO.
      *----------------------

           MOVE 'MILITARY-DPO-FORMATS'
                                   TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF MILITARY-DPO-FORMATS
           .
       SUB-9070-EXIT.
           EXIT.
      /
       SUB-9080-MILITARY-SHIP-PREFIX.
      *------------------------------

           MOVE 'MILITARY-SHIP-PREFIXES'
                                   TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF MILITARY-SHIP-PREFIXES
           .
       SUB-9080-EXIT.
           EXIT.
      /
       SUB-9090-MILITARY-STATE-ABBR.
      *-----------------------------

           MOVE 'MILITARY-STATES-ABBR'
                                   TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF MILITARY-STATES-ABBR
           .
       SUB-9090-EXIT.
           EXIT.
      /
       SUB-9100-POSTCODE.
      *------------------
        
           MOVE 'POSTCODE-FORMATS' TO W-TABLE-1  

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF POSTCODE-FORMATS
           .
       SUB-9100-EXIT.
           EXIT.
      /
       SUB-9110-SECONDARY-ADDRESS.
      *---------------------------

           MOVE 'SECONDARY-ADDRESS-FORMATS'
                                   TO W-TABLE-1  

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF SECONDARY-ADDRESS-FORMATS
           .
       SUB-9110-EXIT.
           EXIT.
      /
       SUB-9120-STATE.
      *---------------

           MOVE 'STATES'           TO W-TABLE-1  

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF STATES
           .
       SUB-9120-EXIT.
           EXIT.
      /
       SUB-9130-STATE-ABBR.
      *--------------------

           MOVE 'STATES-ABBR'      TO W-TABLE-1  

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF STATES-ABBR
           .
       SUB-9130-EXIT.
           EXIT.
      /
       SUB-9140-STATE-POSTCODE.
      *------------------------

           MOVE 'STATES-POSTCODE'  TO W-TABLE-1            

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF STATES-POSTCODE
           .
       SUB-9140-EXIT.
           EXIT.
      /
       SUB-9150-STREET-ADDRESS.
      *------------------------

           MOVE 'FORMATS-STREET-ADDR'
                                   TO W-TABLE-1  

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-STREET-ADDR
           .
       SUB-9150-EXIT.
           EXIT.
      /
       SUB-9160-STREET-NAME.
      *---------------------

           MOVE 'FORMATS-STREET-NAME'
                                   TO W-TABLE-1  

           SET  ADDRESS OF L-FORMAT-TABLE-1
             TO ADDRESS OF FORMATS-STREET-NAME
           .
       SUB-9160-EXIT.
           EXIT.
      /
       SUB-9170-STREET-SUFFIX.
      *-----------------------
        
           MOVE 'STREET-SUFFIXES'  TO W-TABLE-1  

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF STREET-SUFFIXES
           .
       SUB-9170-EXIT.
           EXIT.
      /
       SUB-9180-TERRITORY-ABBR.
      *------------------------
        
           MOVE 'TERRITORIES-ABBR' TO W-TABLE-1  

           SET  ADDRESS OF L-ADDRESS-TABLE-1
             TO ADDRESS OF TERRITORIES-ABBR
           .
       SUB-9180-EXIT.
           EXIT.
      /
       SUB-9190-FIRST-NAME.
      *--------------------
        
           MOVE 'FIRST-NAME'       TO W-TABLE-1  
           SET  PERSON-FIRST-NAME  IN W-FAKER-PARAMETER
             TO TRUE

           CALL W-FAKPERS-PROG  USING W-FAKER-PARAMETER
           .
       SUB-9190-EXIT.
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
       SUB-9800-FIND-RANDOM-ADDRESS.
      *-----------------------------

           PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

           COMPUTE W-RANDOM-SUB    =  FAKRAND-RANDOM-NO
                                      * L-ADDRESS-ENTRY-CNT-1
                                      + 1

           MOVE W-RANDOM-SUB       TO FAKER-RANDOM-NO-SUB
                                        IN L-PARAMETER(FI-DX)
                                      W-FOUND-DX
                                      FAKER-TABLE-ENTRY
                                        IN L-PARAMETER(FI-DX)

           IF      W-TABLE-1 = 'STATES-POSTCODE'
               SET  SP-DX          TO W-FOUND-DX

               PERFORM SUB-9901-CALL-FAKRAND THRU SUB-9901-EXIT

               COMPUTE W-POSTCODE  =  (FAKRAND-RANDOM-NO
                                       * (STATE-POSTCODE-MAX(SP-DX)
                                       -  STATE-POSTCODE-MIN(SP-DX)))
                                      + STATE-POSTCODE-MIN(SP-DX)
                                      + 1
               COMPUTE W-RANDOM-SUB
                                   =  FAKRAND-RANDOM-NO  
                                      * POSTCODE-FORMAT-CNT
                                      + 1

               MOVE L-ADDRESS-ENTRY-1(W-FOUND-DX)(1 : 3)
                                   TO W-FAKER-RESULT(1 : 3)
               MOVE POSTCODE-FORMAT(W-RANDOM-SUB)
                                   TO W-FAKER-RESULT(4 : )
               MOVE W-POSTCODE     TO W-FAKER-RESULT(4 : 5)
           ELSE
               MOVE L-ADDRESS-ENTRY-1(W-FOUND-DX)
                                   TO W-FAKER-RESULT
           END-IF

           MOVE 0                  TO W-DIGIT-CNT

           INSPECT W-FAKER-RESULT
                             TALLYING W-DIGIT-CNT
                              FOR ALL W-HASH
                                      W-PERCENT

           IF      W-DIGIT-CNT > 0
               PERFORM SUB-9810-REPLACE-DIGIT THRU SUB-9810-EXIT
                   VARYING W-SUB-D FROM 1 BY 1
                     UNTIL W-SUB-D > LENGTH OF W-FAKER-RESULT
           END-IF              
           .
       SUB-9800-EXIT.
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
