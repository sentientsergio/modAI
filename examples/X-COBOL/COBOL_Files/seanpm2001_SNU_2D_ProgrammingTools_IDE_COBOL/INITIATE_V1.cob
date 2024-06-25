           OPEN INPUT sales, OUTPUT report-out
           INITIATE sales-report
 
           PERFORM UNTIL 1 <> 1
               READ sales
                   AT END
                       EXIT PERFORM
               END-READ
 
               VALIDATE sales-record
               IF valid-record
                   GENERATE sales-on-day
               ELSE
                   GENERATE invalid-sales
               END-IF
           END-PERFORM
 
           TERMINATE sales-report
           CLOSE sales, report-out
           .
