       ID DIVISION.
       PROGRAM-ID. AESTGET.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     INPUT FILE (AESTAB - LRECL=2860)
            SELECT R-tab ASSIGN TO 'AESTAB'
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE  IS SEQUENTIAL
                   FILE STATUS  IS FS-TAB.

       DATA DIVISION.
       FILE SECTION.
      *   AESTAB
       FD R-TAB LABEL RECORD STANDARD.

       01 TAB.
          COPY 'AESTAB.cpy'.


       WORKING-STORAGE SECTION.
         01 FS.
            05 FS-TAB                  PIC 9(02).
               88 FS-TAB-OK                      VALUE 0.
               88 FS-TAB-EOF                     VALUE 10.
               88 FS-TAB-AOF                     VALUE 41.

         01 PMW.
            COPY 'AESLLOG.cpy'.

       LINKAGE SECTION.
         01 LS.
      *     PUT-MESSAGE AREA
            02 PUT-MESSAGE-LS          PIC X(2178).
      *     DATA-GET AREA
            COPY 'AESLDGET.cpy'.

       PROCEDURE DIVISION USING LS.
       MAINLINE.
            MOVE PUT-MESSAGE-LS             TO PMW.
            MOVE 'OK '                      TO LDG-STATUS.

            IF LDG-CFILE = SPACES OR LOW-VALUES
              IF LDG-ISOPEN = SPACES OR LOW-VALUES
      *         File is not opened, open it
                MOVE 'OPENING AESTAB FILE'  TO LTEXT OF PMW
                SET LLEVEL-INF OF PMW       TO TRUE

                CALL PUT-MESSAGE USING PMW

                PERFORM OPEN-FILE 
              END-IF

      *       Read next reg of file and move it to LS
              MOVE 'READING AESTAB FILE'    TO LTEXT OF PMW
              SET LLEVEL-INF OF PMW         TO TRUE
 
              CALL PUT-MESSAGE USING PMW

              PERFORM READ-FILE
            ELSE
      *       Request to close the file
              MOVE 'CLOSING AESTAB FILE'    TO LTEXT OF PMW
              SET LLEVEL-INF OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW

              PERFORM CLOSE-FILE
            END-IF.

            IF FS-TAB-EOF
              MOVE 'EOF'                    TO LDG-STATUS
            END-IF

            GOBACK.


       OPEN-FILE.
            OPEN INPUT R-TAB.

            IF FS-TAB-OK OR FS-TAB-AOF
              MOVE 'O'                      TO ISOPEN
            ELSE
              STRING 'ERROR OPENING AESTABLE FILE ' 
                     FS-TAB
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR                TO TRUE

              CALL PUT-MESSAGE USING PMW

              PERFORM END-ON-ERROR
            END-IF.


       READ-FILE.
            READ R-TAB.

            EVALUATE TRUE
              WHEN FS-TAB-OK 
                CONTINUE
              WHEN FS-TAB-EOF
                MOVE 'END-OF-FILE AESTAB'   TO LTEXT OF PMW
                SET LLEVEL-INF              TO TRUE

                CALL PUT-MESSAGE USING PMW
              WHEN OTHER
                STRING 'ERROR READING AESTAB FILE '
                       FS-TAB
                DELIMITED BY SIZE         INTO LTEXT OF PMW
                SET LLEVEL-ERR              TO TRUE

                CALL PUT-MESSAGE USING PMW

                PERFORM END-ON-ERROR
            END-EVALUATE.

            PERFORM MOVE-TO-LS.


       CLOSE-FILE.
            CLOSE R-TAB.

            IF FS-TAB-OK
              CONTINUE
            ELSE
              STRING 'ERROR CLOSING AESTAB FILE '
                     FS-TAB
              DELIMITED BY SIZE           INTO LTEXT OF PMW
              SET LLEVEL-ERR OF PMW         TO TRUE

              CALL PUT-MESSAGE USING PMW

              PERFORM END-ON-ERROR
            END-IF.


       MOVE-TO-LS.
            MOVE TAB                        TO LDG-TEXT.


       END-ON-ERROR.
         MOVE 'ERR'                         TO LDG-STATUS.
         GOBACK.
