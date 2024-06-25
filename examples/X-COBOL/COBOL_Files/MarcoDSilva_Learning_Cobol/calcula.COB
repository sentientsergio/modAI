      ******************************************************************
      * Author: Marco
      * Date: 12-09-2019
      * Purpose: avaliação
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AquelaCalculadora.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.

       77  primeiroValor   pic 9(3).
       77  segundoValor    pic 9(3).
       77  soma            pic 9(3).
       77  subtrai         pic 9(3).
       77  divisao         pic 9(3).
       77  multiplicar     pic 9(3).

       77  escolha         pic 9(1).

       77  maskValor1      pic zzzz9.
       77  maskValor2      pic zzzz9.

       77  m_soma          pic zzzz9.
       77  m_subtrai       PIC zzzz9.
       77  m_divisao       pic zzzz9.
       77  m_multiplica    PIC zzzz9.

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.

           primeiraF.
           DISPLAY "Introduza valor1: ".
           ACCEPT primeiroValor.

           perform until (primeiroValor > 0 and primeiroValor < 100) OR
      -    " primeiroValor IS NOT NUMERIC"

             DISPLAY "Introduza valor1: "
             ACCEPT primeiroValor

           END-PERFORM.

           segundaF.
           DISPLAY "Introduza valor2: ".
           ACCEPT segundoValor.

           perform until (segundoValor > 0 and segundoValor < 100) OR
      -    " segundoValor IS NOT NUMERIC"
             DISPLAY "Introduza valor2: "
             ACCEPT segundoValor

           END-PERFORM.

           move primeiroValor to maskValor1.
           move segundoValor to maskValor2.

           DISPLAY "operacoes possiveis:".
           DISPLAY "1 - soma".
           DISPLAY "2 - subtrai".
           DISPLAY "3 - divide".
           DISPLAY "4 - multiplica".

           ACCEPT escolha.

           IF escolha = 1
               GO TO SomaFunc
           END-IF.

           IF escolha = 2
                GO TO SubtraiFunc
           END-IF.

           IF escolha = 3
               GO TO DivisaoFunc
           END-IF.

           IF escolha = 4
               GO TO MultiplicaFunc
           END-IF.

           SomaFunc.
               COMPUTE soma = primeiroValor + segundoValor
               move soma to m_soma
               DISPLAY "SOMA           " m_soma
             STOP RUN.

           SubtraiFunc.
               COMPUTE subtrai = primeiroValor - segundoValor
               move subtrai to m_subtrai
               DISPLAY "SUBTRAI        " m_subtrai.
             STOP RUN.

           DivisaoFunc.
             COMPUTE divisao = primeiroValor / segundoValor
               move divisao to m_divisao
               DISPLAY "DIVISAO        " m_divisao.
             STOP RUN.

           MultiplicaFunc.
             COMPUTE multiplicar = primeiroValor * segundoValor
               move multiplicar TO m_multiplica
               DISPLAY "MULTIPLICAR    " m_multiplica.
             STOP RUN.

      *     DISPLAY "RESULTADOS: ".
      *     DISPLAY "SOMA           " m_soma.
      *     DISPLAY "SUBTRAI        " m_subtrai.
      *     DISPLAY "DIVISAO        " m_divisao.
      *     DISPLAY "MULTIPLICAR    " m_multiplica.

            STOP RUN.
       END PROGRAM AquelaCalculadora.
