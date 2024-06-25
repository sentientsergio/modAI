       01  customer-record.
           05  cust-key            PIC X(10).
           05  cust-name.
               10  cust-first-name PIC X(30).
               10  cust-last-name  PIC X(30).
           05  cust-dob            PIC 9(8).
           05  cust-balance        PIC 9(7)V99.
           
       66  cust-personal-details   RENAMES cust-name THRU cust-dob.
       66  cust-all-details        RENAMES cust-name THRU cust-balance.
