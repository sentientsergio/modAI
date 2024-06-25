       ID DIVISION.
       PROGRAM-ID. AESXGET.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     INPUT FILE (AESDAT - LRECL=32)
            SELECT R-DAT ASSIGN TO 'AESIDAT'
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE  IS SEQUENTIAL
                   FILE STATUS  IS FS-DAT.

       DATA DIVISION.
       FILE SECTION.
      *   AESIDAT
       FD R-DAT LABEL RECORD STANDARD.

       01 DAT.
          02 INPUT-DATA.   
             03 IDT OCCURS 32.
                04 ID-ITEM             PIC X(1).


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
      *     TEXT-GET AREA
            COPY 'AESLXGET.cpy'.

      
       PROCEDURE DIVISION USING LS.
       MAINLINE.
            MOVE PUT-MESSAGE-LS             TO PMW.
            MOVE 'OK '                      TO LXG-STATUS.

            IF LXG-CFILE = SPACES OR LOW-VALUES
              IF LXG-ISOPEN = SPACES OR LOW-VALUES
      *         File is not opened, open it
                MOVE 'OPENING AESIDAT FILE' TO LTEXT OF PMW
                SET LLEVEL-INF OF PMW       TO TRUE

                CALL PUT-MESSAGE USING PMW
                PERFORM OPEN-FILE
              END-IF

      *       Read next reg of file and move it to LS
              MOVE 'READING AESIDAT FILE'   TO LTEXT OF PMW
              SET LLEVEL-INF OF PMW         TO TRUE
 
              CALL PUT-MESSAGE USING PMW
              PERFORM READ-FILE
            ELSE
      *       Request to close the file
              MOVE 'CLOSING AESIDATA FILE'  TO LTEXT OF PMW
              SET LLEVEL-INF OF PMW         TO TRUE
  
              CALL PUT-MESSAGE USING PMW
              PERFORM CLOSE-FILE
            END-IF.

            IF FS-DAT-EOF
              MOVE 'EOF'                    TO LXG-STATUS
            END-IF

            GOBACK.


       OPEN-FILE.
            OPEN INPUT R-DAT.

            IF FS-DAT-OK OR FS-DAT-AOF
              MOVE 'O'                      TO ISOPEN
            ELSE
              STRING 'ERROR OPENING AESIDAT FILE ' 
                     FS-DAT
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR                TO TRUE

              CALL PUT-MESSAGE USING PMW
              PERFORM END-ON-ERROR
            END-IF.


       READ-FILE.
            READ R-DAT.

            EVALUATE TRUE
              WHEN FS-DAT-OK 
                CONTINUE
              WHEN FS-DAT-EOF
                MOVE 'END-OF-FILE(AESIDAT)' TO LTEXT OF PMW
                SET LLEVEL-INF              TO TRUE

                CALL PUT-MESSAGE USING PMW
              WHEN OTHER
                STRING 'ERROR READING AESIDAT FILE '
                       FS-DAT
                DELIMITED BY SIZE         INTO LTEXT OF PMW
                SET LLEVEL-ERR              TO TRUE

                CALL PUT-MESSAGE USING PMW
                PERFORM END-ON-ERROR
            END-EVALUATE.

            PERFORM MOVE-TO-LS.


       CLOSE-FILE.
            CLOSE R-DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              STRING 'ERROR CLOSING AESIDAT FILE '
                     FS-DAT
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW
              PERFORM END-ON-ERROR
            END-IF.


       MOVE-TO-LS.
            MOVE DAT                        TO LXG-TEXT.
            MOVE 32                         TO LXG-TLENGTH.


       END-ON-ERROR.
         MOVE 'ERR'                         TO LXG-STATUS.
         GOBACK.
