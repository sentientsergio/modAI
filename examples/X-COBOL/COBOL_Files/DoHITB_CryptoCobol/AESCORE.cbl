      *****************************************************************
      *                                                               *
      * This software have been developed under GNU GPL v3 License.   *
      *   That means, no closed distribution of this software is      *
      *   allowed.                                                    *
      *                                                               *
      * Please refer to the License text here:                        *
      *   https://www.gnu.org/licenses/gpl-3.0.txt                    *
      *                                                               *
      * Advanced Encription Standard (AES) COBOL Implementation.      *
      *                                                               *
      * This code was written by David O. Solé González (aka DoHITB). *
      *                                                               *
      * The implementation was made following FIPS-197 official text. *
      * You can find the mentioned rfc on the Internet for free, on   *
      * https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197.pdf      *
      *                                                               *
      * For any comment, suggestion or similar, you can reach me via  *
      * mail on "doscar.sole@gmail.com"                               *
      *                                                               *
      * Galois Field arithmetic was bypassed by static tables for     *
      * best performance.                                             *
      *                                                               *
      * How it works: https://github.com/DoHITB/CryptoCobol           *
      *****************************************************************
       ID DIVISION.
       PROGRAM-ID. AESCORE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
         01 SUMM.
            05 XB-X                     PIC 9(2).
            05 XB-Y                     PIC 9(2).
            05 BYTE-A.
               10 BYTES-A OCCURS 2.
                  15 WORD-A             PIC X(1).
            05 BYTE-B.
               10 BYTES-B OCCURS 2.
                  15 WORD-B             PIC X(1).
            05 BYTE-R.
               10 BYTES-R OCCURS 2.
                  15 WORD-R             PIC X(1).

         01 PMUL.
            05 MB-X                     PIC 9(2).
            05 MB-Y                     PIC 9(3).
            05 WS-PX                    PIC 9(1).
            05 BYTE-A                   PIC X(2).
            05 BYTE-B                   PIC X(2).
            05 BYTE-R                   PIC X(2).
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
                  15 BYTE-A             PIC X(2).
            05 WORD-B.
               10 WORDS-B OCCURS 4.
                  15 BYTE-B             PIC X(2).
            05 WORD-R.
               10 WORDS-R OCCURS 4.
                  15 BYTE-R             PIC X(2).

         01 WORDS-T.
            05 WS-CCR                   PIC 9(3).
            05 WS-SX                    PIC 9(1).
            05 BYTE-A.
               10 WORD-A OCCURS 4.
                  15 WORDS-A.
                     20 WORD OCCURS 2   PIC X(1).
            05 WORDS-R OCCURS 4.
               10 WORD-RES.
                  15 WORD-R             PIC X(2).

         01 SUBBYTES-DATA.
            05 WS-BX                    PIC 9(1).
            05 WS-BY                    PIC 9(1).
            05 SBOX-BX                  PIC 9(2).
            05 SBOX-BY                  PIC 9(2).
            05 SBOX-R                   PIC X(2).
            05 HEX-WORD.
               10 SBOX-BA               PIC X(1).
               10 SBOX-BB               PIC X(1).

         01 SHIFTROWS-DATA.
            05 TEMP1                    PIC X(2).
            05 TEMP2                    PIC X(2).
            05 WSD-IDX.
               10 WSD-I OCCURS 3        PIC 9(1).

         01 MCOL-DATA.
            05 WS-XY                    PIC 9(1).

         01 ARK-DATA.
            05 WS-AX                    PIC 9(2).

         01 R-CON.
            05 R-W.
               10 R-WORDS OCCURS 10.
                  15 R-WORD             PIC X(2).
            05 W-TEMP                   PIC X(2).
            05 W-TABLE.
               10 W OCCURS 4            PIC X(2).

         01 W2D-DATA.
            05 W2D-A                    PIC X(1).
            05 W2D-D                    PIC 9(2).
            05 W2D-R                    PIC 9(2).

         01 STATE-DATA.
            05 FILLER OCCURS 4.
               10 FILLER OCCURS 4.
                  15 STATE              PIC X(2).

         01 PARAMS.
            05 NK                       PIC 9(1).
            05 NB                       PIC 9(1).
            05 NR                       PIC 9(2).
            05 NK1                      PIC 9(1).

         01 KED.
            05 KED-I                    PIC 9(3).
            05 KED-J                    PIC 9(3).
            05 KED-T.
               10 KED-TI OCCURS 4       PIC X(2).
            05 KED-D                    PIC 9(2).
            05 KED-M                    PIC 9(1).
            05 KED-W-T.
               10 KED-WORDS OCCURS 60.
                  15 KED-WORD.
                     20 KED-W OCCURS 4  PIC X(2).

         01 CIP.
            05 WS-CR                    PIC 9(2).


       LINKAGE SECTION.
         COPY 'AESLCOR.cpy'.

       PROCEDURE DIVISION USING IOCOMM IOTAB IOPUTM.
       MAINLINE.       
            PERFORM R-FILL.

            EVALUATE IO-BITS OF IOCOMM
              WHEN '128'
                MOVE 4410                   TO PARAMS
              WHEN '192'
                MOVE 6412                   TO PARAMS
              WHEN '256'
                MOVE 8414                   TO PARAMS
            END-EVALUATE.

      *     Temp variables
            MOVE NK                         TO NK1.
            ADD  1                          TO NK1.

      *     We cannot store the result of the KEY-EXPANSION on LS
      *     because on some work modes the KEY will change on each
      *     call of the main module (for example: CTR)
      *
            IF IO-ACTION OF IOCOMM = 'K' OR 'C'
              PERFORM KEY-EXPANSION
              MOVE KED-W-T                  TO IO-KSCH

              IF IO-ACTION OF IOCOMM = 'K'
      *         'K' Action is only used before decrypt to get KEY-SCHEDULE
                GOBACK
              END-IF
            ELSE
      *       On decypher we have the KEY-SCHEDULE on IO-KSCH
              MOVE IO-KSCH                  TO KED-W-T
            END-IF.

            IF IO-ACTION OF IOCOMM = 'C'
      *       cipher
      *
              PERFORM CIPHER
            ELSE
      *       decipher
      *
              PERFORM DECIPHER
            END-IF.

            GOBACK.


      ***************************************************************
      * MAIN FUNCTIONS                                              *
      ***************************************************************
       KEY-EXPANSION.
      *     w[i] = word(key[4*i], key[4*i+1], key[4*i+2], key[4*i+3])
      *
            PERFORM VARYING KED-I FROM 1 BY 1
              UNTIL KED-I >= NK + 1
              COMPUTE KED-J = (8 * (KED-I - 1) + 1)

              MOVE IO-KEY OF IOCOMM(KED-J:8)
                TO KED-WORD(KED-I)
            END-PERFORM.

            PERFORM VARYING KED-I FROM NK1 BY 1
              UNTIL KED-I > (NB * (NR + 1))
              MOVE KED-WORD(KED-I - 1)      TO KED-T

              DIVIDE NK                   INTO KED-I
                                        GIVING KED-D
                                     REMAINDER KED-M

              SUBTRACT 1                  FROM KED-M

              IF KED-M = 0
      *         temp = SubWord(RotWord(temp)) xor Rcon[i/Nk]
      *
                MOVE KED-T                  TO W-TABLE

                PERFORM ROTWORD

                MOVE W-TABLE                TO BYTE-A OF WORDS-T 

                PERFORM SUBWORD

                MOVE WORD-RES(1)            TO BYTE-A OF SUMM
                MOVE R-WORD(KED-D)          TO BYTE-B OF SUMM

                PERFORM ADDITION

                MOVE BYTE-R OF SUMM         TO KED-TI(1)
                MOVE WORD-RES(2)            TO KED-TI(2)
                MOVE WORD-RES(3)            TO KED-TI(3)
                MOVE WORD-RES(4)            TO KED-TI(4)

      *         There is no need to make the rest of the additions as
      *         they will be {xy} XOR {00} = {xy}
              ELSE
                IF (NK > 6) AND (KED-M = 4)
      *           temp = SubWord(temp)
      *
                  MOVE KED-T                TO BYTE-A OF WORDS-T

                  PERFORM SUBWORD

                  MOVE WORD-RES(1)          TO KED-TI(1)
                  MOVE WORD-RES(2)          TO KED-TI(2)
                  MOVE WORD-RES(3)          TO KED-TI(3)
                  MOVE WORD-RES(4)          TO KED-TI(4)
                END-IF
              END-IF

      *       w[i] = w[i-Nk] xor temp
      *

      *       1st 2-hex values
      *
              MOVE KED-W(KED-I - NK, 1)     TO BYTE-A OF SUMM
              MOVE KED-TI(1)                TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO KED-W(KED-I, 1)


      *       2nd group
      *
              MOVE KED-W(KED-I - NK, 2)     TO BYTE-A OF SUMM
              MOVE KED-TI(2)                TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO KED-W(KED-I, 2)


      *       3rd group
      *
              MOVE KED-W(KED-I - NK, 3)     TO BYTE-A OF SUMM
              MOVE KED-TI(3)                TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO KED-W(KED-I, 3)


      *       4th group
      *
              MOVE KED-W(KED-I - NK, 4)     TO BYTE-A OF SUMM
              MOVE KED-TI(4)                TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO KED-W(KED-I, 4)
            END-PERFORM.


       CIPHER.
      *     Initialize values
      *
            MOVE 1                          TO WS-CR
                                               WS-CCR.

      *     Input-to-State
      *
            MOVE IO-TEXT OF IOCOMM          TO STATE-DATA.

      *     AddRoundKey(state, w[0, Nb-1])
      *
            PERFORM ADDROUNDKEY.

            PERFORM VARYING WS-CR FROM 2 BY 1
              UNTIL WS-CR > NR

      *       SubBytes(state)
      *
              PERFORM SUBBYTES

      *       ShiftRows(state)
      *
              PERFORM SHIFTROWS

      *       MixColumns(state)
      *
              PERFORM MIXCOLUMNS

      *       AddRoundKey(state, w[round*Nb, (round+1)*Nb-1])
      *
              PERFORM ADDROUNDKEY
            END-PERFORM.

      *     SubBytes(state)
      *
            PERFORM SUBBYTES.

      *     ShiftRows(state)
      *
            PERFORM SHIFTROWS.

      *     AddRoundKey(state, w[Nr*Nb, (Nr+1)*Nb-1])
      *
            PERFORM ADDROUNDKEY.

      *     State-to-Output
      *
            MOVE STATE-DATA                 TO IO-TEXT OF IOCOMM.


       DECIPHER.
      *     Initialize values
            MOVE NR                         TO WS-CR
            ADD 1                           TO WS-CR 

      *     Input-to-State
      *
            MOVE IO-TEXT OF IOCOMM          TO STATE-DATA.

      *     AddRoundKey(state, w[0, Nb-1])
      *
            PERFORM ADDROUNDKEY.

            SUBTRACT 1                    FROM WS-CR.

            PERFORM VARYING WS-CR FROM WS-CR BY -1
              UNTIL WS-CR < 2
      *       InvShiftRows(state)
      *
              PERFORM SHIFTROWS

      *       InvSubBytes(state)
      *
              PERFORM SUBBYTES

      *       AddRoundKey(state, w[round*Nb, (round+1)*Nb-1])
      *
              PERFORM ADDROUNDKEY

      *       InvMixColumns(state)
      *
              PERFORM MIXCOLUMNS
            END-PERFORM.

      *     InvShiftRows(state)
      *
            PERFORM SHIFTROWS.

      *     InvSubBytes(state)
      *
            PERFORM SUBBYTES.

      *     AddRoundKey(state, w[Nr*Nb, (Nr+1)*Nb-1])
      *
            PERFORM ADDROUNDKEY.

      *     State-to-Output
      *
            MOVE STATE-DATA                 TO IO-TEXT OF IOCOMM.


      ***************************************************************
      * GALOIS FIELD ARITHMETIC FUNCTIONS                           *
      ***************************************************************
       ADDITION.
            MOVE WORD-A OF SUMM(1)          TO W2D-A.
            PERFORM W2D.
            MOVE W2D-R                      TO XB-X.

            MOVE WORD-B OF SUMM(1)          TO W2D-A. 
            PERFORM W2D.
            MOVE W2D-R                      TO XB-Y.

            ADD 1                           TO XB-X
                                               XB-Y.

            MOVE XB-R(XB-X, XB-Y)           TO WORD-R OF SUMM(1).

            MOVE WORD-A OF SUMM(2)          TO W2D-A.
            PERFORM W2D.
            MOVE W2D-R                      TO XB-X.

            MOVE WORD-B OF SUMM(2)          TO W2D-A.
            PERFORM W2D.
            MOVE W2D-R                      TO XB-Y.

            ADD 1                           TO XB-X
                                               XB-Y.

            MOVE XB-R(XB-X, XB-Y)           TO WORD-R OF SUMM(2).


       PMULTIPLICATION.
            EVALUATE BYTE-A OF PMUL
      *       M-BOX HAVE VALUES FOR '00', '01', '02', '03' (CIPHER)
      *                             '09', '0B', '0D', '0E' (DECIPHER)
      *                  MB-A INDEX:  1     2    3     4
      *
              WHEN '00'
              WHEN '09'
                MOVE 1                      TO MB-X
              WHEN '01'
              WHEN '0B'
                MOVE 2                      TO MB-X
              WHEN '02'
              WHEN '0D'
                MOVE 3                      TO MB-X
              WHEN '03'
              WHEN '0E'
                MOVE 4                      TO MB-X
            END-EVALUATE.

      *     Store first byte on MB-Y as a temp variable
            MOVE BYTE-B OF PMUL(1:1)        TO W2D-A.
            PERFORM W2D.
            MOVE W2D-R                      TO MB-Y.

      *     Get the second part of the HEX key
            MOVE BYTE-B OF PMUL(2:1)        TO W2D-A.
            PERFORM W2D.

      *     Calculate the full HEX key
            COMPUTE MB-Y = (MB-Y * 16) + W2D-R + 1.

            MOVE MB-R(MB-X, MB-Y)           TO BYTE-R OF PMUL.


       WMULTIPLICATION.
            IF IO-ACTION = 'C'
      *
      *       S0,C = ({02} * S0,C) + ({03} * S1,C) + S2,C + S3,C
      *

      *       A = {02} * S0,C
              MOVE '02'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 1)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM

      *       B = {03} * S1,C
              MOVE '03'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       C = A XOR B
              PERFORM ADDITION

      *       D = C XOR S2,C
              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF SUMM

              PERFORM ADDITION

      *       E = D XOR S3,C
              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF SUMM

              PERFORM ADDITION

      *       S0,C = E
              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(1)

      *
      *       S1,C = S0,C + ({02} * S1,C) + ({03} * S2,C) + S3,C
      *

      *       A = S0,C
              MOVE STATE(WS-XY, 1)          TO BYTE-A OF SUMM

      *       B = {02} * S1,C
              MOVE '02'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

      *       C = A XOR B
              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {03} * S2,C
              MOVE '03'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       F = E XOR S3,C
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(2)

      *
      *       S2,C = S0,C + S1,C + ({02} * S2,C) + ({03} * S3,C)
      *

      *       A = S0,C XOR S1,C
              MOVE STATE(WS-XY, 1)          TO BYTE-A OF SUMM
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF SUMM

              PERFORM ADDITION   

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       B = {02} * S2,C
              MOVE '02'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       C = A XOR B
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {03} * S3,C
              MOVE '03'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION 

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(3)

      *
      *       S3,C = ({03} * S0,C) + S1,C + S2,C + ({02} * S3,C)
      *

      *       A = {03} * S0,C
              MOVE '03'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 1)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM

      *       B = A XOR S1,C
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       C = B XOR X2,C
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {02} * S3,C
              MOVE '02'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(4)
            ELSE
      *       S0,C = ({0E} * S0,C) + ({0B} * S1,C) + 
      *              ({0D} * S2,C) + ({09} * S3,C)
      *

      *       A = {0E} * S0,C
              MOVE '0E'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 1)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM

      *       B = {0B} * S1,C
              MOVE '0B'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       C = A XOR B
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {0D} * S2,C
              MOVE '0D'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       F = {09} * S3,C
              MOVE '09'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       G = E XOR F
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(1)


      *       S1,C = ({09} * S0,C) + ({0E} * S1,C) + 
      *              ({0B} * S2,C) + ({0D} * S3,C)
      *

      *       A = {09} * S0,C
              MOVE '09'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 1)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM

      *       B = {0E} * S1,C
              MOVE '0E'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       C = A XOR B
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {0B} * S2,C
              MOVE '0B'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       F = {0D} * S3,C
              MOVE '0D'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       G = E XOR F
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(2)


      *       S2,C = ({0D} * S0,C) + ({09} * S1,C) + 
      *              ({0E} * S2,C) + ({0B} * S3,C)
      *

      *       A = {0D} * S0,C
              MOVE '0D'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 1)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM

      *       B = {09} * S1,C
              MOVE '09'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       C = A XOR B
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {0E} * S2,C
              MOVE '0E'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       F = {0B} * S3,C
              MOVE '0B'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       G = E XOR F
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(3)


      *       S3,C = ({0B} * S0,C) + ({0D} * S1,C) + 
      *              ({09} * S2,C) + ({0E} * S3,C)
      *

      *       A = {0B} * S0,C
              MOVE '0B'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 1)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-A OF SUMM

      *       B = {0D} * S1,C
              MOVE '0D'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 2)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       C = A XOR B
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       D = {09} * S2,C
              MOVE '09'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 3)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       E = C XOR D
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-A OF SUMM

      *       F = {0E} * S3,C
              MOVE '0E'                     TO BYTE-A OF PMUL
              MOVE STATE(WS-XY, 4)          TO BYTE-B OF PMUL

              PERFORM PMULTIPLICATION

              MOVE BYTE-R OF PMUL           TO BYTE-B OF SUMM

      *       G = E XOR F
              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO BYTE-R OF WMUL(4)
            END-IF.

            MOVE BYTE-R OF WMUL(1)        TO STATE(WS-XY, 1).
            MOVE BYTE-R OF WMUL(2)        TO STATE(WS-XY, 2).
            MOVE BYTE-R OF WMUL(3)        TO STATE(WS-XY, 3).
            MOVE BYTE-R OF WMUL(4)        TO STATE(WS-XY, 4).


      ***************************************************************
      * KEY EXPANSION FUNCTIONS                                     *
      ***************************************************************
       SUBWORD.
            PERFORM VARYING WS-SX FROM 1 BY 1
              UNTIL WS-SX > 4 
              MOVE WORDS-A OF WORDS-T(WS-SX) 
                TO HEX-WORD

              PERFORM SBOX-TRANSLATE

              MOVE SBOX-R                   TO WORD-RES(WS-SX)
            END-PERFORM.


       ROTWORD.
            MOVE W(1)                       TO W-TEMP.
            MOVE W(2)                       TO W(1).
            MOVE W(3)                       TO W(2).
            MOVE W(4)                       TO W(3).
            MOVE W-TEMP                     TO W(4).


      ***************************************************************
      * CIPHER FUNCTIONS                                            *
      ***************************************************************
       SUBBYTES.
            PERFORM VARYING WS-BX FROM 1 BY 1
              UNTIL WS-BX > 4
              PERFORM VARYING WS-BY FROM 1 BY 1
                UNTIL WS-BY > 4
                MOVE STATE(WS-BX, WS-BY)    TO HEX-WORD

                PERFORM SBOX-TRANSLATE

                MOVE SBOX-R                 TO STATE(WS-BX, WS-BY)
              END-PERFORM
            END-PERFORM.


       SHIFTROWS.
            IF IO-ACTION OF IOCOMM = 'C'
      *       We move state columns 2, 3, 4
              MOVE 234                      TO WSD-IDX
            ELSE
      *       We move state columns 4, 3, 2
              MOVE 432                      TO WSD-IDX
            END-IF.
            
            MOVE STATE(1, WSD-I(1))         TO TEMP1.
            MOVE STATE(2, WSD-I(1))         TO STATE(1, WSD-I(1)).
            MOVE STATE(3, WSD-I(1))         TO STATE(2, WSD-I(1)).
            MOVE STATE(4, WSD-I(1))         TO STATE(3, WSD-I(1)).
            MOVE TEMP1                      TO STATE(4, WSD-I(1)).

            MOVE STATE(1, WSD-I(2))         TO TEMP1.
            MOVE STATE(2, WSD-I(2))         TO TEMP2.
            MOVE STATE(3, WSD-I(2))         TO STATE(1, WSD-I(2)).
            MOVE STATE(4, WSD-I(2))         TO STATE(2, WSD-I(2)).
            MOVE TEMP1                      TO STATE(3, WSD-I(2)).
            MOVE TEMP2                      TO STATE(4, WSD-I(2)).

            MOVE STATE(4, WSD-I(3))         TO TEMP1.
            MOVE STATE(3, WSD-I(3))         TO STATE(4, WSD-I(3)).
            MOVE STATE(2, WSD-I(3))         TO STATE(3, WSD-I(3)).
            MOVE STATE(1, WSD-I(3))         TO STATE(2, WSD-I(3)).
            MOVE TEMP1                      TO STATE(1, WSD-I(3)).


       MIXCOLUMNS.
            PERFORM VARYING WS-XY FROM 1 BY 1
              UNTIL WS-XY > 4
              PERFORM WMULTIPLICATION
            END-PERFORM.


       ADDROUNDKEY.
      *     Calculate CCR position
            COMPUTE WS-CCR = WS-CR * NB - 3.

            PERFORM VARYING WS-AX FROM 1 BY 1
              UNTIL WS-AX > 4
      *       XOR-ing each pair of HEX values from state
      *       going column-by-column
      *

      *       1st pair
              MOVE STATE(WS-AX, 1)          TO BYTE-A OF SUMM
              MOVE KED-W(WS-CCR, 1)         TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO STATE(WS-AX, 1)


      *       2nd pair
              MOVE STATE(WS-AX, 2)          TO BYTE-A OF SUMM
              MOVE KED-W(WS-CCR, 2)         TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO STATE(WS-AX, 2)


      *       3rd pair
              MOVE STATE(WS-AX, 3)          TO BYTE-A OF SUMM
              MOVE KED-W(WS-CCR, 3)         TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO STATE(WS-AX, 3)


      *       4th pair
              MOVE STATE(WS-AX, 4)          TO BYTE-A OF SUMM
              MOVE KED-W(WS-CCR, 4)         TO BYTE-B OF SUMM

              PERFORM ADDITION

              MOVE BYTE-R OF SUMM           TO STATE(WS-AX, 4)

              ADD 1                         TO WS-CCR
            END-PERFORM.


       SBOX-TRANSLATE.
            MOVE SBOX-BA                    TO W2D-A.
            PERFORM W2D.
            MOVE W2D-R                      TO SBOX-BX.

            MOVE SBOX-BB                    TO W2D-A.
            PERFORM W2D.  
            MOVE W2D-R                      TO SBOX-BY.

            ADD 1                           TO SBOX-BX.
            ADD 1                           TO SBOX-BY.

            MOVE SB-R(SBOX-BY, SBOX-BX)     TO SBOX-R.


      ***************************************************************
      * TRANSFORMATIONS                                             *
      ***************************************************************
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


       R-FILL.
           MOVE '01020408102040801B36'      TO R-W.
