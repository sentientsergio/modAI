       ID DIVISION.
       PROGRAM-ID. ITGEN.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     INPUT FILE (AESIDAT - LRECL=32)
            SELECT R-DAT ASSIGN TO 'AESIDAT'
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE  IS SEQUENTIAL
                   FILE STATUS  IS FS-DAT.

      *cobc -x -o TEST1 TEST1.cbl TEST2.cbl
       DATA DIVISION.
       FILE SECTION.
      *   AEDAT
       FD R-DAT LABEL RECORD STANDARD.

       01 DAT                            PIC X(32).

       WORKING-STORAGE SECTION.
         01 FS.
            05 FS-DAT                   PIC 9(02).
               88 FS-DAT-OK                       VALUE 0.
               88 FS-DAT-EOF                      VALUE 10.

       LINKAGE SECTION.
      
       PROCEDURE DIVISION.
       MAINLINE.
            OPEN OUTPUT R-DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON OPEN: ' FS-DAT
              STOP RUN
            END-IF.

            MOVE 
              '00112233445566778899AABBCCDDEEFF'
              TO DAT.

      *     WRITE A LINE
            WRITE DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON WRITTING: ' FS-DAT
              STOP RUN
            END-IF.

            WRITE DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON WRITTING: ' FS-DAT
              STOP RUN
            END-IF.

            CLOSE R-DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERORR ON CLOSING: ' FS-DAT
              STOP RUN
            END-IF.

            STOP RUN.
