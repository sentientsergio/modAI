      **************************************************************
      *    SQL Copybook Z0900-error-routine.cpy
      *
      *    1.Put this file in the /COPYLIB directory.
      *      Include in source with: 'COPY Z0900-error-routine.'
      *
      *    2.Add a data structure in WORKING STORAGE for this routine
      *      with: 'COPY Z0900-error-wkstg.'
      *
      *    3. For traceability, assign the cbl source file name
      *
      *          MOVE 'servicemenu.cbl' TO wc-msg-srcfile
      *
      *       in an init paragraph or in beginning of PROCEDURE DIV.
      *
      *    4. Everywhere where SQL-statements is tested and the Z0900-
      *       routine is called, add trace information like so:
      *
      *        IF SQLCODE NOT = ZERO
      *            DISPLAY 'Produkten kunde inte läggas till!'
      *
      *            add error trace information
      *            MOVE  SQLCODE            TO wn-msg-sqlcode
      *            MOVE 'TUTORIAL.SRV'      TO wc-msg-tblcurs
      *            MOVE 'M0160-add-article' TO wc-msg-para
      *
      *            PERFORM Z0900-error-routine
      *         END-IF
      *
      **************************************************************

      *    log initial error information
           CALL 'SQLLOG' USING wr-program-error-message

      *    display only errors (i.e. exclude warnings >0)
           IF SQLCODE < 0
               DISPLAY wr-program-error-message
           END-IF

      *    this MFE converts sql error codes to character strings
           CALL 'DSNTIAR' USING SQLCA
                                dsntiar-error-message
                                dsntiar-line-length

           IF return-code IS EQUAL TO ZERO

                PERFORM

                   VARYING dem-index FROM 1 BY 1 UNTIL dem-index > 10
      *                use special register to move length of field
                       MOVE LENGTH OF dem-message(dem-index)
                                   TO dem-length
      *                dont show message if empty (i.e. only spaces)
                       MOVE ZERO TO w9-space-cnt
                       INSPECT dem-message(dem-index) TALLYING
                                    w9-space-cnt FOR ALL SPACES

                       IF dem-length NOT EQUAL w9-space-cnt

      *                    here its possible to add custom messages
                           EVALUATE SQLCODE

                               WHEN +100
                                   DISPLAY 'Inga data returnerades!'

                               WHEN OTHER
                                   DISPLAY  dem-message(dem-index)
                                   CALL 'SQLLOG'
                                       USING dem-message(dem-index)

                           END-EVALUATE

                       END-IF

               END-PERFORM
           ELSE
               DISPLAY 'Program fel DSNTIAR rtn-error: ' return-code
               CALL 'SQLLOG' USING 'Program fel DSNTIAR'
           END-IF

      *    reset error message (except source file name)
           MOVE ZERO TO wn-msg-sqlcode
           MOVE SPACE TO wc-msg-tblcurs
           MOVE SPACE TO wc-msg-para

           DISPLAY SPACE
           DISPLAY 'Tryck <Enter> för att fortsätta...'
               WITH NO ADVANCING
           ACCEPT wc-accept



