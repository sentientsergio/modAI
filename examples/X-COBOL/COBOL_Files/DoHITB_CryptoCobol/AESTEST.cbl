       ID DIVISION.
       PROGRAM-ID. AESTEST.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     INPUT FILE (AESIDAT - LRECL=32)
            SELECT R-DAT ASSIGN TO 'AESIDAT'
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE  IS SEQUENTIAL
                   FILE STATUS  IS FS-DAT.

       DATA DIVISION.
       FILE SECTION.
      *   AESIDAT
       FD R-DAT LABEL RECORD STANDARD.
      *          
       01 DAT                            PIC X(32).

       WORKING-STORAGE SECTION.
      *  File Status
         01 FS.
            05 FS-DAT                   PIC 9(02).
               88 FS-DAT-OK                       VALUE 0.
               88 FS-DAT-EOF                      VALUE 10.

      *  Main copy
         01 AES-MAIN.
            COPY "AESLMAIN.cpy".

         01 DAT-MOVE.
            05 D1                      PIC X(16)
            VALUE '0001020304050607'.
            05 D2                      PIC X(16)
            VALUE '08090A0B0C0D0E0F'.
            05 D3                      PIC X(16)
            VALUE '1011121314151617'.
            05 D4                      PIC X(16)
            VALUE '18191A1B1C1D1E1F'.
         66 DAT-MOVE-32   RENAMES D1 THRU D2.
         66 DAT-MOVE-48   RENAMES D1 THRU D3.
         77 DAT-MODE                   PIC X(15) 
            VALUE 'ECBCBCCFBOFBCTR'.
         77 DAT-MODE-R    REDEFINES DAT-MODE
                          OCCURS 5     PIC X(03).
         77 DAT-BITS                   PIC 9(09) 
            VALUE 128192256.
         77 DAT-BITS-R    REDEFINES DAT-BITS
                          OCCURS 3     PIC 9(03).
         77 DAT-I                      PIC 9(01).
         77 DAT-J                      PIC 9(01).
      *     Mode
         01 FILLER        OCCURS 5.
      *         Each mode have 2 occurs
             05 FILLER    OCCURS 2.
      *            BIT length
                10 FILLER OCCURS 3.
                   15 DAT-RES          PIC X(32).

       PROCEDURE DIVISION.
       MAINLINE.
      *     Load pre-calculated results
            PERFORM LOAD-RESULTS.

      *     Begin testing
            PERFORM VARYING DAT-J FROM 1 BY 1
              UNTIL DAT-J > 3
            PERFORM VARYING DAT-I FROM 1 BY 1
              UNTIL DAT-I > 5
              DISPLAY '---------------------------------------------'
              DISPLAY '* TESTING CIPHER (' DAT-MODE-R(DAT-I) ')'
              DISPLAY '* BIT LENGTH: ' DAT-BITS-R(DAT-J)
              DISPLAY '---------------------------------------------'

              PERFORM CIPHER

              MOVE SPACES                        TO LMAIN-DATA-GET
                                                    LMAIN-TEXT-GET
                                                    LMAIN-TEXT-PUT
                                                    LMAIN-PUT-MESSAGE

              MOVE 'CIPHER  '                    TO LMAIN-ACTION
              MOVE DAT-MODE-R(DAT-I)             TO LMAIN-MODE
              MOVE DAT-BITS-R(DAT-J)             TO LMAIN-BITS

              EVALUATE DAT-J
                WHEN 1
                  MOVE DAT-MOVE-32               TO LMAIN-KEY
                WHEN 2
                  MOVE DAT-MOVE-48               TO LMAIN-KEY
                WHEN 3
                  MOVE DAT-MOVE                  TO LMAIN-KEY
              END-EVALUATE

      *       IV is always 32 bits
              MOVE DAT-MOVE-32                   TO LMAIN-IV
              SET LMAIN-LEVEL-INF                TO TRUE

              CALL 'AESMAIN' USING AES-MAIN

              DISPLAY '---------------------------------------------'
              DISPLAY 'EXPECTED:' DAT-RES(DAT-I, 1, DAT-J) 
                      ' ' DAT-RES(DAT-I, 2, DAT-J)
              DISPLAY '---------------------------------------------'
              DISPLAY SPACES

              DISPLAY '---------------------------------------------'
              DISPLAY '* TESTING DECIPHER (' DAT-MODE-R(DAT-I) ')'
              DISPLAY '* BIT LENGTH: ' DAT-BITS-R(DAT-J)
              DISPLAY '---------------------------------------------'

              PERFORM DECIPHER

              MOVE SPACES                        TO LMAIN-DATA-GET
                                                    LMAIN-TEXT-GET
                                                    LMAIN-TEXT-PUT
                                                    LMAIN-PUT-MESSAGE

              MOVE 'DECIPHER'                    TO LMAIN-ACTION
              MOVE DAT-MODE-R(DAT-I)             TO LMAIN-MODE
              MOVE DAT-BITS-R(DAT-J)             TO LMAIN-BITS

              EVALUATE DAT-J
                WHEN 1
                  MOVE DAT-MOVE-32               TO LMAIN-KEY
                WHEN 2
                  MOVE DAT-MOVE-48               TO LMAIN-KEY
                WHEN 3
                  MOVE DAT-MOVE                  TO LMAIN-KEY
              END-EVALUATE

      *       IV is always 32 bits
              MOVE DAT-MOVE-32                   TO LMAIN-IV
              SET LMAIN-LEVEL-INF                TO TRUE

              CALL 'AESMAIN' USING AES-MAIN

              DISPLAY '---------------------------------------------'
              DISPLAY 'EXPECTED: 00112233445566778899AABBCCDDEEFF'
              DISPLAY '---------------------------------------------'
            END-PERFORM
            END-PERFORM.

            STOP RUN.


       CIPHER.
      *     Creates fixed data for cipher
            OPEN OUTPUT R-DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON OPEN: ' FS-DAT
              STOP RUN
            END-IF.

            MOVE '00112233445566778899AABBCCDDEEFF'   
              TO DAT.

            WRITE DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON WRITTING: ' FS-DAT
              STOP RUN
            END-IF.

            MOVE '00112233445566778899AABBCCDDEEFF'   
              TO DAT.

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


       DECIPHER.
      *     Moves the cipher result to file to check decipher
            OPEN OUTPUT R-DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON OPEN: ' FS-DAT
              STOP RUN
            END-IF.

            MOVE DAT-RES(DAT-I, 1, DAT-J)   TO DAT.

            WRITE DAT.

            IF FS-DAT-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON WRITTING: ' FS-DAT
              STOP RUN
            END-IF.

            MOVE DAT-RES(DAT-I, 2, DAT-J)   TO DAT.

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


       LOAD-RESULTS.
      *     Cipher, 128
      *          ECB
            MOVE '69C4E0D86A7B0430D8CDB78070B4C55A'   
            TO DAT-RES(1, 1, 1).
            MOVE '69C4E0D86A7B0430D8CDB78070B4C55A'   
            TO DAT-RES(1, 2, 1).

      *          CBC
            MOVE '76D0627DA1D290436E21A4AF7FCA94B7'   
            TO DAT-RES(2, 1, 1).
            MOVE '32A06AF3E0DF74A359A0D1F48889E615'   
            TO DAT-RES(2, 2, 1).

      *          CFB
            MOVE '0A852986053B9632795A3EE30A8E04A5'   
            TO DAT-RES(3, 1, 1).
            MOVE 'CCEFB18FAB11BCA67C621A7B947C0F3C'   
            TO DAT-RES(3, 2, 1).

      *          OFB
            MOVE '0A852986053B9632795A3EE30A8E04A5'   
            TO DAT-RES(4, 1, 1).
            MOVE 'AEF63C960582C83C63F9147795E2589C'   
            TO DAT-RES(4, 2, 1).

      *          CTR
            MOVE '735731A6D195D269C1E21758A929C3F5'   
            TO DAT-RES(5, 1, 1).
            MOVE '49C7A560DDCEC0FB6B10D0D3AC5C5E62'   
            TO DAT-RES(5, 2, 1).


      *     Cipher, 192
      *          ECB
            MOVE 'DDA97CA4864CDFE06EAF70A0EC0D7191'   
            TO DAT-RES(1, 1, 2).
            MOVE 'DDA97CA4864CDFE06EAF70A0EC0D7191'   
            TO DAT-RES(1, 2, 2).

      *          CBC
            MOVE '9CA47EFF6FD2880B742263496D1C3D3E'   
            TO DAT-RES(2, 1, 2).
            MOVE 'B4A7657757AF7498049138B990DE9445'   
            TO DAT-RES(2, 2, 2).

      *          CFB
            MOVE '00719DCD02D62DCF52C5531DD32FCE51'   
            TO DAT-RES(3, 1, 2).
            MOVE 'F0610E02E49F48F8EFA27D48906564B3'   
            TO DAT-RES(3, 2, 2).

      *          OFB
            MOVE '00719DCD02D62DCF52C5531DD32FCE51'   
            TO DAT-RES(4, 1, 2).
            MOVE '2E95E921E70C71C716BC0819F12C7123'   
            TO DAT-RES(4, 2, 2).

      *          CTR
            MOVE '495F1A690F6AC9C09B734613C4BF89E8'   
            TO DAT-RES(5, 1, 2).
            MOVE 'DB1230B8F318425B0BDBE89D3B17CB39'   
            TO DAT-RES(5, 2, 2).


      *     Cipher, 256
      *          ECB
            MOVE '8EA2B7CA516745BFEAFC49904B496089'   
            TO DAT-RES(1, 1, 3).
            MOVE '8EA2B7CA516745BFEAFC49904B496089'   
            TO DAT-RES(1, 2, 3).

      *          CBC
            MOVE '78E16B06817A4453ABEF8A235FA9FA51'   
            TO DAT-RES(2, 1, 3).
            MOVE '6AEA1E8929F1A7A7EEB3450822E766F8'   
            TO DAT-RES(2, 2, 3).

      *          CFB
            MOVE '5A7F26644CAE17E178B7FF86CE1E486D'   
            TO DAT-RES(3, 1, 3).
            MOVE '2E05F8BBE5166FBBD52A771A3D4FC393'   
            TO DAT-RES(3, 2, 3).

      *          OFB
            MOVE '5A7F26644CAE17E178B7FF86CE1E486D'   
            TO DAT-RES(4, 1, 3).
            MOVE 'CDED0706755E931CA62E2019960099AE'   
            TO DAT-RES(4, 2, 3).

      *          CTR
            MOVE 'F04C549D0EECF9922E6F318A841FD8C2'   
            TO DAT-RES(5, 1, 3).
            MOVE '0EAD97EDF179E5CA8031038ED4F17F66'   
            TO DAT-RES(5, 2, 3).
