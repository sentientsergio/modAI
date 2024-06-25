      *=======================================================================*
       IDENTIFICATION DIVISION.
      *=======================================================================*
       PROGRAM-ID. PROD2V1.
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
      *                        NO MÓDULO 2 PROD 1 exe 2                        *
      *                                                                        *
      *                                                                       *
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
      *    ========input and output files are assigned here ============      *
           SELECT RENTAL ASSIGN TO 'RENTACAR-IN.txt'
               ORGANISATION IS LINE SEQUENTIAL.
           SELECT RENTAL-OUT ASSIGN TO 'RENTACAR-OUT.txt'.

      *=======================================================================*
                                  DATA DIVISION.
      *=======================================================================*
                                   FILE SECTION.

      *          xxxxxxxxxxxxx       ENTRY FILE    xxxxxxxxxxxxxxxxxxxxx      *
           FD RENTAL.
           01 RENTAL-FILE.
               02 CLIENT_NAME PIC A(20).
               02 RENTAL-TYPE.
                   03 NAME_INITIAL PIC A(1).
                   03 CAR_TYPE PIC 9(1).
                   03 KILOMETERS PIC 9(5).
                   03 NUM_DAYS PIC 9(3).

      *          xxxxxxxxxxxxx       OUTPUT FILE    xxxxxxxxxxxxxxxxxxxxx      *
           FD RENTAL-OUT.
           01 RENTAL-FILE-OUT.
               02 CLIENT_NAME_OUT PIC A(20).
               02 FILLER PIC X(1) VALUE SPACE.
               02 NAME_INITIAL_OUT PIC A(1).
               02 FILLER PIC X(1) VALUE SPACE.
               02 CAR_BRAND PIC A(10).
               02 FILLER PIC X(1) VALUE SPACE.
               02 KILOMETERS_OUT PIC zzz99.
               02 FILLER PIC X(1) VALUE SPACE.
               02 NUM_DAYS_OUT PIC zz9.
               02 FILLER PIC X(1) VALUE SPACE.
               02 PAYMENT PIC zz99.99.

      *=======================================================================*
                           WORKING-STORAGE SECTION.

       77  END-LOOP PIC A(3) VALUE SPACES.
       77  KILOMETERS_PAYMENT PIC 9(4)V99.
       77  RENTAL_DAYS_TOTAL PIC 9(4).
      *=======================================================================*
                             PROCEDURE DIVISION.
           MAIN-PROCEDURE.

           OPEN INPUT RENTAL
               OUTPUT RENTAL-OUT.

           READ RENTAL
               AT END MOVE "YYY" TO END-LOOP
           END-READ.



           PERFORM CALCULATIONS UNTIL END-LOOP = "YYY".

           CLOSE RENTAL
                 RENTAL-OUT.

           STOP RUN.

           CALCULATIONS.

           MOVE CLIENT_NAME TO CLIENT_NAME_OUT.
           MOVE NAME_INITIAL TO NAME_INITIAL_OUT.
           MOVE KILOMETERS TO KILOMETERS_OUT.
           MOVE NUM_DAYS TO NUM_DAYS_OUT.

           IF KILOMETERS IS GREATER THAN 75 OR EQUAL TO 75
               COMPUTE KILOMETERS = KILOMETERS - 75.

           EVALUATE CAR_TYPE
              WHEN 1 MOVE "VOLKSWAGEN" TO CAR_BRAND
               COMPUTE KILOMETERS_PAYMENT = KILOMETERS * 0.5
               COMPUTE RENTAL_DAYS_TOTAL = 10 * NUM_DAYS
               COMPUTE PAYMENT = KILOMETERS_PAYMENT + RENTAL_DAYS_TOTAL

              WHEN 2 MOVE "TOYOTA" TO CAR_BRAND
               COMPUTE KILOMETERS_PAYMENT = KILOMETERS * 0.55
               COMPUTE RENTAL_DAYS_TOTAL = 12.5 * NUM_DAYS
               COMPUTE PAYMENT = KILOMETERS_PAYMENT + RENTAL_DAYS_TOTAL

              WHEN 3 MOVE "MERCEDES" TO CAR_BRAND
              COMPUTE KILOMETERS_PAYMENT = KILOMETERS * 0.65
              COMPUTE RENTAL_DAYS_TOTAL = 16 * NUM_DAYS
              COMPUTE PAYMENT = KILOMETERS_PAYMENT + RENTAL_DAYS_TOTAL
           END-EVALUATE.

           WRITE RENTAL-FILE-OUT
               AFTER ADVANCING 1 LINE.

           DISPLAY RENTAL-FILE-OUT.

           READ RENTAL
               AT END MOVE "YYY" TO END-LOOP
           END-READ.

           LEGACY.

       STOP RUN.

       END PROGRAM PROD2V1.
