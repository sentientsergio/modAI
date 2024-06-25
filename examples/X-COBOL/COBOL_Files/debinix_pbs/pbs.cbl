      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. pbs.
      *
      * Authors: Peter B, Bertil K and Sergejs S.
      * Purpose: Manage an invoice print company (PBS)
      * Initial Version Created: 2014-03-11
      *
      **********************************************************
       ENVIRONMENT DIVISION.
      *---------------------------------------------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      **********************************************************
       DATA DIVISION.
      *---------------------------------------------------------
       FILE SECTION.
      **********************************************************
       WORKING-STORAGE SECTION.

      *    switches
       01  menu-switches.
           05 is-exit-application-switch      PIC X(1) VALUE 'N'.
               88  is-exit-application                 VALUE 'Y'.
           05 is-exit-load-file-menu-switch   PIC X(1) VALUE 'N'.
               88  is-exit-load-file-menu              VALUE 'Y'.
           05 is-exit-print-menu-switch       PIC X(1) VALUE 'N'.
               88  is-exit-print-menu                  VALUE 'Y'.
           05 is-exit-pbs-rpt-menu-switch     PIC X(1) VALUE 'N'.
               88  is-exit-pbs-rpt-menu                VALUE 'Y'.
           05 is-exit-customer-menu-switch    PIC X(1) VALUE 'N'.
               88  is-exit-customer-menu               VALUE 'Y'.
           05 is-exit-product-menu-switch     PIC X(1) VALUE 'N'.
               88  is-exit-product-menu                VALUE 'Y'.
           05 is-exit-admin-menu-switch       PIC X(1) VALUE 'N'.
               88  is-exit-maintenance-menu            VALUE 'Y'.
           05 is-exit-statistics-menu-switch  PIC X(1) VALUE 'N'.
               88  is-exit-statistics-menu             VALUE 'Y'.

      *    working storage data for error routine
           COPY Z0900-error-wkstg.

      *    Various generic variables
       01  wc-accept                    PIC X(2)    VALUE SPACE.
       
      *    Various constants
       01  HEADLINE                     PIC X(78)   VALUE ALL '-'.
       
           
      **********************************************************
       PROCEDURE DIVISION.
       0000-main.

           PERFORM A0100-init
           PERFORM B0100-show-main-menu UNTIL is-exit-application
           PERFORM Z0100-exit-application

           GOBACK
           .

      **********************************************************
       A0100-init.

           CONTINUE
           .

      **********************************************************
       B0100-show-main-menu.

           PERFORM UNTIL is-exit-application

               PERFORM B100-diplay-main-menu-list
               EVALUATE wc-accept

                   WHEN '10'
                       PERFORM C0100-call-loadinvoices
                   WHEN '20'
                       PERFORM E0100-call-submitinv
                   WHEN '30'
                       PERFORM G0100-call-statistics
                   WHEN '40'
                       PERFORM I0100-call-reports
                   WHEN '50'
                       PERFORM K0100-call-customermenu
                   WHEN '60'
                       PERFORM M0100-call-servicemenu
                   WHEN '70'
                       PERFORM X0100-call-maintenance
                   WHEN '99'
                       SET is-exit-application TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       B100-diplay-main-menu-list.
       
           DISPLAY HEADLINE
           DISPLAY 'PBS HUVUDMENY'
           DISPLAY HEADLINE
           DISPLAY '(10) Processa inkommande fakturafil'
           DISPLAY '(20) Skriv gäldenärsfakturor'
           DISPLAY '(30) Processtatistik'
      *    DISPLAY '(40) PBS företagsrapporter'
           DISPLAY '(50) Kundregister'
           DISPLAY '(60) Artikelregister'
           DISPLAY '(70) Programunderhåll'
           DISPLAY SPACE
           DISPLAY '(99) Avsluta programmet'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .     

      **********************************************************
       C0100-call-loadinvoices.

           MOVE 'N' TO is-exit-load-file-menu-switch
           PERFORM UNTIL is-exit-load-file-menu

               PERFORM C110-diplay-load-invoices-menu
               EVALUATE wc-accept

                   WHEN '11'
      *                PERFORM C0120-process-import-file
                       MOVE SPACE TO wc-accept
                   WHEN '19'
                       SET is-exit-load-file-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       C110-diplay-load-invoices-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY GÄLDENÄRSFAKTUROR'
           DISPLAY HEADLINE
           DISPLAY '(11) Importera mottagna gäldenärsfakturor'
           DISPLAY SPACE
           DISPLAY '(19) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
       E0100-call-submitinv.

           MOVE 'N' TO is-exit-print-menu-switch
           PERFORM UNTIL is-exit-print-menu

               PERFORM E110-diplay-print-menu
               EVALUATE wc-accept

                   WHEN '21'
      *                PERFORM E0120-process-all-out-invoices
                       MOVE SPACE TO wc-accept
                   WHEN '22'
      *                PERFORM E0130-process-one-out-invoice
                       MOVE SPACE TO wc-accept
                   WHEN '27'
      *                PERFORM E0140-submit-customer-invoice
                       MOVE SPACE TO wc-accept
                   WHEN '29'
                       SET is-exit-print-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       E110-diplay-print-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY FAKTUROR'
           DISPLAY HEADLINE
           DISPLAY '(21) Skriv ut alla väntande gäldenärsfakturor'
           DISPLAY '(22) Skriv ut enskild gäldenärsfakturor'
           DISPLAY SPACE
           DISPLAY '(27) Processa och skicka kundfaktura'
           DISPLAY SPACE
           DISPLAY '(29) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .


      **********************************************************
       G0100-call-statistics.

           MOVE 'N' TO is-exit-statistics-menu-switch
           PERFORM UNTIL is-exit-statistics-menu

               PERFORM G110-diplay-statistics-menu
               EVALUATE wc-accept

                   WHEN '31'
      *                PERFORM G0120-display-in-process-logs
                       MOVE SPACE TO wc-accept
                   WHEN '32'
      *                PERFORM G0130-display-out-process-logs
                       MOVE SPACE TO wc-accept
                   WHEN '39'
                       SET is-exit-statistics-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       G110-diplay-statistics-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY PROCESSRAPPORTER ***'
           DISPLAY HEADLINE
           DISPLAY '(31) Rapport inkontroll av fakturafiler'
           DISPLAY '(32) Rapport utprocess av gäldenärsfakturor'
           DISPLAY SPACE
           DISPLAY '(39) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
       I0100-call-reports.

           MOVE 'N' TO is-exit-pbs-rpt-menu-switch
           PERFORM UNTIL is-exit-pbs-rpt-menu

               PERFORM I110-diplay-cmp-report-menu
               EVALUATE wc-accept

                   WHEN '41'
      *                PERFORM I0120-display-monthly-rpt
                       MOVE SPACE TO wc-accept
                   WHEN '42'
      *                PERFORM I0130-display-accumulated-rpt
                       MOVE SPACE TO wc-accept
                   WHEN '49'
                       SET is-exit-pbs-rpt-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       I110-diplay-cmp-report-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY PBS EKONOMISKA RAPPORTER'
           DISPLAY HEADLINE
           DISPLAY '(41) Rapport intäkter denna månad'
           DISPLAY '(42) Rapport intäkter ackumulerat i år'
           DISPLAY SPACE
           DISPLAY '(49) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
       K0100-call-customermenu.

           MOVE 'N' TO is-exit-customer-menu-switch
           PERFORM UNTIL is-exit-customer-menu

               PERFORM K110-diplay-customer-menu
               EVALUATE wc-accept

                   WHEN '51'
                       CALL 'customermenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '52'
                       CALL 'customermenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '53'
                       CALL 'customermenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '54'
                       CALL 'customermenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '55'
                       CALL 'customermenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '59'
                       SET is-exit-customer-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       K110-diplay-customer-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY KUNDREGISTER'
           DISPLAY HEADLINE
           DISPLAY '(51) Visa kundregister'
           DISPLAY '(52) Uppdatera kundregistret'
           DISPLAY '(53) Uppdatera kunds val av service'
           DISPLAY '(54) Lägg till ny kund'
           DISPLAY '(55) Inaktivera kund'
           DISPLAY SPACE
           DISPLAY '(59) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
       M0100-call-servicemenu.

           MOVE 'N' TO is-exit-product-menu-switch
           PERFORM UNTIL is-exit-product-menu

               PERFORM M110-diplay-product-menu
               EVALUATE wc-accept

                   WHEN '61'
                       CALL 'servicemenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '62'
                       CALL 'servicemenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '63'
                       CALL 'servicemenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '64'
                       CALL 'servicemenu' USING wc-accept
                       MOVE SPACE TO wc-accept
                   WHEN '69'
                       SET is-exit-product-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .


      **********************************************************
       M110-diplay-product-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY ARTIKELREGISTER'
           DISPLAY HEADLINE
           DISPLAY '(61) Visa alla produkter'
           DISPLAY '(62) Uppdatera produktdetaljer'
           DISPLAY '(63) Lägg till ny produkt'
           DISPLAY '(64) Ta bort produkt'
           DISPLAY SPACE
           DISPLAY '(69) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
       X0100-call-maintenance.

           MOVE 'N' TO is-exit-admin-menu-switch
           PERFORM UNTIL is-exit-maintenance-menu

               PERFORM X110-diplay-maintenance-menu
               EVALUATE wc-accept

                   WHEN '71'
      *                PERFORM X0120-display-company-data
                       MOVE SPACE TO wc-accept
                   WHEN '72'
      *                PERFORM X0130-update-company-data
                       MOVE SPACE TO wc-accept
                   WHEN '73'
      *                PERFORM X0140-print-copy-of-invoice
                       MOVE SPACE TO wc-accept
                   WHEN '79'
                       SET is-exit-maintenance-menu TO TRUE
                       CONTINUE
                   WHEN OTHER
                       DISPLAY 'Ogiltigt meny val!'
               END-EVALUATE

           END-PERFORM
           .

      **********************************************************
       X110-diplay-maintenance-menu.

           DISPLAY HEADLINE
           DISPLAY 'SUBMENY PROGRAM UNDERHÅLL'
           DISPLAY HEADLINE
           DISPLAY '(71) Visa PBS företagsinformation'
           DISPLAY '(72) Uppdatera PBS företagsinformation'
           DISPLAY '(73) Skriv ut kopia av gäldenärsfaktura'
           DISPLAY SPACE
           DISPLAY '(79) Tillbaka till huvudmenyn'
           DISPLAY HEADLINE
           DISPLAY ': ' WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
       Z0100-exit-application.
       
      *    other terminating actions



           DISPLAY HEADLINE
           DISPLAY '*** Avslutar Programmet ***'
           DISPLAY SPACE
           DISPLAY 'Tryck <Enter> för att avsluta...'
               WITH NO ADVANCING
           ACCEPT wc-accept
           .

      **********************************************************
