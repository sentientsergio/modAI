      ******************************************************************
      * Author: Tyler Brown
      * Date: 11/30/2017
      * Purpose: create a report form file PR3FA17A.txt and PR3FA17B.txt
      * Tectonics: cobc -xo PROJECT4.exe --std=mf  PROJECT4.cbl
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJECT4.
      **************************COMMENT SECTION*************************
      *THIS PROGRAM PRODUCES AN SALES REPORT FOR DR. CHEEB WITH ALL
      *FINAL SALES VALUES AND HOW MANY PRODUCTS HAVE BEEN SOLD. IT USES
      *THE INPUTS FROM PR3FA17A.TXT AND PR3FA17B.TXT (WHICH CONTAIN
      *WAREHOUSE DATA BASED ON STATE) AND GENERATES A MERGED FILE WITH
      *ALL THE DATA FROM THE 2 FILES AND IS CALLED "PR4 MERGED.TXT".
      *THE DATA IS THE SORTED AND STORED IN FILE "PR4 SORTED.TXT" AND
      *FINALLY IS USED GENERATE THE REPORT FILE WHICH IS STORED IN
      *"PROJECT 4 REPORT.TXT".
      ******************************************************************


      ************************ENVIRONMENT DIVISION**********************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT UNMERGE-FILE1
               ASSIGN TO "PR4FA17A.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT UNMERGE-FILE2
               ASSIGN TO "PR4FA17B.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT MERGE-FILE
               ASSIGN TO "PR4 MERGED.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT SORTED-FILE
               ASSIGN TO "PR4 SORTED.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT REPORT-FILE ASSIGN TO "PROJECT 4 REPORT.TXT".

           SELECT SORT-FILE
               ASSIGN TO PRINTER "SORT.TMP".

           SELECT MERGER
               ASSIGN TO PRINTER "MERGE.TMP".

      ***********************DATA DIVISION******************************
       DATA DIVISION.

       FILE SECTION.

       FD UNMERGE-FILE1
       RECORD CONTAINS 126 CHARACTERS.
       01 UNSORTED-RECORD1.
           05  US-WAREHOUSE-STATE1    PIC A(2).
           05  FILLER                 PIC X(1).
           05  US-WAREHOUSE-CITY1     PIC X(2).
           05  FILLER                 PIC X(1).
           05  US-CUSTOMER-ID1        PIC X(2).
           05  US-CUSTOMER-NAME1      PIC X(20).
           05  US-CUSTOMER-RATING1    PIC 9(1).
           05  FILLER                 PIC X(1).
           05  PRODUCT-DATA OCCURS 6 TIMES.
               10 US-PRODUCT-ID1      PIC X(5).
               10 US-PRODUCT-CODE1    PIC X(1).
               10 US-NUMBER-BOXES1    PIC 9(3).
               10 US-BOX-PRICE1       PIC 999V99.
               10 US-MOUNTH-BOUGHT1   PIC 99.

       FD UNMERGE-FILE2
       RECORD CONTAINS 126 CHARACTERS.
       01 UNSORTED-RECORD2.
           05  US-WAREHOUSE-STATE    PIC A(2).
           05  FILLER                PIC X(1).
           05  US-WAREHOUSE-CITY     PIC X(2).
           05  FILLER                PIC X(1).
           05  US-CUSTOMER-ID        PIC X(2).
           05  US-CUSTOMER-NAME      PIC X(20).
           05  US-CUSTOMER-RATING    PIC 9(1).
           05  FILLER               PIC X(1).
           05  PRODUCT-DATA OCCURS 6 TIMES.
               10 US-PRODUCT-ID      PIC X(5).
               10 US-PRODUCT-CODE    PIC X(1).
               10 US-NUMBER-BOXES    PIC 9(3).
               10 US-BOX-PRICE       PIC 999V99.
               10 US-MOUNTH-BOUGHT   PIC 99.

       FD SORTED-FILE
       RECORD CONTAINS 126 CHARACTERS.
       01 SORTED-RECORD.
           05  WAREHOUSE-STATE    PIC A(2).
           05  FILLER               PIC X(1).
           05  WAREHOUSE-CITY     PIC X(2).
           05  FILLER               PIC X(1).
           05  CUSTOMER-ID        PIC X(2).
           05  CUSTOMER-NAME      PIC X(20).
           05  CUSTOMER-RATING    PIC 9(1).
           05  FILLER               PIC X(1).
           05  PRODUCT-DATA OCCURS 6 TIMES.
               10 PRODUCT-ID      PIC X(5) VALUE SPACES.
               10 PRODUCT-CODE    PIC X(1) VALUE SPACES.
               10 NUMBER-BOXES    PIC 9(3) VALUE ZEROES.
               10 BOX-PRICE       PIC 999V99 VALUE ZEROES.
               10 MOUNTH-BOUGHT   PIC 99 VALUE ZEROES.

       FD REPORT-FILE.
           01 REPORT-RECORD                            PIC X(56).

       SD SORT-FILE.
       01 SORT-RECORD.
           05  S-WAREHOUSE-STATE    PIC A(2).
           05  FILLER               PIC X(1).
           05  S-WAREHOUSE-CITY     PIC X(2).
           05  FILLER               PIC X(1).
           05  S-CUSTOMER-ID        PIC X(2).
           05  S-CUSTOMER-NAME      PIC X(20).
           05  S-CUSTOMER-RATING    PIC 9(1).
           05  FILLER               PIC X(1).
           05  S-PRODUCT-DATA OCCURS 6 TIMES.
               10 S-PRODUCT-ID      PIC X(5).
               10 S-PRODUCT-CODE    PIC X(1).
               10 S-NUMBER-BOXES    PIC 9(3).
               10 S-BOX-PRICE       PIC 999V99.
               10 S-MOUNTH-BOUGHT   PIC 99.

       FD MERGE-FILE.
       01 MERGE-RECORD.
           05  M-WAREHOUSE-STATE    PIC A(2).
           05  FILLER               PIC X(1).
           05  M-WAREHOUSE-CITY     PIC X(2).
           05  FILLER               PIC X(1).
           05  M-CUSTOMER-ID        PIC X(2).
           05  M-CUSTOMER-NAME      PIC X(20).
           05  M-CUSTOMER-RATING    PIC 9(1).
           05  FILLER               PIC X(1).
           05  M-PRODUCT-DATA OCCURS 6 TIMES.
               10 M-PRODUCT-ID      PIC X(5).
               10 M-PRODUCT-CODE    PIC X(1).
               10 M-NUMBER-BOXES    PIC 9(3).
               10 M-BOX-PRICE       PIC 999V99.
               10 M-MOUNTH-BOUGHT   PIC 99.

       WORKING-STORAGE SECTION.

       01  FLAGS-N-SWITCHES.
           05  EOF-FLAG                    PIC X       VALUE ' '.
               88 NO-MORE-DATA                         VALUE 'N'.
               88 MORE-RECORDS                         VALUE 'Y'.
           05  FIRST-RECORD                PIC X(3)    VALUE 'YES'.
           05  SUB                         PIC 9       VALUE ZERO.



       01  REPORT-FIELDS.
           05  PROPER-SPACING              PIC S9      VALUE +1.
           05  LINE-COUNT                  PIC S9(2)   VALUE +0.
           05  PAGE-NO                     PIC S9(2)   VALUE +0.

       01  STATE-TEXT.
           05  PIC X(9) VALUE "ALALABAMA".
           05  PIC X(9) VALUE "GAGEORGIA".

       01  STATE-TABLE REDEFINES STATE-TEXT.
           05  STATE-ITEM OCCURS 2 TIMES INDEXED BY STA-INDEX.
               10  ST-CODE  PIC X(2).
               10  ST-NAME  PIC X(7).

       01  CITY-TEXT.
           05  PIC X(12) VALUE "BMBirmingham".
           05  PIC X(12) VALUE "HUHuntsville".
           05  PIC X(12) VALUE "MOMobile".
           05  PIC X(12) VALUE "TUTuscaloosa".
           05  PIC X(12) VALUE "ATAtlanta".
           05  PIC X(12) VALUE "SASavannah".
           05  PIC X(12) VALUE "VAValdosta".
           05  PIC X(12) VALUE "HEHelena".

       01  CITY-TABLE REDEFINES CITY-TEXT.
           05  CITY-ITEM OCCURS 8 TIMES INDEXED BY CT-INDEX.
               10  CT-CODE  PIC X(2).
               10  CT-NAME  PIC X(10).

       01  MONTH-TEXT.
           05  PIC X(11) VALUE "01January".
           05  PIC X(11) VALUE "02February".
           05  PIC X(11) VALUE "03March".
           05  PIC X(11) VALUE "04April".
           05  PIC X(11) VALUE "05May".
           05  PIC X(11) VALUE "06June".
           05  PIC X(11) VALUE "07July".
           05  PIC X(11) VALUE "08August".
           05  PIC X(11) VALUE "09September".
           05  PIC X(11) VALUE "10October".
           05  PIC X(11) VALUE "11November".
           05  PIC X(11) VALUE "12December".

       01  MONTH-TABLE REDEFINES MONTH-TEXT.
           05 MONTH-ITEM OCCURS 12 TIMES INDEXED BY MO-INDEX.
               10  MO-CODE  PIC X(2).
               10  MO-NAME  PIC X(9).

       01  ACTIVITY-TEXT.
           05 PIC X(11) VALUE "1AGGRESSIVE".
           05 PIC X(11) VALUE "2ACTIVE".
           05 PIC X(11) VALUE "3MODERATE".
           05 PIC X(11) VALUE "4INACTIVE".
           05 PIC X(11) VALUE "5NEW".

       01  ACTIVITY-TABLE REDEFINES ACTIVITY-TEXT.
           05 ACTIVITY-ITEM OCCURS 5 TIMES INDEXED BY AC-INDEX.
               10 AC-CODE PIC X(1).
               10 AC-NAME PIC X(10).

      **************************REPORT SECTION**************************
       01  DETAIL-LINE.
           05  DL-PRODUCT-ID               PIC X(5).
           05                              PIC X(2).
           05  DL-PRODUCT-TYPE             PIC X(8).
           05                              PIC X(2).
           05  DL-MOUNTH-BOUGHT            PIC X(9).
           05                              PIC X(3).
           05  DL-NUM-SOLD                 PIC ZZ9.
           05                              PIC X(3).
           05  DL-BOX-PRICE                PIC ZZ9.99.
           05                              PIC X(3).
           05  DL-MONTH-TOTAL-SOLD         PIC $ZZZ,ZZ9.99.

       01  TITLE-HEADING.
           05                 PIC X(26) VALUE SPACES.
           05                 PIC X(10) VALUE "DR. CHEEBS".

       01  PAGE-HEADER-LINE.
           05                 PIC X(20) VALUE SPACES.
           05                 PIC X(20) VALUE "NEW PRODUCT ANALYSIS".
           05                 PIC X(9) VALUE SPACES.
           05                 PIC X(5) VALUE "PAGE:".
           05  PAGE-OUT       PIC Z9.

       01  STATE-HEADING.
           05                 PIC X(7) VALUE "STATE: ".
           05  STATE-OUT      PIC X(10).

       01  CITY-HEADING.
           05                 PIC X(7) VALUE " CITY: ".
           05  CITY-OUT       PIC X(10).

       01  ID-HEADING.
           05                 PIC X(10) VALUE "     ID:  ".
           05  CUST-ID-OUT    PIC X(5).

       01  NAME-HEADING.
           05                 PIC X(10) VALUE "   NAME:  ".
           05  NAME-OUT       PIC X(19).

       01  RATING-HEADING.
           05                 PIC X(10) VALUE " RATING:  ".
           05  RATING-OUT     PIC X(10).

       01  CUSTOMER-HEADING-1.
           05                 PIC X(19) VALUE " P R O D U C T S   ".
           05                 PIC X(23) VALUE "MONTH     NUM     BOX  ".
           05                 PIC X(13) VALUE "   TOTAL SOLD".

       01  CUSTOMER-HEADING-2.
           05                 PIC X(19) VALUE "   ID     TYPE    ".
           05                 PIC X(17) VALUE "BOUGHT    SOLD   ".
           05                 PIC X(18) VALUE "PRICE    PER MONTH".

       01  TOTAL-CUSTOMER-BREAK-LINE.
           05                      PIC X(27) VALUE SPACES.
           05                      PIC X(6) VALUE "TOTAL:".
           05                      PIC X(10) VALUE SPACES.
           05  CUSTOMER-TOTAL-OUT  PIC $$,$$$,$$9.99.

       01  TOTAL-CITY-SOLD-LINE.
           05                     PIC X(8) VALUE SPACES.
           05                     PIC X(8) VALUE "CITY OF ".
           05  TL-CITY-NAME       PIC X(10).
           05                     PIC X(16) VALUE " TOTAL: ".
           05  TL-CITY-SOLD       PIC $$$,$$$,$$9.99.

       01  TOTAL-STATE-SOLD-LINE.
           05                     PIC X(10) VALUE SPACES.
           05                     PIC X(9) VALUE "STATE OF ".
           05  TL-STATE-NAME      PIC X(7).
           05                     PIC X(12) VALUE " TOTAL: ".
           05  TL-STATE-SOLD      PIC $$$,$$$,$$$,$$9.99.

       01  GRAND-TOTAL-SOLD-LINE.
           05                     PIC X(21) VALUE SPACES.
           05                     PIC X(13) VALUE "GRAND TOTAL: ".
           05  GRAND-TOTAL-SOLD   PIC $$$,$$$,$$$,$$$,$$9.99.

       01  WS-TEMP.
           05  SALES-MONTH-TOTAL  PIC 9(13).
           05  SALES-CUST-TOTAL   PIC 9(13).
           05  WS-STATE           PIC X(7).
           05  WS-CITY            PIC X(15).
           05  WS-CUSTOMER        PIC X(5).
           05  WS-CITY-TOTAL      PIC 999999999V99.
           05  WS-STATE-TOTAL     PIC 999999999999V99.
           05  WS-GRAND-TOTAL     PIC 999999999999V99.

      *************************PROCEDURE DIVISION***********************
       PROCEDURE DIVISION.

       100-MAIN-MODULE.

           PERFORM 105-MERGE-FILE
           PERFORM 110-SORT-FILE
           PERFORM 125-HOUSEKEEPING
           PERFORM 150-READ-SOURCE-FILE
           PERFORM 250-CLOSE-ROUTINE
           .

       105-MERGE-FILE.
           MERGE SORT-FILE
               ON ASCENDING KEY US-WAREHOUSE-STATE
                                US-WAREHOUSE-CITY
                                US-CUSTOMER-ID
               USING UNMERGE-FILE1, UNMERGE-FILE2
               GIVING MERGE-FILE
           .

       110-SORT-FILE.
           SORT SORT-FILE
               ON ASCENDING KEY US-WAREHOUSE-STATE
                                US-WAREHOUSE-CITY
                                US-CUSTOMER-ID
               USING MERGE-FILE
               GIVING SORTED-FILE
           .

       125-HOUSEKEEPING.
           OPEN INPUT SORTED-FILE
           OUTPUT REPORT-FILE
           MOVE 1 TO PROPER-SPACING
           WRITE REPORT-RECORD FROM TITLE-HEADING
               AFTER ADVANCING PROPER-SPACING
           MOVE 2 TO PROPER-SPACING
           PERFORM 145-PAGE-HEADING-ROUTINE
           ADD 5 TO LINE-COUNT
           .

       145-PAGE-HEADING-ROUTINE.
           MOVE 2 TO LINE-COUNT
           ADD 1 TO PAGE-NO
           MOVE PAGE-NO TO PAGE-OUT
           WRITE REPORT-RECORD FROM PAGE-HEADER-LINE
               AFTER ADVANCING PROPER-SPACING
           .

       150-READ-SOURCE-FILE.
           MOVE "Y" TO EOF-FLAG
           PERFORM UNTIL EOF-FLAG = "N"
               READ SORTED-FILE
                   AT END
                       MOVE "N" TO EOF-FLAG
                       PERFORM 225-PUBLISH-FINAL-TOTALS
                   NOT AT END
                       PERFORM 175-CONSTRUCT-DATA
               END-READ
           END-PERFORM
           .

       175-CONSTRUCT-DATA.
           PERFORM 180-BREAK-CONTROL-ROUTINE
           PERFORM VARYING SUB FROM 1 BY 1 UNTIL SUB > 6
               IF PRODUCT-ID(SUB) NOT = SPACES

                   MOVE PRODUCT-ID(SUB) TO DL-PRODUCT-ID
                   EVALUATE TRUE
                       WHEN PRODUCT-CODE(SUB) = "E"
                           MOVE "EDIBLES" TO DL-PRODUCT-TYPE
                       WHEN PRODUCT-CODE(SUB) = "O"
                           MOVE "OILS" TO DL-PRODUCT-TYPE
                       WHEN PRODUCT-CODE(SUB) = "C"
                           MOVE "CAPSULES" TO DL-PRODUCT-TYPE
                       WHEN OTHER
                           MOVE "BAD CODE" TO DL-PRODUCT-TYPE
                   END-EVALUATE
                   SET MO-INDEX TO 1
                   SEARCH MONTH-ITEM
                       AT END
                           MOVE "BAD MONTH" TO DL-MOUNTH-BOUGHT
                       WHEN MOUNTH-BOUGHT(SUB) = MO-CODE(MO-INDEX)
                           MOVE MO-NAME(MO-INDEX) TO DL-MOUNTH-BOUGHT
                   END-SEARCH
                   MOVE NUMBER-BOXES(SUB) TO DL-NUM-SOLD
                   MOVE BOX-PRICE(SUB) TO DL-BOX-PRICE
                   MULTIPLY NUMBER-BOXES(SUB) BY BOX-PRICE(SUB)
                       GIVING SALES-MONTH-TOTAL
                   ADD SALES-MONTH-TOTAL TO SALES-CUST-TOTAL
                   MOVE SALES-MONTH-TOTAL TO DL-MONTH-TOTAL-SOLD

                   WRITE REPORT-RECORD FROM DETAIL-LINE
                       AFTER ADVANCING PROPER-SPACING
                   ADD 2 TO LINE-COUNT

                   PERFORM 200-LINE-COUNT-CHECK
                   DISPLAY SUB
               ELSE
                   IF SUB = 1
                       MOVE " NONE" TO DL-PRODUCT-ID
                       WRITE REPORT-RECORD FROM DL-PRODUCT-ID
                           AFTER ADVANCING PROPER-SPACING
                       ADD 2 TO LINE-COUNT

           END-IF
           END-PERFORM
           MOVE SALES-CUST-TOTAL TO CUSTOMER-TOTAL-OUT
           WRITE REPORT-RECORD FROM TOTAL-CUSTOMER-BREAK-LINE
               AFTER ADVANCING 3
           ADD SALES-CUST-TOTAL TO WS-CITY-TOTAL
           ADD SALES-CUST-TOTAL TO WS-STATE-TOTAL
           ADD SALES-CUST-TOTAL TO WS-GRAND-TOTAL
           MOVE ZEROES TO SALES-MONTH-TOTAL SALES-CUST-TOTAL
           ADD 6 TO LINE-COUNT
           .

       180-BREAK-CONTROL-ROUTINE.
           EVALUATE TRUE
               WHEN FIRST-RECORD = "YES"
                   MOVE "NO" TO FIRST-RECORD
                   PERFORM 185-STATE-BREAK
               WHEN WAREHOUSE-STATE NOT = WS-STATE
                   MOVE WS-CITY-TOTAL TO TL-CITY-SOLD
                   MOVE CITY-OUT TO TL-CITY-NAME
                   WRITE REPORT-RECORD FROM TOTAL-CITY-SOLD-LINE
                       AFTER ADVANCING PROPER-SPACING
                   MOVE WS-STATE-TOTAL TO TL-STATE-SOLD
                   MOVE STATE-OUT TO TL-STATE-NAME
                   WRITE REPORT-RECORD FROM TOTAL-STATE-SOLD-LINE
                       AFTER ADVANCING PROPER-SPACING
                   MOVE ZEROES TO WS-STATE-TOTAL WS-CITY-TOTAL
                   PERFORM 185-STATE-BREAK
               WHEN WAREHOUSE-CITY NOT = WS-CITY
                   MOVE WS-CITY-TOTAL TO TL-CITY-SOLD
                   MOVE CITY-OUT TO TL-CITY-NAME
                   WRITE REPORT-RECORD FROM TOTAL-CITY-SOLD-LINE
                       AFTER ADVANCING PROPER-SPACING
                   PERFORM 190-CITY-BREAK
                   MOVE ZEROES TO WS-CITY-TOTAL
               WHEN CUSTOMER-ID NOT = WS-CUSTOMER
                   PERFORM 195-ID-BREAK
           END-EVALUATE
           .

       185-STATE-BREAK.

           SET STA-INDEX TO 1
           SEARCH STATE-ITEM
               AT END
                   STRING "INVALID "
                       WAREHOUSE-STATE DELIMITED BY SIZE
                       INTO STATE-OUT
                   END-STRING
               WHEN WAREHOUSE-STATE = ST-CODE(STA-INDEX)
                   MOVE ST-NAME(STA-INDEX) TO STATE-OUT
           END-SEARCH
           WRITE REPORT-RECORD FROM STATE-HEADING
               AFTER ADVANCING PROPER-SPACING
           MOVE WAREHOUSE-STATE TO WS-STATE
           ADD 2 TO LINE-COUNT
           PERFORM 200-LINE-COUNT-CHECK
           PERFORM 190-CITY-BREAK
           .

       190-CITY-BREAK.
           SET CT-INDEX TO 1
           SEARCH CITY-ITEM
               AT END
                   STRING "INVALID "
                       WAREHOUSE-CITY
                       INTO CITY-OUT
                   END-STRING
               WHEN WAREHOUSE-CITY = CT-CODE(CT-INDEX)
                   MOVE CT-NAME(CT-INDEX) TO CITY-OUT WS-CITY
           END-SEARCH
           WRITE REPORT-RECORD FROM CITY-HEADING
                   AFTER ADVANCING PROPER-SPACING
           MOVE WAREHOUSE-CITY TO WS-CITY
           ADD 2 TO LINE-COUNT
           PERFORM 200-LINE-COUNT-CHECK
           PERFORM 195-ID-BREAK
           .

       195-ID-BREAK.

           MOVE CUSTOMER-ID TO CUST-ID-OUT WS-CUSTOMER
           MOVE CUSTOMER-NAME TO NAME-OUT
           WRITE REPORT-RECORD FROM ID-HEADING
               AFTER ADVANCING PROPER-SPACING
           WRITE REPORT-RECORD FROM NAME-HEADING
               AFTER ADVANCING 1
           SET AC-INDEX TO 1
           SEARCH ACTIVITY-ITEM
               AT END
                   STRING "INVALID "
                       CUSTOMER-RATING
                       INTO RATING-OUT
                   END-STRING
              WHEN CUSTOMER-RATING = AC-CODE(AC-INDEX)
                   MOVE AC-NAME(AC-INDEX) TO RATING-OUT
           END-SEARCH
           WRITE REPORT-RECORD FROM RATING-HEADING
               AFTER ADVANCING 1
           WRITE REPORT-RECORD FROM CUSTOMER-HEADING-1
               AFTER ADVANCING PROPER-SPACING
           WRITE REPORT-RECORD FROM CUSTOMER-HEADING-2
               AFTER ADVANCING 1
           ADD 8 TO LINE-COUNT
           PERFORM 200-LINE-COUNT-CHECK
           .

       200-LINE-COUNT-CHECK.
           IF LINE-COUNT > 50
               MOVE SPACES TO REPORT-RECORD
               WRITE REPORT-RECORD
                 AFTER ADVANCING PAGE
               PERFORM 145-PAGE-HEADING-ROUTINE
               IF SUB < 6
                   WRITE REPORT-RECORD FROM CUSTOMER-HEADING-1
                       AFTER ADVANCING PROPER-SPACING
                   WRITE REPORT-RECORD FROM CUSTOMER-HEADING-2
                       AFTER ADVANCING 1
           .

       225-PUBLISH-FINAL-TOTALS.
           MOVE WS-CITY-TOTAL TO TL-CITY-SOLD
           MOVE CITY-OUT TO TL-CITY-NAME
           WRITE REPORT-RECORD FROM TOTAL-CITY-SOLD-LINE
               AFTER ADVANCING PROPER-SPACING
           MOVE WS-STATE-TOTAL TO TL-STATE-SOLD
           MOVE STATE-OUT TO TL-STATE-NAME
           WRITE REPORT-RECORD FROM TOTAL-STATE-SOLD-LINE
               AFTER ADVANCING PROPER-SPACING
           MOVE WS-GRAND-TOTAL TO GRAND-TOTAL-SOLD
           WRITE REPORT-RECORD FROM GRAND-TOTAL-SOLD-LINE
               AFTER ADVANCING 3
           .

       250-CLOSE-ROUTINE.
           CLOSE SORTED-FILE
           CLOSE REPORT-FILE
           STOP RUN
           .
