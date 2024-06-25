      *=======================================================================*
       IDENTIFICATION DIVISION.
      *=======================================================================*
       PROGRAM-ID. PROD1V1.
      *************************************************************************
      *************************************************************************
      *************************************************************************
      *                           IEFP SOLUTIONS                              *
      *DATA:            30/10/2019                                            *
      *PROGRAMADOR:     Marco Silva                                           *
      *OBJECTIVO:                                                             *
      *               ESTE PROGRAMA SUPOSTAMENTE SERÁ UTILIZADO               *
      *              PARA AVALIAR O FORMANDO NA SUA " HABILIDADE"             *
      *                       DE COMPREENSÃO EM COBOL                          *
      *                         NO MÓDULO 2 PROD 1 EXE 1                       *
      *                                                                        *
      *                                                                        *
      *************************************************************************
      ***************************FIM DOCUMENTAÇÃO******************************

      *=======================================================================*
                             ENVIRONMENT DIVISION.

      *=======================================================================*
                             CONFIGURATION SECTION.
      *=======================================================================*
                               SPECIAL-NAMES.
      *=======================================================================*
                             INPUT-OUTPUT SECTION.
      *=======================================================================*
                               FILE-CONTROL.

           SELECT WAGE_SHEET ASSIGN TO 'REMUNERACAO-IN.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT WAGE_SHEET_OUT ASSIGN TO 'RENUMERACAO-OUT.txt'.

      *=======================================================================*
                               DATA DIVISION.
      *=======================================================================*
                               FILE SECTION.

      *                 xxxxxxx READING THE FILE xxxxxx                        *
           FD WAGE_SHEET.
           01 WAGE-FILE.
               02 LAST_NAME PIC A(9).
               02 FIRST_NAME PIC A(8).
               02 BIRTHDAY.
                   03 B-DAY PIC 9(2).
                   03 B-MONTH PIC 9(2).
                   03 B-YEAR PIC 9(4).
               02 JOB-CATEGORY PIC A(13).
               02 SCHEDULE.
                   03 ENTRY-HOURS PIC 9(2).
                   03 ENTRY-MINUTES PIC 9(2).
                   03 LEAVING-HOURS PIC 9(2).
                   03 LEAVING-MINUTES PIC 9(2).
               02 LUNCH-BREAK.
                   03 LEAVING-HOURS-BREAK PIC 9(2).
                   03 LEAVING-MINUTES-BREAK PIC 9(2).
                   03 RETURNING-HOURS-BREAK PIC 9(2).
                   03 RETURNING-MINUTES-BREAK PIC 9(2).
               02 WEEKLY-HOURS.
                   03 WORKED-HOURS PIC 9(2).
                   03 WORKED-MINUTES PIC 9(2).
               02 WAGE-RECEIVED PIC 9(4)V99.

      *                xxxxxxx OUTPUTING THE FILE xxxxxx                       *

           FD WAGE_SHEET_OUT.
           01 WAGE-FILE-OUT.
               02 FIRST-NAME-OUT PIC A(9).
               02 LAST-NAME-OUT PIC A(8).
               02 JOB-CATEGORY-OUT PIC A(13).
               02 BIRTHDAY-OUT.
                   03 B-DAY-OUT PIC 9(2).
                   03 barra PIC X(1).
                   03 B-MONTH-OUT PIC 9(2).
                   03 barra2 PIC X(1) VALUE '/'.
                   03 B-YEAR-OUT PIC 9(4).
                   03 FILLER PIC X(1) VALUE SPACE.
               02 HOURS-OUT.
                   03 ENTRY-HOURS-OUT PIC 9(2).
                   03 pontinhos PIC X(1).
                   03 ENTRY-MINUTES-OUT PIC 9(2).
                   03 FILLER PIC X(1) VALUE SPACE.
               02 FINISHING-HOURS-OUT.
                   03 LEAVING-HOURS-OUT PIC 9(2).
                   03 pontinhos2 PIC X(1).
                   03 LEAVING-MINUTES-OUT PIC 9(2).
                   03 FILLER PIC X(1) VALUE SPACE.
               02 WEEKLY-HOURS.
                   03 WORKED-HOURS-OUT PIC 9(2).
                   03 dec PIC X(1).
                   03 WORKED-MINUTES-OUT PIC 9(2).
                   03 FILLER PIC X(1) VALUE SPACE.
               02 WAGE-RECEIVED-OUT PIC z999.99.

      *=======================================================================*
                           WORKING-STORAGE SECTION.
       01  END-LOOP PIC A(3) VALUE SPACES.

      *=======================================================================*
                             PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           OPEN INPUT WAGE_SHEET
               OUTPUT WAGE_SHEET_OUT.

           READ WAGE_SHEET
               AT END MOVE "YYY" TO END-LOOP
           END-READ.

           PERFORM CLEANUP UNTIL END-LOOP = "YYY".
           CLOSE WAGE_SHEET
               WAGE_SHEET_OUT.
           STOP RUN.

           CLEANUP.
           MOVE LAST_NAME TO LAST-NAME-OUT.
           MOVE FIRST_NAME TO FIRST-NAME-OUT.
           MOVE JOB-CATEGORY TO JOB-CATEGORY-OUT.
           MOVE B-DAY TO B-DAY-OUT.
           MOVE B-MONTH TO B-MONTH-OUT.
           MOVE B-YEAR TO B-YEAR-OUT.
           MOVE ENTRY-HOURS TO ENTRY-HOURS-OUT.
           MOVE ENTRY-MINUTES TO ENTRY-MINUTES-OUT.
           MOVE LEAVING-HOURS TO LEAVING-HOURS-OUT.
           MOVE LEAVING-MINUTES TO LEAVING-MINUTES-OUT.
           MOVE WORKED-HOURS TO WORKED-HOURS-OUT.
           MOVE WORKED-MINUTES TO WORKED-MINUTES-OUT.
           MOVE WAGE-RECEIVED TO WAGE-RECEIVED-OUT.

      *    ISTO NÃO SÃO HACKS!!!                                               *
           MOVE "." TO dec.
           MOVE ":" TO pontinhos.
           MOVE ":" TO pontinhos2.
           MOVE "/" TO barra.
           MOVE "/" TO barra2.

           WRITE WAGE-FILE-OUT
               AFTER ADVANCING 1 LINE.

           DISPLAY WAGE-FILE-OUT.

           READ WAGE_SHEET
               AT END MOVE "YYY" TO END-LOOP
           END-READ.
           LEGACY.
       STOP RUN.

       END PROGRAM PROD1V1.
