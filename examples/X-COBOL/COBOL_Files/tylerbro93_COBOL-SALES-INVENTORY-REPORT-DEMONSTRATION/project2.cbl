      ******************************************************************
      * Author: Tyler
      * Date: 9/18/2017
      * Purpose: create a sales report form file PR2FA17.txt
      * Tectonics: cobc -xo PROJECT2.exe --std=mf  PROJECT2.cbl
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJECT2.
      **************************COMMENT SECTION*************************
      *THIS PROGRAM PRODUCES AN SALES REPORT FOR DR. CHEEB WITH ALL
      *FINAL SALES VALUES AND HOW MANY PRODUCTS HAVE BEEN SOLD
      ******************************************************************
      *SALES FILE INPUT:
      *1. CUSTOMER ID
      *2. CUSTOMER NAME
      *3. PRODUCT ID
      *4. PRODUCT NAME
      *5. QUANTITY SOLD
      *6. COST PER ITEM
      ******************************************************************
      *SALES REPORT OUTPUT:
      *1. PRODUCT NAME
      *2. PRODUCT ID
      *3. CUSTOMER NAME
      *4. QUANTITY SOLD
      *5. SALES VALUE
      *6. TOTAL QUANTITY SOLD
      *7. TOTAL SALES VALUE
      *8. FINAL TOTAL QUANTITY SOLD
      *9. FINAL TOTAL SALES VALUE
      ******************************************************************
      *CALCULATIONS:
      *SALES VALUE: QUANTITY SOLD * COST PER ITEM
      *TOTAL SALES VALUE
      *TOTAL QUANITY SOLD
      ******************************************************************


      ************************ENVIRONMENT DIVISION**********************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. OCEANBLUE.
       OBJECT-COMPUTER. OCEANBLUE.


       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SOURCE-FILE ASSIGN TO 'PR2FA17.txt'
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT REPORT-FILE ASSIGN TO 'SALES REPORT.txt'
           .


      ***********************DATA DIVISION******************************
       DATA DIVISION.
       FILE SECTION.

           FD SOURCE-FILE.
           01 SPECULATIVE-SALES.
              05 CUSTOMER-ID                           PIC 9(5).
              05 CUSTOMER-NAME                         PIC X(25).
              05 PRODUCT-ID                            PIC X(3).
              05 FILLER                                PIC X(5).
              05 PRODUCT-NAME                          PIC X(14).
              05 QUANTITY-SOLD                         PIC 9(3).
              05 COST-PER-ITEM                         PIC 999V99.

           FD REPORT-FILE.
           01 REPORT-RECORD                            PIC X(71).

       WORKING-STORAGE SECTION.

           01 WS-WORK-AREAS.
              05 EOF-FLAG          PIC X(3) VALUE 'YES'.
              05 PROPER-SPACING    PIC 9(2) VALUE 0.
              05 LINE-NUM          PIC 9(2) VALUE 10.
              05 WS-QUANTITY-SOLD  PIC 9(3) VALUE 0.
              05 WS-COST-PER-ITEM  PIC 999V99.
              05 WS-SALES-VALUE    PIC 999999V99 VALUE ZEROES.
              05 WS-GROUPING-FLAG  PIC X(3) VALUE 'YES'.
              05 WS-TL-SALES-VALUE PIC 9999999V99.
              05 WS-TL-QUANTITY    PIC 999999.
              05 WS-FN-SALES-VALUE PIC 9999999V99.
              05 WS-FN-QUANTITY    PIC 999999.

           01 WS-DATE.
               05 WS-YEAR          PIC 9(2).
               05 WS-MONTH         PIC 9(2).
               05 WS-DAY           PIC 9(2).

      **************************REPORT SECTION**************************
           01 HEADING-LINE1.
               05                  PIC X(34) VALUE SPACES.
               05                  PIC X(7) VALUE 'DR.CHEB'.

           01 HEADING-LINE2.
               05                  PIC X(9) VALUE SPACES.
               05 HL-MONTH         PIC 9(2).
               05                  PIC X VALUE '/'.
               05 HL-DAY           PIC 9(2).
               05                  PIC X(3) VALUE '/20'.
               05 HL-YEAR          PIC 9(2).
               05                  PIC X(7) VALUE SPACES.
               05                  PIC X(24) VALUE
                                             'SALES SPECULATION REPORT'.
               05                  PIC X(18) VALUE SPACES.
               05                  PIC X(3) VALUE 'TSB'.

           01 HEADING-LINE3.
               05                  PIC X(17) VALUE SPACES.
               05                  PIC X(4) VALUE 'PROD'.
               05                  PIC X(11) VALUE SPACES.
               05                  PIC X(8) VALUE 'CUSTOMER'.
               05                  PIC X(13) VALUE SPACES.
               05                  PIC X(3) VALUE 'QTY'.
               05                  PIC X(9) VALUE SPACES.
               05                  PIC X(5) VALUE 'SALES'.

           01 HEADING-LINE4.
               05                  PIC X(2) VALUE SPACES.
               05                  PIC X(12) VALUE 'PRODUCT NAME'.
               05                  PIC X(4) VALUE SPACES.
               05                  PIC X(2) VALUE 'ID'.
               05                  PIC X(14) VALUE SPACES.
               05                  PIC X(4) VALUE 'NAME'.
               05                  PIC X(14) VALUE SPACES.
               05                  PIC X(4) VALUE 'SOLD'.
               05                  PIC X(9) VALUE SPACES.
               05                  PIC X(5) VALUE 'VALUE'.

           01 TOTALS-LINE.
               05 FILLER             PIC X(32) VALUE SPACES.
               05                    PIC X(6) VALUE 'TOTAL:'.
               05 FILLER             PIC X(12) VALUE SPACES.
               05 TL-QUANTITY-OUT    PIC ZZZ999.
               05 FILLER             PIC X(2) VALUE SPACES.
               05 TL-SALES-VALUE-OUT PIC $Z,ZZZ,ZZZ.99.

           01 TOTAL-FINAL-SOLD-LINE.
               05 FILLER             PIC X(30) VALUE SPACES.
               05                    PIC X(18) VALUE
                                                   'TOTAL AMOUNT SOLD:'.
               05 FILLER             PIC X(14) VALUE SPACES.
               05 FN-QUANTITY-OUT    PIC Z,ZZZ,ZZZ.

           01 TOTAL-FINAL-SALE-VALUE-LINE.
               05 FILLER             PIC X(27) VALUE SPACES.
               05                    PIC X(21) VALUE
                                                'TOTAL VALUE OF SALES:'.
               05 FILLER             PIC X(6) VALUE SPACES.
               05 FN-SALES-VALUE-OUT PIC $Z,ZZZ,ZZZ,ZZZ.99.

           01 DETAIL-LINE.
              05                   PIC X VALUE ' '.
              05 DL-PRODUCT-NAME   PIC X(14) VALUE SPACES.
              05                   PIC X(2) VALUE SPACES.
              05 DL-PRODUCT-ID     PIC X(3) VALUE SPACES.
              05                   PIC X(3) VALUE SPACES.
              05 DL-CUSTOMER-NAME  PIC X(25) VALUE SPACES.
              05                   PIC X(4) VALUE SPACES.
              05 DL-QUANTITY-SOLD  PIC Z999 VALUE ZEROES.
              05                   PIC X(5) VALUE SPACES.
              05 DL-SALES-VALUE    PIC ZZZ,ZZZ.99.

      *************************PROCEDURE DIVISION***********************
       PROCEDURE DIVISION.

       100-MAIN-MODULE.
           PERFORM 125-HOUSEKEEPING
           PERFORM 150-READ-SOURCE-FILE
           PERFORM 200-CLOSE-ROUTINE
           .

       125-HOUSEKEEPING.
           OPEN INPUT SOURCE-FILE
           OUTPUT REPORT-FILE
           PERFORM 130-DATE-ROUTINE
           PERFORM 145-HEADING-ROUTINE
           .

       130-DATE-ROUTINE.
           ACCEPT WS-DATE FROM DATE
           MOVE WS-MONTH TO HL-MONTH
           MOVE WS-DAY TO HL-DAY
           MOVE WS-YEAR TO HL-YEAR
           .

       145-HEADING-ROUTINE.
           MOVE 1 TO PROPER-SPACING
           WRITE REPORT-RECORD FROM HEADING-LINE1
             AFTER ADVANCING PROPER-SPACING
           WRITE REPORT-RECORD FROM HEADING-LINE2
             AFTER ADVANCING PROPER-SPACING
           MOVE 3 TO PROPER-SPACING
           WRITE REPORT-RECORD FROM HEADING-LINE3
             AFTER ADVANCING PROPER-SPACING
           MOVE 1 TO PROPER-SPACING
           WRITE REPORT-RECORD FROM HEADING-LINE4
             AFTER ADVANCING PROPER-SPACING
           MOVE SPACES TO REPORT-RECORD
           WRITE REPORT-RECORD
             AFTER ADVANCING PROPER-SPACING
           .

       150-READ-SOURCE-FILE.
           MOVE 1 TO PROPER-SPACING
           PERFORM UNTIL EOF-FLAG = 'NO'
             READ SOURCE-FILE
               AT END
                  MOVE 'NO' TO EOF-FLAG
                  PERFORM 185-WRITE-TOTALS
                  PERFORM 190-WRITE-FINAL-TOTALS
               NOT AT END
                  PERFORM 175-CONSTRUCT-DATA
                  ADD 1 TO LINE-NUM
                  IF LINE-NUM = 55
                     PERFORM 195-NEW-PAGE
                     MOVE 10 TO LINE-NUM
                  END-IF
             END-READ
           END-PERFORM
           .

       175-CONSTRUCT-DATA.
           PERFORM 180-GROUPING-ROUTINE
           MOVE PRODUCT-NAME TO DL-PRODUCT-NAME
           MOVE PRODUCT-ID TO DL-PRODUCT-ID
           MOVE CUSTOMER-NAME TO DL-CUSTOMER-NAME
           MOVE QUANTITY-SOLD TO DL-QUANTITY-SOLD WS-QUANTITY-SOLD
           MOVE COST-PER-ITEM TO WS-COST-PER-ITEM
           MULTIPLY WS-QUANTITY-SOLD BY WS-COST-PER-ITEM
             GIVING DL-SALES-VALUE WS-SALES-VALUE
           MOVE DETAIL-LINE TO REPORT-RECORD
           WRITE REPORT-RECORD
             AFTER ADVANCING PROPER-SPACING
           MOVE 1 TO PROPER-SPACING
           ADD WS-QUANTITY-SOLD TO WS-TL-QUANTITY
           ADD WS-SALES-VALUE TO WS-TL-SALES-VALUE
           .

       180-GROUPING-ROUTINE.
           IF PRODUCT-ID = DL-PRODUCT-ID
             MOVE SPACES TO PRODUCT-NAME
             MOVE 'YES' TO WS-GROUPING-FLAG
           ELSE
             IF WS-GROUPING-FLAG EQUALS 'YES'
             AND DL-PRODUCT-ID NOT EQUALS SPACES
             THEN
               MOVE 'NO' TO WS-GROUPING-FLAG
               PERFORM 185-WRITE-TOTALS
             ELSE
               MOVE 'NO' TO WS-GROUPING-FLAG
             END-IF
           END-IF
           .

       185-WRITE-TOTALS.
           MOVE WS-TL-SALES-VALUE TO TL-SALES-VALUE-OUT
           MOVE WS-TL-QUANTITY TO TL-QUANTITY-OUT
           MOVE TOTALS-LINE TO REPORT-RECORD
           MOVE 2 TO PROPER-SPACING
           WRITE REPORT-RECORD
             AFTER ADVANCING PROPER-SPACING
           MOVE 3 TO PROPER-SPACING
           ADD WS-TL-SALES-VALUE TO WS-FN-SALES-VALUE
           ADD WS-TL-QUANTITY TO WS-FN-QUANTITY
           MOVE ZEROES TO WS-TL-SALES-VALUE
           MOVE ZEROES TO WS-TL-QUANTITY
           .

       190-WRITE-FINAL-TOTALS.
           MOVE WS-FN-SALES-VALUE TO FN-SALES-VALUE-OUT
           MOVE WS-FN-QUANTITY TO FN-QUANTITY-OUT
           MOVE TOTAL-FINAL-SOLD-LINE TO REPORT-RECORD
           WRITE REPORT-RECORD
             AFTER ADVANCING PROPER-SPACING
           MOVE TOTAL-FINAL-SALE-VALUE-LINE TO REPORT-RECORD
           MOVE 2 TO PROPER-SPACING
           WRITE REPORT-RECORD
             AFTER ADVANCING PROPER-SPACING
           .

       195-NEW-PAGE.
           MOVE SPACES TO REPORT-RECORD
           WRITE REPORT-RECORD
             AFTER ADVANCING PAGE
           PERFORM 145-HEADING-ROUTINE
           .

       200-CLOSE-ROUTINE.
           CLOSE SOURCE-FILE
                 REPORT-FILE
           STOP RUN
           .
