      *****************************************************************
      *                                                               *
      * This software have been developed under GNU GPL v3 License.   *
      *   That means, no closed distribution of this software is      *
      *   allowed.                                                    *
      *                                                               *
      * Please refer to the License text here:                        *
      *   https://www.gnu.org/licenses/gpl-3.0.txt                    *
      *                                                               *
      * Secure Hash Algorithm - 1 (SHA1) COBOL Implementation.        *
      *                                                               *
      * This code was written by David O. Solé González (aka DoHITB). *
      *                                                               *
      * The implementation was made following rfc3174 official text.  *
      * You can find the mentioned rfc on the Internet for free, on   *
      * http://www.ietf.org/rfc/rfc3174.txt                           *
      *                                                               *
      * For any comment, suggestion or similar, you can reach me via  *
      * mail on "doscar.sole@gmail.com"                               *
      *                                                               *
      * General lines and commentaries:                               *
      *     - This programs only works on ASCII data passed as X(n).  *
      *                                                               *
      *     - Once the input arrived, its transofmed into bytes.      *
      *                                                               *
      *     - Then, the data is padded to 16 32-bit word, following   *
      *       the rfc algorithm:                                      *
      *           * Add 1 on position n + 1 where n is the length of  *
      *             the original string.                              *
      *                                                               *
      *           * Fill with 0's until #14 word.                     *
      *                                                               *
      *           * Words #15 and #16 are for putting the HEX value   *
      *             of the original length. In our case, as the       *
      *             original input is limited to 256, #15 word will   *
      *             be always 0's, and also the first half of #16.    *
      *                                                               *
      *     - After padding, the data is being amplied to 80 32-bytes *
      *       words. Each word from #17 to #80 is filled according to *
      *       the rfc:                                                *
      *           * W(t) = S^1(W(t-3) XOR W(t-8)                      * 
      *                    XOR W(t-14) XOR W(t-16))                   *
      *                                                               *
      *     - Finally, the output is calculated, according to rfc:    *
      *           * TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);     *
      *             E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;    *
      *                                                               *
      *     - After all this process, we rearrange the H's data:      *
      *           * H0 = H0 + A                                       *
      *           * H1 = H1 + B                                       *
      *           * H2 = H2 + C                                       *
      *           * H3 = H3 + D                                       *
      *           * H4 = H4 + E                                       *
      *                                                               *
      *     - The concatenation of all H's is the message digest.     *
      *                                                               *
      *****************************************************************
       ID DIVISION.
       PROGRAM-ID. SHA1HEX.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *Max length of block
       77 CNS-BLOCK-L             PIC 9(03)  VALUE 512.

      *Max length of the padding (512 - 16 - 1)
       77 CNS-BLOCK-T             PIC 9(03)  VALUE 496.
      
      *Max length of processing blocks
       77 CNS-PROCESSING-MAX      PIC 9(02)  VALUE 80.

      *Max length of HEX2BIN table
       77 CNS-HEX2BIN-MAX         PIC 9(02)  VALUE 16.
      
      *Max length of DEC2HEX table
       77 CNS-DEC2HEX-MAX         PIC 9(03)  VALUE 256.
      
      *Max length of XOR input
       77 CNS-XOR-MAX             PIC 9(02)  VALUE 32.
      
      *Max length of NOT input
       77 CNS-NOT-MAX             PIC 9(02)  VALUE 32.
      
      *Max length of AND input
       77 CNS-AND-MAX             PIC 9(02)  VALUE 32.
      
      *Max length of OR input
       77 CNS-OR-MAX              PIC 9(02)  VALUE 32.
      
      *Max length of SUM input
       77 CNS-SUM-MAX             PIC 9(02)  VALUE 32.
      
      *Max length of SL input
       77 CNS-SL-MAX              PIC 9(02)  VALUE 32.
      
      *Max length of H's HEX chars
       77 CNS-HS-MAX              PIC 9(01)  VALUE 8.
      
      *Original length of padding
       77 CNS-PADDING-ORI-LENGTH  PIC 9(03)  VALUE ZEROES.
      
      *K's (Already in binary)
       77 CNS-K0                  PIC X(32)
                 VALUE '01011010100000100111100110011001'.
       77 CNS-K1                  PIC X(32)
                 VALUE '01101110110110011110101110100001'.
       77 CNS-K2                  PIC X(32)
                 VALUE '10001111000110111011110011011100'.
       77 CNS-K3                  PIC X(32)
                 VALUE '11001010011000101100000111010110'.

      *   Hex calculation
       77 CNS-B1                  PIC 9(01)  VALUE 1.
       77 CNS-B2                  PIC 9(02)  VALUE 2.
       77 CNS-B3                  PIC 9(02)  VALUE 4.
       77 CNS-B4                  PIC 9(02)  VALUE 8.
      
       01 WS-VAR.
      *   Input text length
          05 WS-TEXT-INDEX        PIC 9(03)  VALUE ZEROES.
          05 WS-TEXT-LENGTH       PIC 9(03)  VALUE ZEROES.
          05 WS-TEXT-ASCII-LEN    PIC 9(03)  VALUE ZEROES.

      *   Input text
          05 WS-RAW-TEXT          PIC X(256) VALUE SPACES.
          05 WS-RAW-CHAR          REDEFINES WS-RAW-TEXT
                                  OCCURS 256 PIC X(01).
          05 CHAR-BLOCK.
              10 FILLER           PIC X(01).
              10 CHAR             PIC X(01).
          05 HEX-CHAR             REDEFINES CHAR-BLOCK  
                                  PIC 9(04)  BINARY.
          05 NUM-CHAR             PIC 9(03).
      
      *   Calculation vars
          05 WS-HEX-VAL-1         PIC 9(02).
          05 WS-HEX-VAL-2         PIC 9(02).
          05 WS-BIN-BYTE-FULL.
              10 WS-BIN-BYTE      OCCURS 4   PIC 9(01).
          05 WS-WORD-BYTE-FULL-1.
              10 WS-WORD-BYTE-1   OCCURS 8   PIC X(04).
          05 WS-WORD-BYTE-FULL-2.
              10 WS-WORD-BYTE-2   OCCURS 8   PIC X(04).
          05 WS-HEX-TABLE-KEY     OCCURS 2   PIC X(02).
      
      *   Text
          05 WS-TEXT              PIC X(512) VALUE SPACES.
          05 WS-TEXT-HEX          REDEFINES WS-TEXT
                                  OCCURS 512 PIC X(01).
          05 WS-TEXT-PAIR         REDEFINES WS-TEXT
                                  OCCURS 256 PIC X(02).
   
      *   Padding data
          05 WS-PADDING-LENGTH    PIC 9(03)  VALUE ZEROES.
          05 WS-PADDING-INDEX     PIC 9(03)  VALUE ZEROES.
          05 WS-PADDING-TEXT      PIC X(512) VALUE SPACES.
          05 WS-PADDING-BIT       REDEFINES WS-PADDING-TEXT 
                                  OCCURS 512 PIC X(01).
          05 WS-PADDING-HEX       REDEFINES WS-PADDING-TEXT 
                                  OCCURS 128 PIC X(04).
          05 WS-PADDING-FULL      REDEFINES WS-PADDING-TEXT
                                  OCCURS 64  PIC X(08).
          05 WS-PADDING-WORD      REDEFINES WS-PADDING-TEXT
                                  OCCURS 16  PIC X(32).
      
      *   Processing data
          05 WS-PROCESSING-INDEX  PIC 9(04) VALUE ZEROES.
          05 WS-PROCESSING        PIC X(2560).
          05 WS-PROCESSING-WORD   REDEFINES WS-PROCESSING
                                  OCCURS 80 PIC X(32).
            
      *   Temporary values to make the process
          05 WS-A                 PIC X(32) VALUE SPACES.
          05 WS-B                 PIC X(32) VALUE SPACES.
          05 WS-C                 PIC X(32) VALUE SPACES.
          05 WS-D                 PIC X(32) VALUE SPACES.
          05 WS-E                 PIC X(32) VALUE SPACES.
          05 WS-T                 PIC X(32) VALUE SPACES.
      
      *   Temporal indexes for logical operations
          05 WS-XOR-INDEX-1       PIC 9(02) VALUE ZEROES.
          05 WS-XOR-INDEX-2       PIC 9(02) VALUE ZEROES.
          05 WS-XOR-INDEX         PIC 9(02) VALUE ZEROES.
          05 WS-NOT-INDEX         PIC 9(02) VALUE ZEROES.
          05 WS-AND-INDEX         PIC 9(02) VALUE ZEROES.
          05 WS-OR-INDEX          PIC 9(02) VALUE ZEROES.
          05 WS-SUM-INDEX         PIC 9(02) VALUE ZEROES.
          05 WS-SL-INDEX-1        PIC 9(02) VALUE ZEROES.
          05 WS-SL-INDEX-2        PIC 9(02) VALUE ZEROES.
      
      *   XOR keys & values
          05 WS-XOR-KEY-1         PIC X(32) VALUE SPACES.
          05 WS-XOR-KEY-1-X       REDEFINES WS-XOR-KEY-1
                                  OCCURS 32 PIC 9(01).
          05 WS-XOR-KEY-2         PIC X(32) VALUE SPACES.
          05 WS-XOR-KEY-2-X       REDEFINES WS-XOR-KEY-2
                                  OCCURS 32 PIC 9(01).
          05 WS-XOR-RESULT        PIC X(32) VALUE SPACES.
          05 WS-XOR-RESULT-X      REDEFINES WS-XOR-RESULT
                                  OCCURS 32 PIC X(01).
      
      *   NOT keys & values
          05 WS-NOT-KEY           PIC X(32) VALUE SPACES.
          05 WS-NOT-KEY-X         REDEFINES WS-NOT-KEY
                                  OCCURS 32 PIC X(01).
          05 WS-NOT-RESULT        PIC X(32) VALUE SPACES.
          05 WS-NOT-RESULT-X      REDEFINES WS-NOT-RESULT
                                  OCCURS 32 PIC X(01).
      
      *   OR keys & values
          05 WS-OR-KEY-1          PIC X(32) VALUE SPACES.
          05 WS-OR-KEY-1-X        REDEFINES WS-OR-KEY-1
                                  OCCURS 32 PIC 9(01).
          05 WS-OR-KEY-2          PIC X(32) VALUE SPACES.
          05 WS-OR-KEY-2-X        REDEFINES WS-OR-KEY-2
                                  OCCURS 32 PIC 9(01).
          05 WS-OR-RESULT         PIC X(32) VALUE SPACES.
          05 WS-OR-RESULT-X       REDEFINES WS-OR-RESULT
                                  OCCURS 32 PIC X(01).
      
      *   AND keys & values
          05 WS-AND-KEY-1         PIC X(32) VALUE SPACES.
          05 WS-AND-KEY-1-X       REDEFINES WS-AND-KEY-1
                                  OCCURS 32 PIC 9(01).
          05 WS-AND-KEY-2         PIC X(32) VALUE SPACES.
          05 WS-AND-KEY-2-X       REDEFINES WS-AND-KEY-2
                                  OCCURS 32 PIC 9(01).
          05 WS-AND-RESULT        PIC X(32) VALUE SPACES.
          05 WS-AND-RESULT-X      REDEFINES WS-AND-RESULT
                                  OCCURS 32 PIC X(01).      
          05 WS-AND-RESULT-1      PIC X(32) VALUE SPACES.
          05 WS-AND-RESULT-2      PIC X(32) VALUE SPACES.
          05 WS-AND-RESULT-3      PIC X(32) VALUE SPACES.
      
      *   SUM keys & values
          05 WS-SUM-KEY-1         PIC X(32) VALUE SPACES.
          05 WS-SUM-KEY-1-X       REDEFINES WS-SUM-KEY-1
                                  OCCURS 32 PIC 9(01).
          05 WS-SUM-KEY-2         PIC X(32) VALUE SPACES.
          05 WS-SUM-KEY-2-X       REDEFINES WS-SUM-KEY-2
                                  OCCURS 32 PIC 9(01).
          05 WS-SUM-RESULT        PIC X(32) VALUE SPACES.
          05 WS-SUM-RESULT-X      REDEFINES WS-SUM-RESULT
                                  OCCURS 32 PIC X(01).
      
      *   S^l keys & values
          05 WS-SL-KEY            PIC X(32) VALUE SPACES.
          05 WS-SL-KEY-X          REDEFINES WS-SL-KEY
                                  OCCURS 32 PIC X(01).
          05 WS-SL-RESULT         PIC X(32) VALUE SPACES.
          05 WS-SL-RESULT-X       REDEFINES WS-SL-RESULT
                                  OCCURS 32 PIC X(01).
      
      *   Indexes for functions
          05 WS-MAIN-INDEX        PIC 9(02) VALUE ZEROES.
          05 WS-HS-INDEX          PIC 9(01) VALUE ZEROES.
      
      *   Function-Fn results
          05 WS-FN-RESULT         PIC X(32) VALUE SPACES.
      
      *   Display variable
          05 WS-DISPLAY           PIC X(40) VALUE SPACES.
          05 WS-DISPLAY-X         REDEFINES WS-DISPLAY
                                  OCCURS 40 PIC X(01).

       01 WS-HS-TABLE.
      *   H's (already in binary)
          05 WS-HS.
              10 WS-H0            PIC X(32) 
                 VALUE '01100111010001010010001100000001'.
              10 WS-H0-FULL       REDEFINES WS-H0
                                  OCCURS 8 PIC X(04).
              10 WS-H1            PIC X(32)
                 VALUE '11101111110011011010101110001001'.
              10 WS-H1-FULL       REDEFINES WS-H1
                                  OCCURS 8 PIC X(04).
              10 WS-H2            PIC X(32)
                 VALUE '10011000101110101101110011111110'.
              10 WS-H2-FULL       REDEFINES WS-H2
                                  OCCURS 8 PIC X(04).
              10 WS-H3            PIC X(32)
                 VALUE '00010000001100100101010001110110'.
              10 WS-H3-FULL       REDEFINES WS-H3
                                  OCCURS 8 PIC X(04).
              10 WS-H4            PIC X(32)
                 VALUE '11000011110100101110000111110000'.
              10 WS-H4-FULL       REDEFINES WS-H4
                                  OCCURS 8 PIC X(04).
      
       01 WS-TABLE.
      *   HEX2BIN
          05 WS-HEX2BIN-INDEX     PIC 9(02) VALUE ZEROES.
          05 WS-HEX-KEY           PIC X(01) VALUE SPACES.
          05 WS-BIN-KEY           PIC X(04) VALUE SPACES.
          05 WS-HEX2BIN           OCCURS 16.
              10 WS-HEX           PIC X(01) VALUE SPACES.
              10 WS-BIN           PIC X(04) VALUE SPACES.
      
      *   DEC2HEX
          05 WS-DEC2HEX-INDEX     PIC 9(03) VALUE ZEROES.
          05 WS-HEXX-KEY          PIC X(02) VALUE SPACES.
          05 WS-DEC-KEY           PIC X(03) VALUE SPACES.
          05 WS-DEC2HEX           OCCURS 256.
              10 WS-DEC           PIC X(03) VALUE SPACES.
              10 WS-HEXX          PIC X(02) VALUE SPACES.
      
      *   K's TABLE (READONLY)
          05 WS-KS                OCCURS 80.
              10 WS-KS-VAL        PIC X(32) VALUE SPACES.
      
      *   Text table
          05 WS-ENTRY-TABLE       OCCURS 256.
              10 ENTRY-ASCII      PIC X(01) VALUE SPACES.
              10 ENTRY-HEX.
                  15 ENTRY-HEX-1  PIC X(01) VALUE SPACES.
                  15 ENTRY-HEX-2  PIC X(01) VALUE SPACES.
              10 ENTRY-DEC        PIC 9(03) VALUE ZEROES.
              10 ENTRY-BIN.
                  15 ENTRY-BIN-1  PIC X(04) VALUE SPACES.
                  15 ENTRY-BIN-2  PIC X(04) VALUE SPACES.

      *   Switches
       01 WS-SWITCH.
           05 SW-XOR              PIC 9(01) VALUE ZEROES.
               88 SW-XOR-FALSE              VALUE 0, 2.
               88 SW-XOR-TRUE               VALUE 1.
           05 SW-AND              PIC 9(01) VALUE ZEROES.
               88 SW-AND-FALSE              VALUE 0, 1.
               88 SW-AND-TRUE               VALUE 2.
           05 SW-OR               PIC 9(01) VALUE ZEROES.
               88 SW-OR-FALSE               VALUE 0.
               88 SW-OR-TRUE                VALUE 1, 2.
           05 SW-SUM              PIC 9(01) VALUE ZEROES.
               88 SW-ZERO                   VALUE 0.
               88 SW-ONE                    VALUE 1.
               88 SW-ACC-OFF                VALUE 0, 1.
               88 SW-ACC-ON                 VALUE 2, 3.
           05 SW-ACC              PIC 9(01) VALUE ZEROES.
               88 SW-ACC-TRUE               VALUE 1.
               88 SW-ACC-FALSE              VALUE ZEROES.

       LINKAGE SECTION.
         01 LS-SECTION.
             05 LS-HEX-TEXT       PIC X(512).
             05 LS-HEX-LENGTH     PIC 9(003).
      
       PROCEDURE DIVISION USING LS-SECTION.
       MAINLINE.
      *****************************************************************
      *    P A D D I N G   S E C T I O N   I N I                      *
      *****************************************************************
           INITIALIZE WS-VAR.
      
           DISPLAY 'SHA-1 Prototype - Made By DoHITB'.
           DISPLAY SPACE.
      
           PERFORM FILL-TABLES.
      
      *    Move linkage var to "official" var
           MOVE LS-HEX-TEXT       TO WS-RAW-TEXT.
           MOVE LS-HEX-LENGTH     TO WS-TEXT-LENGTH
                                     WS-TEXT-ASCII-LEN.
      
      *    Transform ASCII into HEX
      *
      *    The "SUBTRACT" is a kind of bug, when converting it gives
      *    the collate sequence - 192, so I adjusted it.
      *    - Update: it's because COBOL works with EDIBDC, so making
      *      the SUBTRACT will adapt it to ASCII collating sequence.
      *
           PERFORM VARYING WS-TEXT-INDEX FROM 1 BY 1 UNTIL
               WS-TEXT-INDEX > WS-TEXT-LENGTH
               MOVE WS-RAW-CHAR(WS-TEXT-INDEX)
                                  TO CHAR
               MOVE HEX-CHAR      TO NUM-CHAR
               SUBTRACT 192       FROM NUM-CHAR
            
      *        Get HEX value from ASCII char
               MOVE NUM-CHAR      TO WS-DEC-KEY
      
               PERFORM DEC2HEX
           
               MOVE WS-HEXX-KEY   TO WS-TEXT-PAIR(WS-TEXT-INDEX)
      
      *        Get BIN value from HEX char
               DIVIDE 16        INTO NUM-CHAR
                              GIVING WS-HEX-VAL-1
                           REMAINDER WS-HEX-VAL-2
      
      *        Move data to internal table
               MOVE CHAR          TO ENTRY-ASCII(WS-TEXT-INDEX)
               MOVE NUM-CHAR      TO ENTRY-DEC(WS-TEXT-INDEX)
               MOVE WS-HEX-VAL-1  TO WS-HEX2BIN-INDEX
      
               PERFORM BINVALUE
      
               MOVE WS-HEX-VAL-1  TO WS-HEX2BIN-INDEX
      
               PERFORM HEXVALUE
      
               MOVE WS-BIN-KEY    TO ENTRY-BIN-1(WS-TEXT-INDEX)
               MOVE WS-HEX-KEY    TO ENTRY-HEX-1(WS-TEXT-INDEX)
               MOVE WS-HEX-VAL-2  TO WS-HEX2BIN-INDEX
      
               PERFORM BINVALUE
      
               MOVE WS-HEX-VAL-2  TO WS-HEX2BIN-INDEX      
      
               PERFORM HEXVALUE
      
               MOVE WS-BIN-KEY    TO ENTRY-BIN-2(WS-TEXT-INDEX)
               MOVE WS-HEX-KEY    TO ENTRY-HEX-2(WS-TEXT-INDEX)
           END-PERFORM.
      
      *    Duplicate the value of length, because every char is 2-hex long.
           ADD WS-TEXT-LENGTH     TO WS-TEXT-LENGTH.
      
           PERFORM INPUT-TO-PADDING.
     
      *    Store original length for futher actions
           MOVE WS-PADDING-LENGTH TO CNS-PADDING-ORI-LENGTH

      *    We need to start from the next char      
           ADD  1                 TO WS-PADDING-LENGTH.

      *    Now we move a "1" after padding
           MOVE '1'               TO WS-PADDING-BIT(WS-PADDING-LENGTH).

      *    We need to start from the next char
           ADD  1                 TO WS-PADDING-LENGTH.

           PERFORM VARYING WS-PADDING-INDEX FROM WS-PADDING-LENGTH BY 1
               UNTIL WS-PADDING-INDEX > CNS-BLOCK-T
               MOVE '0'           TO WS-PADDING-BIT(WS-PADDING-INDEX)
           END-PERFORM.
      
      *    At this point, we only need to calculate the final blocks.
      *    As we are working with a MAXLEN of 256, the first block
      *    will be '00000000'. But I will fill it out of the main
      *    proc. just for the future, in case I make it accept more
      *    than 256-MAXLEN.
      *
           MOVE ALL ZEROES                     TO WS-PADDING-WORD(15)
                                                  WS-PADDING-WORD(16).
      
      *    Transform CNS-PADDING-ORI-LENGTH to HEX(02).      
      *
           DIVIDE 16                         INTO CNS-PADDING-ORI-LENGTH
                                           GIVING WS-HEX-VAL-1
                                        REMAINDER WS-HEX-VAL-2 .     
      
      *    Now, transform that HEX into BIN
      *
           MOVE WS-HEX-VAL-1                   TO WS-HEX2BIN-INDEX.
       
           PERFORM BINVALUE.
      
           MOVE WS-BIN-KEY                     TO WS-PADDING-HEX(127).
           MOVE WS-HEX-VAL-2                   TO WS-HEX2BIN-INDEX.
      
           PERFORM BINVALUE.
      
           MOVE WS-BIN-KEY                     TO WS-PADDING-HEX(128).
  
      *    At this point, the padding is done
      *****************************************************************
      *    P A D D I N G   S E C T I O N   E N D                      *
      *****************************************************************
      *    P R O C E S S   S E C T I O N   I N I                      *
      *****************************************************************
      *    F I L L I N G   S E C T I O N   I N I                      *
      *****************************************************************
      *    Once the padding is done, we need to fill a 80 * 8 structure
      *    Fist, move the padding to filling
      *
           MOVE WS-PADDING-TEXT                  TO WS-PROCESSING.
      
      *    Now, as rfc3174 specifies, we proceed like this:
      *        For t = 16 to 79 let
      *            W(t) = S^1(W(t-3) XOR W(t-8) XOR W(t-14) XOR W(t-16))
      *
           PERFORM VARYING WS-PROCESSING-INDEX FROM 17 BY 1
               UNTIL WS-PROCESSING-INDEX > CNS-PROCESSING-MAX
      *        W(t - 3) XOR W(t - 8) = W'
               MOVE WS-PROCESSING-INDEX          TO WS-XOR-INDEX-1
                                                    WS-XOR-INDEX-2
      
               SUBTRACT 3 FROM WS-XOR-INDEX-1
               SUBTRACT 8 FROM WS-XOR-INDEX-2
      
               MOVE WS-PROCESSING-WORD(WS-XOR-INDEX-1)
                                                 TO WS-XOR-KEY-1
               MOVE WS-PROCESSING-WORD(WS-XOR-INDEX-2)
                                                 TO WS-XOR-KEY-2
      
               PERFORM XOR
      
      *        W' XOR W(t - 14) = W''
               MOVE 0                            TO WS-XOR-INDEX-1
      
      *        XOR-INDEX-2 is -8, so only -6 needed to become -14
               SUBTRACT 6 FROM WS-XOR-INDEX-2
      
               MOVE WS-XOR-RESULT                TO WS-XOR-KEY-1
               MOVE WS-PROCESSING-WORD(WS-XOR-INDEX-2)
                                                 TO WS-XOR-KEY-2
      
               PERFORM XOR
      
      *        W'' XOR W(t - 16) = W'''
      *        XOR-INDEX-2 is -14, so only -2 needed to become -16
               SUBTRACT 2 FROM WS-XOR-INDEX-2
      
               MOVE WS-XOR-RESULT                TO WS-XOR-KEY-1
               MOVE WS-PROCESSING-WORD(WS-XOR-INDEX-2)
                                                 TO WS-XOR-KEY-2
      
               PERFORM XOR
      
      *        S^1(W''')
               MOVE WS-XOR-RESULT                TO WS-SL-KEY
      
               PERFORM LEFT-SHIFT
      
               MOVE WS-SL-RESULT                 TO WS-PROCESSING-WORD
                                                   (WS-PROCESSING-INDEX)
           END-PERFORM.
      
      *    At this point, we have a 80 word matrix ready to parse
      *****************************************************************
      *    F I L L I N G   S E C T I O N   E N D                      *
      *****************************************************************
      *    F U N C T I O N S   S E C T I O N   I N I                  *
      *****************************************************************
      *    From rfc3174:
      *        Let A = H0, B = H1, C = H2, D = H3, E = H4
      *
           MOVE WS-H0                            TO WS-A.
           MOVE WS-H1                            TO WS-B.
           MOVE WS-H2                            TO WS-C.
           MOVE WS-H3                            TO WS-D.
           MOVE WS-H4                            TO WS-E.
           MOVE SPACES                           TO WS-T.
      
      *    From rfc3174:
      *        For t = 0 to 79 do
      *            TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);
      *            E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;
      *
      *    I will do it in four loops, so I can optimize the function
      *    to choose without making a EVALUATE function that will
      *    trigger 80 times.
      *
           MOVE 1                                TO WS-MAIN-INDEX.
      
           PERFORM 20 TIMES
      *        S^5(A)
               MOVE WS-A                         TO WS-SL-KEY
      
               PERFORM 5 TIMES
                   PERFORM LEFT-SHIFT
       
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
          
      *        f(t;B,C,D)
               PERFORM FUNCTION-F1
      
      *        TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);
               PERFORM FUNCTION-SUM
      
      *        E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;
               MOVE WS-D                         TO WS-E
               MOVE WS-C                         TO WS-D
               
               MOVE WS-B                         TO WS-SL-KEY
      
      *        S^30(B)
               PERFORM 30 TIMES
                   PERFORM LEFT-SHIFT
      
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
               MOVE WS-SL-RESULT                 TO WS-C
               MOVE WS-A                         TO WS-B
               MOVE WS-T                         TO WS-A
      
               ADD 1                             TO WS-MAIN-INDEX
           END-PERFORM.
      
           PERFORM 20 TIMES
      *        S^5(A)
               MOVE WS-A                         TO WS-SL-KEY
      
               PERFORM 5 TIMES
                   PERFORM LEFT-SHIFT
       
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
      *        f(t;B,C,D)
               PERFORM FUNCTION-F2
      
      *        TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);
               PERFORM FUNCTION-SUM
      
      *        E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;
               MOVE WS-D                         TO WS-E
               MOVE WS-C                         TO WS-D
               
               MOVE WS-B                         TO WS-SL-KEY
      
      *        S^30(B)
               PERFORM 30 TIMES
                   PERFORM LEFT-SHIFT
      
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
               MOVE WS-SL-RESULT                 TO WS-C
               MOVE WS-A                         TO WS-B
               MOVE WS-T                         TO WS-A
      
               ADD 1                             TO WS-MAIN-INDEX
           END-PERFORM.
      
           PERFORM 20 TIMES
      *        S^5(A)
               MOVE WS-A                         TO WS-SL-KEY
      
               PERFORM 5 TIMES
                   PERFORM LEFT-SHIFT
       
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
      *        f(t;B,C,D)
               PERFORM FUNCTION-F3
      
      *        TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);
               PERFORM FUNCTION-SUM
      
      *        E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;
               MOVE WS-D                         TO WS-E
               MOVE WS-C                         TO WS-D
               
               MOVE WS-B                         TO WS-SL-KEY
      
      *        S^30(B)
               PERFORM 30 TIMES
                   PERFORM LEFT-SHIFT
      
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
               MOVE WS-SL-RESULT                 TO WS-C
               MOVE WS-A                         TO WS-B
               MOVE WS-T                         TO WS-A
      
               ADD 1                             TO WS-MAIN-INDEX
           END-PERFORM.
      
           PERFORM 20 TIMES
      *        S^5(A)
               MOVE WS-A                         TO WS-SL-KEY
      
               PERFORM 5 TIMES
                   PERFORM LEFT-SHIFT
       
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
      *        f(t;B,C,D)
               PERFORM FUNCTION-F4
      
      *        TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);
               PERFORM FUNCTION-SUM
      
      *        E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;
               MOVE WS-D                         TO WS-E
               MOVE WS-C                         TO WS-D
               
               MOVE WS-B                         TO WS-SL-KEY
      
      *        S^30(B)
               PERFORM 30 TIMES
                   PERFORM LEFT-SHIFT
      
                   MOVE WS-SL-RESULT             TO WS-SL-KEY
               END-PERFORM
      
               MOVE WS-SL-RESULT                 TO WS-C
               MOVE WS-A                         TO WS-B
               MOVE WS-T                         TO WS-A
      
               ADD 1                             TO WS-MAIN-INDEX
           END-PERFORM.
      
      *    At this point, all the functions are processed.
      *****************************************************************
      *    F U N C T I O N S   S E C T I O N   E N D                  *
      *****************************************************************
      *    R E A R R A N G E   S E C T I O N   I N I                  *
      *****************************************************************
      *    I will now rearrange the bytes sections.
      *
      *    From rfc3174:
      *        Let H0 = H0 + A, 
      *            H1 = H1 + B, 
      *            H2 = H2 + C, 
      *            H3 = H3 + D, 
      *            H4 = H4 + E.
      *

      *    H0 = H0 + A
           MOVE WS-H0                            TO WS-SUM-KEY-1.
           MOVE WS-A                             TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
           MOVE WS-SUM-RESULT                    TO WS-H0.
      
      *    H1 = H1 + B
           MOVE WS-H1                            TO WS-SUM-KEY-1.
           MOVE WS-B                             TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
           MOVE WS-SUM-RESULT                    TO WS-H1.
      
      *    H2 = H2 + C
           MOVE WS-H2                            TO WS-SUM-KEY-1.
           MOVE WS-C                             TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
           MOVE WS-SUM-RESULT                    TO WS-H2.
      
      *    H3 = H3 + D
           MOVE WS-H3                            TO WS-SUM-KEY-1.
           MOVE WS-D                             TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
           MOVE WS-SUM-RESULT                    TO WS-H3.
      
      *    H4 = H4 + E
           MOVE WS-H4                            TO WS-SUM-KEY-1.
           MOVE WS-E                             TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
           MOVE WS-SUM-RESULT                    TO WS-H4.
      
      *    At this point, everything is ready, but in binary.
      *****************************************************************
      *    R E A R R A N G E   S E C T I O N   E N D                  *
      *****************************************************************
      *    T R A N S L A T E   S E C T I O N   I N I                  *
      *****************************************************************
      *    For translating, I will take every 4-byte piece of every H
      *    then pass it to HEX into DISPLAY variable.
      *
           MOVE 1                                TO WS-MAIN-INDEX.
      
      *    H0     
           PERFORM VARYING WS-HS-INDEX FROM 1 BY 1
               UNTIL WS-HS-INDEX > CNS-HS-MAX
               MOVE WS-H0-FULL(WS-HS-INDEX)      TO WS-BIN-KEY
      
               PERFORM BIN2HEX
       
               MOVE WS-HEX-KEY                   TO 
                    WS-DISPLAY-X(WS-MAIN-INDEX)
      
               ADD  1                            TO WS-MAIN-INDEX
           END-PERFORM.
      
      *    H1
           PERFORM VARYING WS-HS-INDEX FROM 1 BY 1
               UNTIL WS-HS-INDEX > CNS-HS-MAX
               MOVE WS-H1-FULL(WS-HS-INDEX)      TO WS-BIN-KEY
      
               PERFORM BIN2HEX
      
               MOVE WS-HEX-KEY                   TO 
                    WS-DISPLAY-X(WS-MAIN-INDEX)
      
               ADD  1                            TO WS-MAIN-INDEX
           END-PERFORM.
      
      *    H2
           PERFORM VARYING WS-HS-INDEX FROM 1 BY 1
               UNTIL WS-HS-INDEX > CNS-HS-MAX
               MOVE WS-H2-FULL(WS-HS-INDEX)      TO WS-BIN-KEY
      
               PERFORM BIN2HEX
      
               MOVE WS-HEX-KEY                   TO 
                    WS-DISPLAY-X(WS-MAIN-INDEX)
      
               ADD  1                            TO WS-MAIN-INDEX
           END-PERFORM.
      
      *    H3
           PERFORM VARYING WS-HS-INDEX FROM 1 BY 1
               UNTIL WS-HS-INDEX > CNS-HS-MAX
               MOVE WS-H3-FULL(WS-HS-INDEX)      TO WS-BIN-KEY
      
               PERFORM BIN2HEX
      
               MOVE WS-HEX-KEY                   TO 
                    WS-DISPLAY-X(WS-MAIN-INDEX)
      
               ADD  1                            TO WS-MAIN-INDEX
           END-PERFORM.
      
      *    H4
           PERFORM VARYING WS-HS-INDEX FROM 1 BY 1
               UNTIL WS-HS-INDEX > CNS-HS-MAX
               MOVE WS-H4-FULL(WS-HS-INDEX)      TO WS-BIN-KEY
      
               PERFORM BIN2HEX
      
               MOVE WS-HEX-KEY                   TO 
                    WS-DISPLAY-X(WS-MAIN-INDEX)
      
               ADD  1                            TO WS-MAIN-INDEX
           END-PERFORM.
      
      *    At this point we have all ready to display and go.      
      *****************************************************************
      *    T R A N S L A T E   S E C T I O N   E N D                  *
      *****************************************************************
      *    P R O C E S S   S E C T I O N   E N D                      *
      *****************************************************************
      *     DISPLAY 'Result: ' WS-DISPLAY.
      
           GOBACK.

       INPUT-TO-PADDING.
           PERFORM VARYING WS-PADDING-INDEX FROM 1 BY 1
               UNTIL WS-PADDING-INDEX > WS-TEXT-ASCII-LEN
      
      *        Binary data is stored for S^l conversion
               MOVE ENTRY-BIN(WS-PADDING-INDEX)  TO 
               WS-PADDING-FULL(WS-PADDING-INDEX)
           END-PERFORM.
      
      *    Padding lenght is HEX length multiplied by 4.
           MULTIPLY 4                            BY WS-TEXT-LENGTH
                                             GIVING WS-PADDING-LENGTH.
      
       BIN2HEX.
           MOVE WS-BIN-KEY                       TO WS-BIN-BYTE-FULL.
      
           COMPUTE WS-HEX2BIN-INDEX = (WS-BIN-BYTE(4) * CNS-B1) + 
                                      (WS-BIN-BYTE(3) * CNS-B2) + 
                                      (WS-BIN-BYTE(2) * CNS-B3) +
                                      (WS-BIN-BYTE(1) * CNS-B4).
      
           PERFORM HEXVALUE.
      
       BINVALUE.
      *    No loop needed here. The HEX2BIN table is filled in order
      *    That every HEX is in BIN+1 position
      *
           ADD  1                                TO WS-HEX2BIN-INDEX.
           MOVE WS-BIN(WS-HEX2BIN-INDEX)         TO WS-BIN-KEY.
      
       HEXVALUE.
      *    No loop needed here. The HEX2BIN table is filled in order
      *    That every HEX is in BIN+1 position
      *
           ADD  1                                TO WS-HEX2BIN-INDEX.
           MOVE WS-HEX(WS-HEX2BIN-INDEX)         TO WS-HEX-KEY.      
      
       DEC2HEX.
      *    No loop needed here. The DEC2HEX table is filled in order
      *    That every DEC is in HEX+1 position
      *    For example:
      *        In position 1  we have DEC:0,  HEX:0
      *        In position 17 we have DEC:16, HEX:F
      *
      *        So if we're searching for DEC:0, we need to acces pos(1).
      *
           MOVE WS-DEC-KEY                       TO WS-DEC2HEX-INDEX.
      
           ADD  1                                TO WS-DEC2HEX-INDEX.
           MOVE WS-HEXX(WS-DEC2HEX-INDEX)        TO WS-HEXX-KEY.
      
       XOR.
      *    How it works:
      *        For 1 to 32, makes XOR-KEY-1(n) + XOR-KEY-2(n)
      *        IF result = 1, move 1; else, move 0.
      *
      *     x1 | x2 | x1 + x2 | xr |
      *    ----|----|---------|----|
      *      0 |  0 |    0    |  0 |
      *      0 |  1 |    1    |  1 |
      *      1 |  0 |    1    |  1 |
      *      1 |  1 |    2    |  0 |
      *
           MOVE SPACES                           TO WS-XOR-RESULT.
      
           PERFORM VARYING WS-XOR-INDEX FROM 1 BY 1
               UNTIL WS-XOR-INDEX > CNS-XOR-MAX
               MOVE WS-XOR-KEY-1-X(WS-XOR-INDEX) TO SW-XOR
               ADD  WS-XOR-KEY-2-X(WS-XOR-INDEX) TO SW-XOR
               
               IF SW-XOR-TRUE
                   MOVE '1'                      TO 
                   WS-XOR-RESULT-X(WS-XOR-INDEX)
               ELSE
                   MOVE '0'                      TO
                   WS-XOR-RESULT-X(WS-XOR-INDEX)
               END-IF
           END-PERFORM.
     
       F-NOT.
      *    How it works:
      *        For 1 to 32, if NOT-KEY(n) = 1 then move 0;
      *                                            move 1 otherwise.
      *
      *    NOTE: It could be done re-using "-KEY" value, but in order
      *    to maintain "-KEY" and "-RESULT" correlation, I'll use both.
      *
           MOVE SPACES                           TO WS-NOT-RESULT.
      
           PERFORM VARYING WS-NOT-INDEX FROM 1 BY 1
               UNTIL WS-NOT-INDEX > CNS-NOT-MAX
               IF WS-NOT-KEY-X(WS-NOT-INDEX) = '0'
                   MOVE '1'       TO WS-NOT-RESULT-X(WS-NOT-INDEX)
               ELSE
                   MOVE '0'       TO WS-NOT-RESULT-X(WS-NOT-INDEX)
               END-IF
           END-PERFORM.
      
       F-AND.
      *    How it works:
      *        For 1 to 32, makes AND-KEY-1(n) + AND-KEY-2(n)
      *        IF result = 2, move 1; else, move 0.
      *
      *     x1 | x2 | x1 + x2 | xr |
      *    ----|----|---------|----|
      *      0 |  0 |    0    |  0 |
      *      0 |  1 |    1    |  0 |
      *      1 |  0 |    1    |  0 |
      *      1 |  1 |    2    |  1 |
      *
           MOVE SPACES                           TO WS-AND-RESULT.
      
           PERFORM VARYING WS-AND-INDEX FROM 1 BY 1
               UNTIL WS-AND-INDEX > CNS-AND-MAX
               MOVE WS-AND-KEY-1-X(WS-AND-INDEX) TO SW-AND
               ADD  WS-AND-KEY-2-X(WS-AND-INDEX) TO SW-AND
               
               IF SW-AND-TRUE
                   MOVE '1'                      TO 
                   WS-AND-RESULT-X(WS-AND-INDEX)
               ELSE
                   MOVE '0'                      TO
                   WS-AND-RESULT-X(WS-AND-INDEX)
               END-IF
           END-PERFORM.

       F-OR.
      *    How it works:
      *        For 1 to 32, makes OR-KEY-1(n) + OR-KEY-2(n)
      *        IF result = 1 or 2, move 1; else, move 0.
      *
      *     x1 | x2 | x1 + x2 | xr |
      *    ----|----|---------|----|
      *      0 |  0 |    0    |  0 |
      *      0 |  1 |    1    |  1 |
      *      1 |  0 |    1    |  1 |
      *      1 |  1 |    2    |  1 |
      *
           MOVE SPACES                           TO WS-OR-RESULT.
      
           PERFORM VARYING WS-OR-INDEX FROM 1 BY 1
               UNTIL WS-OR-INDEX > CNS-OR-MAX
               MOVE WS-OR-KEY-1-X(WS-OR-INDEX) TO SW-OR
               ADD  WS-OR-KEY-2-X(WS-OR-INDEX) TO SW-OR
               
               IF SW-OR-TRUE
                   MOVE '1'                      TO 
                   WS-OR-RESULT-X(WS-OR-INDEX)
               ELSE
                   MOVE '0'                      TO
                   WS-OR-RESULT-X(WS-OR-INDEX)
               END-IF
           END-PERFORM.
      
       BIN-SUM.
      *    How it works:
      *        For 32 to 1, makes SUM-KEY-1(n) + SUM-KEY-2(n)
      *
      *     xa | x1 | x2 | x1 + x2 | xr | xa |
      *    ----|----|----|---------|----|----|
      *      0 |  0 |  0 |    0    |  0 |  0 |
      *      0 |  0 |  1 |    1    |  1 |  0 |
      *      0 |  1 |  0 |    1    |  1 |  0 |
      *      0 |  1 |  1 |    2    |  0 |  1 |
      *      1 |  0 |  0 |    1    |  1 |  0 |
      *      1 |  0 |  1 |    2    |  0 |  1 |
      *      1 |  1 |  0 |    2    |  0 |  1 |
      *      1 |  1 |  1 |    3    |  1 |  1 |
      *      
           SET SW-ACC-FALSE                      TO TRUE
      
           PERFORM VARYING WS-SUM-INDEX FROM CNS-SUM-MAX BY -1
               UNTIL WS-SUM-INDEX < 1
               MOVE WS-SUM-KEY-1-X(WS-SUM-INDEX) TO SW-SUM
               ADD  WS-SUM-KEY-2-X(WS-SUM-INDEX) TO SW-SUM
      
               IF SW-ACC-TRUE
                   ADD 1                          TO SW-SUM
                   SET SW-ACC-FALSE               TO TRUE
               END-IF
      
               IF SW-ACC-ON
                   IF SW-SUM = 2
                       MOVE '0'                   TO
                            WS-SUM-RESULT-X(WS-SUM-INDEX)
                   ELSE
                       MOVE '1'                   TO
                            WS-SUM-RESULT-X(WS-SUM-INDEX)
                   END-IF
      
                   SET SW-ACC-TRUE                TO TRUE
               ELSE
                   MOVE SW-SUM                    TO
                        WS-SUM-RESULT-X(WS-SUM-INDEX)
                   SET SW-ACC-FALSE               TO TRUE
               END-IF
           END-PERFORM.
 
      *    Awesome fact:
      *    In order to make a modular sum, the last byte can be
      *    neglected. That's because when aplying modular sum in bin
      *    we find a thing.
      *
      *    Let's supouse we work with 4-byte only, and we have this:
      *
      *    0111 + 1111 = 10110
      *
      *    That's a 5 digit-long data. To trim it into 4-byte, we make:
      *
      *    10110 - 10000
      *
      *    Using 2-complement:
      *
      *    10000 XOR 11111 = 01111 + 1 = 10000
      *
      *    So, the subtraction becomes:
      *
      *    10110 + 10000
      *
      *    As all digits on second operan are 0's, only the leftmost
      *    digit will change, making a 0 + 1 acc, so it gives
      *
      *    00110
      *
      *    That's the correct result, but if in first instance we
      *    won't take the final ACC, we will get same result!
      *
      
       LEFT-SHIFT.
      *    How it works:
      *        First, move SL-KEY(1) to SL-KEY(32)
      *        Then, For 2 to 32, moves SL-KEY(n) to SL-KEY(n - 1)
      *
           MOVE WS-SL-KEY-X(1)    TO WS-SL-RESULT-X(CNS-SL-MAX).
           MOVE 1                 TO WS-SL-INDEX-2.
      
           PERFORM VARYING WS-SL-INDEX-1 FROM 2 BY 1
               UNTIL WS-SL-INDEX-1 > CNS-SL-MAX
               MOVE WS-SL-KEY-X(WS-SL-INDEX-1)   TO
                    WS-SL-RESULT-X(WS-SL-INDEX-2)
      
               ADD 1                             TO WS-SL-INDEX-2
           END-PERFORM.
 
       FUNCTION-F1.
      *    From rfc3174:
      *        f(t;B,C,D) = (B AND C) OR ((NOT B) AND D)
      *
      
      *    NOT B
           MOVE WS-B                             TO WS-NOT-KEY.
      
           PERFORM F-NOT.
      
      *    ((NOT B) AND D)
           MOVE WS-NOT-RESULT                    TO WS-AND-KEY-1.
           MOVE WS-D                             TO WS-AND-KEY-2.
      
           PERFORM F-AND.
      
           MOVE WS-AND-RESULT                    TO WS-AND-RESULT-1.
      
      *    (B AND C)
           MOVE WS-B                             TO WS-AND-KEY-1.
           MOVE WS-C                             TO WS-AND-KEY-2.
      
           PERFORM F-AND.
      
           MOVE WS-AND-RESULT                    TO WS-AND-RESULT-2
      
      *    (B AND C) OR ((NOT B) AND D)
           MOVE WS-AND-RESULT-2                  TO WS-OR-KEY-1.
           MOVE WS-AND-RESULT-1                  TO WS-OR-KEY-2.
      
           PERFORM F-OR.
      
           MOVE WS-OR-RESULT                     TO WS-FN-RESULT.
      
       FUNCTION-F2.
      *    From rfc3174:
      *        f(t;B,C,D) = B XOR C XOR D
      *
       
      *    B XOR C
           MOVE WS-B                             TO WS-XOR-KEY-1.
           MOVE WS-C                             TO WS-XOR-KEY-2.
      
           PERFORM XOR.
      
      *    B XOR C XOR D
           MOVE WS-XOR-RESULT                    TO WS-XOR-KEY-1.
           MOVE WS-D                             TO WS-XOR-KEY-2.
      
           PERFORM XOR.
      
           MOVE WS-XOR-RESULT                    TO WS-FN-RESULT.
      
       FUNCTION-F3.
      *    From rfc3174:
      *        f(t;B,C,D) = (B AND C) OR (B AND D) OR (C AND D)
      *
      
      *    (B AND C)
           MOVE WS-B                             TO WS-AND-KEY-1.
           MOVE WS-C                             TO WS-AND-KEY-2.
      
           PERFORM F-AND.
      
           MOVE WS-AND-RESULT                    TO WS-AND-RESULT-1.
      
      *    (B AND D) - B is already charged
           MOVE WS-D                             TO WS-AND-KEY-2.
      
           PERFORM F-AND.
      
           MOVE WS-AND-RESULT                    TO WS-AND-RESULT-2.
      
      *    (C AND D)
           MOVE WS-C                             TO WS-AND-KEY-1.
           MOVE WS-D                             TO WS-AND-KEY-2.
      
           PERFORM F-AND.
         
           MOVE WS-AND-RESULT                    TO WS-AND-RESULT-3.
      
      *    (B AND C) OR (B AND D)
           MOVE WS-AND-RESULT-1                  TO WS-OR-KEY-1.
           MOVE WS-AND-RESULT-2                  TO WS-OR-KEY-2.
      
           PERFORM F-OR.
      
      *    (B AND C) OR (B AND D) OR (C AND D)
           MOVE WS-OR-RESULT                     TO WS-OR-KEY-1.
           MOVE WS-AND-RESULT-3                  TO WS-OR-KEY-2.
      
           PERFORM F-OR.
      
           MOVE WS-OR-RESULT                     TO WS-FN-RESULT.
            
       FUNCTION-F4.
      *    From rfc3174:
      *        f(t;B,C,D) = B XOR C XOR D
      *
           PERFORM FUNCTION-F2.
      
       FUNCTION-SUM.
      *    From rfc3174:
      *        TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t)
      *    I already have S^5(A) value on SL-RESULT
      *    I already have f(t;B,C,D) value on FN-RESULT
      *    E is on WS-E
      *    W(t) can be obtained with MAIN-INDEX
      *    K(t) can be obtained with MAIN-INDEX
      *
      *    NOTE: All the "+" signs here refers to modular sum.
      *
        
      *    S^5(A) + f(t;B,C,D)
           MOVE WS-SL-RESULT                     TO WS-SUM-KEY-1.
           MOVE WS-FN-RESULT                     TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
      *    S^5(A) + f(t;B,C,D) + E
           MOVE WS-SUM-RESULT                    TO WS-SUM-KEY-1.
           MOVE WS-E                             TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
      *    S^5(A) + f(t;B,C,D) + E + W(t)
           MOVE WS-SUM-RESULT                    TO WS-SUM-KEY-1.
           MOVE WS-PROCESSING-WORD(WS-MAIN-INDEX) TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
      *    S^5(A) + f(t;B,C,D) + E + W(t) + K(t)
           MOVE WS-SUM-RESULT                    TO WS-SUM-KEY-1.
           MOVE WS-KS-VAL(WS-MAIN-INDEX)         TO WS-SUM-KEY-2.
      
           PERFORM BIN-SUM.
      
           MOVE WS-SUM-RESULT                    TO WS-T.
      
       FILL-TABLES.
      *    Fill HEX2BIN
           MOVE '0'               TO WS-HEX(01).
           MOVE '1'               TO WS-HEX(02).
           MOVE '2'               TO WS-HEX(03).
           MOVE '3'               TO WS-HEX(04).
           MOVE '4'               TO WS-HEX(05).
           MOVE '5'               TO WS-HEX(06).
           MOVE '6'               TO WS-HEX(07).
           MOVE '7'               TO WS-HEX(08).
           MOVE '8'               TO WS-HEX(09).
           MOVE '9'               TO WS-HEX(10).
           MOVE 'A'               TO WS-HEX(11).
           MOVE 'B'               TO WS-HEX(12).
           MOVE 'C'               TO WS-HEX(13).
           MOVE 'D'               TO WS-HEX(14).
           MOVE 'E'               TO WS-HEX(15).
           MOVE 'F'               TO WS-HEX(16).

           MOVE '0000'            TO WS-BIN(01).
           MOVE '0001'            TO WS-BIN(02).
           MOVE '0010'            TO WS-BIN(03).
           MOVE '0011'            TO WS-BIN(04).
           MOVE '0100'            TO WS-BIN(05).
           MOVE '0101'            TO WS-BIN(06).
           MOVE '0110'            TO WS-BIN(07).
           MOVE '0111'            TO WS-BIN(08).
           MOVE '1000'            TO WS-BIN(09).
           MOVE '1001'            TO WS-BIN(10).
           MOVE '1010'            TO WS-BIN(11).
           MOVE '1011'            TO WS-BIN(12).
           MOVE '1100'            TO WS-BIN(13).
           MOVE '1101'            TO WS-BIN(14).
           MOVE '1110'            TO WS-BIN(15).
           MOVE '1111'            TO WS-BIN(16).

      *    Fill DEC2HEX
           MOVE '000'             TO WS-DEC(001).
           MOVE '001'             TO WS-DEC(002).
           MOVE '002'             TO WS-DEC(003).
           MOVE '003'             TO WS-DEC(004).
           MOVE '004'             TO WS-DEC(005).
           MOVE '005'             TO WS-DEC(006).
           MOVE '006'             TO WS-DEC(007).
           MOVE '007'             TO WS-DEC(008).
           MOVE '008'             TO WS-DEC(009).
           MOVE '009'             TO WS-DEC(010).
           MOVE '010'             TO WS-DEC(011).
           MOVE '011'             TO WS-DEC(012).
           MOVE '012'             TO WS-DEC(013).
           MOVE '013'             TO WS-DEC(014).
           MOVE '014'             TO WS-DEC(015).
           MOVE '015'             TO WS-DEC(016).
           MOVE '016'             TO WS-DEC(017).
           MOVE '017'             TO WS-DEC(018).
           MOVE '018'             TO WS-DEC(019).
           MOVE '019'             TO WS-DEC(020).
           MOVE '020'             TO WS-DEC(021).
           MOVE '021'             TO WS-DEC(022).
           MOVE '022'             TO WS-DEC(023).
           MOVE '023'             TO WS-DEC(024).
           MOVE '024'             TO WS-DEC(025).
           MOVE '025'             TO WS-DEC(026).
           MOVE '026'             TO WS-DEC(027).
           MOVE '027'             TO WS-DEC(028).
           MOVE '028'             TO WS-DEC(029).
           MOVE '029'             TO WS-DEC(030).
           MOVE '030'             TO WS-DEC(031).
           MOVE '031'             TO WS-DEC(032).
           MOVE '032'             TO WS-DEC(033).
           MOVE '033'             TO WS-DEC(034).
           MOVE '034'             TO WS-DEC(035).
           MOVE '035'             TO WS-DEC(036).
           MOVE '036'             TO WS-DEC(037).
           MOVE '037'             TO WS-DEC(038).
           MOVE '038'             TO WS-DEC(039).
           MOVE '039'             TO WS-DEC(040).
           MOVE '040'             TO WS-DEC(041).
           MOVE '041'             TO WS-DEC(042).
           MOVE '042'             TO WS-DEC(043).
           MOVE '043'             TO WS-DEC(044).
           MOVE '044'             TO WS-DEC(045).
           MOVE '045'             TO WS-DEC(046).
           MOVE '046'             TO WS-DEC(047).
           MOVE '047'             TO WS-DEC(048).
           MOVE '048'             TO WS-DEC(049).
           MOVE '049'             TO WS-DEC(050).
           MOVE '050'             TO WS-DEC(051).
           MOVE '051'             TO WS-DEC(052).
           MOVE '052'             TO WS-DEC(053).
           MOVE '053'             TO WS-DEC(054).
           MOVE '054'             TO WS-DEC(055).
           MOVE '055'             TO WS-DEC(056).
           MOVE '056'             TO WS-DEC(057).
           MOVE '057'             TO WS-DEC(058).
           MOVE '058'             TO WS-DEC(059).
           MOVE '059'             TO WS-DEC(060).
           MOVE '060'             TO WS-DEC(061).
           MOVE '061'             TO WS-DEC(062).
           MOVE '062'             TO WS-DEC(063).
           MOVE '063'             TO WS-DEC(064).
           MOVE '064'             TO WS-DEC(065).
           MOVE '065'             TO WS-DEC(066).
           MOVE '066'             TO WS-DEC(067).
           MOVE '067'             TO WS-DEC(068).
           MOVE '068'             TO WS-DEC(069).
           MOVE '069'             TO WS-DEC(070).
           MOVE '070'             TO WS-DEC(071).
           MOVE '071'             TO WS-DEC(072).
           MOVE '072'             TO WS-DEC(073).
           MOVE '073'             TO WS-DEC(074).
           MOVE '074'             TO WS-DEC(075).
           MOVE '075'             TO WS-DEC(076).
           MOVE '076'             TO WS-DEC(077).
           MOVE '077'             TO WS-DEC(078).
           MOVE '078'             TO WS-DEC(079).
           MOVE '079'             TO WS-DEC(080).
           MOVE '080'             TO WS-DEC(081).
           MOVE '081'             TO WS-DEC(082).
           MOVE '082'             TO WS-DEC(083).
           MOVE '083'             TO WS-DEC(084).
           MOVE '084'             TO WS-DEC(085).
           MOVE '085'             TO WS-DEC(086).
           MOVE '086'             TO WS-DEC(087).
           MOVE '087'             TO WS-DEC(088).
           MOVE '088'             TO WS-DEC(089).
           MOVE '089'             TO WS-DEC(090).
           MOVE '090'             TO WS-DEC(091).
           MOVE '091'             TO WS-DEC(092).
           MOVE '092'             TO WS-DEC(093).
           MOVE '093'             TO WS-DEC(094).
           MOVE '094'             TO WS-DEC(095).
           MOVE '095'             TO WS-DEC(096).
           MOVE '096'             TO WS-DEC(097).
           MOVE '097'             TO WS-DEC(098).
           MOVE '098'             TO WS-DEC(099).
           MOVE '099'             TO WS-DEC(100).
           MOVE '100'             TO WS-DEC(101).
           MOVE '101'             TO WS-DEC(102).
           MOVE '102'             TO WS-DEC(103).
           MOVE '103'             TO WS-DEC(104).
           MOVE '104'             TO WS-DEC(105).
           MOVE '105'             TO WS-DEC(106).
           MOVE '106'             TO WS-DEC(107).
           MOVE '107'             TO WS-DEC(108).
           MOVE '108'             TO WS-DEC(109).
           MOVE '109'             TO WS-DEC(110).
           MOVE '110'             TO WS-DEC(111).
           MOVE '111'             TO WS-DEC(112).
           MOVE '112'             TO WS-DEC(113).
           MOVE '113'             TO WS-DEC(114).
           MOVE '114'             TO WS-DEC(115).
           MOVE '115'             TO WS-DEC(116).
           MOVE '116'             TO WS-DEC(117).
           MOVE '117'             TO WS-DEC(118).
           MOVE '118'             TO WS-DEC(119).
           MOVE '119'             TO WS-DEC(120).
           MOVE '120'             TO WS-DEC(121).
           MOVE '121'             TO WS-DEC(122).
           MOVE '122'             TO WS-DEC(123).
           MOVE '123'             TO WS-DEC(124).
           MOVE '124'             TO WS-DEC(125).
           MOVE '125'             TO WS-DEC(126).
           MOVE '126'             TO WS-DEC(127).
           MOVE '127'             TO WS-DEC(128).
           MOVE '128'             TO WS-DEC(129).
           MOVE '129'             TO WS-DEC(130).
           MOVE '130'             TO WS-DEC(131).
           MOVE '131'             TO WS-DEC(132).
           MOVE '132'             TO WS-DEC(133).
           MOVE '133'             TO WS-DEC(134).
           MOVE '134'             TO WS-DEC(135).
           MOVE '135'             TO WS-DEC(136).
           MOVE '136'             TO WS-DEC(137).
           MOVE '137'             TO WS-DEC(138).
           MOVE '138'             TO WS-DEC(139).
           MOVE '139'             TO WS-DEC(140).
           MOVE '140'             TO WS-DEC(141).
           MOVE '141'             TO WS-DEC(142).
           MOVE '142'             TO WS-DEC(143).
           MOVE '143'             TO WS-DEC(144).
           MOVE '144'             TO WS-DEC(145).
           MOVE '145'             TO WS-DEC(146).
           MOVE '146'             TO WS-DEC(147).
           MOVE '147'             TO WS-DEC(148).
           MOVE '148'             TO WS-DEC(149).
           MOVE '149'             TO WS-DEC(150).
           MOVE '150'             TO WS-DEC(151).
           MOVE '151'             TO WS-DEC(152).
           MOVE '152'             TO WS-DEC(153).
           MOVE '153'             TO WS-DEC(154).
           MOVE '154'             TO WS-DEC(155).
           MOVE '155'             TO WS-DEC(156).
           MOVE '156'             TO WS-DEC(157).
           MOVE '157'             TO WS-DEC(158).
           MOVE '158'             TO WS-DEC(159).
           MOVE '159'             TO WS-DEC(160).
           MOVE '160'             TO WS-DEC(161).
           MOVE '161'             TO WS-DEC(162).
           MOVE '162'             TO WS-DEC(163).
           MOVE '163'             TO WS-DEC(164).
           MOVE '164'             TO WS-DEC(165).
           MOVE '165'             TO WS-DEC(166).
           MOVE '166'             TO WS-DEC(167).
           MOVE '167'             TO WS-DEC(168).
           MOVE '168'             TO WS-DEC(169).
           MOVE '169'             TO WS-DEC(170).
           MOVE '170'             TO WS-DEC(171).
           MOVE '171'             TO WS-DEC(172).
           MOVE '172'             TO WS-DEC(173).
           MOVE '173'             TO WS-DEC(174).
           MOVE '174'             TO WS-DEC(175).
           MOVE '175'             TO WS-DEC(176).
           MOVE '176'             TO WS-DEC(177).
           MOVE '177'             TO WS-DEC(178).
           MOVE '178'             TO WS-DEC(179).
           MOVE '179'             TO WS-DEC(180).
           MOVE '180'             TO WS-DEC(181).
           MOVE '181'             TO WS-DEC(182).
           MOVE '182'             TO WS-DEC(183).
           MOVE '183'             TO WS-DEC(184).
           MOVE '184'             TO WS-DEC(185).
           MOVE '185'             TO WS-DEC(186).
           MOVE '186'             TO WS-DEC(187).
           MOVE '187'             TO WS-DEC(188).
           MOVE '188'             TO WS-DEC(189).
           MOVE '189'             TO WS-DEC(190).
           MOVE '190'             TO WS-DEC(191).
           MOVE '191'             TO WS-DEC(192).
           MOVE '192'             TO WS-DEC(193).
           MOVE '193'             TO WS-DEC(194).
           MOVE '194'             TO WS-DEC(195).
           MOVE '195'             TO WS-DEC(196).
           MOVE '196'             TO WS-DEC(197).
           MOVE '197'             TO WS-DEC(198).
           MOVE '198'             TO WS-DEC(199).
           MOVE '199'             TO WS-DEC(200).
           MOVE '200'             TO WS-DEC(201).
           MOVE '201'             TO WS-DEC(202).
           MOVE '202'             TO WS-DEC(203).
           MOVE '203'             TO WS-DEC(204).
           MOVE '204'             TO WS-DEC(205).
           MOVE '205'             TO WS-DEC(206).
           MOVE '206'             TO WS-DEC(207).
           MOVE '207'             TO WS-DEC(208).
           MOVE '208'             TO WS-DEC(209).
           MOVE '209'             TO WS-DEC(210).
           MOVE '210'             TO WS-DEC(211).
           MOVE '211'             TO WS-DEC(212).
           MOVE '212'             TO WS-DEC(213).
           MOVE '213'             TO WS-DEC(214).
           MOVE '214'             TO WS-DEC(215).
           MOVE '215'             TO WS-DEC(216).
           MOVE '216'             TO WS-DEC(217).
           MOVE '217'             TO WS-DEC(218).
           MOVE '218'             TO WS-DEC(219).
           MOVE '219'             TO WS-DEC(220).
           MOVE '220'             TO WS-DEC(221).
           MOVE '221'             TO WS-DEC(222).
           MOVE '222'             TO WS-DEC(223).
           MOVE '223'             TO WS-DEC(224).
           MOVE '224'             TO WS-DEC(225).
           MOVE '225'             TO WS-DEC(226).
           MOVE '226'             TO WS-DEC(227).
           MOVE '227'             TO WS-DEC(228).
           MOVE '228'             TO WS-DEC(229).
           MOVE '229'             TO WS-DEC(230).
           MOVE '230'             TO WS-DEC(231).
           MOVE '231'             TO WS-DEC(232).
           MOVE '232'             TO WS-DEC(233).
           MOVE '233'             TO WS-DEC(234).
           MOVE '234'             TO WS-DEC(235).
           MOVE '235'             TO WS-DEC(236).
           MOVE '236'             TO WS-DEC(237).
           MOVE '237'             TO WS-DEC(238).
           MOVE '238'             TO WS-DEC(239).
           MOVE '239'             TO WS-DEC(240).
           MOVE '240'             TO WS-DEC(241).
           MOVE '241'             TO WS-DEC(242).
           MOVE '242'             TO WS-DEC(243).
           MOVE '243'             TO WS-DEC(244).
           MOVE '244'             TO WS-DEC(245).
           MOVE '245'             TO WS-DEC(246).
           MOVE '246'             TO WS-DEC(247).
           MOVE '247'             TO WS-DEC(248).
           MOVE '248'             TO WS-DEC(249).
           MOVE '249'             TO WS-DEC(250).
           MOVE '250'             TO WS-DEC(251).
           MOVE '251'             TO WS-DEC(252).
           MOVE '252'             TO WS-DEC(253).
           MOVE '253'             TO WS-DEC(254).
           MOVE '254'             TO WS-DEC(255).
           MOVE '255'             TO WS-DEC(256).

           MOVE '00'              TO WS-HEXX(001).
           MOVE '01'              TO WS-HEXX(002).
           MOVE '02'              TO WS-HEXX(003).
           MOVE '03'              TO WS-HEXX(004).
           MOVE '04'              TO WS-HEXX(005).
           MOVE '05'              TO WS-HEXX(006).
           MOVE '06'              TO WS-HEXX(007).
           MOVE '07'              TO WS-HEXX(008).
           MOVE '08'              TO WS-HEXX(009).
           MOVE '09'              TO WS-HEXX(010).
           MOVE '0A'              TO WS-HEXX(011).
           MOVE '0B'              TO WS-HEXX(012).
           MOVE '0C'              TO WS-HEXX(013).
           MOVE '0D'              TO WS-HEXX(014).
           MOVE '0E'              TO WS-HEXX(015).
           MOVE '0F'              TO WS-HEXX(016).
           MOVE '10'              TO WS-HEXX(017).
           MOVE '11'              TO WS-HEXX(018).
           MOVE '12'              TO WS-HEXX(019).
           MOVE '13'              TO WS-HEXX(020).
           MOVE '14'              TO WS-HEXX(021).
           MOVE '15'              TO WS-HEXX(022).
           MOVE '16'              TO WS-HEXX(023).
           MOVE '17'              TO WS-HEXX(024).
           MOVE '18'              TO WS-HEXX(025).
           MOVE '19'              TO WS-HEXX(026).
           MOVE '1A'              TO WS-HEXX(027).
           MOVE '1B'              TO WS-HEXX(028).
           MOVE '1C'              TO WS-HEXX(029).
           MOVE '1D'              TO WS-HEXX(030).
           MOVE '1E'              TO WS-HEXX(031).
           MOVE '1F'              TO WS-HEXX(032).
           MOVE '20'              TO WS-HEXX(033).
           MOVE '21'              TO WS-HEXX(034).
           MOVE '22'              TO WS-HEXX(035).
           MOVE '23'              TO WS-HEXX(036).
           MOVE '24'              TO WS-HEXX(037).
           MOVE '25'              TO WS-HEXX(038).
           MOVE '26'              TO WS-HEXX(039).
           MOVE '27'              TO WS-HEXX(040).
           MOVE '28'              TO WS-HEXX(041).
           MOVE '29'              TO WS-HEXX(042).
           MOVE '2A'              TO WS-HEXX(043).
           MOVE '2B'              TO WS-HEXX(044).
           MOVE '2C'              TO WS-HEXX(045).
           MOVE '2D'              TO WS-HEXX(046).
           MOVE '2E'              TO WS-HEXX(047).
           MOVE '2F'              TO WS-HEXX(048).
           MOVE '30'              TO WS-HEXX(049).
           MOVE '31'              TO WS-HEXX(050).
           MOVE '32'              TO WS-HEXX(051).
           MOVE '33'              TO WS-HEXX(052).
           MOVE '34'              TO WS-HEXX(053).
           MOVE '35'              TO WS-HEXX(054).
           MOVE '36'              TO WS-HEXX(055).
           MOVE '37'              TO WS-HEXX(056).
           MOVE '38'              TO WS-HEXX(057).
           MOVE '39'              TO WS-HEXX(058).
           MOVE '3A'              TO WS-HEXX(059).
           MOVE '3B'              TO WS-HEXX(060).
           MOVE '3C'              TO WS-HEXX(061).
           MOVE '3D'              TO WS-HEXX(062).
           MOVE '3E'              TO WS-HEXX(063).
           MOVE '3F'              TO WS-HEXX(064).
           MOVE '40'              TO WS-HEXX(065).
           MOVE '41'              TO WS-HEXX(066).
           MOVE '42'              TO WS-HEXX(067).
           MOVE '43'              TO WS-HEXX(068).
           MOVE '44'              TO WS-HEXX(069).
           MOVE '45'              TO WS-HEXX(070).
           MOVE '46'              TO WS-HEXX(071).
           MOVE '47'              TO WS-HEXX(072).
           MOVE '48'              TO WS-HEXX(073).
           MOVE '49'              TO WS-HEXX(074).
           MOVE '4A'              TO WS-HEXX(075).
           MOVE '4B'              TO WS-HEXX(076).
           MOVE '4C'              TO WS-HEXX(077).
           MOVE '4D'              TO WS-HEXX(078).
           MOVE '4E'              TO WS-HEXX(079).
           MOVE '4F'              TO WS-HEXX(080).
           MOVE '50'              TO WS-HEXX(081).
           MOVE '51'              TO WS-HEXX(082).
           MOVE '52'              TO WS-HEXX(083).
           MOVE '53'              TO WS-HEXX(084).
           MOVE '54'              TO WS-HEXX(085).
           MOVE '55'              TO WS-HEXX(086).
           MOVE '56'              TO WS-HEXX(087).
           MOVE '57'              TO WS-HEXX(088).
           MOVE '58'              TO WS-HEXX(089).
           MOVE '59'              TO WS-HEXX(090).
           MOVE '5A'              TO WS-HEXX(091).
           MOVE '5B'              TO WS-HEXX(092).
           MOVE '5C'              TO WS-HEXX(093).
           MOVE '5D'              TO WS-HEXX(094).
           MOVE '5E'              TO WS-HEXX(095).
           MOVE '5F'              TO WS-HEXX(096).
           MOVE '60'              TO WS-HEXX(097).
           MOVE '61'              TO WS-HEXX(098).
           MOVE '62'              TO WS-HEXX(099).
           MOVE '63'              TO WS-HEXX(100).
           MOVE '64'              TO WS-HEXX(101).
           MOVE '65'              TO WS-HEXX(102).
           MOVE '66'              TO WS-HEXX(103).
           MOVE '67'              TO WS-HEXX(104).
           MOVE '68'              TO WS-HEXX(105).
           MOVE '69'              TO WS-HEXX(106).
           MOVE '6A'              TO WS-HEXX(107).
           MOVE '6B'              TO WS-HEXX(108).
           MOVE '6C'              TO WS-HEXX(109).
           MOVE '6D'              TO WS-HEXX(110).
           MOVE '6E'              TO WS-HEXX(111).
           MOVE '6F'              TO WS-HEXX(112).
           MOVE '70'              TO WS-HEXX(113).
           MOVE '71'              TO WS-HEXX(114).
           MOVE '72'              TO WS-HEXX(115).
           MOVE '73'              TO WS-HEXX(116).
           MOVE '74'              TO WS-HEXX(117).
           MOVE '75'              TO WS-HEXX(118).
           MOVE '76'              TO WS-HEXX(119).
           MOVE '77'              TO WS-HEXX(120).
           MOVE '78'              TO WS-HEXX(121).
           MOVE '79'              TO WS-HEXX(122).
           MOVE '7A'              TO WS-HEXX(123).
           MOVE '7B'              TO WS-HEXX(124).
           MOVE '7C'              TO WS-HEXX(125).
           MOVE '7D'              TO WS-HEXX(126).
           MOVE '7E'              TO WS-HEXX(127).
           MOVE '7F'              TO WS-HEXX(128).
           MOVE '80'              TO WS-HEXX(129).
           MOVE '81'              TO WS-HEXX(130).
           MOVE '82'              TO WS-HEXX(131).
           MOVE '83'              TO WS-HEXX(132).
           MOVE '84'              TO WS-HEXX(133).
           MOVE '85'              TO WS-HEXX(134).
           MOVE '86'              TO WS-HEXX(135).
           MOVE '87'              TO WS-HEXX(136).
           MOVE '88'              TO WS-HEXX(137).
           MOVE '89'              TO WS-HEXX(138).
           MOVE '8A'              TO WS-HEXX(139).
           MOVE '8B'              TO WS-HEXX(140).
           MOVE '8C'              TO WS-HEXX(141).
           MOVE '8D'              TO WS-HEXX(142).
           MOVE '8E'              TO WS-HEXX(143).
           MOVE '8F'              TO WS-HEXX(144).
           MOVE '90'              TO WS-HEXX(145).
           MOVE '91'              TO WS-HEXX(146).
           MOVE '92'              TO WS-HEXX(147).
           MOVE '93'              TO WS-HEXX(148).
           MOVE '94'              TO WS-HEXX(149).
           MOVE '95'              TO WS-HEXX(150).
           MOVE '96'              TO WS-HEXX(151).
           MOVE '97'              TO WS-HEXX(152).
           MOVE '98'              TO WS-HEXX(153).
           MOVE '99'              TO WS-HEXX(154).
           MOVE '9A'              TO WS-HEXX(155).
           MOVE '9B'              TO WS-HEXX(156).
           MOVE '9C'              TO WS-HEXX(157).
           MOVE '9D'              TO WS-HEXX(158).
           MOVE '9E'              TO WS-HEXX(159).
           MOVE '9F'              TO WS-HEXX(160).
           MOVE 'A0'              TO WS-HEXX(161).
           MOVE 'A1'              TO WS-HEXX(162).
           MOVE 'A2'              TO WS-HEXX(163).
           MOVE 'A3'              TO WS-HEXX(164).
           MOVE 'A4'              TO WS-HEXX(165).
           MOVE 'A5'              TO WS-HEXX(166).
           MOVE 'A6'              TO WS-HEXX(167).
           MOVE 'A7'              TO WS-HEXX(168).
           MOVE 'A8'              TO WS-HEXX(169).
           MOVE 'A9'              TO WS-HEXX(170).
           MOVE 'AA'              TO WS-HEXX(171).
           MOVE 'AB'              TO WS-HEXX(172).
           MOVE 'AC'              TO WS-HEXX(173).
           MOVE 'AD'              TO WS-HEXX(174).
           MOVE 'AE'              TO WS-HEXX(175).
           MOVE 'AF'              TO WS-HEXX(176).
           MOVE 'B0'              TO WS-HEXX(177).
           MOVE 'B1'              TO WS-HEXX(178).
           MOVE 'B2'              TO WS-HEXX(179).
           MOVE 'B3'              TO WS-HEXX(180).
           MOVE 'B4'              TO WS-HEXX(181).
           MOVE 'B5'              TO WS-HEXX(182).
           MOVE 'B6'              TO WS-HEXX(183).
           MOVE 'B7'              TO WS-HEXX(184).
           MOVE 'B8'              TO WS-HEXX(185).
           MOVE 'B9'              TO WS-HEXX(186).
           MOVE 'BA'              TO WS-HEXX(187).
           MOVE 'BB'              TO WS-HEXX(188).
           MOVE 'BC'              TO WS-HEXX(189).
           MOVE 'BD'              TO WS-HEXX(190).
           MOVE 'BE'              TO WS-HEXX(191).
           MOVE 'BF'              TO WS-HEXX(192).
           MOVE 'C0'              TO WS-HEXX(193).
           MOVE 'C1'              TO WS-HEXX(194).
           MOVE 'C2'              TO WS-HEXX(195).
           MOVE 'C3'              TO WS-HEXX(196).
           MOVE 'C4'              TO WS-HEXX(197).
           MOVE 'C5'              TO WS-HEXX(198).
           MOVE 'C6'              TO WS-HEXX(199).
           MOVE 'C7'              TO WS-HEXX(200).
           MOVE 'C8'              TO WS-HEXX(201).
           MOVE 'C9'              TO WS-HEXX(202).
           MOVE 'CA'              TO WS-HEXX(203).
           MOVE 'CB'              TO WS-HEXX(204).
           MOVE 'CC'              TO WS-HEXX(205).
           MOVE 'CD'              TO WS-HEXX(206).
           MOVE 'CE'              TO WS-HEXX(207).
           MOVE 'CF'              TO WS-HEXX(208).
           MOVE 'D0'              TO WS-HEXX(209).
           MOVE 'D1'              TO WS-HEXX(210).
           MOVE 'D2'              TO WS-HEXX(211).
           MOVE 'D3'              TO WS-HEXX(212).
           MOVE 'D4'              TO WS-HEXX(213).
           MOVE 'D5'              TO WS-HEXX(214).
           MOVE 'D6'              TO WS-HEXX(215).
           MOVE 'D7'              TO WS-HEXX(216).
           MOVE 'D8'              TO WS-HEXX(217).
           MOVE 'D9'              TO WS-HEXX(218).
           MOVE 'DA'              TO WS-HEXX(219).
           MOVE 'DB'              TO WS-HEXX(220).
           MOVE 'DC'              TO WS-HEXX(221).
           MOVE 'DD'              TO WS-HEXX(222).
           MOVE 'DE'              TO WS-HEXX(223).
           MOVE 'DF'              TO WS-HEXX(224).
           MOVE 'E0'              TO WS-HEXX(225).
           MOVE 'E1'              TO WS-HEXX(226).
           MOVE 'E2'              TO WS-HEXX(227).
           MOVE 'E3'              TO WS-HEXX(228).
           MOVE 'E4'              TO WS-HEXX(229).
           MOVE 'E5'              TO WS-HEXX(230).
           MOVE 'E6'              TO WS-HEXX(231).
           MOVE 'E7'              TO WS-HEXX(232).
           MOVE 'E8'              TO WS-HEXX(233).
           MOVE 'E9'              TO WS-HEXX(234).
           MOVE 'EA'              TO WS-HEXX(235).
           MOVE 'EB'              TO WS-HEXX(236).
           MOVE 'EC'              TO WS-HEXX(237).
           MOVE 'ED'              TO WS-HEXX(238).
           MOVE 'EE'              TO WS-HEXX(239).
           MOVE 'EF'              TO WS-HEXX(240).
           MOVE 'F0'              TO WS-HEXX(241).
           MOVE 'F1'              TO WS-HEXX(242).
           MOVE 'F2'              TO WS-HEXX(243).
           MOVE 'F3'              TO WS-HEXX(244).
           MOVE 'F4'              TO WS-HEXX(245).
           MOVE 'F5'              TO WS-HEXX(246).
           MOVE 'F6'              TO WS-HEXX(247).
           MOVE 'F7'              TO WS-HEXX(248).
           MOVE 'F8'              TO WS-HEXX(249).
           MOVE 'F9'              TO WS-HEXX(250).
           MOVE 'FA'              TO WS-HEXX(251).
           MOVE 'FB'              TO WS-HEXX(252).
           MOVE 'FC'              TO WS-HEXX(253).
           MOVE 'FD'              TO WS-HEXX(254).
           MOVE 'FE'              TO WS-HEXX(255).
           MOVE 'FF'              TO WS-HEXX(256).
      
      *    Fill K's table
           MOVE CNS-K0            TO WS-KS-VAL(01).
           MOVE CNS-K0            TO WS-KS-VAL(02).
           MOVE CNS-K0            TO WS-KS-VAL(03).
           MOVE CNS-K0            TO WS-KS-VAL(04).
           MOVE CNS-K0            TO WS-KS-VAL(05).
           MOVE CNS-K0            TO WS-KS-VAL(06).
           MOVE CNS-K0            TO WS-KS-VAL(07).
           MOVE CNS-K0            TO WS-KS-VAL(08).
           MOVE CNS-K0            TO WS-KS-VAL(09).
           MOVE CNS-K0            TO WS-KS-VAL(10).
           MOVE CNS-K0            TO WS-KS-VAL(11).
           MOVE CNS-K0            TO WS-KS-VAL(12).
           MOVE CNS-K0            TO WS-KS-VAL(13).
           MOVE CNS-K0            TO WS-KS-VAL(14).
           MOVE CNS-K0            TO WS-KS-VAL(15).
           MOVE CNS-K0            TO WS-KS-VAL(16).
           MOVE CNS-K0            TO WS-KS-VAL(17).
           MOVE CNS-K0            TO WS-KS-VAL(18).
           MOVE CNS-K0            TO WS-KS-VAL(19).
           MOVE CNS-K0            TO WS-KS-VAL(20).
           MOVE CNS-K1            TO WS-KS-VAL(21).
           MOVE CNS-K1            TO WS-KS-VAL(22).
           MOVE CNS-K1            TO WS-KS-VAL(23).
           MOVE CNS-K1            TO WS-KS-VAL(24).
           MOVE CNS-K1            TO WS-KS-VAL(25).
           MOVE CNS-K1            TO WS-KS-VAL(26).
           MOVE CNS-K1            TO WS-KS-VAL(27).
           MOVE CNS-K1            TO WS-KS-VAL(28).
           MOVE CNS-K1            TO WS-KS-VAL(29).
           MOVE CNS-K1            TO WS-KS-VAL(30).
           MOVE CNS-K1            TO WS-KS-VAL(31).
           MOVE CNS-K1            TO WS-KS-VAL(32).
           MOVE CNS-K1            TO WS-KS-VAL(33).
           MOVE CNS-K1            TO WS-KS-VAL(34).
           MOVE CNS-K1            TO WS-KS-VAL(35).
           MOVE CNS-K1            TO WS-KS-VAL(36).
           MOVE CNS-K1            TO WS-KS-VAL(37).
           MOVE CNS-K1            TO WS-KS-VAL(38).
           MOVE CNS-K1            TO WS-KS-VAL(39).
           MOVE CNS-K1            TO WS-KS-VAL(40).
           MOVE CNS-K2            TO WS-KS-VAL(41).
           MOVE CNS-K2            TO WS-KS-VAL(42).
           MOVE CNS-K2            TO WS-KS-VAL(43).
           MOVE CNS-K2            TO WS-KS-VAL(44).
           MOVE CNS-K2            TO WS-KS-VAL(45).
           MOVE CNS-K2            TO WS-KS-VAL(46).
           MOVE CNS-K2            TO WS-KS-VAL(47).
           MOVE CNS-K2            TO WS-KS-VAL(48).
           MOVE CNS-K2            TO WS-KS-VAL(49).
           MOVE CNS-K2            TO WS-KS-VAL(50).
           MOVE CNS-K2            TO WS-KS-VAL(51).
           MOVE CNS-K2            TO WS-KS-VAL(52).
           MOVE CNS-K2            TO WS-KS-VAL(53).
           MOVE CNS-K2            TO WS-KS-VAL(54).
           MOVE CNS-K2            TO WS-KS-VAL(55).
           MOVE CNS-K2            TO WS-KS-VAL(56).
           MOVE CNS-K2            TO WS-KS-VAL(57).
           MOVE CNS-K2            TO WS-KS-VAL(58).
           MOVE CNS-K2            TO WS-KS-VAL(59).
           MOVE CNS-K2            TO WS-KS-VAL(60).
           MOVE CNS-K3            TO WS-KS-VAL(61).
           MOVE CNS-K3            TO WS-KS-VAL(62).
           MOVE CNS-K3            TO WS-KS-VAL(63).
           MOVE CNS-K3            TO WS-KS-VAL(64).
           MOVE CNS-K3            TO WS-KS-VAL(65).
           MOVE CNS-K3            TO WS-KS-VAL(66).
           MOVE CNS-K3            TO WS-KS-VAL(67).
           MOVE CNS-K3            TO WS-KS-VAL(68).
           MOVE CNS-K3            TO WS-KS-VAL(69).
           MOVE CNS-K3            TO WS-KS-VAL(70).
           MOVE CNS-K3            TO WS-KS-VAL(71).
           MOVE CNS-K3            TO WS-KS-VAL(72).
           MOVE CNS-K3            TO WS-KS-VAL(73).
           MOVE CNS-K3            TO WS-KS-VAL(74).
           MOVE CNS-K3            TO WS-KS-VAL(75).
           MOVE CNS-K3            TO WS-KS-VAL(76).
           MOVE CNS-K3            TO WS-KS-VAL(77).
           MOVE CNS-K3            TO WS-KS-VAL(78).
           MOVE CNS-K3            TO WS-KS-VAL(79).
           MOVE CNS-K3            TO WS-KS-VAL(80).
