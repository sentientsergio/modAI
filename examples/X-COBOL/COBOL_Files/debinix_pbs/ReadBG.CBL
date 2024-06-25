       IDENTIFICATION DIVISION.
       PROGRAM-ID. PbsReadBG.
      **> Authors: Peter B, Bertil K and Sergejs S.
      **> Purpose: Manage an invoice print company (PBS)
      **> Initial Version Created: 2014-03-22
      **>

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  BGMAXFIL ASSIGN TO 'data/bgmaxfil.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS INFIL-FS.

           SELECT  BGFELDATA ASSIGN TO 'data/bgfeldata.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FELFIL-FS.

       DATA DIVISION.
       FILE SECTION.

       FD  BGMAXFIL.
       01  BGMAXFIL-POST.
           05  TRANCODE-TYP    PIC X(2).
           05  FILLER          PIC X(78).

       FD BGFELDATA.
       01  BGFELDATA-POST.
           05  FELDATA-ROW PIC X(80).

       WORKING-STORAGE SECTION.
       01  SWITCHES.
           05  END-OF-FILE             PIC X VALUE 'N'.
               88  EOF                     VALUE 'Y'.
           05  START-POST-EXIST-SW     PIC X VALUE 'N'.
               88  START-POST-EXIST        VALUE 'Y'.
           05  END-POST-EXIST-SW       PIC X VALUE 'N'.
               88  END-POST-EXIST          VALUE 'Y'.
           05  OPEN-POST-EXIST-SW      PIC X VALUE 'N'.
               88  OPEN-POST-EXIST         VALUE 'Y'.
           05  DEPOSIT-POST-EXIST-SW   PIC X VALUE 'N'.
               88  DEPOSIT-POST-EXIST      VALUE 'Y'.
           05  VALID-POST-FILE-SW      PIC X VALUE 'Y'.
               88  VALID-POST-FILE         VALUE 'Y'.

       01  FILE-STATUS-FIELDS.
           05 INFIL-FS                 PIC XX.
               88  INFIL-SUCCESSFUL        VALUE '00'.
           05 FELFIL-FS                PIC XX.
               88  FELFIL-SUCCESSFUL       VALUE '00'.

       01  COUNTS-FIELDS.
           05  PAYMENT-COUNT    PIC 9(8)    VALUE ZERO.
           05  DEPOSIT-COUNT    PIC 9(8)    VALUE ZERO.
           05  DEDUCTION-COUNT  PIC 9(8)    VALUE ZERO.
           05  REFERENCE-COUNT  PIC 9(8)    VALUE ZERO.
           05  TOT-COUNT        PIC 9(8)    VALUE ZERO.

       01  TODAYS-DATE.
           05  T-YEAR          PIC X(4).
           05  T-MONTH         PIC X(2).
           05  T-DAY           PIC X(2).
           05  FILLER          PIC X(13).

       01  WC-ACCEPT           PIC X(2)    VALUE SPACE.

       01  START-POST-01.
           05  TRANCODE-01     PIC X(2).
           05  SYSTEM-01       PIC X(20).
           05  VERSION-01      PIC X(2).
           05  FILDAT-01       PIC X(20).
           05  TEST-01         PIC X(1).
           05  FILLER          PIC X(35).

       01  OPEN-POST-05.
           05  TRANCODE-05     PIC X(2).
           05  DESTBG-05       PIC X(10).
           05  DESTPG-05       PIC X(10).
           05  CUR-05          PIC X(3).
           05  FILLER          PIC X(55).

       01  DESTBG-RED          PIC Z(10) VALUE ZERO.

       01  DEPOSIT-POST-15.
           05  TRANCODE-15     PIC X(2).
           05  RECBANKACC-15   PIC X(35).
           05  PAYMENT-DATE-15 PIC X(8).
           05  SERNUMBER-15    PIC X(5).
           05  PAYMENTSUM-15   PIC X(18).
           05  CUR-15          PIC X(3).
           05  PAYMENTNUM-15   PIC X(8).
           05  PAYMENTTYPE-15  PIC X.

       01  PAYMENT-POST-20.
           05  TRANCODE-20     PIC X(2).
           05  SENDERBG-20     PIC X(10).
           05  REF-20          PIC X(27).
           05  PAYMENTSUM-20   PIC X(18).
           05  REFCODE-20      PIC X.
           05  PAYMENTCODE-20  PIC X.
           05  BGCNR-20        PIC X(12).
           05  SELECTION-20    PIC X.
           05  FILLER          PIC X(8).

       01  PAYMENTSUM-RED      PIC 9(16)V99 VALUE ZERO.

       01  END-POST-70.
           05  TRANCODE-70     PIC X(2).
           05  PAYMENTNUM-70   PIC X(8).
           05  DEDUCTNUM-70    PIC X(8).
           05  REFERNUM-70     PIC X(8).
           05  DEPOSITNUM-70   PIC X(8).
           05  FILLER          PIC X(46).

       01  DEDUCTION-POST-21.
           05  FILLER          PIC X(80).
       01  REFERENCE-POST-22.
           05  FILLER          PIC X(80).
       01  REFERENCE-POST-23.
           05  FILLER          PIC X(80).
       01  INFORMATION-POST-25.
           05  FILLER          PIC X(80).
       01  NAME-POST-26.
           05  FILLER          PIC X(80).
       01  ADDRESS-1-POST-27.
           05  FILLER          PIC X(80).
       01  ADDRESS-2-POST-28.
           05  FILLER          PIC X(80).
       01  ORGNUMBER-POST-29.
           05  FILLER          PIC X(80).

           EXEC SQL INCLUDE SQLCA      END-EXEC.
           EXEC SQL INCLUDE INVOICE    END-EXEC.
           EXEC SQL INCLUDE INVITEM    END-EXEC.
           EXEC SQL INCLUDE ITEM       END-EXEC.
           EXEC SQL INCLUDE CUSTOMER   END-EXEC.
           EXEC SQL INCLUDE FINDATA    END-EXEC.

           COPY Z0900-ERROR-WKSTG.

       PROCEDURE DIVISION.

       000-POST-BG.
           MOVE 'ReadBG.cbl' TO WC-MSG-SRCFILE
           PERFORM 100-INIT
           PERFORM 100-READ-BG-FILE UNTIL EOF.
           IF  VALID-POST-FILE
               PERFORM 101-INIT
               PERFORM 101-READ-BG-FILE UNTIL EOF.
           PERFORM 100-END
           STOP RUN.
      **************************

       100-END.
       CLOSE BGMAXFIL BGFELDATA.
      ***********************

       100-INIT.
           MOVE 'N' TO END-OF-FILE
           MOVE 'N' TO START-POST-EXIST-SW
           MOVE 'N' TO END-POST-EXIST-SW
           MOVE 'N' TO DEPOSIT-POST-EXIST-SW
           MOVE ZERO TO PAYMENT-COUNT, DEPOSIT-COUNT, DEDUCTION-COUNT
           MOVE ZERO TO REFERENCE-COUNT, TOT-COUNT
           OPEN OUTPUT BGFELDATA
                INPUT BGMAXFIL
           IF INFIL-SUCCESSFUL
               READ BGMAXFIL
                   AT END SET EOF TO TRUE
               END-READ
           ELSE
               SET EOF TO TRUE
               DISPLAY ' Indata file error: '.
      ***********************

       101-INIT.
           CLOSE BGMAXFIL BGFELDATA
           MOVE 'N' TO END-OF-FILE
           OPEN OUTPUT BGFELDATA
                INPUT BGMAXFIL
           IF INFIL-SUCCESSFUL
               READ BGMAXFIL
                   AT END SET EOF TO TRUE
               END-READ
           ELSE
               SET EOF TO TRUE
               DISPLAY ' Indata file error: '.
      ***********************

       100-READ-BG-FILE.
           MOVE 'Y' TO VALID-POST-FILE-SW
           EVALUATE TRANCODE-TYP
               WHEN '01' PERFORM 110-START-POST
               WHEN '05' PERFORM 110-OPEN-POST
               WHEN '15' PERFORM 110-DEPOSIT-POST
               WHEN '20' ADD 1 TO PAYMENT-COUNT
               WHEN '21' ADD 1 TO DEDUCTION-COUNT
               WHEN '22' ADD 1 TO REFERENCE-COUNT
               WHEN '23' ADD 1 TO REFERENCE-COUNT
               WHEN '25' CONTINUE
               WHEN '26' CONTINUE
               WHEN '27' CONTINUE
               WHEN '28' CONTINUE
               WHEN '29' CONTINUE
               WHEN '70' PERFORM 190-SLUT-POST
               WHEN OTHER
                MOVE 'N' TO VALID-POST-FILE-SW
                MOVE ' *** Transaktionskod är ogiltig' TO BGFELDATA-POST
                PERFORM WRITE-BAD-FILE
           END-EVALUATE

           IF NOT VALID-POST-FILE
               SET EOF TO TRUE
               DISPLAY '  Post-filen är ogiltig'
               MOVE ' *** Post-filen är ogiltig' TO BGFELDATA-POST
               WRITE BGFELDATA-POST.

           READ BGMAXFIL AT END
               SET EOF TO TRUE
               IF NOT START-POST-EXIST OR NOT END-POST-EXIST  OR NOT
                   OPEN-POST-EXIST OR NOT DEPOSIT-POST-EXIST
                   MOVE 'N' TO VALID-POST-FILE-SW
                   DISPLAY ' Inläsningen avbryts på grund av filen har'
      -            ' inte START/SLUT/ÖPEN/INSÄTTNING poster'
               MOVE ' *** inte START/SLUT/ÖPEN/INSÄTTNING poster'
                   TO BGFELDATA-POST
                   PERFORM WRITE-BAD-FILE
               END-IF
           END-READ.
      **********************************************************

       101-READ-BG-FILE.
           MOVE 'Y' TO VALID-POST-FILE-SW
           EVALUATE TRANCODE-TYP
               WHEN '15' PERFORM 111-DEPOSIT-POST
               WHEN '20' PERFORM 110-PAYMENT-POST
               WHEN OTHER CONTINUE
           END-EVALUATE

           IF NOT VALID-POST-FILE
               SET EOF TO TRUE
               DISPLAY ' Betalnings/Insättnings-poster är ogiltig'
               DISPLAY ' Inläsningen avbryts !!!'
               MOVE ' *** Betalnings/Insättnings-poster är ogiltig'
                       TO BGFELDATA-POST
               WRITE BGFELDATA-POST.

           READ BGMAXFIL AT END SET EOF TO TRUE.
      *********************

       110-START-POST.
           IF NOT START-POST-EXIST
               MOVE BGMAXFIL-POST TO START-POST-01
               SET START-POST-EXIST TO TRUE
               IF SYSTEM-01 NOT = 'BGMAX' OR TEST-01 NOT = 'P'
                   MOVE 'N' TO VALID-POST-FILE-SW
         MOVE ' *** SYSTEM-01/TEST-01 fält är ogiltig' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE
               END-IF
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' START-POST är dubbel'
               MOVE ' *** START-POST är dubbel' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      ********************

       110-OPEN-POST.
           IF NOT OPEN-POST-EXIST
               MOVE BGMAXFIL-POST TO OPEN-POST-05
               MOVE 'Y' TO OPEN-POST-EXIST-SW
               MOVE FUNCTION NUMVAL(DESTBG-05) TO DESTBG-RED
               MOVE DESTBG-RED  TO FINDATA-BANKGIRO
               EXEC SQL
                   SELECT FIN_ID
                   INTO :FINDATA-FIN-ID
                   FROM FINDATA
                   WHERE BANKGIRO = :FINDATA-BANKGIRO
               END-EXEC

               IF SQLCODE = ZERO
                   EXEC SQL
                       SELECT CUST_ID
                       INTO :CUSTOMER-CUST-ID
                       FROM CUSTOMER
                       WHERE FIN_ID = :FINDATA-FIN-ID
                   END-EXEC
                   IF CUSTOMER-CUST-ID NOT = 1
                       MOVE 'N' TO VALID-POST-FILE-SW
                       DISPLAY ' Mottagar BANKGIRO-nummer är ogiltig'
                MOVE ' *** BANKGIRO-nummer är ogiltig' TO BGFELDATA-POST
                       PERFORM WRITE-BAD-FILE
                   END-IF
               ELSE
                   MOVE 'N' TO VALID-POST-FILE-SW
                   DISPLAY ' Mottagar BANKGIRO-nummer är ogiltig'
                MOVE ' *** BANKGIRO-nummer är ogiltig' TO BGFELDATA-POST
                   PERFORM WRITE-BAD-FILE
               END-IF
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' OPEN-POST är dubbel'
               MOVE ' *** OPEN-POST är dubbel' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      ********************

       110-PAYMENT-POST.
           MOVE BGMAXFIL-POST TO PAYMENT-POST-20
           MOVE REF-20(1:10) TO CUSTOMER-CUSTNO
           MOVE REF-20(12:16) TO INVOICE-INVNO
           MOVE FUNCTION CURRENT-DATE TO TODAYS-DATE
           MOVE TODAYS-DATE(1:4) TO INVOICE-INVDATE(1:4)
           MOVE TODAYS-DATE(5:2) TO INVOICE-INVDATE(6:2)
           MOVE TODAYS-DATE(7:2) TO INVOICE-INVDATE(9:2)
           MOVE '-' TO INVOICE-INVDATE(5:1), INVOICE-INVDATE(8:1)
           MOVE FUNCTION NUMVAL(PAYMENTSUM-20) TO PAYMENTSUM-RED
           COMPUTE PAYMENTSUM-RED = PAYMENTSUM-RED * 0.01

           PERFORM 210-CHECK-CUSTOMER-NUMBER

           IF VALID-POST-FILE
               PERFORM 210-CHECK-INVOICE-NUMBER.

           IF VALID-POST-FILE AND REFCODE-20 NOT = '4'
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' Referens kod är ogiltig '
               MOVE ' *** Referens kod är ogiltig' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.

           IF VALID-POST-FILE
               PERFORM 210-CHECK-INVOICE-SUMMA.

           IF VALID-POST-FILE
               PERFORM 210-UPDATE-INVOICE-STATUS.
      ********************

       210-CHECK-CUSTOMER-NUMBER.
           EXEC SQL
               SELECT CUST_ID
               INTO :CUSTOMER-CUST-ID
               FROM CUSTOMER
               WHERE CUSTNO = :CUSTOMER-CUSTNO
           END-EXEC

           IF SQLCODE NOT = ZERO
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' Kundens nummer är ogiltig '
               MOVE ' *** Kundens nummer är ogiltig' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      *******************

       210-CHECK-INVOICE-NUMBER.
           EXEC SQL
               SELECT INV_ID
               INTO :INVOICE-INV-ID
               FROM INVOICE
               WHERE CUST_ID = :CUSTOMER-CUST-ID AND
                               INVNO = :INVOICE-INVNO
           END-EXEC

           IF SQLCODE NOT = ZERO
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' Kundens fakturnummer är ogiltig '
               MOVE ' *** Kundens fakturnummer är ogiltig '
                       TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      *******************

       210-CHECK-INVOICE-SUMMA.
           EXEC SQL
               SELECT SUM(QTY*PRICE)
               INTO :ITEM-PRICE
               FROM ITEM
               WHERE ITEM_ID IN
                   (SELECT ITEM_ID
                    FROM INVITEM
                    WHERE INV_ID = :INVOICE-INV-ID)
           END-EXEC

           IF SQLCODE NOT = ZERO
               MOVE 'N' TO VALID-POST-FILE-SW
           ELSE
               IF PAYMENTSUM-RED NOT = ITEM-PRICE
                   MOVE 'N' TO VALID-POST-FILE-SW
                   DISPLAY ' Betalningsbelopp är inte korrekt'
                   MOVE ' *** Betalningsbelopp är inte korrekt'
                           TO BGFELDATA-POST
                   PERFORM WRITE-BAD-FILE
                 END-IF
           END-IF.
      *******************

       210-UPDATE-INVOICE-STATUS.
           EXEC SQL
               UPDATE INVOICE
               SET INVSTATE=9
               WHERE INV_ID = :INVOICE-INV-ID
           END-EXEC

           IF SQLCODE NOT= ZERO
               DISPLAY ' Updatera Invoice Status - fel. Invoice ID: '
      -            INVOICE-INV-ID
               MOVE ' *** Updatera Invoice Status - fel'
                           TO BGFELDATA-POST
               WRITE BGFELDATA-POST
               MOVE SQLCODE    TO  WN-MSG-SQLCODE
               MOVE 'INVOICE' TO  WC-MSG-TBLCURS
               MOVE '210-UPDATE-INVOICE-STATUS'    TO  WC-MSG-PARA
               PERFORM Z0900-ERROR-ROUTINE.

           EXEC SQL
               UPDATE INVOICE
               SET INVDATE = :INVOICE-INVDATE
               WHERE INV_ID = :INVOICE-INV-ID
           END-EXEC

           IF SQLCODE NOT= ZERO
               DISPLAY ' Updatera Invoice Datum - fel. Invoice ID: '
      -            INVOICE-INV-ID
               MOVE ' *** Updatera Invoice Datum - fel'
                           TO BGFELDATA-POST
               WRITE BGFELDATA-POST
               MOVE SQLCODE    TO  wn-msg-sqlcode
               MOVE 'INVOICE' TO  wc-msg-tblcurs
               MOVE '210-UPDATE-INVOICE-STATUS'    TO  WC-MSG-PARA
               PERFORM Z0900-ERROR-ROUTINE.
      *******************

       190-SLUT-POST.
           IF NOT END-POST-EXIST
               MOVE BGMAXFIL-POST TO END-POST-70
               SET END-POST-EXIST TO TRUE
               IF FUNCTION NUMVAL(PAYMENTNUM-70) NOT = PAYMENT-COUNT OR
                  FUNCTION NUMVAL(DEDUCTNUM-70) NOT = DEDUCTION-COUNT OR
                  FUNCTION NUMVAL(REFERNUM-70) NOT = REFERENCE-COUNT  OR
                  FUNCTION NUMVAL(DEPOSITNUM-70) NOT = DEPOSIT-COUNT
                  MOVE 'N' TO VALID-POST-FILE-SW
                  DISPLAY ' Antalet poster inte stämmer'
               MOVE ' *** Antalet poster inte stämmer' TO BGFELDATA-POST
                  PERFORM WRITE-BAD-FILE
               END-IF
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' SLUTT-POST är dubbel'
               MOVE ' *** SLUT-POST är dubbel' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      *******************

       110-DEPOSIT-POST.
           IF NOT DEPOSIT-POST-EXIST
               MOVE 'Y' TO DEPOSIT-POST-EXIST-SW
               ADD 1 TO DEPOSIT-COUNT
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' INSÄTTNINGS-POST är dubbel'
               MOVE ' *** INSÄTTNINGS-POST är dubbel' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      *******************

       111-DEPOSIT-POST.
           MOVE BGMAXFIL-POST TO DEPOSIT-POST-15
           COMPUTE TOT-COUNT = PAYMENT-COUNT + DEDUCTION-COUNT
           IF PAYMENTNUM-15 NOT = TOT-COUNT
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' INSÄTTNINGS-POST är fel'
               MOVE ' *** INSÄTTNINGS-POST är fel' TO BGFELDATA-POST
               PERFORM WRITE-BAD-FILE.
      *******************

       Z0900-ERROR-ROUTINE.
           COPY Z0900-ERROR-ROUTINE.
       .
      *******************

       WRITE-BAD-FILE.
           WRITE BGFELDATA-POST
           MOVE BGMAXFIL-POST TO BGFELDATA-POST
           WRITE BGFELDATA-POST
           DISPLAY ' *** See Bad transactions file !!! '.
