       *>*******************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. submit-invoices AS 'submit-invoices.cbl'.
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

           select output-file assign to 'output.tex'
               organization is line sequential.

       *>*******************************************************
       DATA DIVISION.
       *>-------------------------------------------------------
       FILE SECTION.

       FD output-file.
       01  output-rec.
           05 filler                       pic x(120).

       *>*******************************************************
       WORKING-STORAGE SECTION.
       *> switches

       *>-------------------------------------------------------
       *> SQL Copybooks

           exec sql include SQLCA end-exec.

           exec sql include ADDR end-exec.

           exec sql include CUSTOMER end-exec.

           exec sql include INVOICE end-exec.

           exec sql include INVITEM end-exec.

           exec sql include ITEM end-exec.

           exec sql include DEBTOR end-exec

       *>-------------------------------------------------------
       *> Counters etc.
       01 wn-current-customer-no             pic s9(9) comp.
       01 wn-current-adress-no               pic s9(9) comp.
       01 wn-current-invoice-no              pic s9(9) comp.
       01 wn-current-invoice-item-no         pic s9(9) comp.
       01 wn-cur-cust-no  redefines customer-custno x(10)
                                               usage display.

       *>-------------------------------------------------------
       *> Filenames
       01 old-filename                       pic x(30) value
      -                                              'output-file.tex'.
       01 new-filename                       pic x(30) value space.

       01 file-status                        pic xx comp-x.



       *>-------------------------------------------------------
       *> Cursors
       *>  for customers
           exec sql
               declare cur-customers cursor for
                   select  cust_id, custno, addr_id
                       from customer
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
                   select debt_id,
                          invno,
                          custno,
                          invdate,
                          vat
                       from invoice
                       where customer_id =
                                   :wn-current-customer-no
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
           05 wc-debtor-name                 pic x(30) value space.
           05 wc-debtor-contact              pic x(30) value space.
           05 wc-debtor-street               pic x(30) value space.
           05 wc-debtor-postnr               pic x(5)  value space.
           05 wc-debtor-place                pic x(30) value space.


       *>-------------------------------------------------------
       *>  Various generic variables


       *>-------------------------------------------------------
       *> display (for test) variables
       01 wr-invoice-header.
           05 wc-header-pad                  pic x(30) value all ' '.



       *>*******************************************************
       PROCEDURE DIVISION.
       0000-main.

           PERFORM A0100-init
           PERFORM B0100-submit-invoices
           PERFORM Z0100-exit-application

           GOBACK
           .

       *>*******************************************************
       A0100-init.

       *>  Fetch first customer
           exec sql
               open cur-customers
           end-exec

           exec sql
               fetch cur-customers into
                   :customer-cust-id,
                   :customer-custno,
                   :customer-addr-id
           end-exec

           move customer-cust-id to wn-current-customer-no
           move customer-addr-id to wn-current-adress-no

       *>  Get first customers adress
           exec sql
               select street, postno, place
                   into :addr-street,
                        :addr-postno,
                        :addr-place
                   from addr
                   where addr_id = :wn-current-adress-no
           end-exec

       *>  Fetch first customers first invoice
           exec sql
               open cur-invoices
           end-exec

           exec sql
               fetch cur-invoices into
                   :invoice-debt-id,
                   :invoice-invno,
                   :invoice-custno,
                   :invoice-invdate,
                   :invoice-vat
           end-exec

       *>  Get the debtor adress for the first invoice
           exec sql
               select name,
                      contact,
                      street,
                      postnr,
                      place
               into   :wc-debtor-name,
                      :wc-debtor-contact,
                      :wc-debtor-street,
                      :wc-debtor-postnr,
                      :wc-debtor-place
               from debtor, addr
               where addr.addr_id = (select addr_id
                                         from debtor
                                         where debtor.debt_id
                                               = invoice.debt_id
                                               and
                                               invoice.invoice_id
                                               = :wn-current-invoice-no)
           end-exec

       *> Get first invoice's invoice items and first invoice item
           exec sql
               open cur-invoice-items
           end-exec

           exec sql
               fetch cur-invoice-items into
                   :invitem-item-id
           end-exec

           exec sql
               select description, artno, unitdesc, qty, price
                   into :item-description,
                        :item-artno,
                        :item-unitdesc,
                        :item-qty,
                        :item-price
                   from item
                   where item_id = :invitem-item-id
           end-exec
           .

       *>*******************************************************
       B0100-submit-invoices.
           perform B0200-create-invoices until sqlcode not = zero
           .
       *>*******************************************************
       B0200-create-invoices.
       *>  Outermost loop: loop thru all customers
           perform until sqlcode = 100
       *>      middle loop: loop thru a customers invoices
               perform until sqlcode = 100

                   open output output-file
                   display 'PBS' with no advancing
                   display wc-header-pad with no advancing
                   display 'Faktura' with no advancing
                   display wc-header-pad with no advancing
                   display 'Sida 1 av 1'
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display invoice-invno
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display invoice-custno
                   display ' '
                   display ' '
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display wc-debtor-name
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display 'Er ref.: ' wc-debtor-contact
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display wc-debtor-street
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display wc-debtor-postnr with no advancing
                   display '  ' with no advancing
                   display wc-debtor-place

                   display 'Description' with no advancing
                   display '    ' with no advancing
                   display 'Art number' with no advancing
                   display '    ' with no advancing
                   display 'Unit desc' with no advancing
                   display '    ' with no advancing
                   display 'Qantity' with no advancing
                   display '    ' with no advancing
                   display 'Price'
                   display '------------------------------------------'
                   *> innermost loop: loop thru an invoice's invoice
                   *> items.
                   perform until sqlcode = 100

                       display item-description with no advancing
                       display '    ' with no advancing
                       display item-artno with no advancing
                       display '    ' with no advancing
                       display item-unitdesc with no advancing
                       display '    ' with no advancing
                       display item-qty with no advancing
                       display '    ' with no advancing
                       display item-price

                       exec sql
                           fetch cur-invoice-items into
                               :invitem-item-id
                       end-exec

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

                   end-perform  *> inner loop

                   *> write invoice sum etc and footer
                   *> Get PBS customer data
                   exec sql
                       select name,
                          boardplace,
                          tel,
                          email,
                          web,
                          orgno,
                          fin_id
                       into :customer-name,
                            :customer-boardplace
                            :customer-tel,
                            :customer-email,
                            :customer-web,
                            :customer-orgno,
                            :customer-fin-id
                       from customer
                       where cust_id = :wn-current-customer-no
                   end-exec

                   exec sql
                       select street,
                              postno,
                              place
                       into :addr-street,
                            :addr-postno,
                            :addr-place
                       where addr_id = :wn-current-adress-no
                   end-exec

                   exec sql
                       select vatregno,
                              bankgiro,
                              postgiro
                       into   :findata-vatregno,
                              :findata-bankgiro,
                              :findata-postgiro
                       where fin_id = :customer-fin-id
                   end-exec

                   *> write sum etc
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display 'Netto             ' with no advancing
                   display wn-invoice-sum
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display 'Moms 12%          ' with no advancing
                   display wn-vat
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display 'Öresutjämning     ' with no advancing
                   display wn-even-sum
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display 'Summa att betala  ' with no advancing
                   display wn-invoice-sum

                   display ' ' with no advancing
                   display ' ' with no advancing
                   display ' ' with no advancing
                   display ' ' with no advancing

                   display 'Efter förfallodag ' with no advancing
                   display 'debiteras dröjsmålsränta' with no advancing
                   display 'med ' wn-intrest-rate with no advancing
                   display '%'
                   display '__________________________________________'
                   *> write invoice footer
                   display customer-name
                   display wc-header-pad with no advancing
                   display wc-header-pad with no advancing
                   display 'Bankgiro ' findata-bankgiro
                   display addr-street with no advancing
                   display wc-header-pad with no advancing
                   display 'Tel ' customer-tel
                   display wc-header-pad with no advancing
                   display 'Org nr ' customer-orgno
                   display addr-postno with no advancing
                   display ' ' with no advancing
                   display addr-place with no advancing
                   display wc-header-pad with no advancing
                   display customer-email with no advancing
                   display wc-header-pad with no advancing
                   display 'Momsnr ' findata-vatregno
                   display 'Styrelsens säte ' customer-boardplace with
                           no advancing
                   display wc-header-pad with no advancing
                   display customer-web with no advancing
                   display wc-header-pad with no advancing
                   display 'Innehar F-skattsedel'

                   *> close cursors
                   exec sql
                       close cur-invoice-items
                   end-exec

                   *> load next invoice
                   exec sql
                       fetch cur-invoices into
                           :invoice-debt-id,
                           :invoice-invno,
                           :invoice-custno,
                           :invoice-invdate,
                           :invoice-vat
                   end-exec

                   exec sql
                       open cur-invoice-items
                   end-exec


                   *> get debtor details
                   exec sql
                       select name,
                              contact,
                              street,
                              postnr,
                              place
                       into :wc-debtor-name,
                            :wc-debtor-contact,
                            :wc-debtor-street,
                            :wc-debtor-postnr,
                            :wc-debtor-place
                       from debtor, addr
                       where addr.addr_id =
                                   (select addr_id
                                       from debtor
                                       where debtor.debt_id
                                           = invoice.debt_id
                                           and
                                           invoice.invoice_id
                                           = :wn-current-invoice-no)
                   end-exec

                   close output-file

                   *> create new filename and rename output.tex
                   string customer-custno delimited by size
                       '-' delimited by size
                       invoice-invno delimited by size
                       '.tex' delimited by size
                       into new-filename

                   call "CBL_RENAME_FILE" using     old-filename
                                                   new-filename
                                       returning return-code

                   if return-code not = 0
                       move return-code to file-status
                   end-if

               end-perform *> middle loop

               *> close cursors and re-open
               exec sql
                   close cur-invoices
               end-exec

               *> get next customer
               exec sql
                   fetch cur-customers into
                       :customer-cust-id,
                       :customer-addr-id
               end-exec

               move customer-cust-id to wn-current-customer-no
               move customer-addr-id to wn-current-adress-no

               *> get next customers adress
               exec sql
                   select street, postno, place
                       into :addr-street,
                            :addr-postno,
                            :addr-place
                       from addr
                       where addr_id = :wn-current-adress-no
               end-exec

               *> get next customers invoices
               exec sql
                   open cur-invoices
               end-exec

               exec sql
                   fetch cur-invoices into
                       :invoice-debt-id,
                       :invoice-invno,
                       :invoice-custno,
                       :invoice-invdate,
                       :invoice-vat
               end-exec
           end-perform *> outer loop


       .
       *>*******************************************************
       Z0100-exit-application.

           *> other terminating actions
           *> close file


           .

       *>*******************************************************
