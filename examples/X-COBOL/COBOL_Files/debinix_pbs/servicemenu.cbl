      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. servicemenu IS INITIAL.
      *
      * Authors: Peter B, Bertil K and Sergejs S.
      * Purpose: Maintain products/articles database table
      * Initial Version Created: 2014-03-19
      *
      **********************************************************
       ENVIRONMENT DIVISION.
      *---------------------------------------------------------
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *---------------------------------------------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      **********************************************************
       DATA DIVISION.
      *---------------------------------------------------------
       FILE SECTION.
      **********************************************************
       WORKING-STORAGE SECTION.

           EXEC SQL INCLUDE SQLCA END-EXEC.

           EXEC SQL INCLUDE SRV END-EXEC.

      **********************************************************
      *    cursor area
      **********************************************************

      *    list produkter
           EXEC SQL
               DECLARE BCURSRV1 CURSOR FOR
               SELECT S.SRV_ID, S.ARTNO,
                      S.DESCRIPTION, S.CHARGE
               FROM TUTORIAL.SRV S
               ORDER BY S.SRV_ID
           END-EXEC

      *    get highest primary key
           EXEC SQL
               DECLARE BCURSRV2 CURSOR FOR
               SELECT SRV_ID
               FROM TUTORIAL.SRV
               ORDER BY SRV_ID DESC
           END-EXEC

      **********************************************************
      *    switches
       01  menu-switches.
           05 is-exit-update-menu-switch      PIC X(1) VALUE 'N'.
               88  is-exit-update-menu                 VALUE 'Y'.
           05 is-existing-id-number-switch    PIC X(1) VALUE 'N'.
               88  is-existing-id-number               VALUE 'Y'.
           05 is-invalid-user-input-switch    PIC X(1) VALUE 'N'.
               88  is-invalid-user-input               VALUE 'Y'.


      *    working storage data for error routine
           COPY Z0900-error-wkstg.

      *    Various generic variables
       01  wc-accept                    PIC X(2)     VALUE SPACE.
       01  we-srv-id                    PIC Z9       VALUE ZERO.
       01  we-charge                    PIC ZZ9,99   VALUE ZERO.
       01  wc-charge                    PIC X(5)     VALUE SPACE.
       01  we-cust-id                   PIC Z9       VALUE ZERO.
       01  we-sqlrows                   PIC Z9       VALUE ZERO.


      *    Updating table variables
       01  w9-srv-id                    PIC S9(9)           COMP.
       01  wc-artno                     PIC X(10)    VALUE SPACE.
       01  wc-description               PIC X(40)    VALUE SPACE.
       01  w9-charge                    PIC S9(3)V9(2)    COMP-3.
       01  wc-srv-type                  PIC X(1)     VALUE SPACE.


      *    Various constants
       01  HEADLINE                     PIC X(78)   VALUE ALL '-'.

       LINKAGE SECTION.
       01  lc-accept                    PIC X(2)    VALUE SPACE.
       
           
      **********************************************************
       PROCEDURE DIVISION USING lc-accept.
       0000-servicemenu.

      *    current source file to error handler
           MOVE 'servicemenu.cbl' TO wc-msg-srcfile

          EVALUATE lc-accept

               WHEN '61'
                   PERFORM M0110-list-articles
               WHEN '62'
                   PERFORM M0120-update-article
               WHEN '63'
                   PERFORM M0160-add-article
               WHEN '64'
               CONTINUE
                   PERFORM M0170-delete-article
               WHEN OTHER
                   DISPLAY 'Fel menyval från huvudprogram!'
           END-EVALUATE

           EXIT PROGRAM
           .


      **********************************************************
       M0110-list-articles.

           PERFORM U0200-list-services

           DISPLAY SPACE
           DISPLAY 'Press <Enter> för att fortsätta...'
           ACCEPT wc-accept

           .

      **********************************************************
       M0120-update-article.

           MOVE 'N' TO is-exit-update-menu-switch
           PERFORM UNTIL is-exit-update-menu

               DISPLAY HEADLINE
               DISPLAY 'UPPDATERA PRODUKTREGISTER'
               DISPLAY HEADLINE

               DISPLAY 'A - Artikel nummer'
               DISPLAY 'B - Beskrivning'
               DISPLAY 'K - Kostnad per faktura'
               DISPLAY SPACE
               DISPLAY 'X - Tillbaka till föregående meny'

               DISPLAY HEADLINE
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-accept

               EVALUATE FUNCTION UPPER-CASE(wc-accept)
                   WHEN 'A'
                       PERFORM M0130-update-article-number
                   WHEN 'B'
                       PERFORM M0140-update-description
                   WHEN 'K'
                       PERFORM M0150-update-charge
                   WHEN 'X'
                       SET is-exit-update-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt val!'
               END-EVALUATE

           END-PERFORM
           .
      **********************************************************
       M0130-update-article-number.

           PERFORM U0100-confirm-id-number

           IF is-existing-id-number

               DISPLAY HEADLINE
               DISPLAY 'Existerande artikelnummer: ' wc-artno
               DISPLAY 'Ge artikelnummeret för uppdatering'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-artno(1:10)

               EXEC SQL
                   UPDATE TUTORIAL.SRV
                   SET ARTNO = :wc-artno
                   WHERE SRV_ID = :w9-srv-id
               END-EXEC

               IF SQLCODE = ZERO
                   DISPLAY 'Artikelnumret har uppdaterats!'
               ELSE
                   DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *            add error trace information
                   MOVE  SQLCODE            TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.SRV'      TO wc-msg-tblcurs
                   MOVE 'M0130-update-article-number' TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF

           ELSE
               DISPLAY 'Ogiltigt id nummer - se meny 61'
           END-IF
           .

      **********************************************************
       M0140-update-description.

           PERFORM U0100-confirm-id-number

           IF is-existing-id-number

               DISPLAY HEADLINE
               DISPLAY 'Existerande beskrivning: ' wc-description
               DISPLAY 'Ge en ny beskrivning'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-description(1:40)

               EXEC SQL
                   UPDATE TUTORIAL.SRV
                   SET DESCRIPTION = :wc-description
                   WHERE SRV_ID = :w9-srv-id
               END-EXEC

               IF SQLCODE = ZERO
                   DISPLAY 'Beskrivningen har uppdaterats!'
               ELSE
                   DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *            add error trace information
                   MOVE  SQLCODE            TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.SRV'      TO wc-msg-tblcurs
                   MOVE 'M0140-update-description' TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF

           ELSE
               DISPLAY 'Ogiltigt id nummer - se meny 61'
           END-IF
           .


      **********************************************************
       M0150-update-charge.

           PERFORM U0100-confirm-id-number

           IF is-existing-id-number

               MOVE w9-charge TO we-charge

               DISPLAY HEADLINE
               DISPLAY 'Existerande produktavgift: ' we-charge
               DISPLAY 'Ge en ny avgift för denna produkt'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT w9-charge

               EVALUATE TRUE
                   WHEN w9-charge IS NUMERIC AND w9-charge NOT = ZERO

                       EXEC SQL
                           UPDATE TUTORIAL.SRV
                           SET CHARGE = :w9-charge
                           WHERE SRV_ID = :w9-srv-id
                       END-EXEC

                       IF SQLCODE = ZERO
                           DISPLAY 'Produktavgiften har uppdaterats!'
                       ELSE
                           DISPLAY 'Ett uppdateringsproblem uppstod!'

      *                    add error trace information
                           MOVE  SQLCODE            TO wn-msg-sqlcode
                           MOVE 'TUTORIAL.SRV'      TO wc-msg-tblcurs
                           MOVE 'M0150-update-charge' TO wc-msg-para

                           PERFORM Z0900-error-routine
                       END-IF
                   WHEN w9-charge EQUAL ZERO
                       DISPLAY 'Indata är 0, saknas eller är felaktiga!'
                   WHEN OTHER
                       DISPLAY 'Indata saknas eller är felaktiga!'
               END-EVALUATE

           ELSE
               DISPLAY 'Ogiltigt id nummer'
           END-IF
           .

      **********************************************************
       M0160-add-article.

           MOVE 'N' TO is-invalid-user-input-switch

           DISPLAY HEADLINE
           DISPLAY 'Ge ett nytt artikelnummer för denna nya produkt'
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-artno(1:10)

           DISPLAY HEADLINE
           DISPLAY 'Ge typkoden för denna tjänst '  WITH NO ADVANCING
           DISPLAY 'P för skriva ut fakturor, I fakturabevakning '
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept(1:1)

           EVALUATE TRUE
               WHEN wc-accept = 'P' OR wc-accept = 'p'
                   MOVE FUNCTION UPPER-CASE(wc-accept) TO wc-srv-type
               WHEN wc-accept = 'I' OR wc-accept = 'i'
                   MOVE FUNCTION UPPER-CASE(wc-accept) TO wc-srv-type
               WHEN OTHER
                   SET is-invalid-user-input TO TRUE
           END-EVALUATE

           DISPLAY HEADLINE
           DISPLAY 'Ge en ny beskrivning'
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-description(1:40)

           DISPLAY HEADLINE
           DISPLAY 'Ge en ny avgift för denna produkt'
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT w9-charge

           EVALUATE TRUE
               WHEN w9-charge IS NUMERIC AND w9-charge NOT = ZERO
                  CONTINUE
               WHEN OTHER
                  SET is-invalid-user-input TO TRUE
           END-EVALUATE

           IF is-invalid-user-input
               DISPLAY 'Givna indata är fel eller saknas - försök igen'
           ELSE
      *        open cursor
               EXEC SQL
                   OPEN BCURSRV2
               END-EXEC

      *        fetch first row
               EXEC SQL
                   FETCH BCURSRV2
                   INTO :w9-srv-id
               END-EXEC

               IF SQLCODE NOT = ZERO
                   DISPLAY 'Ett problem uppstod med nästa rad!'

      *            add error trace information
                   MOVE  SQLCODE            TO wn-msg-sqlcode
                   MOVE 'BCURSRV2'          TO wc-msg-tblcurs
                   MOVE 'M0160-add-article' TO wc-msg-para

                   PERFORM Z0900-error-routine
               ELSE
      *            add one for new article
                   ADD 1 TO w9-srv-id

      *            add product to table
                   EXEC SQL
                       INSERT INTO TUTORIAL.SRV
                       VALUES (:w9-srv-id, :wc-artno, :wc-description,
                               :w9-charge, :wc-srv-type)
                   END-EXEC

                   IF SQLCODE NOT = ZERO
                       DISPLAY 'Produkten kunde inte läggas till!'

      *                add error trace information
                       MOVE  SQLCODE            TO wn-msg-sqlcode
                       MOVE 'TUTORIAL.SRV'      TO wc-msg-tblcurs
                       MOVE 'M0160-add-article' TO wc-msg-para

                       PERFORM Z0900-error-routine

                   ELSE
                       MOVE SQLERRD(3)TO we-sqlrows
                       DISPLAY we-sqlrows ' rad har lagts till'
                   END-IF

               END-IF

      *        close cursor
               EXEC SQL
                   CLOSE BCURSRV2
               END-EXEC

           END-IF

           .

      **********************************************************
       M0170-delete-article.

           PERFORM U0100-confirm-id-number

           IF is-existing-id-number

               DISPLAY HEADLINE
               DISPLAY 'Följande produkt kommer att tas bort:'
               DISPLAY 'Artikel nummer: ' wc-artno
               DISPLAY 'Beskrivning: ' wc-description
               DISPLAY 'Är du säker på att du vill ta bort [y/N]?'
               DISPLAY ': ' WITH NO ADVANCING

               ACCEPT wc-accept
               IF FUNCTION UPPER-CASE(wc-accept) = 'Y'

                   EXEC SQL
                       DELETE FROM TUTORIAL.SRV
                       WHERE SRV_ID = :w9-srv-id
                   END-EXEC

                   IF SQLCODE = ZERO
                       DISPLAY HEADLINE
                       MOVE SQLERRD(3) TO we-sqlrows
                       DISPLAY we-sqlrows ' rad i registret borttagen'
                   ELSE
                       DISPLAY 'Ett problem uppstod vid borttagningen'

      *                add error trace information
                       MOVE  SQLCODE               TO wn-msg-sqlcode
                       MOVE 'TUTORIAL.SRV'         TO wc-msg-tblcurs
                       MOVE 'M0170-delete-article' TO wc-msg-para

                       PERFORM Z0900-error-routine
                   END-IF

               ELSE
                   DISPLAY HEADLINE
                   DISPLAY 'Bortagning avbröts av användaren'
               END-IF

           ELSE
               DISPLAY 'Ogiltigt id nummer'
           END-IF
           .


      **********************************************************
       U0100-confirm-id-number.

           MOVE 'N' TO is-existing-id-number-switch

           PERFORM U0200-list-services

           DISPLAY HEADLINE
           DISPLAY 'Ge id-nummer för åtgärd'
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT w9-srv-id

           EXEC SQL
               SELECT DISTINCT S.ARTNO, S.DESCRIPTION, S.CHARGE
                   INTO :wc-artno, :wc-description, :w9-charge
                   FROM TUTORIAL.SRV S
                   WHERE S.SRV_ID = :w9-srv-id
           END-EXEC

           IF SQLSTATE = "00000"
                SET is-existing-id-number TO TRUE
           ELSE
               IF SQLSTATE NOT = "02000"

      *            add error trace information
                   MOVE  SQLCODE                  TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.SRV'            TO wc-msg-tblcurs
                   MOVE 'U0100-confirm-id-number' TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF
           END-IF

           .

      **********************************************************
       U0200-list-services.

           DISPLAY HEADLINE
           DISPLAY 'PRODUKTREGISTER'
           DISPLAY HEADLINE
           DISPLAY 'Id|Artikel   |Beskrivning' WITH NO ADVANCING
           DISPLAY '                             |Pris/faktura (kr)'
           DISPLAY HEADLINE

           EXEC SQL
               OPEN BCURSRV1
           END-EXEC

           EXEC SQL
               FETCH BCURSRV1
                   INTO :SRV-SRV-ID, :SRV-ARTNO,
                        :SRV-DESCRIPTION, :SRV-CHARGE
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

               MOVE SRV-SRV-ID TO we-srv-id
               MOVE SRV-CHARGE TO we-charge
               DISPLAY we-srv-id
                       '|' SRV-ARTNO
                       '|' SRV-DESCRIPTION
                       '|' we-charge

      *        fetch next row
               EXEC SQL
               FETCH BCURSRV1
                   INTO :SRV-SRV-ID, :SRV-ARTNO,
                        :SRV-DESCRIPTION, :SRV-CHARGE
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURSRV1'                TO wc-msg-tblcurs
               MOVE 'U0200-list-services'     TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURSRV1
           END-EXEC

           .

      **********************************************************
       Z0900-error-routine.

      *    requires the ending dot (and no extension)!
           COPY Z0900-error-routine.
           .

      **********************************************************
