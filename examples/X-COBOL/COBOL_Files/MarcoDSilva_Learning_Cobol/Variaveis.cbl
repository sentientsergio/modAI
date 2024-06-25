      ******************************************************************
      * Author: Marco
      * Date: 04/09/2019
      * Purpose: Variaveis
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. variables.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77  Numero      PIC 9(18).
       77  Nome        PIC A(15).
       77  alphanum    PIC X(15).
       77  num_dec     pic 9(02).9(02).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           display "insira num".
           accept Numero.

           display "insira nome".
           accept nome.

           display "insira alphanum".
           accept alphanum.

           display "insira num_dec".
           accept num_dec.

            STOP RUN.
       END PROGRAM variables.
