      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. customermenu IS INITIAL.
      *
      * Authors: Peter B, Bertil K and Sergejs S.
      * Purpose: Maintain customer related database tables
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

           EXEC SQL INCLUDE CUSTOMER END-EXEC.

           EXEC SQL INCLUDE SRVCUST END-EXEC.

           EXEC SQL INCLUDE ADDR END-EXEC.

           EXEC SQL INCLUDE FINDATA END-EXEC.

      **********************************************************
      *    cursor area
      **********************************************************

      *    Required variables in cursors below
       01  w9-cust-id                   PIC S9(9)    COMP.
       01  w9-srv-id                    PIC S9(9)    COMP.

      *    list PBS Ekonomi customers
           EXEC SQL
               DECLARE BCURS1 CURSOR FOR
               SELECT C.CUST_ID, C.CUSTNO, C.ORGNO, C.NAME
               FROM TUTORIAL.CUSTOMER C
               WHERE C.CUSTNO NOT LIKE 'PBS%'
               AND C.ACTIVE LIKE 'Y'
               ORDER BY C.CUST_ID
           END-EXEC

      *    contact details by customer
           EXEC SQL
               DECLARE BCURS2 CURSOR FOR
               SELECT C.NAME, C.OURCONTACT, A.STREET,
                   A.POSTNO, A.PLACE, C.BOARDPLACE, C.TEL, C.EMAIL,
                   C.WEB
                   FROM TUTORIAL.CUSTOMER C, TUTORIAL.ADDR A
                   WHERE C.CUST_ID = :w9-cust-id
                   AND C.ADDR_ID = A.ADDR_ID
           END-EXEC

      *    finance details by customer
           EXEC SQL
               DECLARE BCURS3 CURSOR FOR
               SELECT C.NAME, C.ORGNO, C.DELRATE, C.DUEDAYS,
                   F.VATREGNO, F.BANKGIRO, F.POSTGIRO, C.OURNOTE
                   FROM TUTORIAL.CUSTOMER C, TUTORIAL.FINDATA F
                   WHERE C.CUST_ID = :w9-cust-id
                   AND C.FIN_ID = F.FIN_ID
           END-EXEC

      *    services by customer
           EXEC SQL
               DECLARE BCURS4 CURSOR FOR
               SELECT C.NAME, S.TYPE, S.ARTNO, S.DESCRIPTION, S.CHARGE
                   FROM TUTORIAL.CUSTOMER C
                   INNER JOIN TUTORIAL.SRVCUST SC
                   ON C.CUST_ID = SC.CUST_ID
                   INNER JOIN TUTORIAL.SRV S
                   ON SC.SRV_ID = S.SRV_ID
                   AND C.CUST_ID = :w9-cust-id
           END-EXEC

      *    list all services
           EXEC SQL
               DECLARE BCURS5 CURSOR FOR
               SELECT S.SRV_ID, S.TYPE, S.ARTNO,
                      S.DESCRIPTION, S.CHARGE
               FROM TUTORIAL.SRV S
               ORDER BY S.SRV_ID
           END-EXEC

      *    count agreed services by customer
           EXEC SQL
               DECLARE BCURS6 CURSOR FOR
               SELECT COUNT (SC.SRV_ID)
               FROM TUTORIAL.SRVCUST SC
               WHERE SC.CUST_ID = :w9-cust-id
           END-EXEC

      *    get highest primary key in ADDR table
           EXEC SQL
               DECLARE BCURS7 CURSOR FOR
               SELECT ADDR_ID
               FROM TUTORIAL.ADDR
               ORDER BY ADDR_ID DESC
           END-EXEC

      *    get highest primary key in FINDATA table
           EXEC SQL
               DECLARE BCURS8 CURSOR FOR
               SELECT FIN_ID
               FROM TUTORIAL.FINDATA
               ORDER BY FIN_ID DESC
           END-EXEC

      *    get highest primary key in CUSTOMER table
           EXEC SQL
               DECLARE BCURS9 CURSOR FOR
               SELECT CUST_ID
               FROM TUTORIAL.CUSTOMER
               ORDER BY CUST_ID DESC
           END-EXEC

      **********************************************************
      *    switches
       01  menu-switches.
           05 is-exit-update-menu-switch      PIC X(1) VALUE 'N'.
               88  is-exit-update-menu                 VALUE 'Y'.
           05 is-existing-id-number-switch    PIC X(1) VALUE 'N'.
               88  is-existing-id-number               VALUE 'Y'.
           05 is-exit-list-menu-switch        PIC X(1) VALUE 'N'.
               88  is-exit-list-menu                   VALUE 'Y'.
           05 is-exit-add-menu-switch         PIC X(1) VALUE 'N'.
               88  is-exit-add-menu                    VALUE 'Y'.

       01  data-switches.
           05 is-complete-data-switch         PIC X(1) VALUE 'N'.
               88  is-complete-data                    VALUE 'Y'.
           05 is-add-data-saved-switch        PIC X(1) VALUE 'N'.
               88  is-add-data-saved                   VALUE 'Y'.
           05 is-addr-data-ok-switch          PIC X(1) VALUE 'N'.
               88  is-addr-data-ok                     VALUE 'Y'.
           05 is-findata-data-ok-switch       PIC X(1) VALUE 'N'.
               88  is-findata-data-ok                  VALUE 'Y'.
           05 is-customer-data-ok-switch      PIC X(1) VALUE 'N'.
               88  is-customer-data-ok                 VALUE 'Y'.
           05 is-srvcust-data-ok-switch       PIC X(1) VALUE 'N'.
               88  is-srvcust-data-ok                  VALUE 'Y'.




      *    Indicator variables (for possible table NULLs)
       01  ind-variables.
           05  ind-web                  PIC S9(4)    COMP.
           05  ind-note                 PIC S9(4)    COMP.


      *    working storage data for error routine
           COPY Z0900-error-wkstg.

      *    Various constants
       01  HEADLINE                     PIC X(78)   VALUE ALL '-'.

      *    Various generic variables
       01  wc-accept                    PIC X(2)     VALUE SPACE.
       01  w9-srv-id-new                PIC S9(9)    COMP.
       01  w9-addr-id                   PIC S9(9)    COMP.
       01  w9-fin-id                    PIC S9(9)    COMP.


       01  w9-srv-cnt                   PIC S9(4)    COMP.


       01  we-cust-id                   PIC Z9       VALUE ZERO.
       01  we-duedays                   PIC Z9       VALUE ZERO.
       01  we-delrate                   PIC 9,99     VALUE ZERO.
       01  we-charge                    PIC ZZ9,99   VALUE ZERO.
       01  we-srv-id                    PIC Z9       VALUE ZERO.
       01  we-sqlrows                   PIC Z9       VALUE ZERO.



      *    Customer related (CUSTOMER,ADDR,FINDATA) table variables
       01  wr-cust-record.
           05  wc-street              PIC X(30)    VALUE SPACE.
           05  wc-postno              PIC X(5)     VALUE SPACE.
           05  wc-place               PIC X(30)    VALUE SPACE.
           05  wc-custno              PIC X(10)    VALUE SPACE.
           05  wc-custname            PIC X(40)    VALUE SPACE.
           05  wc-boardplc            PIC X(30)    VALUE SPACE.
           05  wc-tel                 PIC X(20)    VALUE SPACE.
           05  wc-email               PIC X(40)    VALUE SPACE.
           05  wc-orgno               PIC X(11)    VALUE SPACE.
           05  wc-active              PIC X(1)     VALUE SPACE.
           05  w9-delrate             PIC S9(1)V9(2) VALUE ZERO COMP-3.
           05  w9-duedays             PIC S9(4)      VALUE ZERO COMP.
           05  wc-contact             PIC X(40)    VALUE SPACE.
           05  wc-vatregno            PIC X(14)    VALUE SPACE.
           05  wc-bankgiro            PIC X(9)     VALUE SPACE.
           05  wc-postgiro            PIC X(8)     VALUE SPACE.
           05  wc-web                 PIC X(40)    VALUE SPACE.
           05  wc-ournote             PIC X(60)    VALUE SPACE.


      *********** old variables *******************
       01  wc-charge                    PIC X(5)     VALUE SPACE.
       01  wc-artno                     PIC X(10)    VALUE SPACE.
       01  wc-description               PIC X(40)    VALUE SPACE.
       01  w9-charge                    PIC S9(3)V9(2) COMP-3.


      **********************************************************
      *    linkage area
      **********************************************************
       LINKAGE SECTION.
       01  lc-accept                    PIC X(2)    VALUE SPACE.
       
           
      **********************************************************
       PROCEDURE DIVISION USING lc-accept.
       0000-servicemenu.

      *    current source file to error handler
           MOVE 'customermenu.cbl' TO wc-msg-srcfile

           EVALUATE lc-accept

               WHEN '51'
                   PERFORM K0110-list-customers
               WHEN '52'
                   PERFORM K0160-update-customer
               WHEN '53'
                   PERFORM K0170-update-service
               WHEN '54'
                   PERFORM K0400-add-customer
               WHEN '55'
                   PERFORM K0500-delete-customer
               WHEN OTHER
                   DISPLAY 'Fel menyval från huvudprogram!'
           END-EVALUATE

           EXIT PROGRAM
           .


      **********************************************************
       K0110-list-customers.

           PERFORM U0100-list-cust-id
           PERFORM U0200-validate-id

           IF is-existing-id-number
               PERFORM K0120-list-cust-details
           END-IF
           .

      **********************************************************
       K0120-list-cust-details.

           MOVE 'N' TO is-exit-list-menu-switch
           PERFORM UNTIL is-exit-list-menu

               DISPLAY HEADLINE
               DISPLAY 'VISA KUNDDETALJER'
               DISPLAY HEADLINE

               DISPLAY 'A - Visa kundens adressdetaljer'
               DISPLAY 'F - Visa kundens finansiella detaljer'
               DISPLAY 'T - Visa kundens tjänster'

               DISPLAY SPACE
               DISPLAY 'X - Tillbaka till föregående meny'

               DISPLAY HEADLINE
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-accept

               EVALUATE FUNCTION UPPER-CASE(wc-accept)
                   WHEN 'A'
                       PERFORM K0130-address-info
                   WHEN 'F'
                       PERFORM K0140-financial-info
                   WHEN 'T'
                       PERFORM K0150-service-info
                   WHEN 'X'
                       SET is-exit-list-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       K0130-address-info.


           EXEC SQL
               OPEN BCURS2
           END-EXEC

           EXEC SQL
               FETCH BCURS2
                   INTO :CUSTOMER-NAME, :CUSTOMER-OURCONTACT,
                   :ADDR-STREET, :ADDR-POSTNO, :ADDR-PLACE,
                   :CUSTOMER-BOARDPLACE, :CUSTOMER-TEL,
                   :CUSTOMER-EMAIL, :CUSTOMER-WEB:IND-WEB
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

               DISPLAY HEADLINE

               DISPLAY 'Företag:         ' CUSTOMER-NAME
               DISPLAY 'Kontakt:         ' CUSTOMER-OURCONTACT
               DISPLAY 'Gatuadress:      ' ADDR-STREET
               DISPLAY 'Postadress:      ' ADDR-POSTNO ' ' ADDR-PLACE
               DISPLAY 'Styrelsens säte: ' CUSTOMER-BOARDPLACE
               DISPLAY 'Telefon:         ' CUSTOMER-TEL
               DISPLAY 'E-mail:          ' CUSTOMER-EMAIL

      *        dont display if NULL in table
               IF ind-web NOT = -1
                   DISPLAY 'Web:             ' CUSTOMER-WEB
               ELSE
                   DISPLAY 'Web:'
               END-IF

      *        fetch next row
               EXEC SQL
               FETCH BCURS2
                   INTO :CUSTOMER-NAME, :CUSTOMER-OURCONTACT,
                   :ADDR-STREET, :ADDR-POSTNO, :ADDR-PLACE,
                   :CUSTOMER-BOARDPLACE, :CUSTOMER-TEL,
                   :CUSTOMER-EMAIL, :CUSTOMER-WEB:IND-WEB
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS2'                  TO wc-msg-tblcurs
               MOVE 'K0130-address-info'      TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS2
           END-EXEC

           .

      **********************************************************
       K0140-financial-info.

           EXEC SQL
               OPEN BCURS3
           END-EXEC

           EXEC SQL
               FETCH BCURS3
                   INTO :CUSTOMER-NAME, :CUSTOMER-ORGNO,
                   :CUSTOMER-DELRATE, :CUSTOMER-DUEDAYS,
                   :FINDATA-VATREGNO, :FINDATA-BANKGIRO,
                   :FINDATA-POSTGIRO, :CUSTOMER-OURNOTE:IND-NOTE
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

               DISPLAY HEADLINE

               MOVE CUSTOMER-DELRATE TO we-delrate
               MOVE CUSTOMER-DUEDAYS TO we-duedays

               DISPLAY 'Företag:          ' CUSTOMER-NAME
               DISPLAY 'Organisationsnr:  ' CUSTOMER-ORGNO
               DISPLAY 'Dröjsmålsränta:   ' we-delrate
               DISPLAY 'Förfallodagar:    ' we-duedays ' dagar'
               DISPLAY 'Moms reg. nummer: ' FINDATA-VATREGNO
               DISPLAY 'Bankgiro:         ' FINDATA-BANKGIRO
               DISPLAY 'Postgiro:         ' FINDATA-POSTGIRO

      *        dont display if NULL in table
               IF ind-note NOT = -1
                   DISPLAY 'Not:              ' CUSTOMER-OURNOTE
               ELSE
                   DISPLAY 'Not:'
               END-IF

      *        fetch next row
               EXEC SQL
                   FETCH BCURS3
                   INTO :CUSTOMER-NAME, :CUSTOMER-ORGNO,
                   :CUSTOMER-DELRATE, :CUSTOMER-DUEDAYS,
                   :FINDATA-VATREGNO, :FINDATA-BANKGIRO,
                   :FINDATA-POSTGIRO, :CUSTOMER-OURNOTE:IND-NOTE
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS3'                  TO wc-msg-tblcurs
               MOVE 'K0140-financial-info'    TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS3
           END-EXEC

           .

      **********************************************************
       K0150-service-info.

           EXEC SQL
               OPEN BCURS4
           END-EXEC

           EXEC SQL
               FETCH BCURS4
                   INTO :CUSTOMER-NAME, :SRV-TYPE, :SRV-ARTNO,
                        :SRV-DESCRIPTION, :SRV-CHARGE
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

               DISPLAY HEADLINE
               MOVE SRV-CHARGE TO we-charge

               DISPLAY 'Företag:          ' CUSTOMER-NAME
               DISPLAY 'Service typkod:   ' SRV-TYPE
               DISPLAY 'Artikelnummer:    ' SRV-ARTNO
               DISPLAY 'Tjänst:           ' SRV-DESCRIPTION
               DISPLAY 'Avgift/faktura: ' we-charge ' kr'

      *        fetch next row
               EXEC SQL
                   FETCH BCURS4
                   INTO :CUSTOMER-NAME, :SRV-TYPE, :SRV-ARTNO,
                        :SRV-DESCRIPTION, :SRV-CHARGE
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS4'                  TO wc-msg-tblcurs
               MOVE 'K0150-service-info'      TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS4
           END-EXEC

           .

      **********************************************************
       K0160-update-customer.

           MOVE 'N' TO is-exit-update-menu-switch
           PERFORM UNTIL is-exit-update-menu

               DISPLAY HEADLINE
               DISPLAY 'UPPDATERA KUNDREGISTER DETALJER'
               DISPLAY HEADLINE

               DISPLAY 'Skriv en bokstavskod för att ändra uppgift'

               DISPLAY 'ST - Ändra gatuadressen'
               DISPLAY 'PO - Ändra postnumret'
               DISPLAY 'PL - Ändra postortsnamnet'

               DISPLAY 'CU - Ändra kundnumret'
               DISPLAY 'NA - Ändra företagsnamnet'
               DISPLAY 'BO - Ändra styrelsen säte'

               DISPLAY 'TE - Ändra telefonnumret'
               DISPLAY 'EM - Ändra email'
               DISPLAY 'OR - Ändra organisationsnumret'

               DISPLAY 'OU - Ändra vår kontaktperson'
               DISPLAY 'DE - Ändra dröjsmålsräntan'
               DISPLAY 'DU - Ändra antal förfallodagar'

               DISPLAY 'VA - Ändra registreringsnr. för mervärdesskatt'
               DISPLAY 'BG - Ändra bankgironumret'
               DISPLAY 'PG - Ändra postgironumret'

      *        these two items may be NULL in table CUSTOMER
               DISPLAY 'WE - Ändra optional webbaddress'
               DISPLAY 'NO - Ändra optional faktura not'

               DISPLAY SPACE
               DISPLAY 'X - Tillbaka till föregående meny'

               DISPLAY HEADLINE
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-accept

               IF FUNCTION UPPER-CASE(wc-accept) = 'X'
                   SET is-exit-update-menu TO TRUE
               ELSE
                   PERFORM K0200-update
               END-IF

           END-PERFORM
           .

      **********************************************************
       K0170-update-service.

           PERFORM U0100-list-cust-id
           PERFORM U0200-validate-id

           IF is-existing-id-number

      *        list all available agreements
               PERFORM K0175-list-agreements

               DISPLAY HEADLINE
               MOVE ZERO TO w9-srv-id
               PERFORM UNTIL w9-srv-id NOT  EQUAL ZERO
                   DISPLAY 'Välj artikel-id (*) du vill ändra på'
                   DISPLAY ': ' WITH NO ADVANCING
                   ACCEPT w9-srv-id
               END-PERFORM

               DISPLAY HEADLINE
               MOVE ZERO TO w9-srv-id-new
               DISPLAY 'Välj sedan ett nytt artikel-id'
               DISPLAY 'Välj <Enter> om du vill ta bort denna service'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT w9-srv-id-new

      *        update or remove chosen service
               IF w9-srv-id-new NOT = ZERO
                   PERFORM K0176-update-agreement
               ELSE
                   PERFORM K0177-remove-agreement
               END-IF


               IF SQLCODE NOT = ZERO
                   DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *            add error trace information
                   MOVE  SQLCODE                TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.SRVCUST'      TO wc-msg-tblcurs
                   MOVE 'K0170-update-service'  TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF

           ELSE
               DISPLAY 'Ogiltigt id nummer - se meny 61'
           END-IF
           .

      **********************************************************
       K0175-list-agreements.

           DISPLAY HEADLINE
           DISPLAY 'PRODUKTREGISTER'
           DISPLAY HEADLINE
           DISPLAY 'Id |Type|Artikel   |Beskrivning' WITH NO ADVANCING
           DISPLAY '                             |Pris/faktura (kr)'
           DISPLAY HEADLINE

           EXEC SQL
               OPEN BCURS5
           END-EXEC

           EXEC SQL
               FETCH BCURS5
                   INTO :SRV-SRV-ID, :SRV-TYPE, :SRV-ARTNO,
                        :SRV-DESCRIPTION, :SRV-CHARGE
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

      *        get in-use services for this customer
               EXEC SQL
                   SELECT DISTINCT CS.SRV_ID
                   INTO :SRVCUST-SRV-ID
                   FROM TUTORIAL.SRVCUST CS
                   WHERE CS.CUST_ID = :w9-cust-id
               END-EXEC

               MOVE SRV-SRV-ID TO we-srv-id
               MOVE SRV-CHARGE TO we-charge

      *        mark current in-use service for this customer
               IF SQLCODE NOT = 100 AND SRVCUST-SRV-ID = SRV-SRV-ID
                   DISPLAY '*' WITH NO ADVANCING
               ELSE
                   DISPLAY SPACE WITH NO ADVANCING
               END-IF

               DISPLAY we-srv-id
                       '|' SRV-TYPE
                       '   '
                       '|' SRV-ARTNO
                       '|' SRV-DESCRIPTION
                       '|' we-charge

      *        fetch next row
               EXEC SQL
               FETCH BCURS5
                   INTO :SRV-SRV-ID, :SRV-TYPE, :SRV-ARTNO,
                        :SRV-DESCRIPTION, :SRV-CHARGE
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS5'                  TO wc-msg-tblcurs
               MOVE 'K0175-list-agreements'   TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS5
           END-EXEC
           .

      **********************************************************
       K0176-update-agreement.

           EXEC SQL
               UPDATE TUTORIAL.SRVCUST
               SET SRV_ID = :w9-srv-id-new
               WHERE CUST_ID = :w9-cust-id
               AND SRV_ID = :w9-srv-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Avtalet med PBS har uppdaterats!'
           END-IF

           .

      **********************************************************
       K0177-remove-agreement.

      *    dont allow removal if only one service remains
           EXEC SQL
               OPEN BCURS6
           END-EXEC

      *    fetch first row
           EXEC SQL
               FETCH BCURS6
               INTO :w9-srv-cnt
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

      *        fetch next
               EXEC SQL
                   FETCH BCURS6
                   INTO :w9-srv-cnt
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS6'                  TO wc-msg-tblcurs
               MOVE 'K0177-remove-agreement'  TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS6
           END-EXEC

      *    remove service only if more than one remains
           IF w9-srv-cnt > 1

               EXEC SQL
                   DELETE FROM TUTORIAL.SRVCUST
                       WHERE CUST_ID = :w9-cust-id
                       AND SRV_ID = :w9-srv-id
               END-EXEC

               IF SQLCODE = ZERO
                   DISPLAY HEADLINE
                   MOVE SQLERRD(3) TO we-sqlrows
                   DISPLAY we-sqlrows ' rad i registret borttagen'
               ELSE
      *            add error trace information
                   MOVE  SQLCODE                  TO wn-msg-sqlcode
                   MOVE 'SRVCUST'                 TO wc-msg-tblcurs
                   MOVE 'K0177-remove-agreement'  TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF

           ELSE
               DISPLAY HEADLINE
               DISPLAY 'Otillåten operation!'
               DISPLAY 'Minst en service måste återstå!'
           END-IF

           .

      **********************************************************
       K0190-update-our-items.

           PERFORM U0200-validate-id

           IF is-existing-id-number

               DISPLAY HEADLINE
               DISPLAY 'Existerande beskrivning: ' wc-description
               DISPLAY 'Ge en ny beskrivning'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-description(1:40)

               EXEC SQL
                   UPDATE TUTORIAL.SRV
                   SET DESCRIPTION = :wc-description
                   WHERE SRV_ID = :w9-cust-id
               END-EXEC

               IF SQLCODE = ZERO
                   DISPLAY 'Beskrivningen har uppdaterats!'
               ELSE
                   DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *            add error trace information
                   MOVE  SQLCODE                 TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.SRV'           TO wc-msg-tblcurs
                   MOVE 'K0180-update-our-items' TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF

           ELSE
               DISPLAY 'Ogiltigt id nummer - se meny 61'
           END-IF
           .

      **********************************************************
       K0200-update.

           PERFORM U0100-list-cust-id
           PERFORM U0200-validate-id

           IF is-existing-id-number

               IF FUNCTION UPPER-CASE(wc-accept) = 'ST'
                   PERFORM K0210-update-street
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'PO'
                   PERFORM K0220-update-pono
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'PL'
                   PERFORM K0230-update-place
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'CU'
                   PERFORM K0240-update-custno
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'NA'
                   PERFORM K0250-update-custname
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'BO'
                   PERFORM K0260-update-boardplc
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'TE'
                   PERFORM K0270-update-tel
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'EM'
                   PERFORM K0280-update-email
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'OR'
                   PERFORM K0290-update-orgno
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'DE'
                   PERFORM K0300-update-delrate
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'DU'
                   PERFORM K0310-update-duedays
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'OU'
                   PERFORM K0320-update-contact
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'VA'
                   PERFORM K0330-update-vatno
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'BG'
                   PERFORM K0340-update-bg
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'PG'
                   PERFORM K0350-update-pg
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'WE'
                   PERFORM K0360-update-web
               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'NO'
                   PERFORM K0370-update-note
               ELSE
                   DISPLAY 'Ej giltigt val!'
               END-IF

           ELSE
               DISPLAY 'Ogiltigt id nummer - se meny 61'
           END-IF
           .

      **********************************************************
       K0210-update-street.

           MOVE SPACE TO wc-street
           PERFORM UNTIL wc-street NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande gatuadress: ' ADDR-STREET
               DISPLAY 'Ge en ny gatuadress'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-street
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.ADDR
               SET STREET = :wc-street
               WHERE ADDR_ID = :CUSTOMER-ADDR-ID
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Gatuadressen har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE              TO wn-msg-sqlcode
               MOVE 'TUTORIAL.ADDR'       TO wc-msg-tblcurs
               MOVE 'K0210-update-street' TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

           .

      **********************************************************
       K0220-update-pono.

           MOVE SPACE TO wc-postno
           PERFORM UNTIL wc-postno NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande postnummer: ' ADDR-POSTNO
               DISPLAY 'Ge ett nytt postnummer'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-postno
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.ADDR
               SET POSTNO = :wc-postno
               WHERE ADDR_ID = :CUSTOMER-ADDR-ID
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Postnumret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE              TO wn-msg-sqlcode
               MOVE 'TUTORIAL.ADDR'       TO wc-msg-tblcurs
               MOVE 'K0220-update-pono'   TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

           .

      **********************************************************
       K0230-update-place.

           MOVE SPACE TO wc-place
           PERFORM UNTIL wc-place NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande postort: ' ADDR-PLACE
               DISPLAY 'Ge en ny postort'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-place
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.ADDR
               SET PLACE = :wc-place
               WHERE ADDR_ID = :CUSTOMER-ADDR-ID
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Postorten har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE              TO wn-msg-sqlcode
               MOVE 'TUTORIAL.ADDR'       TO wc-msg-tblcurs
               MOVE 'K0230-update-place'  TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0240-update-custno.

           MOVE SPACE TO wc-custno
           PERFORM UNTIL wc-custno NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande kundnummer: ' CUSTOMER-CUSTNO
               DISPLAY 'Ge ett nytt kundnummer'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-custno
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET CUSTNO = :wc-custno
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Kundnumret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE              TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'   TO wc-msg-tblcurs
               MOVE 'K0240-update-custno' TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0250-update-custname.

           MOVE SPACE TO wc-custname
           PERFORM UNTIL wc-custname NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande kundnamn: ' CUSTOMER-NAME
               DISPLAY 'Ge ett nytt kundnamn'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-custname
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET NAME = :wc-custname
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Kundnamnet har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'       TO wc-msg-tblcurs
               MOVE 'K0250-update-custname'   TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0260-update-boardplc.

           MOVE SPACE TO wc-boardplc
           PERFORM UNTIL wc-boardplc NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande ort för styrelsen: '
                                               CUSTOMER-BOARDPLACE
               DISPLAY 'Ge en ny ort för styrelsen'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-boardplc
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET BOARDPLACE = :wc-boardplc
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Ort för styrelsen har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                 TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'      TO wc-msg-tblcurs
               MOVE 'K0260-update-boardplc'  TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0270-update-tel.

           MOVE SPACE TO wc-tel
           PERFORM UNTIL wc-tel NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande telefonnummer: ' CUSTOMER-TEL
               DISPLAY 'Ge ett nytt telefonnummer'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-tel
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET TEL = :wc-tel
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Telefonnumret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE              TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'   TO wc-msg-tblcurs
               MOVE 'K0270-update-tel'    TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0280-update-email.

           MOVE SPACE TO wc-email
           PERFORM UNTIL wc-email NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande email-adress: ' CUSTOMER-EMAIL
               DISPLAY 'Ge en ny email-adress'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-email
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET EMAIL = :wc-email
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Email har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'       TO wc-msg-tblcurs
               MOVE 'K0280-update-email'      TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0290-update-orgno.

           MOVE SPACE TO wc-orgno
           PERFORM UNTIL wc-orgno NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande org.nummer: ' CUSTOMER-ORGNO
               DISPLAY 'Ge en nytt org. nummer (YYMMDD-nnnn)'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-orgno
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET ORGNO = :wc-orgno
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Organisationsnumret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                 TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'      TO wc-msg-tblcurs
               MOVE 'K0290-update-orgno'     TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0300-update-delrate.

           MOVE ZERO TO w9-delrate
           PERFORM UNTIL w9-delrate NOT EQUAL ZERO
               DISPLAY HEADLINE
               MOVE CUSTOMER-DELRATE to we-delrate
               DISPLAY 'Existerande dröjsmålsränta: ' we-delrate
               DISPLAY 'Ge en ny dröjsmålsränta'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT w9-delrate
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET DELRATE = :w9-delrate
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Dröjsmålsräntan har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'       TO wc-msg-tblcurs
               MOVE 'K0300-update-delrate'    TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0310-update-duedays.

           MOVE ZERO TO w9-duedays
           PERFORM UNTIL w9-duedays NOT EQUAL ZERO
               DISPLAY HEADLINE
               MOVE CUSTOMER-DUEDAYS TO we-duedays
               DISPLAY 'Existerande förfallodagar: ' we-duedays
               DISPLAY 'Ge ett nytt antal förfallodagar'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT w9-duedays
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET DUEDAYS = :w9-duedays
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Antal förfallodagar har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                    TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'         TO wc-msg-tblcurs
               MOVE 'K0310-update-duedays'      TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0320-update-contact.

           MOVE SPACE TO wc-contact
           PERFORM UNTIL wc-contact NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande kontaktperson: '
                                       CUSTOMER-OURCONTACT
               DISPLAY 'Ge ett nytt namn på kontaktperson'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-contact
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.CUSTOMER
               SET OURCONTACT = :wc-contact
               WHERE CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Vår kontaktperson har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                   TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'        TO wc-msg-tblcurs
               MOVE 'K0320-update-contact'     TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0330-update-vatno.

           MOVE SPACE TO wc-vatregno
           PERFORM UNTIL wc-vatregno NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande moms reg. nummer: '
                                                FINDATA-VATREGNO
               DISPLAY 'Ge ett nytt moms reg. nummer'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-vatregno
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.FINDATA
               SET VATREGNO = :wc-vatregno
               WHERE FIN_ID = :CUSTOMER-FIN-ID
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Moms reg. numret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'TUTORIAL.FINDATA'        TO wc-msg-tblcurs
               MOVE 'K0330-update-vatno'      TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0340-update-bg.

           MOVE SPACE TO wc-bankgiro
           PERFORM UNTIL wc-bankgiro NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande bankgironummer: ' FINDATA-BANKGIRO
               DISPLAY 'Ge ett nytt bankgironummer'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-bankgiro
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.FINDATA
               SET BANKGIRO = :wc-bankgiro
               WHERE FIN_ID = :CUSTOMER-FIN-ID
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Bankgironumret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                    TO wn-msg-sqlcode
               MOVE 'TUTORIAL.FINDATA'          TO wc-msg-tblcurs
               MOVE 'K0340-update-bg'           TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0350-update-pg.

           MOVE SPACE TO wc-postgiro
           PERFORM UNTIL wc-postgiro NOT EQUAL SPACE
               DISPLAY HEADLINE
               DISPLAY 'Existerande postgironummer: '
                                       FINDATA-POSTGIRO
               DISPLAY 'Ge ett nytt postgironummer'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-postgiro
           END-PERFORM

           EXEC SQL
               UPDATE TUTORIAL.FINDATA
               SET POSTGIRO = :wc-postgiro
               WHERE FIN_ID = :CUSTOMER-FIN-ID
           END-EXEC

           IF SQLCODE = ZERO
               DISPLAY 'Postgironumret har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                   TO wn-msg-sqlcode
               MOVE 'TUTORIAL.FINDATA'         TO wc-msg-tblcurs
               MOVE 'K0350-update-pg'          TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0360-update-web.

           MOVE SPACE TO wc-web
           DISPLAY HEADLINE
           DISPLAY 'Press <Enter> för att ta bort en adress'

           IF ind-web NOT = -1
               DISPLAY 'Existerande webbadress: ' CUSTOMER-WEB
           ELSE
               DISPLAY 'Existerande webbadress:'
           END-IF

           DISPLAY 'Ge en ny webbadress'
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-web

      *    table field accept NULL
           IF wc-web EQUAL SPACE
               MOVE -1 TO ind-web
               EXEC SQL
                   UPDATE TUTORIAL.CUSTOMER
                   SET WEB = NULL
                   WHERE CUST_ID = :w9-cust-id
               END-EXEC
           ELSE
               MOVE ZERO TO ind-web
               EXEC SQL
                   UPDATE TUTORIAL.CUSTOMER
                   SET WEB = :wc-web
                   WHERE CUST_ID = :w9-cust-id
               END-EXEC
           END-IF

           IF SQLCODE = ZERO
               DISPLAY 'Webbadressen har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                    TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'         TO wc-msg-tblcurs
               MOVE 'K0360-update-web'           TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .

      **********************************************************
       K0370-update-note.

           MOVE SPACE TO wc-ournote
           DISPLAY HEADLINE
           DISPLAY 'Press <Enter> för att ta bort not på faktura'

           IF ind-note NOT = -1
               DISPLAY 'Existerande not på faktura: ' CUSTOMER-OURNOTE
           ELSE
               DISPLAY 'Existerande not på faktura:'
           END-IF

           DISPLAY 'Ge en ny not på faktura'
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-ournote

      *    table field accept NULL
           IF wc-ournote EQUAL SPACE
               MOVE -1 TO ind-note
               EXEC SQL
                   UPDATE TUTORIAL.CUSTOMER
                   SET OURNOTE = NULL
                   WHERE CUST_ID = :w9-cust-id
               END-EXEC
           ELSE
               MOVE ZERO TO ind-note
               EXEC SQL
                   UPDATE TUTORIAL.CUSTOMER
                   SET OURNOTE = :wc-ournote
                   WHERE CUST_ID = :w9-cust-id
               END-EXEC
           END-IF

           IF SQLCODE = ZERO
               DISPLAY 'Noten på faktura har uppdaterats!'
               PERFORM U0300-enter-to-continue
           ELSE
               DISPLAY 'Ett problem uppstod vid uppdateringen!'

      *        add error trace information
               MOVE  SQLCODE                    TO wn-msg-sqlcode
               MOVE 'TUTORIAL.CUSTOMER'         TO wc-msg-tblcurs
               MOVE 'K0370-update-not'          TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF
           .
      **********************************************************
       K0400-add-customer.

           MOVE 'N' TO is-exit-add-menu-switch
           MOVE 'N' TO is-add-data-saved-switch
           MOVE ZERO TO we-delrate
           MOVE ZERO TO we-duedays
           INITIALIZE wr-cust-record

           PERFORM UNTIL is-exit-add-menu

               DISPLAY HEADLINE
               DISPLAY 'LÄGG UPP NY KUND I REGISTRET'
               DISPLAY HEADLINE

               DISPLAY 'Skriv bokstavskod för att lägga till uppgift'

               DISPLAY 'NA - Företag                   : ' wc-custname
               DISPLAY 'ST - Gatuadress                : ' wc-street
               DISPLAY 'PO - Postnummer                : ' wc-postno
               DISPLAY 'PL - Postort                   : ' wc-place
               DISPLAY 'TE - Telefon                   : ' wc-tel
               DISPLAY 'EM - Email                     : ' wc-email
               DISPLAY 'OR - Org. nummer               : ' wc-orgno
               DISPLAY 'OU - Kontaktperson             : ' wc-contact
               DISPLAY 'CU - Kundnummer                : ' wc-custno
               DISPLAY 'BO - Styrelsen säte            : ' wc-boardplc
               DISPLAY 'DE - Dröjsmålsränta            : ' we-delrate
               DISPLAY 'DU - Förfallodagar             :   ' we-duedays
               DISPLAY 'VA - MVS reg. nr               : ' wc-vatregno
               DISPLAY 'BG - Bankgiro                  : ' wc-bankgiro
               DISPLAY 'PG - Postgiro                  : ' wc-postgiro

      *        these two items may be NULL in table CUSTOMER
               DISPLAY 'WE - Webbaddress (optional)    : ' wc-web
               DISPLAY 'NO - Text på faktura (optional): ' wc-ournote

               DISPLAY 'S - Spara ovanstående uppgifter'
               DISPLAY 'X - Tillbaka till föregående meny'

               DISPLAY HEADLINE
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT wc-accept

               IF FUNCTION UPPER-CASE(wc-accept) = 'X'

                   IF NOT is-add-data-saved
                       DISPLAY HEADLINE
                       DISPLAY 'Kunddata är inte sparat än!'
                       DISPLAY 'Osparade data går ' WITH NO ADVANCING
                       DISPLAY 'förlorade om du lämnar menyn.'
                       DISPLAY 'Vill du lämna denna meny [j/N]?'
                       DISPLAY ': ' WITH NO ADVANCING
                       ACCEPT wc-accept
                       IF FUNCTION UPPER-CASE(wc-accept) = 'J'
                           SET is-exit-add-menu TO TRUE
                       END-IF
                   ELSE
                       SET is-exit-add-menu TO TRUE
                   END-IF

               ELSE IF FUNCTION UPPER-CASE(wc-accept) = 'S'

                   IF is-add-data-saved
                       DISPLAY HEADLINE
                       DISPLAY 'Dessa kunddata är redan sparade!'
                       DISPLAY 'Lämna menyn med X'
                       PERFORM U0300-enter-to-continue
                   ELSE
                       PERFORM K0410-save-cust-detail
                   END-IF

               ELSE
                   PERFORM K0420-get-cust-detail
               END-IF

           END-PERFORM

           .

      **********************************************************
       K0410-save-cust-detail.


      *    initially assume all input data is complete
           SET is-complete-data TO TRUE

      *    check that all required customer data is given
           IF wc-street = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-postno = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-place = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-custno = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-custname = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-boardplc = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-tel = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-email = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-orgno = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF w9-delrate = ZERO
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF w9-duedays = ZERO
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-contact = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-vatregno = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-bankgiro = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF
           IF wc-postgiro = SPACE
               MOVE 'N' TO is-complete-data-switch
           END-IF

      *    handle not mandatory items (may be NULL i CUSTOMER table)
           IF wc-web = SPACE
               MOVE -1 TO ind-web
           ELSE
               MOVE ZERO TO ind-web
           END-IF

           IF wc-ournote = SPACE
               MOVE -1 TO ind-web
           ELSE
               MOVE ZERO TO ind-web
           END-IF

           IF is-complete-data
      *        set this customer as active
               MOVE 'Y' TO wc-active
               PERFORM K0430-insert-customer-data
           ELSE
               DISPLAY 'Nödvändiga uppgifter för kund saknas!'
               PERFORM U0300-enter-to-continue
           END-IF

           .

      **********************************************************
       K0420-get-cust-detail.

      *    TODO: validate input

           EVALUATE FUNCTION UPPER-CASE(wc-accept)
               WHEN 'NA'
                   DISPLAY HEADLINE
                   DISPLAY 'Företagsnamn: ' WITH NO ADVANCING
                   ACCEPT wc-custname
               WHEN 'ST'
                   DISPLAY HEADLINE
                   DISPLAY 'Gatuadress: ' WITH NO ADVANCING
                   ACCEPT wc-street
               WHEN 'PO'
                   DISPLAY HEADLINE
                   DISPLAY 'Postnummer: ' WITH NO ADVANCING
                   ACCEPT wc-postno
               WHEN 'PL'
                   DISPLAY HEADLINE
                   DISPLAY 'Postort: ' WITH NO ADVANCING
                   ACCEPT wc-place
               WHEN 'TE'
                   DISPLAY HEADLINE
                   DISPLAY 'Telefon: ' WITH NO ADVANCING
                   ACCEPT wc-tel
               WHEN 'EM'
                   DISPLAY HEADLINE
                   DISPLAY 'Email: ' WITH NO ADVANCING
                   ACCEPT wc-email
               WHEN 'OR'
                   DISPLAY HEADLINE
                   DISPLAY 'Org. nummer: ' WITH NO ADVANCING
                   ACCEPT wc-orgno
               WHEN 'OU'
                   DISPLAY HEADLINE
                   DISPLAY 'Kontaktperson: ' WITH NO ADVANCING
                   ACCEPT wc-contact
               WHEN 'CU'
                   DISPLAY HEADLINE
                   DISPLAY 'Kundnummer: ' WITH NO ADVANCING
                   ACCEPT wc-custno
               WHEN 'BO'
                   DISPLAY HEADLINE
                   DISPLAY 'Styrelsen säte: ' WITH NO ADVANCING
                   ACCEPT wc-boardplc
               WHEN 'DE'
                   DISPLAY HEADLINE
                   DISPLAY 'Dröjsmålsränta: ' WITH NO ADVANCING
                   ACCEPT w9-delrate
                   MOVE w9-delrate TO we-delrate
               WHEN 'DU'
                   DISPLAY HEADLINE
                   DISPLAY 'Förfallodagar: ' WITH NO ADVANCING
                   ACCEPT w9-duedays
                   MOVE w9-duedays TO we-duedays
               WHEN 'VA'
                   DISPLAY HEADLINE
                   DISPLAY 'MVS reg. nr: ' WITH NO ADVANCING
                   ACCEPT wc-vatregno
               WHEN 'BG'
                   DISPLAY HEADLINE
                   DISPLAY 'Bankgiro: ' WITH NO ADVANCING
                   ACCEPT wc-bankgiro
               WHEN 'PG'
                   DISPLAY HEADLINE
                   DISPLAY 'Postgiro: ' WITH NO ADVANCING
                   ACCEPT wc-postgiro
               WHEN 'WE'
                   DISPLAY HEADLINE
                   DISPLAY 'Webbaddress (optional): ' WITH NO ADVANCING
                   ACCEPT wc-web
               WHEN 'NO'
                   DISPLAY HEADLINE
                   DISPLAY 'Text på faktura (optional)'
                                WITH NO ADVANCING
                   DISPLAY ': ' WITH NO ADVANCING
                   ACCEPT wc-ournote
               WHEN OTHER
                   DISPLAY HEADLINE
                   DISPLAY 'Ogiltigt val i menyn! Försök igen.'
                   PERFORM U0300-enter-to-continue
                   PERFORM
           END-EVALUATE
           .

      **********************************************************
       K0430-insert-customer-data.

           MOVE 'N' TO is-addr-data-ok-switch
           MOVE 'N' TO is-findata-data-ok-switch
           MOVE 'N' TO is-customer-data-ok-switch
           MOVE 'N' TO is-srvcust-data-ok-switch

      *    finally add customer data to all tables
           PERFORM K0440-add-to-addr

           PERFORM K0450-add-to-findata

           PERFORM K0460-add-to-customer

      *    add an initial default service to this new customer
           PERFORM K0470-cust-to-srvcust

           IF is-addr-data-ok AND is-findata-data-ok
                              AND is-customer-data-ok
                              AND is-srvcust-data-ok

               SET is-add-data-saved TO TRUE

               DISPLAY HEADLINE
               DISPLAY 'Ny kund upplagd!'
               PERFORM U0300-enter-to-continue

           ELSE
               DISPLAY HEADLINE
               DISPLAY 'Databasfel. Kunden kunde inte sparas korrekt'
               PERFORM U0300-enter-to-continue
           END-IF

           .

      **********************************************************
       K0440-add-to-addr.

      *    open cursor
           EXEC SQL
               OPEN BCURS7
           END-EXEC

      *    fetch first row (which now have the highest id/PK)
           EXEC SQL
               FETCH BCURS7
               INTO :w9-addr-id
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY 'Ett problem uppstod för att hitta nästa rad!'

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS7'                  TO wc-msg-tblcurs
               MOVE 'K0440-add-to-addr-tbl'   TO wc-msg-para

               PERFORM Z0900-error-routine
           ELSE
      *        add one for new customer address details
               ADD 1 TO w9-addr-id

               EXEC SQL
                   INSERT INTO TUTORIAL.ADDR
                   VALUES (:w9-addr-id,:wc-street,
                           :wc-postno, :wc-place)
               END-EXEC

               IF SQLCODE NOT = ZERO
                   DISPLAY 'Kundens adress kunde inte läggas till!'

      *            add error trace information
                   MOVE  SQLCODE            TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.ADDR'     TO wc-msg-tblcurs
                   MOVE 'K0440-add-to-addr' TO wc-msg-para

                   PERFORM Z0900-error-routine
               ELSE
                   MOVE SQLERRD(3)TO we-sqlrows
                   DISPLAY we-sqlrows ' rad har lagts till i ADDR'
                   SET is-addr-data-ok TO TRUE
               END-IF

           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS7
           END-EXEC

           .

      **********************************************************
       K0450-add-to-findata.

      *    open cursor
           EXEC SQL
               OPEN BCURS8
           END-EXEC

      *    fetch first row (which now have the highest id/PK)
           EXEC SQL
               FETCH BCURS8
               INTO :w9-fin-id
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY 'Ett problem uppstod för att hitta nästa rad!'

      *        add error trace information
               MOVE  SQLCODE                TO wn-msg-sqlcode
               MOVE 'BCURS8'                TO wc-msg-tblcurs
               MOVE 'K0450-add-to-findata'  TO wc-msg-para

               PERFORM Z0900-error-routine
           ELSE
      *        add one for new customer address details
               ADD 1 TO w9-fin-id

               EXEC SQL
                   INSERT INTO TUTORIAL.FINDATA
                   VALUES (:w9-fin-id,   :wc-vatregno,
                           :wc-bankgiro, :wc-postgiro)
               END-EXEC

               IF SQLCODE NOT = ZERO
                   DISPLAY 'Kundens finansdata kunde inte läggas till!'

      *            add error trace information
                   MOVE  SQLCODE               TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.FINDATA'     TO wc-msg-tblcurs
                   MOVE 'K0450-add-to-findata' TO wc-msg-para

                   PERFORM Z0900-error-routine
               ELSE
                   MOVE SQLERRD(3)TO we-sqlrows
                   DISPLAY we-sqlrows ' rad har lagts till i FINDATA'
                   SET is-findata-data-ok TO TRUE
               END-IF

           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS8
           END-EXEC
           .

      **********************************************************
       K0460-add-to-customer.

      *    open cursor
           EXEC SQL
               OPEN BCURS9
           END-EXEC

      *    fetch first row (which now have the highest id/PK)
           EXEC SQL
               FETCH BCURS9
               INTO :w9-cust-id
           END-EXEC


           IF SQLCODE NOT = ZERO
               DISPLAY 'Ett problem uppstod för att hitta nästa rad!'

      *        add error trace information
               MOVE  SQLCODE                 TO wn-msg-sqlcode
               MOVE 'BCURS9'                 TO wc-msg-tblcurs
               MOVE 'K0460-add-to-customer'  TO wc-msg-para

               PERFORM Z0900-error-routine
           ELSE
      *        add one for new customer
               ADD 1 TO w9-cust-id

               EXEC SQL
                   INSERT INTO TUTORIAL.CUSTOMER
                   VALUES (:w9-cust-id, :wc-custno,
                       :wc-custname, :wc-boardplc,
                       :wc-contact, :wc-ournote:ind-note,
                       :wc-tel, :wc-email,
                       :wc-web:ind-web, :wc-orgno,
                       :wc-active, :w9-addr-id, :w9-fin-id,
                       :w9-delrate, :w9-duedays)
               END-EXEC

               IF SQLCODE NOT = ZERO
                   DISPLAY 'Kundens basdata kunde inte läggas till!'

      *            add error trace information
                   MOVE  SQLCODE                TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.CUSTOMER'     TO wc-msg-tblcurs
                   MOVE 'K0460-add-to-customer' TO wc-msg-para

                   PERFORM Z0900-error-routine
               ELSE
                   MOVE SQLERRD(3)TO we-sqlrows
                   DISPLAY we-sqlrows ' rad har lagts till i CUSTOMER'
                   SET is-customer-data-ok TO TRUE
               END-IF

           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS9
           END-EXEC

           .

      **********************************************************
       K0470-cust-to-srvcust.

      *    open cursor
           EXEC SQL
               OPEN BCURS5
           END-EXEC

      *    fetch first row (which now have the lowest service id/PK)
           EXEC SQL
               FETCH BCURS5
               INTO :w9-srv-id
           END-EXEC

           IF SQLCODE NOT = ZERO
               DISPLAY 'Ett problem uppstod att hitta default service!'

      *        add error trace information
               MOVE  SQLCODE                 TO wn-msg-sqlcode
               MOVE 'BCURS5'                 TO wc-msg-tblcurs
               MOVE 'K0470-cust-to-srvcust'  TO wc-msg-para

               PERFORM Z0900-error-routine
           ELSE

      *        insert the default service
               EXEC SQL
                   INSERT INTO TUTORIAL.SRVCUST
                   VALUES (:w9-srv-id, :w9-cust-id)
               END-EXEC

               IF SQLCODE NOT = ZERO
                   DISPLAY 'Kundens service kunde inte läggas till!'

      *            add error trace information
                   MOVE  SQLCODE                TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.SRVCUST'      TO wc-msg-tblcurs
                   MOVE 'K0470-cust-to-srvcust' TO wc-msg-para

                   PERFORM Z0900-error-routine
               ELSE
                   MOVE SQLERRD(3)TO we-sqlrows
                   DISPLAY we-sqlrows ' rad har lagts till i SRVCUST'
                   SET is-srvcust-data-ok TO TRUE
               END-IF

           END-IF

      *    close cursor
           EXEC SQL
               CLOSE BCURS5
           END-EXEC

           .

      **********************************************************
       K0500-delete-customer.

           PERFORM U0100-list-cust-id

           PERFORM U0200-validate-id

           IF is-existing-id-number

               DISPLAY HEADLINE
               DISPLAY 'Följande kund kommer att tas bort:'
               DISPLAY 'Namn: ' CUSTOMER-NAME
               DISPLAY 'Organisationsnummer: ' CUSTOMER-ORGNO
               DISPLAY 'Är du säker på att du vill ta bort [j/N]?'
               DISPLAY ': ' WITH NO ADVANCING

               ACCEPT wc-accept
               IF FUNCTION UPPER-CASE(wc-accept) = 'J'

                   EXEC SQL
                       UPDATE TUTORIAL.CUSTOMER
                       SET ACTIVE = 'N'
                       WHERE CUST_ID = :w9-cust-id
                   END-EXEC

                   IF SQLCODE = ZERO
                       DISPLAY HEADLINE
                       DISPLAY 'Kund märkt för borttagning'
                   ELSE
                       DISPLAY 'Ett problem uppstod vid borttagningen'

      *                add error trace information
                       MOVE  SQLCODE                TO wn-msg-sqlcode
                       MOVE 'TUTORIAL.CUSTOMER'     TO wc-msg-tblcurs
                       MOVE 'K0400-delete-customer' TO wc-msg-para

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
       U0100-list-cust-id.

           DISPLAY HEADLINE
           DISPLAY 'KUNDREGISTER'
           DISPLAY HEADLINE
           DISPLAY 'Id|Kundnummer|Org. nummer|Namn'
           DISPLAY HEADLINE

           EXEC SQL
               OPEN BCURS1
           END-EXEC

           EXEC SQL
               FETCH BCURS1
                   INTO :CUSTOMER-CUST-ID, :CUSTOMER-CUSTNO,
                        :CUSTOMER-ORGNO, :CUSTOMER-NAME
           END-EXEC

           PERFORM UNTIL SQLCODE NOT = ZERO

               MOVE CUSTOMER-CUST-ID TO we-cust-id
               DISPLAY we-cust-id
                       '|' CUSTOMER-CUSTNO
                       '|' CUSTOMER-ORGNO
                       '|' CUSTOMER-NAME

      *        fetch next row
               EXEC SQL
               FETCH BCURS1
                   INTO :CUSTOMER-CUST-ID, :CUSTOMER-CUSTNO,
                        :CUSTOMER-ORGNO, :CUSTOMER-NAME
               END-EXEC

           END-PERFORM

      *    end of data
           IF SQLSTATE NOT = "02000"

      *        add error trace information
               MOVE  SQLCODE                  TO wn-msg-sqlcode
               MOVE 'BCURS1'                  TO wc-msg-tblcurs
               MOVE 'U0100-list-cust-id' TO wc-msg-para

               PERFORM Z0900-error-routine
           END-IF

      *    close cursor sum up revenue
           EXEC SQL
               CLOSE BCURS1
           END-EXEC
           .

      **********************************************************
       U0200-validate-id.

           MOVE 'N' TO is-existing-id-number-switch

           MOVE ZERO TO w9-cust-id
           PERFORM UNTIL w9-cust-id > 1
               DISPLAY HEADLINE
               DISPLAY 'Ge kundens id-nummer för nästa åtgärd'
               DISPLAY ': ' WITH NO ADVANCING
               ACCEPT w9-cust-id
           END-PERFORM

           EXEC SQL
               SELECT DISTINCT C.CUSTNO, C.NAME,C.BOARDPLACE,
               C.OURCONTACT, C.TEL,C.EMAIL,C.ORGNO,C.DELRATE,C.DUEDAYS,
               A.STREET,A.POSTNO,A.PLACE,
               F.VATREGNO,F.BANKGIRO,F.POSTGIRO,C.ADDR_ID,C.FIN_ID,
               C.WEB, C.OURNOTE, C.ACTIVE
               INTO :CUSTOMER-CUSTNO, :CUSTOMER-NAME,
                    :CUSTOMER-BOARDPLACE, :CUSTOMER-OURCONTACT,
                    :CUSTOMER-TEL, :CUSTOMER-EMAIL, :CUSTOMER-ORGNO,
                    :CUSTOMER-DELRATE, :CUSTOMER-DUEDAYS,
                    :ADDR-STREET, :ADDR-POSTNO, :ADDR-PLACE,
                    :FINDATA-VATREGNO, :FINDATA-BANKGIRO,
                    :FINDATA-POSTGIRO,
                    :CUSTOMER-ADDR-ID, :CUSTOMER-FIN-ID,
                    :CUSTOMER-WEB:IND-WEB,:CUSTOMER-OURNOTE:IND-NOTE,
                    :CUSTOMER-ACTIVE
               FROM TUTORIAL.CUSTOMER C
               JOIN TUTORIAL.ADDR A
               ON C.ADDR_ID = A.ADDR_ID
               JOIN TUTORIAL.FINDATA F
               ON C.FIN_ID = F.FIN_ID
               WHERE C.CUST_ID = :w9-cust-id
           END-EXEC

           IF SQLSTATE = "00000"

                IF CUSTOMER-ACTIVE = 'N'
                   DISPLAY HEADLINE
                   DISPLAY 'Kund Id-nummer är ogiltigt - borrtaget'
                   PERFORM U0300-enter-to-continue
                ELSE
                   SET is-existing-id-number TO TRUE
                END-IF

           ELSE
               IF SQLSTATE NOT = "02000"

      *            add error trace information
                   MOVE  SQLCODE                  TO wn-msg-sqlcode
                   MOVE 'TUTORIAL.CUSTOMER'       TO wc-msg-tblcurs
                   MOVE 'U0200-validate-id' TO wc-msg-para

                   PERFORM Z0900-error-routine
               END-IF

               DISPLAY HEADLINE
               DISPLAY 'Id-numret: ' w9-cust-id  ' tillhör ingen kund!'
               PERFORM U0300-enter-to-continue

           END-IF
           .

      **********************************************************
       U0300-enter-to-continue.

           DISPLAY SPACE
           DISPLAY 'Press <Enter> för att fortsätta...'
           ACCEPT wc-accept
           .

      **********************************************************
       Z0900-error-routine.

      *    requires the ending dot (and no extension)!
           COPY Z0900-error-routine.
           .

      **********************************************************
