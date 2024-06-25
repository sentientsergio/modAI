      ******************************************************************
      * Author: Marco Silva
      * Date: 17/09/19
      * Purpose: Passar o módulo com 10 após este exercicio
      * Tectonics: cobc
      * Não me apeteceu meter as máscaras no input, tenho preguiça
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HalpMePlz.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.

       77  n1      pic S9(2).
       77  n2      pic S9(2).
       77  nTotal  pic S9(4)v99.
       77  nMask   pic -z9.99.
       77  menuEscolha pic x(1) value NULL.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           inicio.
           DISPLAY "insert number 1" AT 1335.
           ACCEPT n1 at 1365.
           display space at 1335.
           compute nTotal = nTotal + n1.
           move nTotal to nMask.

           menu.
           DISPLAY "     =================================" AT 0430.
           DISPLAY "     xx        +) SOMAR             xx" AT 0530.
           DISPLAY "     xx        -) SUBTRAIR          xx" AT 0630.
           DISPLAY "     xx        *) DIVIDIR           xx" AT 0730.
           DISPLAY "     xx        /) MULTIPLICAR       xx" AT 0830.
           DISPLAY "     xx        R) REINICIAR         xx" AT 0930.
           DISPLAY "     xx        S) SAIR              xx" AT 1030.
           DISPLAY "     =================================" AT 1130.
           DISPLAY "     =================================" AT 1430.
           display nMask at 1535.


           display "insira a operacao a efectuar: " at 1335.

           accept menuEscolha at 1365.
           display space at 1335.

           opcao.
           EVALUATE menuEscolha
               WHEN "+"
                   GO TO soma
               WHEN "-"
                  GO TO sub
               WHEN "/"
                   GO TO div
               WHEN "*"
                   GO TO mult
               WHEN "r"
                   GO TO restart
               WHEN "s"
                   GO TO sair
               WHEN OTHER
                   GO TO menu
           END-EVALUATE.

           soma.
           DISPLAY "     =================================" AT 1430.
           display nMask at 1535.

               DISPLAY menuEscolha at 1565.
               DISPLAY "insert number: " at 1335.

           ACCEPT n2 at 1360.
               compute nTotal = nTotal + n2.
               move nTotal to nMask.

           GO TO menu.

           sub.
           DISPLAY "     =================================" AT 1430.
           display nMask at 1535.

               DISPLAY menuEscolha at 1565.
               DISPLAY "insert number: " at 1335.

           ACCEPT n2 at 1360.
               compute nTotal = nTotal - n2.
               move nTotal to nMask.
           GO TO menu.

           div.
           DISPLAY "     =================================" AT 1430.
           display nMask at 1535.
               DISPLAY "insert number: " at 1335.
               DISPLAY menuEscolha at 1565.

           ACCEPT n2 at 1360.
               compute nTotal = nTotal / n2.
               move nTotal to nMask.
               GO TO menu.

           mult.
           DISPLAY "     =================================" AT 1430.
           display nMask at 1535.
               DISPLAY "insert number: " at 1335.
               DISPLAY menuEscolha at 1565.

           ACCEPT n2 at 1360.
               compute nTotal = nTotal * n2.
               move nTotal to nMask.
           GO TO menu.

           restart.
               compute n1 equals zero.
               compute n2 equals zero.
               compute nTotal equals zero.
           move nTotal to nMask.

           GO TO inicio.

           sair.
           DISPLAY SPACE AT 1601.
           DISPLAY "                                   _" AT 1631.
           DISPLAY "                                ,-"" ""." AT 1731.
           DISPLAY "                              ,'  ____  `." AT 1831.
           DISPLAY "                            ,'  ,'    `.  `._"
      -     AT 1931.
           DISPLAY "   (`.         _..--.._   ,'  ,'        \    \"
      -    AT 2031.
           DISPLAY "  (`-.\    .-""        ""'   /          (  d _b"
      -    AT 2131.
           DISPLAY " (`._  `-"" ,._             (            `-(   \"
      -     AT 2231.
           DISPLAY " <_  `     (  <`<            \              `-._\"
      -    AT 2331.
           DISPLAY "  <`-       (__< <           :" AT 2431.
           DISPLAY "   (__        (_<_<          ;"  AT 2531.
           DISPLAY "quackbye! Press enter to ... escape" AT 2631.

           STOP " ".
           STOP RUN.

           ACCEPT menuEscolha at 1360.
           GO TO opcao.
           STOP RUN.

            STOP RUN.
       END PROGRAM HalpMePlz.
