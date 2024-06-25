       ID DIVISION.
       PROGRAM-ID. AESTPUT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     OUTPUT FILE (AESODAT - LRECL=32)
            SELECT R-DAT ASSIGN TO 'AESODAT'
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE  IS SEQUENTIAL
                   FILE STATUS  IS FS-DAT.

       DATA DIVISION.
       FILE SECTION.
      *   AESDAT
       FD R-DAT LABEL RECORD STANDARD.

       01 DAT.
          02 OUTPUT-DATA.
             03 ODT OCCURS 32.
                04 OD-ITEM             PIC X(01).

       WORKING-STORAGE SECTION.
         01 FS.
            05 FS-DAT                  PIC 9(02).
               88 FS-DAT-OK                      VALUE 0.
               88 FS-DAT-EOF                     VALUE 10.
               88 FS-DAT-AOF                     VALUE 41.

         01 PMW.
            COPY 'AESLLOG.cpy'.

       LINKAGE SECTION.
         01 LS.
      *     PUT-MESSAGE AREA
            02 PUT-MESSAGE-LS          PIC X(2178).
      *     TEXT-PUT AREA 
            COPY 'AESLTPUT.cpy'.


       PROCEDURE DIVISION USING LS.
       MAINLINE.
            MOVE PUT-MESSAGE-LS             TO PMW.
            MOVE 'OK '                      TO LXP-STATUS.

            IF LXP-CFILE = SPACES OR LOW-VALUES
              IF LXP-ISOPEN = SPACES OR LOW-VALUES
      *         File is not opened, open it
                MOVE 'OPENING FILE'         TO LTEXT OF PMW
                SET LLEVEL-INF OF PMW       TO TRUE

                CALL PUT-MESSAGE USING PMW
                PERFORM OPEN-FILE
              END-IF

      *       Write the reg from LS
              MOVE 'WRITTING FILE'          TO LTEXT OF PMW
              SET LLEVEL-INF OF PMW         TO TRUE
  
              CALL PUT-MESSAGE USING PMW
              PERFORM WRITE-FILE
            ELSE
      *       Request to close the file
              MOVE 'CLOSING FILE'           TO LTEXT OF PMW
              SET LLEVEL-INF OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW
              PERFORM CLOSE-FILE
            END-IF.

            GOBACK.


       OPEN-FILE.
            OPEN OUTPUT R-DAT.

            IF FS-DAT-OK OR FS-DAT-AOF
              MOVE 'O'                      TO ISOPEN
            ELSE
              STRING 'ERROR OPENING OUTPUT FILE '
                     FS-DAT
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW
              PERFORM END-ON-ERROR
            END-IF.


       WRITE-FILE.
            MOVE SPACES                     TO OUTPUT-DATA.
            MOVE LXP-TEXT(1:LXP-TLENGTH)    TO OUTPUT-DATA.

            WRITE DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              STRING 'ERROR WRITTING OUTPUT FILE '
                     FS-DAT
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW
              PERFORM END-ON-ERROR
            END-IF.


       CLOSE-FILE.
            CLOSE R-DAT.
 
            IF FS-DAT-OK
              CONTINUE
            ELSE
              STRING 'ERROR CLOSING OUTPUT FILE '
                     FS-DAT
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW
              PERFORM END-ON-ERROR
            END-IF.


       END-ON-ERROR.
            MOVE 'ERR'                      TO LXP-STATUS.
            GOBACK.
