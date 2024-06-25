      ******************************************************************
      * Author: Não foi o Marco
      * Date: 23/10/2019
      * Purpose: treinar algo
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. send_halp.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT ISBN ASSIGN TO "ISBN-IN.txt"
               ORGANISATION IS LINE SEQUENTIAL.
           SELECT ISBN-OUT ASSIGN TO 'ISBN-OUT.txt'.

       DATA DIVISION.
           FILE SECTION.
      *               ========  info a ler ========                                              *
           FD ISBN.
           01 ISBN-FILE.
               02 TITULO PIC A(80).
               02 AUTOR PIC A(30).
               02 EDITORA PIC A(20).
               02 ISBN-ID.
                   03 ID-PAIS PIC 9(3).
                   03 ID-EDITORA PIC 9(2).
                   03 ID-LIVRO PIC 9(4).
                   03 CONTROLO PIC X(1).
               02 VENDIDAS PIC 9(4).
               02 PRECO PIC 9(5).
               02 DESCONTO PIC 9(2).

      *                ======== vomitar ficheiro =======                                       *
           FD ISBN-OUT.
           01 ISBN-FILE-OUT.
               02 ISBN-ID-OUT.
                   03 ID-PAIS-OUT PIC 9(3).
                   03 ID-EDITORA-OUT PIC 9(2).
                   03 ID-LIVRO-OUT PIC 9(4).
                   03 CONTROLO-OUT PIC X(1).

               02 FILLER PIC X(1) VALUE SPACE.
               02 VENDIDAS-OUT PIC 9(4).
               02 FILLER PIC X(1) VALUE SPACE.
               02 PRECO-OUT PIC 9(5).
               02 FILLER PIC X(1) VALUE SPACE.
               02 DESCONTO-OUT PIC 9(2).
               02 FILLER PIC X(1) VALUE SPACE.
               02 VALOR-FACTURADO-OUT PIC 9(6).
               02 FILLER PIC X(1) VALUE SPACE.
               02 OBSERVACOES-OUT PIC X(10).



       WORKING-STORAGE SECTION.
           01 TERMINA-LOOP PIC A(3) VALUE SPACE.
           77 OBSERVA PIC X(10).
           77 iva pic 9(5).
           77 calcula_desconto pic 9(5).
           77 calcula_preco pic 9(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT ISBN
               OUTPUT ISBN-OUT.

           READ ISBN
               AT END MOVE 'YYY' TO TERMINA-LOOP
           END-READ.

           PERFORM cuspidelas UNTIL TERMINA-LOOP = 'YYY'.

           CLOSE ISBN
               ISBN-OUT.
           STOP RUN.

           cuspidelas.
           if(CONTROLO is not numeric and CONTROLO is not equal TO 'X')
      -    move "ISBN INVALIDO" TO OBSERVA.

               MOVE ID-PAIS to ID-PAIS-OUT.
               move ID-EDITORA to ID-EDITORA-OUT.
               move ID-LIVRO TO ID-LIVRO-OUT.
               MOVE CONTROLO TO CONTROLO-OUT.
               move VENDIDAS to VENDIDAS-OUT.
               move PRECO to PRECO-OUT.
               move DESCONTO to DESCONTO-out.

           compute iva = ((VENDIDAS * preco) * 0.05)
           compute calcula_desconto = ((VENDIDAS * preco) + iva) * 0.20
           compute calcula_preco = ((vendidas * preco) + iva)
      -         - calcula_desconto.

               move calcula_preco TO VALOR-FACTURADO-OUT.
               move OBSERVA TO OBSERVACOES-OUT.

           WRITE ISBN-FILE-OUT
             AFTER ADVANCING 1 LINE.

               move SPACE to OBSERVA.
               DISPLAY ISBN-FILE-OUT.

           READ ISBN
               AT END MOVE 'YYY' TO TERMINA-LOOP
           END-READ.


       END PROGRAM send_halp.
