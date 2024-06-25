       ID DIVISION.
       PROGRAM-ID. AESMPUT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     OUTPUT FILE (AESLOG - LRECL=150)
            SELECT R-LOG ASSIGN TO 'AESLOG'
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE  IS SEQUENTIAL
                   FILE STATUS  IS FS-LOG.

       DATA DIVISION.
       FILE SECTION.
      *   AESLOG
       FD R-LOG LABEL RECORD STANDARD.

       01 LOG.
          COPY 'AESFLOG.cpy'.


       WORKING-STORAGE SECTION.
         01 FS.
            05 FS-LOG                  PIC 9(02).
               88 FS-LOG-OK                      VALUE 0.
               88 FS-LOG-EOF                     VALUE 10.
               88 FS-LOG-AOP                     VALUE 41.

         01 AUX-DATA.
            02 SDATE.
               03 SYYYY                PIC 9(04).
               03 SMM                  PIC 9(02).
               03 SDD                  PIC 9(02).
            02 STIME.
               03 SHH                  PIC 9(02).
               03 SMN                  PIC 9(02).
               03 SSS                  PIC 9(02).
               03 SMS                  PIC 9(02).


       LINKAGE SECTION.
         01 LS.
            COPY 'AESLLOG.cpy'.


       PROCEDURE DIVISION USING LS.
       MAINLINE.
            IF CFILE = SPACES OR LOW-VALUES
      *       Check for threshold
              IF LMESSAGE-LEVEL >= LLOG-LEVEL
                PERFORM LOG-MESSAGE
              END-IF
            ELSE
              PERFORM CLOSE-FILE
            END-IF.

            GOBACK.


       LOG-MESSAGE.
      *     If file is not opened, open it
            IF ISOPEN = SPACES OR LOW-VALUES
              PERFORM OPEN-FILE
            END-IF.

            PERFORM SET-DATA.
            PERFORM WRITE-FILE.


       SET-DATA.
      *     Get system date and time
            ACCEPT SDATE                  FROM DATE YYYYMMDD.
            ACCEPT STIME                  FROM TIME.

      *     Move to file
            MOVE SDD                        TO DD.
            MOVE SMM                        TO MM.
            MOVE SYYYY                      TO YYYY.

            MOVE SHH                        TO HH.
            MOVE SMN                        TO MN.
            MOVE SSS                        TO SS.

      *     Fix the separators 
            MOVE '.'                        TO TST1
                                               TST2.
            MOVE SPACE                      TO TST3.
            MOVE ':'                        TO TST4
                                               TST5.

            MOVE '|'                        TO SEP1
                                               SEP2.

      *     Move the text
            MOVE LTEXT                      TO RTEXT.


       OPEN-FILE.
            OPEN OUTPUT R-LOG.

            IF FS-LOG-OK OR FS-LOG-AOP
              MOVE 'O'                      TO ISOPEN
            ELSE
              DISPLAY 'ERROR OPENING LOG: ' FS-LOG
              STOP RUN
            END-IF.


       WRITE-FILE.
            WRITE LOG.

            IF FS-LOG-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR WRITTING LOG: ' FS-LOG
              STOP RUN
            END-IF.


       CLOSE-FILE.
            CLOSE R-LOG.
 
            IF FS-LOG-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR CLOSING LOG: ' FS-LOG
              STOP RUN
            END-IF.
