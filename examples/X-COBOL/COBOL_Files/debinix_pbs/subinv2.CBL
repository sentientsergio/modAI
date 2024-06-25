       *>*******************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. subinv2 AS 'subinv2.cbl'.
       *>
       *> Authors: Peter B, Bertil K and Sergejs S.
       *> Purpose: Manage an invoice print company (PBS)
       *>          Submit invoices to printer (pdf creator)
       *> Initial Version Created: 2014-03-17
       *>
       *>*******************************************************
       ENVIRONMENT DIVISION.
       *>-------------------------------------------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           select output-file assign to 'output.txt'
               organization is line sequential.

       *>*******************************************************
       DATA DIVISION.
       *>-------------------------------------------------------
       FILE SECTION.

       FD output-file.
       01  output-rec.
           05 filler                       pic x(80).

       *>*******************************************************
       WORKING-STORAGE SECTION.
       *> constants
       01 constants.
           05 ok                               pic 9 value 0.



       copy sql-codes.

       *>-------------------------------------------------------
       *> SQL Copybooks

           exec sql include SQLCA end-exec.

           exec sql include ADDR end-exec.

           exec sql include CUSTOMER end-exec.

           exec sql include INVOICE end-exec.

           exec sql include INVITEM end-exec.

           exec sql include ITEM end-exec.

           exec sql include DEBTOR end-exec.

           exec sql include FINDATA end-exec.

       *>-------------------------------------------------------.
       *> C = constants
       01 C.
           05 wn-lines-per-page                pic 99 value 60.
           05 wn-header-1-starts               pic 99 value 1.
           05 wn-header-2-starts               pic 99 value 2.
           05 wn-header-3-starts               pic 99 value 4.
           05 wn-footer-starts                 pic 99 value 52.
           05 wn-invoice-head-starts           pic 99 value 20.
           05 wn-label-1-starts                pic 99 value 20.
           05 wn-item-labels-starts            pic 99 value 30.
           05 wn-item-label-underline-starts   pic 99 value 31.
           05 wn-items-starts                  pic 99 value 32.
           05 wn-max-items-on-page-1           pic 99 value 10.
           05 wn-max-items-on-page-2           pic 99 value 40.
           05 wn-item-lbl-p2-starts            pic 99 value 5.
           05 wn-item-lbl-p2-ul-starts         pic 99 value 6.
           05 wn-items-p2-starts               pic 99 value 7.
           05 wn-line-length                   pic 99 value 80.


       *> A = internal work fields
       01 A.
           05 wn-current-customer-no           pic s9(9) comp.
           05 wn-current-adress-no             pic s9(9) comp.
           05 wn-current-invoice-no            pic s9(9) comp.
           05 wn-current-invoice-item-no       pic s9(9) comp.
           05 wn-invoice-sum                   pic 9(9)v99.
           05 wn-invoice-decimal               pic s99.
           05 wn-invoice-sum-ed                pic z(8)9.99.
           05 wn-vat                           pic 9(8)v99.
           05 wn-intrest-rate                  pic z9.
           05 wn-even-sum                      pic 9(9)v99.
           05 wc-qty-ed                        pic z(5).99.
           05 wc-price-ed                      pic z(9).99.
           05 wn-inv-vat-pre-ed                pic z9.
           05 wc-inv-vat-ed                    pic z(8).99.
           05 wc-vat-ed                        pic z(8).99.
           05 wc-even-sum-ed                   pic z(9).99.
           05 wn-no-pages                      pic 9(9).
           05 wc-no-pages-ed                   pic z(9).
           05 wn-current-page                  pic 99.
           05 wn-no-of-items-in-inv            pic s9(9) usage comp.
           05 wn-no-pages-rem                  pic 9v99.
           05 wn-art-price                     pic 9(9)v99.
           05 wn-art-price-ed                  pic z(9).99.
           05 wn-current-line                  pic 99.
           05 wn-move-no-lines                 pic 99.

       *> D = current date
       01 D. 
           05 wn-current-year                  pic 9(4).
           05 wn-current-month                 pic 9(2).
           05 wn-current-day                   pic 9(2).
           05 wn-current-hour                  pic 9(2).
           05 wn-current-minute                pic 9(2).
           05 wn-current-second                pic 9(2).
           05 wn-current-100-sec               pic 9(2).
           05 wn-current-gmt                   pic x(5).
           05 wc-invoice-date                  pic x(10).
           05 wc-current-time                  pic x(10).

       *> Output fields
       01 wr-header-1.
           05 filler                           pic x(64) value space.
           05 filler                           pic x(5) value 'Sida '.
           05 wc-page-no                       pic x(2).
           05 filler                           pic x(1) value space.
           05 filler                           pic x(3) value 'av '.
           05 filler                           pic x(1) value space.
           05 wc-tot-pages                     pic x(2).
           05 filler                           pic x(2) value space.

       01 wr-header-2.
           05 filler                           pic x(2) value space.
           05 wc-customer-name                 pic x(40).
           05 filler                           pic x(29) value space.
           05 filler                          pic x(7) value 'FAKTURA'.
           05 filler                           pic x(2) value space.

       01 wr-header-3.
           05 filler                           pic x(2) value space.
           05 filler              pic x(15) value 'Kundnummer:    '.
           05 wc-cust-no             pic x(17).
           05 filler                           pic x(4) value space.
           05 wc-debt-name                     pic x(40).
           05 filler                           pic x(2) value space.

       01 wr-header-4.
           05 filler                           pic x(2) value space.
           05 filler               pic x(15) value 'Fakturadatum:  '.
           05 wc-inv-date            pic x(17).
           05 filler                           pic x(4) value space.
           05 wc-debt-contact                  pic x(40).
           05 filler                           pic x(2) value space.

       01 wr-header-5.
           05 filler                           pic x(2) value space.
           05 filler                 pic x(15) value 'Fakturanummer: '.
           05 wc-inv-no              pic x(18).
           05 filler                           pic x(3) value space.
           05 wc-debtor-addr                   pic x(40).
           05 filler                           pic x(2) value space.

       01 wr-header-6.
           05 filler                           pic x(38) value space.
           05 wc-debt-place                    pic x(36).
           05 filler                           pic x(6) value space.

       01 wr-label-1.
           05 filler                           pic x(2) value space.
           05 wc-invoice-label                 pic x(7).
           05 filler                           pic x(71) value space.

       01 wr-items-label.
           05 filler                           pic x(2) value space.
           05 filler                 pic x(10) value 'Artikelnr'.
           05 filler                           pic x(1) value space.
           05 filler                 pic x(11) value 'Beskrivning'.
           05 filler                           pic x(7) value space.
           05 filler                 pic x(5) value 'Enhet'.
           05 filler                           pic x(10) value space.
           05 filler                 pic x(4)  value 'Ant.'.
           05 filler                           pic x(5) value space.
           05 filler                 pic x(8)  value 'Pris/en.'.
           05 filler                           pic x(10) value space.
           05 filler                 pic x(5) value 'Summa'.
           05 filler                           pic x(2) value space.

       01 wr-items-label2.
           05 filler                           pic x(56) value space.
           05 filler                 pic x(11) value '(exl. moms)'.
           05 filler                           pic x(2) value space.
           05 filler                 pic x(11) value '(exl. moms)'.
           05 filler                           pic x(2) value space.

       01 wr-underline.
           05 filler                           pic x(2) value space.
           05 filler                           pic x(76) value all '-'.
           05 filler                           pic x(2) value space.

       01 wr-artk-items.
           05 filler                           pic x(2) value space.
           05 wc-art-no                        pic x(10).
           05 filler                           pic x(1) value space.
           05 wc-art-desc                      pic x(17).
           05 filler                           pic x(1) value space.
           05 wc-art-unit                      pic x(10).
           05 filler                           pic x(1) value space.
           05 wc-art-num                       pic x(8).
           05 filler                           pic x(1) value space.
           05 wc-price-unit                    pic x(12).
           05 filler                           pic x(1) value space.
           05 wc-art-sum                       pic x(14) just right.
           05 filler                           pic x(2) value space.

       01 wr-order-summary.
           05 filler                           pic x(2) value space.
           05 filler                  pic x(11) value 'Nettobelopp'.
           05 filler                           pic x(18) value space.
           05 filler      pic x(9) value 'Momssats '.
           05 wc-vat-perc                      pic x(2).
           05 filler      pic x(2) value ' %' just right.
           05 filler                           pic x(1) value space.
           05 filler      pic x(10) value 'Öresutjmn.' just right.
           05 filler                           pic x(11) value space.
           05 filler      pic x(12) value 'Bruttobelopp' just right.
           05 filler                           pic x(2) value space.

       01 wr-order-data.
           05 filler                           pic x(2) value space.
           05 wc-netto-sum                     pic x(12) just right.
           05 filler                           pic x(19) value space.
           05 wc-vat-sum                       pic x(11).
           05 filler                           pic x(1) value space.
           05 wc-even                          pic x(3).
           05 filler                           pic x(18).
           05 wc-brutto-sum                    pic x(12).
           05 filler                           pic x(2) value space.


       01 wr-intrest-rate.
           05 filler                           pic x(80).

       01 wr-footer-1.
           05 filler                           pic x(2) value space.
           05 filler                  pic x(5) value 'Firma'.
           05 filler                           pic x(19) value space.
           05 filler          pic x(19) value 'Företagsinformation'.
           05 filler                           pic x(16) value space.
           05 filler          pic x(17) value 'Bankgiro/plusgiro'.
           05 filler                           pic x(2) value space.

       01 wr-footer-2.
           05 filler                           pic x(2) value space.
           05 wc-footer-col1                   pic x(38).
           05 wc-footer-col2                   pic x(38) just right.
           05 filler                           pic x(2) value space.

       01 wr-footer-3.
           05 filler                           pic x(25) value space.
           05 filler   pic x(29) value 'Företaget har f-skatte sedel'.

       01 wr-ind-variables.
           05 wn-ind-cust-ournote              pic s9(4) comp.
           05 wn-ind-cust-web                  pic s9(4) comp.
        
       01 wc-output-line                       pic x(80).

       *>-------------------------------------------------------
       *> Filenames
       01 files.
           05 old-filename                     pic x(30) value
                                                  'output-file.tex'.
           05 new-filename                     pic x(30) value space.
           05 file-status                      pic xx comp-x.


       *>-------------------------------------------------------
       *> Cursors
       *>  for customers
           exec sql
               declare cur-customers cursor for
                   select cust_id, custno, addr_id
                     from customer
                    where cust_id <> 1

           end-exec.

       *>  for customer adresses
           exec sql
               declare cur-adress cursor for
                   select street, postno, place
                     from addr
                    where addr_id = :wn-current-adress-no
           end-exec

       *>  for customer invoices
           exec sql
               declare cur-invoices cursor for
                   select inv_id,
                          cust_id,
                          debt_id,
                          invno,
                          custno,
                          invdate,
                          vat
                     from invoice
                    where cust_id = :wn-current-customer-no
           end-exec.

       *>  for invoice items
           exec sql
               declare cur-invoice-items cursor for
                   select item_id
                     from invitem
                    where inv_id = :wn-current-invoice-no
           end-exec


       *>-------------------------------------------------------
       *> Working records
       01 wr-debtor-contact-info.
           05 wc-debtor-name                 pic x(30).
           05 wc-debtor-contact              pic x(30).
           05 wc-debtor-street               pic x(30).
           05 wc-debtor-postnr               pic x(5).
           05 wc-debtor-place                pic x(30).


       *>-------------------------------------------------------
       *>  Various generic variables
       01  wc-accept                         pic x(2)  value space.

       *>-------------------------------------------------------
       *> display (for test) variables
       01 wr-invoice-header.
           05 wc-header-pad                  pic x(30) value all ' '.

       copy X0900-error-wkstg.
       *>*******************************************************
       LINKAGE SECTION.
       01 subinv.
           05  out-parm.
               10  ret-code                pic 9.

       *>*******************************************************
       PROCEDURE DIVISION using subinv.
       0000-main.

           perform A0100-init
           perform B0100-submit-invoices
           perform Z0100-exit-application

           goback
       .
       *>*******************************************************
       A0100-init.

           move 'subinv.cbl' to wc-msg-srcfile
           open output output-file

           initialize A
           initialize D
           initialize wr-debtor-contact-info
           move 1 to wn-current-page
           move zero to wn-current-line
           
           move function current-date to D

           perform X0500-set-invoice-date
           perform x0550-set-current-time
           
       *>  Fetch first customer
           exec sql
               open cur-customers
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'A0100-init'        to wc-msg-para

               perform X0900-error-routine
           end-evaluate

           perform X0100-get-customer-data

           perform X0250-get-pbs-customer-data

       *>  Get the debtor adress for the first invoice
           perform X0200-get-debtor-details

       .
       *>*******************************************************
       B0100-submit-invoices.
           move zero to sqlcode
           perform B0200-create-invoices until sqlcode not = zero
       .
       *>-------------------------------------------------------
       B0200-create-invoices.
       *>  Outermost loop: loop thru all customers
           perform until sqlcode = sql-end-of-data
       *>      middle loop: loop thru a customers invoices
               perform until sqlcode = sql-end-of-data


                   perform B0210-write-invoice                                     
                   
                   *> load next invoice
                   perform X0260-fetch-current-invoice

                   move zero to wn-current-line

                   if not sqlcode = sql-end-of-data then
                       move invoice-inv-id to wn-current-invoice-no

                       exec sql
                           open cur-invoice-items
                       end-exec

                       evaluate sqlcode
                       when ok
                       when sql-end-of-data
                           continue
                       when not = zero
                           display 'sqlcode: ' sqlcode
                           move  sqlcode            to wn-msg-sqlcode
                           move 'tutorial.srv'      to wc-msg-tblcurs
                           move 'B0200-create-invoices' to wc-msg-para

                           perform X0900-error-routine
                       end-evaluate

                       perform X0270-fetch-invoice-items

                       *> get debtor details
                       perform X0200-get-debtor-details

                   end-if
               end-perform *> middle loop

               *> close cursors and re-open
               exec sql
                   close cur-invoices
               end-exec

               perform X0100-get-customer-data

           end-perform *> outer loop          
       .
       *>-------------------------------------------------------
       B0210-write-invoice.
           *> We need to know how many items this invoice has
           *> we use this to predict how many pages we will need
           *> to print

           perform X0265-select-no-items-in-inv

           *> Clear text fields
           move space to wc-customer-name
           move space to wc-cust-no
           move space to wc-debt-name
           move space to wc-inv-date
           move space to wc-debt-contact
           move space to wc-inv-no
           move space to wc-debtor-addr
           move space to wc-debt-place


           evaluate wn-no-of-items-in-inv
               when less than wn-max-items-on-page-1
                   *> only one page to print
                   perform B0220-write-invoice-header
                   *> current line = 6

                   compute wn-move-no-lines =
                           wn-label-1-starts - wn-current-line

                   perform wn-move-no-lines times
                       move space to wc-output-line
                       perform X0560-write-rec
                   end-perform

                   *> innermost loop: loop thru an invoice's invoice
                   *> items.
                   perform B0230-write-invoice-items

                   *> write invoice sum etc and footer
                   perform X0250-get-pbs-customer-data

                   move space to wc-output-line
                   perform X0560-write-rec

                   *> write sum etc
                   perform B0260-write-invoice-sum

                   compute wn-move-no-lines =
                           wn-footer-starts - wn-current-line

                   perform wn-move-no-lines times
                       move space to wc-output-line
                       perform X0560-write-rec
                   end-perform

                   *> write invoice footer
                   perform B0280-write-invoice-footer
               when other
                   *> Calc no of pages
                   divide wn-no-of-items-in-inv
                       into wn-max-items-on-page-2
                       giving wn-no-pages
                       remainder wn-no-pages-rem

                   if wn-no-pages-rem greater than 0
                       *> final page will
                       add 1 to wn-no-pages
                   end-if
                   *> process first page
                   perform B0220-write-invoice-header

                   perform B0235-calc-invoice-sum

                   *> write invoice sum etc and footer
                   perform X0250-get-pbs-customer-data

                   *> write sum etc
                   perform B0260-write-invoice-sum

                   *> write invoice footer
                   perform B0280-write-invoice-footer

                   perform  wn-no-pages times
                   *> process the rest of the pages
                       perform B0220-write-invoice-header
                       perform B0230-write-invoice-items
                   end-perform
           end-evaluate

           *> close cursor for invoices
           exec sql
               close cur-invoice-items
           end-exec
       .
       *>-------------------------------------------------------
       B0220-write-invoice-header.

           move wn-current-page to wc-page-no
           move wn-no-pages to wc-no-pages-ed
           move wc-no-pages-ed to wc-tot-pages
           move wr-header-1 to wc-output-line
      *    perform X0560-write-rec

           string customer-name delimited by '  '
                  into wc-customer-name
           end-string
           move wr-header-2 to wc-output-line
           perform X0560-write-rec
           
           move space to wc-output-line
           perform X0560-write-rec

           move invoice-custno to wc-cust-no
           move wc-debtor-name to wc-debt-name
           move wr-header-3 to wc-output-line
           perform X0560-write-rec

           move wc-invoice-date to wc-inv-date
           move wc-debtor-contact to wc-debt-contact
           move wr-header-4 to wc-output-line
           perform X0560-write-rec

           move invoice-invno to wc-inv-no
           move addr-street to wc-debtor-addr
           move wr-header-5 to wc-output-line
           perform X0560-write-rec

           string addr-postno delimited by size
                  ' '  delimited by size
                  addr-place delimited by '  '
                  into wc-debt-place
           end-string
           move wr-header-6 to wc-output-line
           perform X0560-write-rec

           .
       *>-------------------------------------------------------
       B0230-write-invoice-items.
           *> header
           move 'Faktura' to wc-invoice-label
           move wr-label-1 to wc-output-line
           perform X0560-write-rec

           move space to wc-output-line
           perform X0560-write-rec

           *> Labels
           move wr-items-label to wc-output-line
           perform X0560-write-rec
           move wr-underline to wc-output-line
           perform X0560-write-rec
           *> data
           perform until sqlcode = sql-end-of-data

               move item-qty to wc-qty-ed
               move item-price to wc-price-ed
               move item-artno to wc-art-no
               move item-description to wc-art-desc
               move item-unitdesc to wc-art-unit
               move wc-qty-ed to wc-art-num
               move wc-price-ed to wc-price-unit
               compute wn-art-price = item-price * item-qty
               move wn-art-price to wn-art-price-ed
               move wn-art-price-ed to wc-art-sum

               move wr-artk-items to wc-output-line
               perform X0560-write-rec
           
               compute wn-invoice-sum = wn-invoice-sum +
                                        wn-art-price

               perform X0270-fetch-invoice-items
               
           end-perform
       .
       *>-------------------------------------------------------
       B0232-write-invoice-items-m-p.
       *> innermost loop: loop thru an invoice's invoice items.

           perform until sqlcode = sql-end-of-data

               move item-qty to wc-qty-ed
               move item-price to wc-price-ed

               string item-description
                      '&'
                      item-artno
                      '&'
                      item-unitdesc
                      '&'
                      wc-qty-ed
                      '&'
                      wc-price-ed
                      'kr.\\'
                      delimited by size
                      into wc-output-line
               end-string
               perform X0560-write-rec

               compute wn-invoice-sum = wn-invoice-sum +
                                    (item-price * item-qty)

               perform X0270-fetch-invoice-items

           end-perform

       .

       *>-------------------------------------------------------
       B0235-calc-invoice-sum.
           perform until sqlcode = sql-end-of-data
               compute wn-invoice-sum = wn-invoice-sum +
                                    (item-price * item-qty)

               perform X0270-fetch-invoice-items

           end-perform
       .
       *>-------------------------------------------------------
       B0260-write-invoice-sum.
           compute wn-vat = wn-invoice-sum * invoice-vat
           compute wn-even-sum rounded =  wn-invoice-sum + wn-vat
           compute wn-invoice-decimal =
                   (wn-invoice-sum - wn-even-sum) * 100

           *> Edit output fields
           compute wn-inv-vat-pre-ed = invoice-vat * 100
           move wn-vat to wc-vat-ed
           move wn-invoice-sum to wn-invoice-sum-ed
           move wn-even-sum to wc-even-sum-ed

           *> Labels
           move wn-inv-vat-pre-ed to wc-vat-perc
           move wr-order-summary to wc-output-line
           perform X0560-write-rec

           move wr-underline to wc-output-line
           perform X0560-write-rec

           *> Data
           move wn-invoice-sum-ed to wc-netto-sum
           move wc-vat-ed to wc-vat-sum
           move wn-invoice-decimal to wc-even
           move wc-even-sum-ed to wc-brutto-sum
           move wr-order-data to wc-output-line
           perform X0560-write-rec

           move wr-underline to wc-output-line
           perform X0560-write-rec
           move wr-underline to wc-output-line
           perform X0560-write-rec

           move zero to wn-invoice-sum
           move zero to wn-even-sum
           move zero to wn-vat
       .
       *>-------------------------------------------------------
       B0280-write-invoice-footer.

           compute wn-intrest-rate = customer-delrate * 100
           string '  Efter förfallodag debiteras dröjsmålsränta '
                  'med '
                  wn-intrest-rate
                  '%'
                  delimited by size
                  into wc-output-line
           end-string
           perform X0560-write-rec
           
           move wr-underline to wc-output-line
           perform X0560-write-rec
           
           move space to wc-footer-col1
           move space to wc-footer-col2
           move customer-name to wc-footer-col1

           evaluate true also true
               when findata-bankgiro not = space
                    also findata-postgiro not = space
                   string 'BG: '
                          findata-bankgiro
                          '/'
                          'PG: '
                          findata-postgiro
                          delimited by size
                          into wc-footer-col2
                   end-string
               when findata-bankgiro not = space
                    also findata-postgiro = space
                   string 'BG: '
                          findata-bankgiro
                          delimited by size
                          into wc-footer-col2
                   end-string
               when findata-bankgiro = space
                    also findata-postgiro not = space
                   string 'PG: '
                          findata-postgiro
                          delimited by size
                          into wc-footer-col2
                   end-string
           end-evaluate

           move wr-footer-2 to wc-output-line
           perform X0560-write-rec

           move space to wc-footer-col1
           move space to wc-footer-col2
           move addr-street to wc-footer-col1
           string 'Organisationsnummer: '
                   customer-orgno
                   delimited by size
                   into wc-footer-col2
           end-string

           move wr-footer-2 to wc-output-line
           perform X0560-write-rec

           move space to wc-footer-col1
           move space to wc-footer-col2
           string addr-postno delimited by size
                  ' '  delimited by size
                  addr-place delimited by '  '
                  into wc-footer-col1
           end-string

           string 'Momsnr: '
                   findata-vatregno
                   delimited by size
                   into wc-footer-col2
           end-string

           move wr-footer-2 to wc-output-line
           perform X0560-write-rec

           move space to wc-footer-col1
           move space to wc-footer-col2
           string 'Telefon: '
                   customer-tel
                   delimited by size
                   into wc-footer-col1
           
           string 'E-post: '
                  customer-email
                  delimited by size
                  into wc-footer-col2
           end-string

           move wr-footer-2 to wc-output-line
           perform X0560-write-rec

           move space to wc-footer-col1
           move space to wc-footer-col2
           if wn-ind-cust-web = ok then
               string 'Web: '
                      customer-web
                      delimited by size
                      into wc-footer-col1
               end-string
           end-if

           string 'Styrelsens säte '
                  customer-boardplace
                  delimited by size
                  into wc-footer-col2
           end-string

           move wr-footer-2 to wc-output-line
           perform X0560-write-rec
           
           move wr-footer-3 to wc-output-line
           perform X0560-write-rec
       .
       *>*******************************************************
       *> Utility procedures usable by all procedures in the
       *> program
        X0100-get-customer-data.
           *> get customer
           exec sql
               fetch cur-customers into
                     :customer-cust-id,
                     :customer-custno,
                     :customer-addr-id
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0100-get-customer-data' to wc-msg-para

               perform X0900-error-routine
           end-evaluate

           if not sqlcode = sql-end-of-data then
               move customer-cust-id to wn-current-customer-no
               move customer-addr-id to wn-current-adress-no

               *> get customers adress
               exec sql
                   select street, postno, place
                     into :addr-street,
                          :addr-postno,
                          :addr-place
                     from addr
                    where addr_id = :wn-current-adress-no
               end-exec

               evaluate sqlcode
               when ok
               when sql-end-of-data
                   continue
               when not = zero
                   display 'sqlcode: ' sqlcode
                   move  sqlcode            to wn-msg-sqlcode
                   move 'tutorial.srv'      to wc-msg-tblcurs
                   move 'X0100-get-customer-data' to wc-msg-para

                   perform X0900-error-routine
               end-evaluate

               exec sql
                   open cur-invoices
               end-exec

               evaluate sqlcode
               when ok
               when sql-end-of-data
                   continue
               when not = zero
                   display 'sqlcode: ' sqlcode
                   move  sqlcode            to wn-msg-sqlcode
                   move 'tutorial.srv'      to wc-msg-tblcurs
                   move 'X0100-get-customer-data' to wc-msg-para

                   perform X0900-error-routine
               end-evaluate

               perform X0260-fetch-current-invoice
               move invoice-inv-id to wn-current-invoice-no

               exec sql
                   open cur-invoice-items
               end-exec

               evaluate sqlcode
               when ok
               when sql-end-of-data
                   continue
               when not = zero
                   display 'sqlcode: ' sqlcode
                   move  sqlcode            to wn-msg-sqlcode
                   move 'tutorial.srv'      to wc-msg-tblcurs
                   move 'X0100-get-customer-data' to wc-msg-para

                   perform X0900-error-routine
               end-evaluate

               perform X0270-fetch-invoice-items
               move zero to wn-invoice-sum

           end-if
       .
       *>-------------------------------------------------------
       X0200-get-debtor-details.
           exec sql
               select  name,
                       contact,
                       street,
                       postno,
                       place
               into    :wc-debtor-name,
                       :wc-debtor-contact,
                       :wc-debtor-street,
                       :wc-debtor-postnr,
                       :wc-debtor-place
               from debtor, addr, invoice
               where addr.addr_id = debtor.addr_id
               and debtor.addr_id =
                           (select addr_id
                              from debtor
                             where debtor.debt_id
                                       = invoice.debt_id
                                   and
                                   invoice.inv_id
                                       = :wn-current-invoice-no)
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0200-get-debtor-details' to wc-msg-para

               perform X0900-error-routine
           end-evaluate

       .
       *>-------------------------------------------------------
       X0250-get-pbs-customer-data.
           exec sql
               select name,
                      boardplace,
                      tel,
                      email,
                      web,
                      orgno,
                      delrate,
                      fin_id
                 into :customer-name,
                      :customer-boardplace,
                      :customer-tel,
                      :customer-email,
                      :customer-web:wn-ind-cust-web,
                      :customer-orgno,
                      :customer-delrate,
                      :customer-fin-id
                 from customer
                where cust_id = :wn-current-customer-no
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0250-get-pbs-customer-data' to wc-msg-para

               perform X0900-error-routine
           end-evaluate

           exec sql
               select street,
                      postno,
                      place
                 into :addr-street,
                      :addr-postno,
                      :addr-place
                 from addr
                where addr_id = :wn-current-adress-no
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0250-get-pbs-customer-data' to wc-msg-para

               perform X0900-error-routine
           end-evaluate

           exec sql
               select vatregno,
                      bankgiro,
                      postgiro
                 into :findata-vatregno,
                      :findata-bankgiro,
                      :findata-postgiro
                 from findata
                where fin_id = :customer-fin-id
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0250-get-pbs-customer-data' to wc-msg-para

               perform X0900-error-routine
           end-evaluate
       .
       *>-------------------------------------------------------
       X0260-fetch-current-invoice.
           exec sql
               fetch cur-invoices into
                     :invoice-inv-id,
                     :invoice-cust-id,
                     :invoice-debt-id,
                     :invoice-invno,
                     :invoice-custno,
                     :invoice-invdate,
                     :invoice-vat
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0260-fetch-current-invoice' to wc-msg-para

               perform X0900-error-routine
           end-evaluate

       .
       *>-------------------------------------------------------
       X0265-select-no-items-in-inv.
           exec sql
               select count(item_id)
                 into :wn-no-of-items-in-inv
                 from invitem
                where inv_id = :wn-current-invoice-no
           end-exec

           evaluate sqlcode
           when ok
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0260-fetch-current-invoice' to wc-msg-para

               perform X0900-error-routine
           end-evaluate
       .

       *>-------------------------------------------------------
       X0270-fetch-invoice-items.
           exec sql
               fetch cur-invoice-items into
                   :invitem-item-id
           end-exec

           evaluate sqlcode
           when ok
               exec sql
                   select description,
                       artno,
                       unitdesc,
                       qty,
                       price
                   into :item-description,
                       :item-artno,
                       :item-unitdesc,
                       :item-qty,
                       :item-price
                   from item
                   where item_id = :invitem-item-id
               end-exec

               evaluate sqlcode
               when ok
               when sql-end-of-data
                   continue
               when not = zero
                   display 'sqlcode: ' sqlcode
                   move  sqlcode            to wn-msg-sqlcode
                   move 'tutorial.srv'      to wc-msg-tblcurs
                   move 'X0270-fetch-invoice-items' to wc-msg-para

                   perform X0900-error-routine
               end-evaluate
           when sql-end-of-data
               continue
           when not = zero
               display 'sqlcode: ' sqlcode
               move  sqlcode            to wn-msg-sqlcode
               move 'tutorial.srv'      to wc-msg-tblcurs
               move 'X0270-fetch-invoice-items' to wc-msg-para

               perform X0900-error-routine
           end-evaluate

           .
       *>-------------------------------------------------------
       X0500-set-invoice-date.
           string wn-current-year
                  '-'
                  wn-current-month
                  '-'
                  wn-current-day
                  delimited by size
                  into wc-invoice-date
           .
       *>-------------------------------------------------------
       X0550-set-current-time.
           string wn-current-hour
                  ':'
                  wn-current-minute
                  ':'
                  wn-current-second
                  delimited by size
                  into wc-current-time
           .
       *>-------------------------------------------------------
       X0560-write-rec.
           move wc-output-line to output-rec
           write output-rec
           move space to wc-output-line
           move space to output-rec
           add 1 to wn-current-line
       .
       *>-------------------------------------------------------
       copy X0900-error-routine.

       *>*******************************************************

       Z0100-exit-application.

           close output-file
           *> Close open cursors
           exec sql
               close cur-invoices
           end-exec

           exec sql
               close cur-customers
           end-exec

       .

       *>*******************************************************
