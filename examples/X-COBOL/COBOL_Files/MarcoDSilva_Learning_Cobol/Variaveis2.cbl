      ******************************************************************
      * Author: Marco
      * Date: 04/09/2019
      * Purpose: Records and output input
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. vars2.
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       77  name_user      pic x(20) value spaces.
       77  age_user    pic 9(2) value zeros.
       77  actual_year pic 9(4) value 2019.
       77  data_actual   pic 9(6)  value zeros.
       77  data_actual_mask  pic 99/99/99.
       77  day_semana    pic 9(1)  value zero.

       01  horas_actuais.
           02 horas_dia  pic 9(2) value ZEROS.
           02 filler pic X(1) value ":".
           02 minutos_dia pic 9(2) value zeros.


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           DISPLAY "insira o seu nome".
           ACCEPT name_user.

           DISPLAY "insira a sua idade."
           ACCEPT age_user.

           SUBTRACT age_user FROM actual_year.

           DISPLAY "insira data actual em YYMMDD".
           accept data_actual.
           MOVE data_actual to data_actual_mask.

           DISPLAY "insira o dia da semana".
           ACCEPT day_semana.

           DISPLAY "insira a hora".
           ACCEPT horas_dia.

           DISPLAY "insira minutos".
           ACCEPT minutos_dia.

           DISPLAY "Ola, " name_user.
           DISPLAY "Nasceste em " actual_year.

            EVALUATE day_semana
             WHEN 1 DISPLAY "Dia: Segunda-Feira"
             WHEN 2 DISPLAY "Dia: Terça-Feira"
             WHEN 3 DISPLAY "Dia: Quarta-feira"
             WHEN 4 DISPLAY "Dia: Quinta-feira"
             WHEN 5 DISPLAY "Dia: Sexta-feira"
             WHEN 6 DISPLAY "Dia: Sábado"
             WHEN 7 DISPLAY "Dia: Domingo".

           DISPLAY "horas actuais: " horas_actuais.

           STOP RUN.
       END PROGRAM vars2.
