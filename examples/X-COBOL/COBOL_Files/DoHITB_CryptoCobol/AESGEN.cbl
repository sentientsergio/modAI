       ID DIVISION.
       PROGRAM-ID. AESGEN.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     OUTPUT FILE (AESTAB - LRECL=2860)
            SELECT R-TAB ASSIGN TO 'AESTAB'
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
            05 FS-TAB                   PIC 9(02).
               88 FS-TAB-OK                       VALUE 0.
               88 FS-TAB-EOF                      VALUE 10.

         01 AUX-DATA.
            05 X                        PIC 9(03).
            05 Y                        PIC 9(03).
            05 MMR-TEMP.
               10 MMR-F                 PIC X(04).
               10 MMR-T                 PIC X(04).
            05 PMUL-TEMP.
               10 PMUL-RT OCCURS 2.
                  15 PMUL-T             PIC X(01).
            05 XBR-T                    PIC X(04).
            05 SBR-T                    PIC X(32).
            05 SBR-TR REDEFINES SBR-T OCCURS 16
                                        PIC X(02).

         01 SUMM.
            05 BYTE-A.
               10 BITS-A OCCURS 8.
                  15 BIT-A              PIC 9(1).
            05 BYTE-NA REDEFINES BYTE-A PIC 9(8).
            05 BYTE-B.
               10 BITS-B OCCURS 8.
                  15 BIT-B              PIC 9(1).
            05 BYTE-NB REDEFINES BYTE-B PIC 9(8).
            05 BYTE-R.
               10 BITS-R OCCURS 8.
                  15 BIT-R              PIC 9(1).
            05 BYTE-NR REDEFINES BYTE-R PIC 9(8).

         01 MUL.
            05 WS-MX                    PIC 9(2).
            05 BYTE-A.
               10 BITS-A OCCURS 8.
                  15 BIT-A              PIC 9(1).
            05 BYTE-NA REDEFINES BYTE-A PIC 9(8).
            05 BYTE-B. 
               10 BITS-B OCCURS 8.
                  15 BIT-B              PIC 9(1).
            05 BYTE-NB REDEFINES BYTE-B PIC 9(8).
            05 BYTE-T.
               10 BITS-T OCCURS 16.
                  15 BIT-T              PIC 9(1).
            05 BYTE-NT REDEFINES BYTE-T PIC 9(16).
            05 BYTE-X.
               10 BITS-X OCCURS 8.
                  15 BIT-X              PIC 9(1).
            05 BYTE-NX REDEFINES BYTE-X PIC 9(8).
            05 BYTE-Y.
               10 BITS-Y OCCURS 9.
                  15 BIT-Y              PIC 9(1).
            05 BYTE-NY REDEFINES BYTE-Y PIC 9(9).
            05 BYTE-R. 
               10 BITS-R OCCURS 8.
                  15 BIT-R              PIC 9(1).
            05 BYTE-NR REDEFINES BYTE-R PIC 9(8).

         01 PMUL.
            05 WS-PX                    PIC 9(1).
            05 BYTE-A.
               10 BITS-A OCCURS 8.
                  15 BIT-A              PIC 9(1).
            05 BYTE-B.
               10 BITS-B OCCURS 8.
                  15 BIT-B              PIC 9(1).
            05 BYTE-R.
               10 BITS-R OCCURS 8.
                  15 BIT-R              PIC 9(1).
            05 BYTE-AUX.
               10 BIT-ACC               PIC 9(1).
               10 BIT-AUX-FULL.
                  15 BITS-AUX OCCURS 8.
                     20 BIT-AUX         PIC 9(1).

         01 WMUL.
            05 WS-WX                    PIC 9(1).
            05 WS-WY                    PIC 9(1).
            05 WORD-A. 
               10 WORDS-A OCCURS 4.
                  15 BYTE-A             PIC X(8).
            05 WORD-B.
               10 WORDS-B OCCURS 4.
                  15 BYTE-B             PIC X(8).
            05 WORD-R.
               10 WORDS-R OCCURS 4.
                  15 BYTE-R             PIC X(8).

         01 OFFSET-BYTES-A.
            05 OFFSET-BYTES-RAW.
               10 OFFSET-BYTE-1         PIC X(4) VALUE '1432'.
               10 OFFSET-BYTE-2         PIC X(4) VALUE '2143'.
               10 OFFSET-BYTE-3         PIC X(4) VALUE '3214'.
               10 OFFSET-BYTE-4         PIC X(4) VALUE '4321'.
            05 FILLER REDEFINES OFFSET-BYTES-RAW OCCURS 4.
               10 FILLER OCCURS 4.
                  15 OFFSET-BYTE-A      PIC 9(1).

         01 B2W-DATA.
            05 B2W-A                    PIC X(4).
            05 B2W-D REDEFINES B2W-A   
                     OCCURS 4           PIC 9(1).
            05 B2W-R                    PIC X(1).
            05 B2W-I                    PIC 9(2).
            05 B2W-TABLE.
               10 B2W-T OCCURS 16       PIC X(1).

         01 W2B-DATA.
            05 W2B-A                    PIC X(1).
            05 W2B-I                    PIC 9(2).
            05 W2B-R                    PIC X(4).
            05 W2B-TABLE.
               10 W2B-T OCCURS 16       PIC X(4).

         01 W2D-DATA.
            05 W2D-A                    PIC X(1).
            05 W2D-D                    PIC 9(2).
            05 W2D-R                    PIC 9(2).

         01 D2B-DATA.
            05 D2B-A                    PIC 9(3).
            05 D2B-W1                   PIC 9(2).
            05 D2B-W2                   PIC 9(2).
            05 D2B-RES.
               10 D2B-RX OCCURS 2.
                  15 D2B-R              PIC X(4).

         01 NOR.
            05 WS-NI                    PIC 9(1).
            05 BYTE-A.
               10 BITS-A OCCURS 8.
                  15 BIT-A              PIC 9(1).
            05 BYTE-R.
               10 BITS-R OCCURS 8.
                  15 BIT-R              PIC 9(1).

         01 NORM-DATA.
            05 NORM-A                   PIC X(1).
            05 NORM-D REDEFINES NORM-A  PIC 9(1).
            05 NORM-R                   PIC X(1).
            05 NORM-TABLE.
               10 NORM-T OCCURS 10      PIC X(1).

       LINKAGE SECTION.

       PROCEDURE DIVISION.
       MAINLINE.
      *     First of all, fill the tables.
            PERFORM B2W-FILL.
            PERFORM NORM-FILL.
            PERFORM W2B-FILL.         

            OPEN OUTPUT R-TAB.

            IF FS-TAB-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON OPEN: ' FS-TAB
              STOP RUN
            END-IF.

      *     CIPHER MODE
      *     Fill M-BOX
            MOVE '0123'                     TO M-MAP.
            MOVE '0000'                     TO MMR-F.

            PERFORM VARYING X FROM 1 BY 1
              UNTIL X > 4
              MOVE MMR(X)                   TO W2B-A
              PERFORM W2B
              MOVE W2B-R                    TO MMR-T

              PERFORM VARYING Y FROM 1 BY 1
                UNTIL Y > 256
                MOVE MMR-TEMP               TO BYTE-A OF PMUL
                MOVE Y                      TO D2B-A
                PERFORM D2B
                MOVE D2B-RES                TO BYTE-B OF PMUL

                PERFORM PMULTIPLICATION

                MOVE BYTE-R OF PMUL(1:4)    TO B2W-A
                PERFORM B2W
                MOVE B2W-R                  TO PMUL-T(1)
                MOVE BYTE-R OF PMUL(5:4)    TO B2W-A
                PERFORM B2W
                MOVE B2W-R                  TO PMUL-T(2)
                MOVE PMUL-TEMP              TO MB-R(X, Y)
              END-PERFORM
            END-PERFORM.

      *     Fill X-BOX
            PERFORM VARYING X FROM 1 BY 1
              UNTIL X > 16
              MOVE X                        TO D2B-A
              PERFORM D2B
              MOVE D2B-R(2)                 TO XBR-T
              PERFORM VARYING Y FROM 1 BY 1
                UNTIL Y > 16
                MOVE XBR-T                  TO BYTE-A OF SUMM
                MOVE '0000'                 TO BYTE-A OF SUMM(5:4)
 
                MOVE Y                      TO D2B-A
                PERFORM D2B
                MOVE D2B-R(2)               TO BYTE-B OF SUMM
                MOVE '0000'                 TO BYTE-B OF SUMM(5:4)

                PERFORM ADDITION

                MOVE BYTE-R OF SUMM(1:4)    TO B2W-A
                PERFORM B2W
                MOVE B2W-R                  TO XB-R(X, Y)
              END-PERFORM
            END-PERFORM.

      *     Fill S-BOX
            MOVE '63CAB7040953D051CD60E0E7BA70E18C'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(1).
            MOVE '7C82FDC783D1EFA30C8132C8783EF8A1'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(2).
            MOVE '77C993232C00AA40134F3A3725B59889'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(3).
            MOVE '7B7D26C31AEDFB8FECDC0A6D2E66110D'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(4).
            MOVE 'F2FA36181B2043925F22498D1C4869BF'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(5).
            MOVE '6B593F966EFC4D9D972A06D5A603D9E6'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(6).
            MOVE '6F47F7055AB133384490244EB4F68E42'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(7).
            MOVE 'C5F0CC9AA05B85F517885CA9C60E9468'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(8).
            MOVE '30AD3407526A45BCC446C26CE8619B41'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(9).
            MOVE '01D4A5123BCBF9B6A7EED356DD351E99'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(10).
            MOVE '67A2E580D6BE02DA7EB8ACF47457872D'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(11).
            MOVE '2BAFF1E2B3397F213D1462EA1FB9E90F'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(12).
            MOVE 'FE9C71EB294A501064DE91654B86CEB0'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(13).
            MOVE 'D7A4D827E34C3CFF5D5E957ABDC15554'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(14).
            MOVE 'AB7231B22F589FF3190BE4AE8B1D28BB'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(15).
            MOVE '76C0157584CFA8D273DB79088A9EDF16'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(16).


      *     WRITE A LINE
            WRITE TAB.

            IF FS-TAB-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON WRITTING: ' FS-TAB
              STOP RUN
            END-IF.

      *     DECIPHRER MODE
      *     Fill M-BOX
            MOVE '9BDE'                     TO M-MAP.
            MOVE '0000'                     TO MMR-F.

            PERFORM VARYING X FROM 1 BY 1
              UNTIL X > 4
              MOVE MMR(X)                   TO W2B-A
              PERFORM W2B
              MOVE W2B-R                    TO MMR-T

              PERFORM VARYING Y FROM 1 BY 1
                UNTIL Y > 256
                MOVE MMR-TEMP               TO BYTE-A OF PMUL
                MOVE Y                      TO D2B-A
                PERFORM D2B
                MOVE D2B-RES                TO BYTE-B OF PMUL

                PERFORM PMULTIPLICATION

                MOVE BYTE-R OF PMUL(1:4)    TO B2W-A
                PERFORM B2W
                MOVE B2W-R                  TO PMUL-T(1)
                MOVE BYTE-R OF PMUL(5:4)    TO B2W-A
                PERFORM B2W
                MOVE B2W-R                  TO PMUL-T(2)
                MOVE PMUL-TEMP              TO MB-R(X, Y)
              END-PERFORM
            END-PERFORM.

      *     Fill S-BOX
            MOVE '527C5408726C90D03A9647FC1F60A017'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(1).
            MOVE '09E37B2EF870D82C91ACF156DD51E02B'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(2).
            MOVE '6A3994A1F648AB1E11741A3EA87F3B04'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(3).
            MOVE 'D58232666450008F4122714B33A94D7E'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(4).
            MOVE '309BA62886FD8CCA4FE71DC68819AEBA'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(5).
            MOVE '362FC2D968EDBC3F67AD29D207B52A77'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(6).
            MOVE 'A5FF232498B9D30FDC35C579C74AF5D6'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(7).
            MOVE '38873DB216DA0A02EA858920310DB026Â'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(8).
            MOVE 'BF34EE76D45EF7C197E26F9AB12DC8E1'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(9).
            MOVE '408E4C5BA415E4AFF2F9B7DB12E5EB69'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(10).
            MOVE 'A34395A25C4658BDCF3762C0107ABB14'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(11).
            MOVE '9E440B49CC570503CEE80EFE599F3C63'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(12).
            MOVE '81C4426D5DA7B801F01CAA7827938355'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(13).
            MOVE 'F3DEFA8B658DB313B47518CD80C95321'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(14).
            MOVE 'D7E9C3D1B69D458AE6DFBE5AEC9C990C'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(15).
            MOVE 'FBCB4E259284066B736E1BF45FEF617D'
              TO SBR-T.
            MOVE SBR-T                      TO SB-BX(16).

      *     WRITE A LINE
            WRITE TAB.
 
            IF FS-TAB-OK
              CONTINUE
            ELSE
              DISPLAY 'ERROR ON WRITTING: ' FS-TAB
              STOP RUN
            END-IF.

            CLOSE R-TAB.

            IF FS-TAB-OK
              CONTINUE
            ELSE
              DISPLAY 'ERORR ON CLOSING: ' FS-TAB
              STOP RUN
            END-IF.

            STOP RUN.


      ***************************************************************
      * GALOIS FIELD ARITHMETIC                                     *
      ***************************************************************
       ADDITION.
            MOVE BYTE-NA OF SUMM            TO BYTE-NR OF SUMM.
            ADD  BYTE-NB OF SUMM            TO BYTE-NR OF SUMM.

            MOVE BYTE-R OF SUMM             TO BYTE-A OF NOR.

            PERFORM NORMALIZE.

            MOVE BYTE-R OF NOR              TO BYTE-R OF SUMM.


       MULTIPLICATION.
            MOVE ALL '0'                    TO BYTE-X
                                               BYTE-Y.

            PERFORM VARYING WS-MX FROM 1 BY 1
              UNTIL WS-MX > 8
              IF BIT-B OF MUL(WS-MX) = 1
                MOVE BYTE-NT(WS-MX + 1:8)   TO BYTE-NX
                ADD  BYTE-NA OF MUL         TO BYTE-NX
                MOVE BYTE-NX                TO BYTE-NT(WS-MX + 1:8)
              END-IF
            END-PERFORM.

            MOVE BYTE-T(1:8)                TO BYTE-A OF NOR.
            PERFORM NORMALIZE.
            MOVE BYTE-R OF NOR              TO BYTE-T(1:8).

            MOVE BYTE-T(9:8)                TO BYTE-A OF NOR.
            PERFORM NORMALIZE.
            MOVE BYTE-R OF NOR              TO BYTE-T(9:8).

            PERFORM VARYING WS-MX FROM 1 BY 1
              UNTIL WS-MX > 8
              IF BIT-T(WS-MX) = 1 OR 3 OR 5 OR 7 OR 9
                MOVE BYTE-NT(WS-MX:9)       TO BYTE-NY
                ADD 100011011               TO BYTE-NY
                MOVE BYTE-NY                TO BYTE-NT(WS-MX:9)
              END-IF
            END-PERFORM.

            MOVE BYTE-T(9:8)                TO BYTE-A OF NOR.
            PERFORM NORMALIZE.
            MOVE BYTE-R OF NOR              TO BYTE-R OF MUL.


       PMULTIPLICATION.
            MOVE BYTE-A OF PMUL             TO BIT-AUX-FULL.
            MOVE '00000000'                 TO BYTE-R OF PMUL.

            PERFORM VARYING WS-PX FROM 7 BY -1
              UNTIL WS-PX < 1
              PERFORM XTIME

              IF BIT-B OF PMUL(WS-PX) = 1
                MOVE BIT-AUX-FULL           TO BYTE-A OF SUMM
                MOVE BYTE-R OF PMUL         TO BYTE-B OF SUMM

                PERFORM ADDITION

                MOVE BYTE-R OF SUMM         TO BYTE-R OF PMUL
              END-IF
            END-PERFORM.

            IF BIT-B OF PMUL(8) = 1
              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM
              MOVE BYTE-A OF PMUL           TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF PMUL
            END-IF.


       WMULTIPLICATION.
            MOVE ALL '0'                    TO WORD-R OF WMUL.

            PERFORM VARYING WS-WY FROM 1 BY 1
              UNTIL WS-WY > 4
              PERFORM VARYING WS-WX FROM 1 BY 1
                UNTIL WS-WX > 4

                MOVE BYTE-A OF WMUL(OFFSET-BYTE-A(WS-WY, WS-WX))
                  TO BYTE-A OF PMUL
                MOVE BYTE-B OF WMUL(WS-WX)
                  TO BYTE-B OF PMUL

                PERFORM PMULTIPLICATION

                MOVE BYTE-R OF WMUL(WS-WY)  TO BYTE-A OF SUMM
                MOVE BYTE-R OF PMUL         TO BYTE-B OF SUMM

                PERFORM ADDITION

                MOVE BYTE-R OF SUMM         TO BYTE-R OF WMUL(WS-WY)
              END-PERFORM
            END-PERFORM.


       XTIME.
            PERFORM SHIFT.
  
            IF BIT-ACC = 1
              MOVE BIT-AUX-FULL             TO BYTE-A OF SUMM
              MOVE '00011011'               TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BIT-AUX-FULL
            END-IF.


       SHIFT.
            MOVE BIT-AUX-FULL               TO BYTE-AUX.
            MOVE 0                          TO BIT-AUX(8).


       NORMALIZE.
            PERFORM VARYING WS-NI FROM 1 BY 1
              UNTIL WS-NI > 8
              MOVE BIT-A OF NOR(WS-NI)      TO NORM-A

              PERFORM NORM

              MOVE NORM-R                   TO BIT-R OF NOR(WS-NI)
            END-PERFORM.


      ***************************************************************
      * TRANSFORMATIONS                                             *
      ***************************************************************
       B2W.
      *     Converts BIN input to INDEX (remembering that COBOL starts
      *     by 1 instead than 0.
      *
            COMPUTE B2W-I = (B2W-D(4))     +
                            (B2W-D(3) * 2) +
                            (B2W-D(2) * 4) +
                            (B2W-D(1) * 8) +
                            1.

            MOVE B2W-T(B2W-I)               TO B2W-R.


        W2B.
            MOVE W2B-A                      TO W2D-A.
            PERFORM W2D.
            MOVE W2D-R                      TO W2B-I.
            ADD 1                           TO W2B-I.

            MOVE W2B-T(W2B-I)               TO W2B-R.


        W2D.
            IF W2D-A IS NUMERIC
              MOVE W2D-A                    TO W2D-R
            ELSE
              EVALUATE W2D-A
                WHEN 'A'
                  MOVE 10                   TO W2D-R
                WHEN 'B'
                  MOVE 11                   TO W2D-R
                WHEN 'C'
                  MOVE 12                   TO W2D-R
                WHEN 'D' 
                  MOVE 13                   TO W2D-R
                WHEN 'E'
                  MOVE 14                   TO W2D-R
                WHEN 'F'
                  MOVE 15                   TO W2D-R
              END-EVALUATE
            END-IF.


       D2B.
            SUBTRACT 1                    FROM D2B-A.
            DIVIDE 16                     INTO D2B-A
                                        GIVING D2B-W1
                                     REMAINDER D2B-W2.

            MOVE W2B-T(D2B-W1 + 1)          TO D2B-R(1).
            MOVE W2B-T(D2B-W2 + 1)          TO D2B-R(2).
 
 
       NORM.
            MOVE NORM-T(NORM-D + 1)         TO NORM-R.


       B2W-FILL.
            MOVE '0123456789ABCDEF'         TO B2W-TABLE.


       NORM-FILL.
            MOVE '0101010101'               TO NORM-TABLE.


       W2B-FILL.
           MOVE '0000'                      TO W2B-T(01).
           MOVE '0001'                      TO W2B-T(02).
           MOVE '0010'                      TO W2B-T(03).
           MOVE '0011'                      TO W2B-T(04).
           MOVE '0100'                      TO W2B-T(05).
           MOVE '0101'                      TO W2B-T(06).
           MOVE '0110'                      TO W2B-T(07).
           MOVE '0111'                      TO W2B-T(08).
           MOVE '1000'                      TO W2B-T(09).
           MOVE '1001'                      TO W2B-T(10).
           MOVE '1010'                      TO W2B-T(11).
           MOVE '1011'                      TO W2B-T(12).
           MOVE '1100'                      TO W2B-T(13).
           MOVE '1101'                      TO W2B-T(14).
           MOVE '1110'                      TO W2B-T(15).
           MOVE '1111'                      TO W2B-T(16).
