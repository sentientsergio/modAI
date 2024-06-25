      *================================================================*
       IDENTIFICATION                                  DIVISION.
      *================================================================*
       PROGRAM-ID. PRODUCAO-1.
      ***************************DOCUMENTAÇÃO***************************
      ******************************************************************
      *                                                       PI 01-19 *
      *    AUTOR:      Marco Silva nº 9                                *
      *    DATA:       2019/09/26                                      *
      *    ESPECIFICACAO DO PROGRAMA: Cálculo da média aritmética das  *
      *                               notas de um aluno    (prod)      *
      *    LOCAL:      Mazagão(AVELEDA!), Braga, Portugal              *
      *                                                                *
      *    NOTA ESCOLAR: 20 valores e umas sandes de presunto          *                                 *
      *                                                                *
      *    COMENTÁRIOS:                                               *
      *                                                                *
      ******************************************************************
      *************************FIM DOCUMENTAÇÃO*************************

      *================================================================*
       ENVIRONMENT                                     DIVISION.
      *================================================================*

      *----------------------------------------------------------------*
       CONFIGURATION                           SECTION.
      *----------------------------------------------------------------*

       SPECIAL-NAMES.

      *----------------------------------------------------------------*
       INPUT-OUTPUT                            SECTION.
      *----------------------------------------------------------------*

       FILE-CONTROL.

      *================================================================*
       DATA                                            DIVISION.
      *================================================================*

      *----------------------------------------------------------------*
       FILE                                    SECTION.
      *----------------------------------------------------------------*

      *----------------------------------------------------------------*
       WORKING-STORAGE                         SECTION.
      *-   ---------------------------------------------------------------*
       77  input_grade         PIC z9.
       77  student_name        PIC A(20) VALUE SPACES.
       77  first_grade         PIC 9(2) VALUE 0.
       77  second_grade        PIC 9(2) VALUE 0.
       77  third_grade         PIC 9(2) VALUE 0.
       77  fourth_grade        PIC 9(2) VALUE 0.
       77  sum_grades          PIC 9(2) value zero.
       77  average             PIC S9(2)V99.
       77  avg_masked          PIC z9.99.
       77  exit_cmd            pic x(1) value null.
       77  exam_masked         pic z9.
       77  exam_grade          pic 9(2)V99 value zero.
       77  masked_hours_input  pic z9.
       77  faulty_hours        pic 9(2) value zero.
       77  faulty_dec          pic 9(2)V99.
       77  faulty_masked       pic z9.99.

       01  actual_date.
           03 ac_year   PIC  9(2) values zero.
           03 ac_month  PIC  9(2) values zero.
           03 ac_day    PIC  9(2) values zero.


      *----------------------------------------------------------------*
       SCREEN                                  SECTION.
      *----------------------------------------------------------------*


      *================================================================*
       PROCEDURE                                       DIVISION.
      *================================================================*

      *    ==== data, texto calculo media notas e dados avaliacao ======       *
       ACCEPT actual_date FROM DATE.
           DISPLAY "Data: " AT 0202 ac_day "/" ac_month "/" ac_year.

           DISPLAY "XXXXX Calculo da Media das notas do aluno XXXXX"
      -    AT 0235.

           DISPLAY "DADOS para avaliacao" AT 0355.

           getName.
           DISPLAY "Digite o nome do aluno: " AT 0413.
           ACCEPT student_name AT 0455.

           IF (student_name IS NOT ALPHABETIC) OR
      -         (student_name IS EQUAL TO SPACES)
               GO TO getName
           END-IF.

      *      ======== notas e verificação das mesmas  ========              *
           firstGrade.
           DISPLAY "Digite a primeira nota: " AT 0513.
           DISPLAY " valor(es)" AT 0557.
           ACCEPT input_grade AT 0555.


           MOVE input_grade TO first_grade.

           IF (first_grade GREATER THAN 20) OR (first_grade LESS THAN 0)
              GO TO firstGrade
           END-IF.

           secondGrade.
           DISPLAY "Digite a segunda nota: " AT 0613.
           DISPLAY " valor(es)" AT 0657.
           ACCEPT input_grade AT 0655.

           MOVE input_grade TO second_grade.

           IF (second_grade > 20) OR (second_grade LESS THAN 0)
              GO TO secondGrade
           END-IF.

           thirdGrade.
           DISPLAY "Digite a terceira nota: " AT 0713.
           DISPLAY " valor(es)" AT 0757.
           ACCEPT input_grade AT 0755.
           MOVE input_grade TO third_grade.

           IF (third_grade GREATER THAN 20) OR (third_grade LESS THAN 0)
              GO TO thirdGrade
           END-IF.

           fourthGrade.
           DISPLAY "Digite a quarta nota: " AT 0813.
           DISPLAY " valor(es)" AT 0857.
           ACCEPT input_grade AT 0855.
           MOVE input_grade TO fourth_grade.

           IF (fourth_grade > 20) OR (fourth_grade LESS THAN 0)
              GO TO fourthGrade
           END-IF.

      *           ================ faltas do aluno ===============
           skippingHours.
           DISPLAY "Numero de horas de falta: " AT 0913.
           DISPLAY " horas" AT 0957
           ACCEPT masked_hours_input AT 0955.
           MOVE masked_hours_input TO faulty_hours.
           COMPUTE faulty_dec = (faulty_hours * 0.5);

      *         ============== calculos da media ==================          *
           COMPUTE sum_grades  = first_grade + second_grade
      -        + third_grade + fourth_grade.

           COMPUTE average = (sum_grades / 4).
           MOVE average to avg_masked.

      *          ================= horas/media  ====================
           IF average - faulty_dec < 0
               GO TO finalHoras
           ELSE
               IF (faulty_hours > 25)
                   GO TO reprovado
           END-IF.

      *        ======== verifica se média acima ou abaixo de 10 =========      *
           IF (average < 10)
               DISPLAY "-------------------------------------" AT 1234
               DISPLAY "A media do aluno: " AT 1343 avg_masked at 1362
               DISPLAY "O aluno: " AT 1443 student_name AT 1452
               DISPLAY "O aluno esta reprovado." AT 1543
               DISPLAY "-------------------------------------" AT 1634
               GO TO exam
           ELSE
               DISPLAY "-------------------------------------" AT 1234
               DISPLAY "A media do aluno: " AT 1343 avg_masked at 1362
               DISPLAY "O aluno: " AT 1443 student_name AT 1452
               DISPLAY "O aluno esta aprovado." AT 1543
               DISPLAY "-------------------------------------" AT 1634
               GO TO fimPrograma
           END-IF.

      *        =========== Nota exame e nova media ==============              *
           exam.
               DISPLAY "Digite a nota do exame: " AT 1813
               DISPLAY " valor(es)" AT 1857
               ACCEPT exam_masked AT 1855
               MOVE exam_masked TO exam_grade.

           IF (exam_grade GREATER THAN 20) OR (exam_grade LESS THAN 0)
              GO TO exam
           END-IF.

           COMPUTE exam_grade = ((exam_grade + average) / 2).
           MOVE exam_grade TO avg_masked.

           IF exam_grade GREATER or EQUAL to 10
               DISPLAY "-------------------------------------" AT 2034
               DISPLAY "A media do aluno: " AT 2143 avg_masked at 2162
               DISPLAY "O aluno: " AT 2243 student_name AT 2252
               DISPLAY "O aluno esta aprovado." AT 2343
               DISPLAY "-------------------------------------" AT 2434
               GO TO fimPrograma
           ELSE
               DISPLAY "-------------------------------------" AT 2034
               DISPLAY "A media do aluno: " AT 2143 avg_masked at 2162
               DISPLAY "O aluno: " AT 2243 student_name AT 2252
               DISPLAY "O aluno esta reprovado." AT 2343
               DISPLAY "-------------------------------------" AT 2434
               GO TO fimPrograma
           END-IF.


           finalHoras.
             COMPUTE faulty_masked = (average - faulty_dec)
             DISPLAY "-------------------------------------" AT 1234
             DISPLAY "A media do aluno: " AT 1343 avg_masked at 1362
             DISPLAY "O aluno: " AT 1443 student_name AT 1452
             DISPLAY "O aluno esta reprovado." AT 1543
             DISPLAY "-------------------------------------" AT 1634
             DISPLAY "O aluno esta reprovado por faltas com o " AT 1713
      -    "valor de : " AT 1753 "-" AT 1765 faulty_masked AT 1766
      -     " valores" AT 1771
             GO TO fimPrograma.

           reprovado.
               DISPLAY "XXXXX REPROVADO XXXXXX" AT 1238.

           fimPrograma.
               DISPLAY "---------------FIM DO PROGRAMA--------------"
      -     AT 3030
            ACCEPT exit_cmd AT 2901.
           STOP RUN.
       END PROGRAM PRODUCAO-1.
