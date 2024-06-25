       IDENTIFICATION DIVISION.
       PROGRAM-ID. PbsRead.
      **> Koden är testat med data/indata.txt filen. Kan prova!
      **>
      **> Authors: Peter B, Bertil K and Sergejs S.
      **> Purpose: Manage an invoice print company (PBS)
      **> Initial Version Created: 2014-03-11
      **>

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  INDATA ASSIGN TO 'data/indata.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS INFIL-FS.

           SELECT  FELDATA ASSIGN TO 'data/feldata.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FELFIL-FS.

       DATA DIVISION.
       FILE SECTION.

       FD  INDATA.
       01  INDATA-POST.
           05  INDATA-TYP  PIC X(2).
           05  FILLER      PIC X(298).

       FD FELDATA.
       01  FELDATA-POST.
           05  FELDATA-ROW PIC X(300).

       WORKING-STORAGE SECTION.
       01  SWITCHES.
           05  END-OF-FILE             PIC X VALUE 'N'.
               88  EOF                     VALUE 'Y'.
           05  START-POST-EXIST-SW     PIC X VALUE 'N'.
               88  START-POST-EXIST        VALUE 'Y'.
           05  END-POST-EXIST-SW       PIC X VALUE 'N'.
               88  END-POST-EXIST          VALUE 'Y'.
           05  VALID-POST-FILE-SW      PIC X VALUE 'Y'.
               88  VALID-POST-FILE         VALUE 'Y'.
           05 VALID-POSTER-COUNTS-SW   PIC X VALUE 'Y'.
               88  VALID-POSTER-COUNTS     VALUE 'Y'.
           05  FIRST-TIME-FAKTURA-SW   PIC X VALUE 'Y'.
               88  FIRST-TIME-FAKTURA      VALUE 'Y'.
           05  INVOICE-EXIST-SW        PIC X VALUE 'Y'.
               88  INVOICE-EXIST           VALUE 'Y'.


       01  FILE-STATUS-FIELDS.
           05 INFIL-FS                 PIC XX.
               88  INFIL-SUCCESSFUL        VALUE '00'.
           05 FELFIL-FS                PIC XX.
               88  FELFIL-SUCCESSFUL       VALUE '00'.

       01  COUNTS-FIELDS.
           05  POSTER-COUNT    PIC 9(6)    VALUE ZERO.

       01  START-POST-10.
           05  POSTTYP-10      PIC X(2).
           05  SYSTEM-10       PIC X(8).
           05  KNDNR-10        PIC X(10).
           05  FILDAT-10       PIC X(8).
           05  FLNR-10         PIC X(5).
           05  FILLER          PIC X(267).

       01  FAKTURA-POST-20.
           05  POSTTYP-20      PIC X(2).
           05  ORDNR1-20       PIC X(10).
           05  GELNR2-20       PIC X(10).
           05  ORDDAT-20       PIC X(8).
           05  ORDRAB-20       PIC X(2).
           05  MOMS-20         PIC X(2).
           05  FAKTSUM-20      PIC X(8).
           05  FAKTNR-20       PIC X(16).
           05  GELNMN-20       PIC X(40).
           05  GELADD1-20      PIC X(30).
           05  GELADD2-20      PIC X(30).
           05  GELADD3-20      PIC X(30).
           05  GELPNR-20       PIC X(5).
           05  GELPOR-20       PIC X(30).
           05  GELONR-20       PIC X(10).
           05  FILLER          PIC X(67).

       01  FAKT-SUM            PIC 9(9)    VALUE ZERO.
       01  FAKT-SUM-1          PIC 9(9)    VALUE ZERO.
       01  MOMS-T              PIC 9V99    VALUE ZERO.

       01  FAKTURA-POST-20-OLD.
           05  POSTTYP-20-OLD  PIC X(2).
           05  ORDNR1-20-OLD   PIC X(10).
           05  GELNR2-20-OLD   PIC X(10).
           05  ORDDAT-20-OLD   PIC X(8).
           05  ORDRAB-20-OLD   PIC X(2).
           05  MOMS-20-OLD     PIC X(2).
           05  FAKTSUM-20-OLD  PIC X(8).
           05  FAKTNR-20-OLD   PIC X(16).
           05  GELNMN-20-OLD   PIC X(40).
           05  GELADD1-20-OLD  PIC X(30).
           05  GELADD2-20-OLD  PIC X(30).
           05  GELADD3-20-OLD  PIC X(30).
           05  GELPNR-20-OLD   PIC X(5).
           05  GELPOR-20-OLD   PIC X(30).
           05  GELONR-20-OLD   PIC X(10).
           05  FILLER          PIC X(67).


       01  ARTIKEL-POST-30.
           05  POSTTYP-30      PIC X(2).
           05  ARTNR-30        PIC X(10).
           05  ARTANT-30       PIC X(4).
           05  ARTPRS-30       PIC X(6).
           05  SUMMA-30        PIC X(9).
           05  BESKRIV-30      PIC X(30).
           05  FILLER          PIC X(138).

       01  ART-SUM             PIC 9(9)    VALUE ZERO.

       01  SLUT-POST-90.
           05  POSTTYP-90      PIC X(2).
           05  FILLER          PIC X(13).
           05  ANTAL-90        PIC X(6).
           05  FILLER          PIC X(279).

           EXEC SQL INCLUDE SQLCA      END-EXEC.
           EXEC SQL INCLUDE DEBTOR     END-EXEC.
           EXEC SQL INCLUDE INVOICE    END-EXEC.
           EXEC SQL INCLUDE INVITEM    END-EXEC.
           EXEC SQL INCLUDE ITEM       END-EXEC.
           EXEC SQL INCLUDE ADDR       END-EXEC.
           EXEC SQL INCLUDE CUSTOMER   END-EXEC.
           EXEC SQL INCLUDE INLOG      END-EXEC.
           EXEC SQL INCLUDE SRV        END-EXEC.
           EXEC SQL INCLUDE FINDATA    END-EXEC.
           EXEC SQL INCLUDE INERROR    END-EXEC.

       PROCEDURE DIVISION.

       000-POST-CUST.

           PERFORM 100-INIT
           PERFORM 101-INIT
           PERFORM 100-READ-CUST-FILE UNTIL EOF.
           PERFORM 100-END
           IF  VALID-POST-FILE
               PERFORM 101-INIT
               PERFORM 101-READ-CUST-FILE UNTIL EOF.
           CLOSE INDATA FELDATA
           STOP RUN.
      **************************

       100-INIT.

           MOVE 'N' TO END-OF-FILE
           MOVE 'N' TO START-POST-EXIST-SW
           MOVE 'N' TO END-POST-EXIST-SW
           MOVE ZERO TO POSTER-COUNT

           OPEN OUTPUT FELDATA.
      ***********************

       100-END.
       CLOSE INDATA.
      ***********************

       101-INIT.

           MOVE 'N' TO END-OF-FILE
           OPEN INPUT INDATA
           IF INFIL-SUCCESSFUL
               READ INDATA
                   AT END SET EOF TO TRUE
               END-READ
           ELSE
               SET EOF TO TRUE
               DISPLAY ' Indata file error: '.
      ***********************

       100-READ-CUST-FILE.

           MOVE 'Y' TO VALID-POST-FILE-SW

           EVALUATE INDATA-TYP
               WHEN '10' PERFORM 110-START-POST
               WHEN '20' ADD 1 TO POSTER-COUNT
               WHEN '30' ADD 1 TO POSTER-COUNT
               WHEN '90' PERFORM 190-SLUT-POST
               WHEN OTHER MOVE 'N' TO VALID-POST-FILE-SW
           END-EVALUATE

           IF NOT VALID-POST-FILE
               SET EOF TO TRUE
               DISPLAY ' Post-filen är ogiltig'.

           IF NOT VALID-POSTER-COUNTS
               PERFORM WRITE-BAD-FILE.

           READ INDATA AT END
               SET EOF TO TRUE
               IF NOT START-POST-EXIST OR NOT END-POST-EXIST
                   MOVE 'N' TO VALID-POST-FILE-SW
                   DISPLAY ' Inläsningen avbryts på grund av filen har'
      -                    ' inte START-POST eller SLUT-POST poster'
               END-IF
           END-READ.
      **********************************************************

       101-READ-CUST-FILE.
           EVALUATE INDATA-TYP
               WHEN '10' CONTINUE
               WHEN '20' PERFORM 120-FAKTURA-POST
               WHEN '30' PERFORM 130-ARTIKEL-POST
               WHEN '90' PERFORM 220-CHECK-FAKTURA-SUM
           END-EVALUATE

           READ INDATA AT END SET EOF TO TRUE.
      **********************************************************

       110-START-POST.
           IF NOT START-POST-EXIST
               MOVE INDATA-POST TO START-POST-10
               SET START-POST-EXIST TO TRUE

               PERFORM 210-CHECK-CUSTOMER-NR
               IF VALID-POST-FILE
                   PERFORM 210-CHECK-FILE-NR
               END-IF

               IF VALID-POST-FILE
                   ADD 1 TO POSTER-COUNT
               END-IF
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' START-POST är dubbel'.
      *****************************************************

       210-CHECK-CUSTOMER-NR.
           MOVE KNDNR-10 TO CUSTOMER-CUSTNO
               EXEC SQL
                   SELECT CUST_ID
                   INTO :CUSTOMER-CUST-ID
                   FROM CUSTOMER
                   WHERE CUSTOMER.CUSTNO = :CUSTOMER-CUSTNO
               END-EXEC.

           IF SQLCODE NOT = ZERO
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' START-POST är ogiltig'.
      ****************************

       210-CHECK-FILE-NR.
               EXEC SQL
                   SELECT MAX(FILENO)
                   INTO :INLOG-FILENO
                   FROM INLOG
                   WHERE CUST_ID = :CUSTOMER-CUST-ID
               END-EXEC

           IF SQLCODE = ZERO
               IF FUNCTION NUMVAL(FLNR-10) > INLOG-FILENO
                   MOVE FUNCTION NUMVAL(FLNR-10) TO INLOG-FILENO
               ELSE
                   DISPLAY ' Filens löpnummer är ogiltig'
                   MOVE 'N' TO VALID-POST-FILE-SW
               END-IF
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' START-POST är ogiltig'.
      *****************************

       120-FAKTURA-POST.
           MOVE 'N' TO INVOICE-EXIST-SW
           IF FIRST-TIME-FAKTURA
               MOVE INDATA-POST TO FAKTURA-POST-20-OLD
               MOVE INDATA-POST TO FAKTURA-POST-20
               MOVE 'N' TO FIRST-TIME-FAKTURA-SW
           ELSE
               MOVE FAKTURA-POST-20 TO FAKTURA-POST-20-OLD
               MOVE INDATA-POST TO FAKTURA-POST-20
           END-IF
           MOVE ORDDAT-20(1:4) TO INLOG-PROCDATE(1:4)
           MOVE ORDDAT-20(5:2) TO INLOG-PROCDATE(6:2)
           MOVE ORDDAT-20(7:2) TO INLOG-PROCDATE(9:2)
           MOVE '-'    TO INLOG-PROCDATE(5:1) INLOG-PROCDATE(8:1)
           MOVE FAKTNR-20 TO INLOG-INVNO

           MOVE ZERO TO INLOG-RESULTCODE

           EXEC SQL
                   SELECT MAX(INLOG_ID)
                   INTO :INLOG-INLOG-ID
                   FROM INLOG
           END-EXEC

           EXEC SQL
               INSERT INTO INLOG
               VALUES ( (:INLOG-INLOG-ID+1),
                         :CUSTOMER-CUST-ID,
                         :INLOG-FILENO,
                         :INLOG-PROCDATE,
                         :INLOG-INVNO,
                         :INLOG-RESULTCODE
                         )
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats på INLOG tabel är felt'.

           IF FAKTNR-20-OLD NOT = FAKTNR-20
               PERFORM 220-CHECK-FAKTURA-SUM.

           PERFORM 220-INVOICE-EXIST
            IF NOT INVOICE-EXIST
               PERFORM 220-INVOICE-INSERT.

           MOVE ZERO TO FAKT-SUM.
      ****************************

       130-ARTIKEL-POST.
           MOVE INDATA-POST    TO ARTIKEL-POST-30
           MOVE ZERO   TO ART-SUM

           COMPUTE ART-SUM =
               FUNCTION NUMVAL(ARTANT-30) * FUNCTION NUMVAL(ARTPRS-30)
           COMPUTE FAKT-SUM = FAKT-SUM + ART-SUM

           IF ART-SUM NOT = FUNCTION NUMVAL(SUMMA-30)
               DISPLAY 'Artikel summa är felt. Artikel NR: ' ARTNR-30
                STRING 'Felaktig artikelsumma för Art.NR:' ' ' ARTNR-30
                   DELIMITED BY SIZE INTO INERROR-DESCRIPTION
               PERFORM 230-ARTIKEL-UPDATE
           ELSE
               PERFORM 230-ITEM-INSERT.
      ***************************

       230-ARTIKEL-UPDATE.
           EXEC SQL
               UPDATE INLOG
                SET RESULTCODE = 2
                WHERE INLOG_ID = :INLOG-INLOG-ID + 1
           END-EXEC
           IF SQLCODE NOT = ZERO
               DISPLAY ' Update Faktura status in INLOG table är felt'
           ELSE
               EXEC SQL
                   SELECT MAX(INERR_ID)
                   INTO :INERROR-INERR-ID
                   FROM INERROR
               END-EXEC

               EXEC SQL
                   INSERT INTO INERROR
                   VALUES ( (:INERROR-INERR-ID+1),
                         :INERROR-DESCRIPTION,
                         :INLOG-INLOG-ID + 1
                         )
               END-EXEC
               IF SQLCODE NOT = ZERO
                   DISPLAY ' Insert SQL sats in INERROR table är felt'.
           .
      ***************************

       230-FAKTURA-UPDATE.
      *** Update Order status in INLOG table
           EXEC SQL
               UPDATE INLOG
                SET RESULTCODE = 1
                WHERE INLOG_ID = :INLOG-INLOG-ID
           END-EXEC.

           IF SQLCODE NOT = ZERO
               DISPLAY ' Update Faktura status in INLOG table är felt'.

           EXEC SQL
               UPDATE INVOICE
                SET INVSTATE = 99
                WHERE INV_ID = :INVOICE-INV-ID + 1
           END-EXEC.

           IF SQLCODE NOT = ZERO
             DISPLAY ' Update INVOICE status in INVOICE table är felt'.

           PERFORM 240-INSERT-INERR.
      ****************************

       240-INSERT-INERR.
               EXEC SQL
                   SELECT MAX(INERR_ID)
                   INTO :INERROR-INERR-ID
                   FROM INERROR
               END-EXEC

               EXEC SQL
                   INSERT INTO INERROR
                   VALUES ( (:INERROR-INERR-ID+1),
                         :INERROR-DESCRIPTION,
                         :INLOG-INLOG-ID
                         )
               END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats in INERROR table är felt'.
      ***************************

       220-CHECK-FAKTURA-SUM.
           MOVE FAKT-SUM TO FAKT-SUM-1
           IF INDATA-TYP = '90'
               MOVE FAKTURA-POST-20 TO FAKTURA-POST-20-OLD
               ADD 1 TO INLOG-INLOG-ID.
           IF FAKT-SUM-1 NOT = FUNCTION NUMVAL(FAKTSUM-20-OLD)
             DISPLAY 'Faktura summa är felt. Faktura NR: ' FAKTNR-20-OLD
             STRING 'Felaktig fakturasumma för Fak.NR: '   FAKTNR-20-OLD
                   DELIMITED BY SIZE INTO INERROR-DESCRIPTION
             PERFORM 230-FAKTURA-UPDATE
            END-IF
            .
      *        PERFORM WRITE-BAD-FILE
      ****************************

       190-SLUT-POST.
           IF NOT END-POST-EXIST
               MOVE INDATA-POST TO SLUT-POST-90
               SET END-POST-EXIST TO TRUE
               ADD 1 TO POSTER-COUNT

               IF FUNCTION NUMVAL(ANTAL-90) NOT = POSTER-COUNT
                   MOVE 'N' TO VALID-POSTER-COUNTS-SW
                   MOVE 'N' TO VALID-POST-FILE-SW
               END-IF
           ELSE
               MOVE 'N' TO VALID-POST-FILE-SW
               DISPLAY ' SLUTT-POST är dubbel'.
      ****************************

       220-INVOICE-EXIST.
           MOVE FAKTNR-20  TO  INVOICE-INVNO
           EXEC SQL
                 SELECT INV_ID
                 INTO :INVOICE-INV-ID
                 FROM INVOICE
          WHERE CUST_ID=:CUSTOMER-CUST-ID AND INVNO=:INVOICE-INVNO
           END-EXEC

           IF SQLCODE = ZERO
               MOVE 'Y' TO INVOICE-EXIST-SW.
       .
      **************************

       220-INVOICE-INSERT.
           MOVE GELNMN-20  TO DEBTOR-NAME
           MOVE GELADD1-20 TO ADDR-STREET
           MOVE GELPNR-20  TO ADDR-POSTNO
           MOVE GELPOR-20  TO ADDR-PLACE
           MOVE SPACE      TO DEBTOR-CONTACT DEBTOR-NOTE

           EXEC SQL
                   SELECT MAX(ADDR_ID)
                   INTO :ADDR-ADDR-ID
                   FROM ADDR
           END-EXEC

           EXEC SQL
               INSERT INTO ADDR
               VALUES ( (:ADDR-ADDR-ID+1),
                         :ADDR-STREET,
                         :ADDR-POSTNO,
                         :ADDR-PLACE )
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats in ADDR table är felt'.

      *    EXEC SQL
      *        UPDATE CUSTOMER
      *        SET ADDR_ID = :ADDR-ADDR-ID+1
      *        WHERE CUST_ID = :CUSTOMER-CUST-ID
      *    END-EXEC
      *
      *    IF SQLCODE NOT = ZERO
      *        DISPLAY ' Update SQL sats in CUSTOMER table är felt'.

           EXEC SQL
                   SELECT MAX(DEBT_ID)
                   INTO :DEBTOR-DEBT-ID
                   FROM DEBTOR
           END-EXEC

           EXEC SQL
               INSERT INTO DEBTOR
               VALUES ( (:DEBTOR-DEBT-ID+1),
                         :DEBTOR-NAME,
                         :DEBTOR-CONTACT,
                         :DEBTOR-NOTE,
                        (:ADDR-ADDR-ID+1))
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats in DEBTOR table är felt'.

           EXEC SQL
                   SELECT MAX(INV_ID)
                   INTO :INVOICE-INV-ID
                   FROM INVOICE
           END-EXEC

           MOVE 0 TO INVOICE-INVSTATE
           COMPUTE MOMS-T = 0.01 * FUNCTION NUMVAL(MOMS-20)
           MOVE MOMS-T TO INVOICE-VAT
           MOVE FAKTNR-20  TO  INVOICE-INVNO
           MOVE CUSTOMER-CUSTNO    TO  INVOICE-CUSTNO
           MOVE ORDDAT-20(1:4) TO INVOICE-INVDATE(1:4)
           MOVE ORDDAT-20(5:2) TO INVOICE-INVDATE(6:2)
           MOVE ORDDAT-20(7:2) TO INVOICE-INVDATE(9:2)
           MOVE '-'    TO INVOICE-INVDATE(5:1) INVOICE-INVDATE(8:1)

           EXEC SQL
               INSERT INTO INVOICE
               VALUES ( (:INVOICE-INV-ID+1),
                         :CUSTOMER-CUST-ID,
                        (:DEBTOR-DEBT-ID+1),
                         :INVOICE-INVSTATE,
                         :INVOICE-INVNO,
                         :INVOICE-CUSTNO,
                         :INVOICE-INVDATE,
                         :INVOICE-VAT)
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats in INVOICE table är felt'.
      ****************************

       230-ITEM-INSERT.
           MOVE ARTNR-30 TO ITEM-ARTNO
           MOVE FUNCTION NUMVAL(ARTANT-30) TO ITEM-QTY
           MOVE FUNCTION NUMVAL(ARTPRS-30) TO ITEM-PRICE
           MOVE FUNCTION NUMVAL(ARTANT-30) TO ITEM-QTY
           MOVE BESKRIV-30 TO ITEM-DESCRIPTION

           EXEC SQL
                   SELECT MAX(ITEM_ID)
                   INTO :ITEM-ITEM-ID
                   FROM ITEM
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' MAX(ITEM_ID) på ITEM tabel är felt'.

           EXEC SQL
               INSERT INTO ITEM
               VALUES ( (:ITEM-ITEM-ID+1),
                         :ITEM-DESCRIPTION,
                         :ITEM-ARTNO,
                         :ITEM-UNITDESC,
                         :ITEM-QTY,
                         :ITEM-PRICE
                         )
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats på ITEM tabel är felt'.

           EXEC SQL
               INSERT INTO INVITEM
               VALUES ( (:INVOICE-INV-ID+1),
                        (:ITEM-ITEM-ID+1))
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY ' Insert SQL sats in INVITEM table är felt'.

      ****************************

       WRITE-BAD-FILE.
           MOVE INDATA-POST TO FELDATA-POST
           WRITE FELDATA-POST
           DISPLAY ' *** See Bad transactions file !!! '.

