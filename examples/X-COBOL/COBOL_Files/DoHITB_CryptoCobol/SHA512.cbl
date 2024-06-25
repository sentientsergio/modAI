      *****************************************************************
      *                                                               *
      * This software have been developed under GNU GPL v3 License.   *
      *   That means, no closed distribution of this software is      *
      *   allowed.                                                    *
      *                                                               *
      * Please refer to the License text here:                        *
      *   https://www.gnu.org/licenses/gpl-3.0.txt                    *
      *                                                               *
      * Secure Hash Algorithm - 2 (SHA512) COBOL Implementation.      *
      *                                                               *
      * This code was written by David O. Solé González (aka DoHITB). *
      *                                                               *
      * The implementation was made following rfc6234 official text.  *
      * You can find the mentioned rfc on the Internet for free, on   *
      * https://tools.ietf.org/html/rfc6234                           *
      *                                                               *
      * For any comment, suggestion or similar, you can reach me via  *
      * mail on "doscar.sole@gmail.com"                               *
      *                                                               *
      * This version covers SHA-384 and SHA-512 implementations, that *
      * works on 64-bit words (W).                                    *
      *                                                               *
      * Mainline of the algorithm:                                    *
      *  Count the number of bits that compose the file (LRECL=64)    *
      *   (This will be a binary value stored on PIC X(128) variable  *
      *                                                               *
      *  Make padding for the file, as specified on rfc6234:          *
      *    After all data, add a '1', then a number 'K' of 0's that   *
      *    make ( L + 1 + K ) mod 1024 = 896 (where L is the previous *
      *    calculated length).                                        *
      *                                                               *
      *  Perform the hash routine                                     *
      *       For i = 1 to N                                          *
      *         1. Prepare the message schedule W:                    *
      *         2. Initialize the working variables:                  *
      *         3. Perform the main hash computation:                 *
      *         4. Compute the intermediate hash value H(i)           *
      *                                                               *
      *  (Refer to "HASHING" function to see detail, or rfc6234.      *
      *                                                               *
      *  Move the final data to LINKAGE-SECTION.                      *
      *                                                               *
      *  CODING STANDARDS                                             *
      *    - Identation is 2 spaces                                   *
      *    - Destination vars ("TO") goes to column 50, or new line   *
      *    - PIC goes to column 35                                    *
      *    - After a comment block, add an extra * line               *
      *    - Add a blank line between functional groups of variables  *
      *    - Add two blank lines between every 01 group               *
      *    - Try to copy litteraly from rfc6234.                      *
      *                                                               *
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SHA512.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *     LS-FILE-NAME (LRECL=64)
            SELECT R-HASH ASSIGN TO RANDOM CNS-FILE-NAME
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE IS SEQUENTIAL
                   FILE STATUS IS FS-HASH.
                   
      *     LS-FILE-NAME-X (LRECL=64)
            SELECT R-OUT ASSIGN TO RANDOM CNS-FILE-OUT
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS MODE IS SEQUENTIAL
                   FILE STATUS IS FS-OUT.

       DATA DIVISION.
       FILE SECTION.

      *   LS-FILE-NAME
       FD R-HASH LABEL RECORD STANDARD.

       01 HASH.
          05 HCHAR PIC X(08) OCCURS 8.
       
      *   LS-FILE-NAME-X
       FD R-OUT LABEL RECORD STANDARD.

       01 OUT.
          05 HOUT PIC X(08) OCCURS 8.
       
       WORKING-STORAGE SECTION.       
      *Max length of XOR input
       77 CNS-XOR-MAX             PIC 9(02)  VALUE 64.
      
      *Max length of NOT input
       77 CNS-NOT-MAX             PIC 9(02)  VALUE 64.
      
      *Max length of AND input
       77 CNS-AND-MAX             PIC 9(02)  VALUE 64.
      
      *Max length of OR input
       77 CNS-OR-MAX              PIC 9(02)  VALUE 64.
       
      *Max length of SUM input
       77 CNS-SUM-MAX             PIC 9(02)  VALUE 64.
       
      *Max length of SL input
       77 CNS-SL-MAX              PIC 9(02)  VALUE 64.
       
      *Max length of RS input
       77 CNS-RS-MAX              PIC 9(02)  VALUE 64.
				 
      *Input file name
       77 CNS-FILE-NAME           PIC X(08).
       
      *Output fule name
       77 CNS-FILE-OUT            PIC X(08).
       
      *Hex calculation
       77 CNS-B1                  PIC 9(01)  VALUE 1.
       77 CNS-B2                  PIC 9(02)  VALUE 2.
       77 CNS-B3                  PIC 9(02)  VALUE 4.
       77 CNS-B4                  PIC 9(02)  VALUE 8.
       
      *Version audit
       01 VERSION.
          05 VERSION-MAJOR        PIC 9(02).
          05 FILLER               PIC X(01) VALUE '.'.
          05 VERSION-MINOR        PIC 9(02).
          05 FILLER               PIC X(01) VALUE '.'.
          05 VERSION-HOTFIX       PIC 9(03).


       01 FILE-STATUS.
      *      Input file File-Status
          05 FS-HASH              PIC 9(02) VALUE ZEROES.
             88 FS-HASH-OK                  VALUE ZEROES.
             88 FS-HASH-EOF                 VALUE 10.
      *      Output file File-Status
          05 FS-OUT               PIC 9(02) VALUE ZEROES.
             88 FS-OUT-OK                   VALUE ZEROES.
             88 FS-OUT-EOF                  VALUE 10.

       01 WS-VAR.
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
          05 WS-RS-INDEX-1        PIC 9(02) VALUE ZEROES.
          05 WS-RS-INDEX-2        PIC 9(02) VALUE ZEROES.
          
      *   File variables
          05 WS-FL-INDEX          PIC 9(01) VALUE ZEROES.
          05 WS-FL-ICHAR-I        PIC 9(01) VALUE ZEROES.
          05 WS-FL-ICHAR-FULL     PIC X(08).
          05 WS-FL-ICHAR          REDEFINES WS-FL-ICHAR-FULL
                                  PIC X(01) OCCURS 8.
          05 WS-FL-OFFSET         PIC 9(02) VALUE ZEROES.
          05 WS-FL-OFFSET-X       PIC X(08) VALUE SPACES.
          05 WS-FL-OFFSET-B       REDEFINES WS-FL-OFFSET-X
                                  OCCURS 8 PIC X(01).
      
      *   HEX2BIN conversion
          05 WS-HEX-VAL-1         PIC 9(02).
          05 WS-HEX-VAL-2         PIC 9(02).
          05 WS-BIN-VAL.
             10 WS-BIN-VAL-1      PIC X(04).
             10 WS-BIN-VAL-2      PIC X(04).
          05 WS-BIN-VAL-X         REDEFINES WS-BIN-VAL
                                  OCCURS 8 PIC 9(01).
          05 WS-BIN-BYTE-FULL.
              10 WS-BIN-BYTE      OCCURS 4   PIC 9(01).
      
      *   XOR keys & values
          05 WS-XOR-KEY-1         PIC X(64) VALUE SPACES.
          05 WS-XOR-KEY-1-X       REDEFINES WS-XOR-KEY-1
                                  OCCURS 64 PIC 9(01).
          05 WS-XOR-KEY-2         PIC X(64) VALUE SPACES.
          05 WS-XOR-KEY-2-X       REDEFINES WS-XOR-KEY-2
                                  OCCURS 64 PIC 9(01).
          05 WS-XOR-RESULT        PIC X(64) VALUE SPACES.
          05 WS-XOR-RESULT-X      REDEFINES WS-XOR-RESULT
                                  OCCURS 64 PIC X(01).
      
      *   NOT keys & values
          05 WS-NOT-KEY           PIC X(64) VALUE SPACES.
          05 WS-NOT-KEY-X         REDEFINES WS-NOT-KEY
                                  OCCURS 64 PIC X(01).
          05 WS-NOT-RESULT        PIC X(64) VALUE SPACES.
          05 WS-NOT-RESULT-X      REDEFINES WS-NOT-RESULT
                                  OCCURS 64 PIC X(01).
      
      *   OR keys & values
          05 WS-OR-KEY-1          PIC X(64) VALUE SPACES.
          05 WS-OR-KEY-1-X        REDEFINES WS-OR-KEY-1
                                  OCCURS 64 PIC 9(01).
          05 WS-OR-KEY-2          PIC X(64) VALUE SPACES.
          05 WS-OR-KEY-2-X        REDEFINES WS-OR-KEY-2
                                  OCCURS 64 PIC 9(01).
          05 WS-OR-RESULT         PIC X(65) VALUE SPACES.
          05 WS-OR-RESULT-X       REDEFINES WS-OR-RESULT
                                  OCCURS 65 PIC X(01).
      
      *   AND keys & values
          05 WS-AND-KEY-1         PIC X(64) VALUE SPACES.
          05 WS-AND-KEY-1-X       REDEFINES WS-AND-KEY-1
                                  OCCURS 64 PIC 9(01).
          05 WS-AND-KEY-2         PIC X(64) VALUE SPACES.
          05 WS-AND-KEY-2-X       REDEFINES WS-AND-KEY-2
                                  OCCURS 64 PIC 9(01).
          05 WS-AND-RESULT        PIC X(64) VALUE SPACES.
          05 WS-AND-RESULT-X      REDEFINES WS-AND-RESULT
                                  OCCURS 64 PIC X(01). 
          05 WS-AND-RESULT-1      PIC X(64) VALUE SPACES.
          05 WS-AND-RESULT-2      PIC X(64) VALUE SPACES.
          05 WS-AND-RESULT-3      PIC X(64) VALUE SPACES.
          
      *   SUM keys & values
          05 WS-SUM-KEY-1         PIC X(64) VALUE SPACES.
          05 WS-SUM-KEY-1-X       REDEFINES WS-SUM-KEY-1
                                  OCCURS 64 PIC 9(01).
          05 WS-SUM-KEY-2         PIC X(64) VALUE SPACES.
          05 WS-SUM-KEY-2-X       REDEFINES WS-SUM-KEY-2
                                  OCCURS 64 PIC 9(01).
          05 WS-SUM-RESULT        PIC X(64) VALUE SPACES.
          05 WS-SUM-RESULT-X      REDEFINES WS-SUM-RESULT
                                  OCCURS 64 PIC X(01). 
          05 WS-SUM-RESULT-1      PIC X(64) VALUE SPACES.
          05 WS-SUM-RESULT-2      PIC X(64) VALUE SPACES.
          05 WS-SUM-RESULT-3      PIC X(64) VALUE SPACES.
          
      *   S^l and R^l keys & values
          05 WS-SL-KEY            PIC X(64) VALUE SPACES.
          05 WS-SL-KEY-X          REDEFINES WS-SL-KEY
                                  OCCURS 64 PIC X(01).
          05 WS-SL-RESULT         PIC X(64) VALUE SPACES.
          05 WS-SL-RESULT-X       REDEFINES WS-SL-RESULT
                                  OCCURS 64 PIC X(01).
                                  
      *   x>>n keys & values
          05 WS-RS-KEY            PIC X(64) VALUE SPACES.
          05 WS-RS-KEY-X          REDEFINES WS-RS-KEY
                                  OCCURS 64 PIC X(01).
          05 WS-RS-RESULT         PIC X(64) VALUE SPACES.
          05 WS-RS-RESULT-X       REDEFINES WS-RS-RESULT
                                  OCCURS 64 PIC X(01).
          
      *   128-bit final padding
          05 WS-PADDING-KEY       PIC X(128) VALUE SPACES.
          05 WS-PADDING-KEY-X     REDEFINES WS-PADDING-KEY
                                  OCCURS 128 PIC X(01).
          05 WS-PADDING-KEY-9     REDEFINES WS-PADDING-KEY
                                  OCCURS 128 PIC 9(01).
          05 WS-PADDING-64        REDEFINES WS-PADDING-KEY
                                  OCCURS 2 PIC X(64).
      *   K and L calculation
          05 WS-L-VAL             PIC 9(04) VALUE ZEROES.
          05 WS-K-VAL             PIC 9(04) VALUE ZEROES.
          05 WS-X-VAL             PIC 9(04) VALUE ZEROES.
          
      *   Padding calculation
          05 WS-P1-RAW.
             10 WS-P1             OCCURS 64 PIC 9(01).
          05 WS-P1-BLOCK          REDEFINES WS-P1-RAW.
             10 WS-P1-B           OCCURS 8  PIC X(08).
          05 WS-P2-RAW.
             10 WS-P2             OCCURS 64 PIC 9(01).
          05 WS-P2-BLOCK          REDEFINES WS-P2-RAW.
             10 WS-P2-B           OCCURS 8 PIC X(08).
          05 WS-P1-IDX            PIC 9(02) VALUE ZEROES.
          05 WS-P2-IDX            PIC 9(02) VALUE ZEROES.
          05 WS-PADDING-IDX       PIC 9(04) VALUE ZEROES.
          05 WS-K-BLOCKS          PIC 9(04) VALUE ZEROES.
          
      *   Functions variables
          05 WS-X                 PIC X(64) VALUE SPACES.
          05 WS-X-S               REDEFINES WS-X
                                  OCCURS 64 PIC X(01).
          05 WS-Y                 PIC X(64) VALUE SPACES.
          05 WS-Y-S               REDEFINES WS-Y
                                  OCCURS 64 PIC X(01).
          05 WS-Z                 PIC X(64) VALUE SPACES.
          05 WS-Z-S               REDEFINES WS-Z
                                  OCCURS 64 PIC X(01).
          05 WS-R                 PIC X(64) VALUE SPACES.
          05 WS-R-S               REDEFINES WS-R
                                  OCCURS 64 PIC X(01).
                                  
      *   Hashing variables
      *      M
          05 WS-M                 OCCURS 16 PIC X(64).
          05 WS-MI                PIC 9(02).
      *      W
          05 WS-W                 OCCURS 80 PIC X(64).
          05 WS-WI                PIC 9(02).
      *      H (Current)
          05 WS-HC                OCCURS 8.
             10 WS-HC1            PIC X(32).
             10 WS-HC2            PIC X(32).
          05 WS-HI                PIC 9(02).
      *      H (Previous)
          05 WS-HP                OCCURS 8.
             10 WS-HP1            PIC X(32).
             10 WS-HP2            PIC X(32).
          05 WS-HI                PIC 9(02).
      *      A, B, C, D, E, F, G, H
          05 WS-A                 PIC X(64).
          05 WS-B                 PIC X(64).
          05 WS-C                 PIC X(64).
          05 WS-D                 PIC X(64).
          05 WS-E                 PIC X(64).
          05 WS-F                 PIC X(64).
          05 WS-G                 PIC X(64).
          05 WS-H                 PIC X(64).
      *      T1, T2
          05 WS-T1                PIC X(64).
          05 WS-T2                PIC X(64).
      *      Hash count
          05 WS-T                 PIC 9(02).
          
      *   Translation to final hash
          05 WS-HAUX-IN           PIC X(64).
          05 WS-HAUX-IN-B         REDEFINES WS-HAUX-IN
                                  OCCURS 16 PIC X(04).
          05 WS-HAUX-OUT          PIC X(16).
          05 WS-HAUX-OUT-H        REDEFINES WS-HAUX-OUT
                                  OCCURS 16 PIC X(01).
          05 WS-CI                PIC 9(02) VALUE ZEROES.
          05 WS-CJ                PIC 9(02) VALUE ZEROES.


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
           05 SW-HASH-EOF         PIC 9(01) VALUE ZEROES.
               88 SW-HASH-EOF-F             VALUE ZEROES.
               88 SW-HASH-EOF-T             VALUE 1. 
           05 SW-OUT-EOF          PIC 9(01) VALUE ZEROES.
               88 SW-OUT-EOF-F              VALUE ZEROES.
               88 SW-OUT-EOF-T              VALUE 1. 
           05 SW-FILE-ZERO        PIC 9(01) VALUE ZEROES.
               88 SW-FILE-ZERO-F            VALUE ZEROES.
               88 SW-FILE-ZERO-T            VALUE 1.
               

      *   DO NOT INITIALIZE THIS VALUES!
       01 WS-TABLE.
      *   Data beacon
          05 WS-BEACON            PIC X(01) VALUE SPACES.
          
      *   HEX2BIN
          05 WS-HEX2BIN-INDEX     PIC 9(02) VALUE ZEROES.
          05 WS-HEX-KEY           PIC X(01) VALUE SPACES.
          05 WS-BIN-KEY           PIC X(04) VALUE SPACES.
          05 WS-HEX2BIN           OCCURS 16.
              10 WS-HEX           PIC X(01) VALUE SPACES.
              10 WS-BIN           PIC X(04) VALUE SPACES.

      *   K's TABLE (READONLY)
          05 WS-KS                OCCURS 80.
              10 WS-KS-VAL        PIC X(64) VALUE SPACES.
              10 WS-KS-BIN        REDEFINES WS-KS-VAL.
                 15 WS-KS-BIN-1   PIC X(32).
                 15 WS-KS-BIN-2   PIC X(32).
      
      *   DEBUGGING
       01 TEMP-LINK.
          05 LS-FILE-NAME         PIC X(08) VALUE 'TEST    '.        
          05 LS-OUTPUT.
             10 LS-OUT            OCCURS 8.
                15 LS-OUT-OCC     PIC X(16).
              
              
      *LINKAGE SECTION.
      *  01 LS-SECTION.
      *     05 LS-FILE-NAME       PIC X(08).
      *     05 LS-OUTPUT.
      *        10 LS-OUT          OCCURS 8.
      *           15 LS-OUT-OCC   PIC X(64).
      
      *PROCEDURE DIVISION USING LS-SECTION.
       PROCEDURE DIVISION.
       MAINLINE.
      *****************************************************************
      *    P A D D I N G   S E C T I O N   I N I                      *
      *****************************************************************
           INITIALIZE VERSION
                      FILE-STATUS
                      WS-VAR
                      WS-SWITCH.
      
      *    Version audit data. Modify after each modification
      *
           MOVE 1                                TO VERSION-MAJOR.
           MOVE 0                                TO VERSION-MINOR.
           MOVE 0                                TO VERSION-HOTFIX.
      
           DISPLAY 'SHA-512 Hasing - Made By DoHITB'.
           DISPLAY '  Version: ' VERSION.
           DISPLAY SPACE.
      
      *    Fill initial data
      *
           IF WS-BEACON = 'B'
             CONTINUE
           ELSE
             PERFORM FILL-TABLES
           END-IF
       
      *    DEBUGGING
           MOVE LS-FILE-NAME                    TO CNS-FILE-NAME.
           OPEN OUTPUT R-HASH.

      *         abcde text
           MOVE '00000000'                      TO HCHAR(1).
           MOVE '00000000'                      TO HCHAR(2).
           MOVE '00000000'                      TO HCHAR(3).
           MOVE '01100001'                      TO HCHAR(4).
           MOVE '01100010'                      TO HCHAR(5).
           MOVE '01100011'                      TO HCHAR(6).
           MOVE '01100100'                      TO HCHAR(7).
           MOVE '01100101'                      TO HCHAR(8).

           WRITE HASH.
           CLOSE R-HASH.

      *    To padd the message we need to calculate the length of the 
      *    message
      *
           PERFORM COUNT-BITS.
           
      *    Once we have correct values for L and K, it's time to make
      *    the padding
           PERFORM MAKE-PADDING.
      *****************************************************************
      *    P A D D I N G   S E C T I O N   E N D                      *
      *****************************************************************
      *****************************************************************
      *    H A S H I N G   S E C T I O N   I N I                      *
      *****************************************************************
           PERFORM HASHING.
      *****************************************************************
      *    H A S H I N G   S E C T I O N   E N D                      *
      *****************************************************************
     
      *****************************************************************
      *    F I N A L   T R A N S L A T I O N                          *
      *****************************************************************
      *    As specified on rfc6234:       
      *      After the above computations have been sequentially 
      *      performed for all of the blocks in the message, the final
      *      output is calculated. For SHA-512, this is the 
      *      concatenation of all of H(N)0, H(N)1, through H(N)7.
      *
      
      *    We move each HC(i) 64-bit blocks to LS-OUT-OCC, but first
      *    we need to convert from BIN to HEX.
      * 
           PERFORM VARYING WS-CI FROM 1 BY 1
           UNTIL WS-CI > 8
      *      Move each HC(i) to aux structure
      *
             MOVE WS-HC(WS-CI)                   TO WS-HAUX-IN
      
             PERFORM VARYING WS-CJ FROM 1 BY 1
             UNTIL WS-CJ > 16
      *        Iterate over each 4-bit to translate to HEX
      *
               MOVE WS-HAUX-IN-B(WS-CJ)          TO WS-BIN-KEY
               
               PERFORM BIN2HEX

               MOVE WS-HEX-KEY                   
               TO WS-HAUX-OUT-H(WS-CJ)
             END-PERFORM

      *      Move HOUT to corresponding LS-OUT-OCC
      *
             MOVE WS-HAUX-OUT                    TO LS-OUT-OCC(WS-CI)
           END-PERFORM.
           
           DISPLAY 'Result: ' LS-OUTPUT.
           DISPLAY SPACE.
           
           STOP RUN.
         
		 
      *****************************************************************
      *    P A D D I N G   F U N C T I O N S                          *
      *****************************************************************
      *****************************************************************
       COUNT-BITS.
      *****************************************************************
      *    How it works:
      *      Open file LS-FILE-NAME, and read it to EOF.
      *      For each read character, increase WS-PADDING-KEY.
      *    We will treat LS-FILE-NAME as binary content.
      *
      
      *    First, open file and check for errors
           PERFORM OPEN-HASH.
    
      *    Make first read
           PERFORM READ-HASH.
           
      *    This switch will activate once found the first non-0 bit
           SET SW-FILE-ZERO-F                    TO TRUE.
           
      *    Initialize padding data
           MOVE ALL '0'                          TO WS-PADDING-KEY.
           
      *    Unitil EOF, count and read
           PERFORM UNTIL SW-HASH-EOF-T
             PERFORM ADD-DATA

             PERFORM READ-HASH
           END-PERFORM.
           
      *    Close the file as we ended by now
           PERFORM CLOSE-HASH.
           
      *    On this point, WS-PADDING-KEY have the binary value of L
      *    Now we have to calculate ( L + 1 + K ) mod 1024 = 896
      *
      *    To achieve this, the best to do it is to keep subtracting
      *    1024 for WS-PADDING-KEY each time until 
      *    WS-PADDING-KEY < 1024 and then just calculate
      *    ( L + 1 + K ) mod 1024 = 896. (if L > 896).
      *
      *    As we're working on a 2^n mod, we can just truncate the data
      *    and assume it as modulus
      *
      
      *    First of all, convert WS-PADDING from binary to decimal
      *    modulus 1024
      *
           COMPUTE WS-L-VAL = WS-PADDING-KEY-9(128) *   1 + 
                              WS-PADDING-KEY-9(127) *   2 +
                              WS-PADDING-KEY-9(126) *   4 +
                              WS-PADDING-KEY-9(125) *   8 +
                              WS-PADDING-KEY-9(124) *  16 +
                              WS-PADDING-KEY-9(123) *  32 +
                              WS-PADDING-KEY-9(122) *  64 +
                              WS-PADDING-KEY-9(121) * 128 +
                              WS-PADDING-KEY-9(120) * 256 +
                              WS-PADDING-KEY-9(119) * 512.

      *    L + 1
           ADD 1                                 TO WS-L-VAL.
           
      *    If L > 896, just add 1024 to make it modulus-like
      *
           MOVE 896                              TO WS-X-VAL
           
           IF WS-L-VAL > 896
             ADD 1024                            TO WS-X-VAL
           END-IF.
           
           SUBTRACT WS-X-VAL                   FROM WS-L-VAL
                                             GIVING WS-K-VAL.   

           ADD 1                                 TO WS-K-VAL.


      *****************************************************************
       ADD-DATA.
      *****************************************************************
      *    How it works:
      *      For each HCHAR, search for the first non-zero data.
      *      If non-zero data is not found, add 64; else add custom.
      *
      
      *    As on any read SW-FILE-ZERO-T can be TRUE, we have to
      *    manually initialize the vaules before each perform.
      *
           MOVE 1                                TO WS-FL-INDEX
                                                    WS-FL-ICHAR-I
                                                    
           PERFORM VARYING WS-FL-INDEX FROM 1 BY 1
           UNTIL WS-FL-INDEX > 8 OR
                 SW-FILE-ZERO-T
      *      Get each 8-bit string from HCHAR
             MOVE HCHAR(WS-FL-INDEX)             TO WS-FL-ICHAR-FULL
             
             PERFORM VARYING WS-FL-ICHAR-I FROM 1 BY 1
             UNTIL WS-FL-ICHAR-I > 8 OR
                   SW-FILE-ZERO-T
      *        Check for non-0 bit
               IF WS-FL-ICHAR(WS-FL-ICHAR-I) = '1'
                 SET SW-FILE-ZERO-T              TO TRUE
               END-IF
             END-PERFORM
           END-PERFORM.
           
           IF SW-FILE-ZERO-F
      *      All 64-bits were 0
             MOVE 0                              TO WS-FL-OFFSET
           ELSE
      *      The first non-0 digit has been found. We will add
      *      64 - (WS-FL-INDEX - 1) * 8 + (WS-FL-ICHAR-I - 1)
      *
             SUBTRACT 1                        FROM WS-FL-INDEX
             MOVE 0                              TO WS-FL-ICHAR-I 

             MOVE WS-FL-INDEX                    TO WS-FL-OFFSET
             SUBTRACT 1                        FROM WS-FL-OFFSET
             MULTIPLY 8                          BY WS-FL-OFFSET
             ADD WS-FL-ICHAR-I                   TO WS-FL-OFFSET
             SUBTRACT 64                       FROM WS-FL-OFFSET
           END-IF.
           
           PERFORM COUNT-DATA.
           
      *****************************************************************
       COUNT-DATA.
      *****************************************************************
      *    It will convert WS-FL-OFFSET to bin value then add it to the
      *    main counter.
      *
           DIVIDE 16                           INTO WS-FL-OFFSET
                                             GIVING WS-HEX-VAL-1
                                          REMAINDER WS-HEX-VAL-2.
                                       
      *    First hex digit                                       
           MOVE WS-HEX-VAL-1                     TO WS-HEX2BIN-INDEX.
           PERFORM BINVALUE.
           MOVE WS-BIN-KEY                       TO WS-BIN-VAL-1.
           
      *    Second hex digit
           MOVE WS-HEX-VAL-2                     TO WS-HEX2BIN-INDEX.
           PERFORM BINVALUE.
           MOVE WS-BIN-KEY                       TO WS-BIN-VAL-2.

      *    Now on WS-BIN-VAL we have the bin repr. of WS-FL-OFFSET.
      *    We add WS-BIN-VAL to the value we already have.
      *
      *    CAUTION: We're using SUM variables!
           SET SW-ACC-FALSE                      TO TRUE

      *    First, we will add the last 8 bits of PADDING-KEY
      *    to WS-BIN-VAL
      *
           PERFORM VARYING WS-SUM-INDEX FROM 1 BY 1
           UNTIL WS-SUM-INDEX > 8
             MOVE WS-PADDING-KEY-X(129 - WS-SUM-INDEX)
               TO SW-SUM

             ADD  WS-BIN-VAL-X(9 - WS-SUM-INDEX)
              TO  SW-SUM

             IF SW-ACC-TRUE
               ADD 1                             TO SW-SUM
               SET SW-ACC-FALSE                  TO TRUE
             END-IF

             IF SW-ACC-ON
               IF SW-SUM = 2
                 MOVE '0'
                   TO WS-PADDING-KEY-X(129 - WS-SUM-INDEX)
               ELSE
                 MOVE '1'
                   TO WS-PADDING-KEY-X(129 - WS-SUM-INDEX)
               END-IF
             ELSE
               MOVE SW-SUM
                 TO WS-PADDING-KEY-X(129 - WS-SUM-INDEX)

               SET  SW-ACC-FALSE                 TO TRUE
             END-IF
           END-PERFORM.
      
      *    For this scenario, if there's carry, we need to treat it
      *
           IF SW-ACC-TRUE          
             PERFORM VARYING WS-SUM-INDEX FROM 9 BY 1
             UNTIL WS-SUM-INDEX > 128 OR
                   SW-ACC-FALSE
               MOVE WS-PADDING-KEY-X(129 - WS-SUM-INDEX) 
               TO SW-SUM
               
               IF SW-ACC-TRUE
                 ADD 1                           TO SW-SUM
                 SET SW-ACC-FALSE                TO TRUE
               END-IF
             
               IF SW-ACC-ON
                 IF SW-SUM = 2
                   MOVE '0'                    
                   TO WS-PADDING-KEY-X(WS-SUM-INDEX)
                 ELSE
                   MOVE '1'                   
                   TO WS-PADDING-KEY-X(WS-SUM-INDEX)
                 END-IF
      
                 SET SW-ACC-TRUE                 TO TRUE
               ELSE
                 MOVE SW-SUM                       
                 TO WS-PADDING-KEY-X(WS-SUM-INDEX)
                 
                 SET SW-ACC-FALSE                TO TRUE
               END-IF
             END-PERFORM
           END-IF.

      
      *****************************************************************
       MAKE-PADDING.
      *****************************************************************
      *    It will open the original file, and wirte it elsewhere, with
      *    new information (padding).
      *
      
      *    We're searching for the first non-0 value
           SET SW-FILE-ZERO-F                    TO TRUE
           MOVE 1                                TO WS-P2-IDX
      
      *    First, open both files
           PERFORM OPEN-HASH.
           PERFORM OPEN-OUT.
           
      *    Then, copy HASH to OUT
           PERFORM READ-HASH.
           
           PERFORM UNTIL SW-HASH-EOF-T
      *       Move all 64-bits to RAW structure
              MOVE HASH                          TO WS-P1-RAW
              
              PERFORM VARYING WS-P1-IDX FROM 1 BY 1
              UNTIL WS-P1-IDX > 8
      *         If there's still no data, just keep going
      *
                IF SW-FILE-ZERO-F
                  IF WS-P1-B(WS-P1-IDX) = '00000000'
                    CONTINUE
                  ELSE
                    SET SW-FILE-ZERO-T           TO TRUE
                    MOVE WS-P1-B(WS-P1-IDX)      TO WS-P2-B(WS-P2-IDX)
                    
                    ADD 1                        TO WS-P2-IDX
                  END-IF
                ELSE
                  MOVE WS-P1-B(WS-P1-IDX)        TO WS-P2-B(WS-P2-IDX)
                    
                  ADD 1                          TO WS-P2-IDX
                END-IF
                
                IF WS-P2-IDX > 8
                  MOVE WS-P2-RAW                 TO OUT
                  MOVE 1                         TO WS-P2-IDX
                  
                  PERFORM WRITE-OUT
                END-IF
              END-PERFORM
           
             PERFORM READ-HASH
           END-PERFORM.
           
      *    Once the file is copied, it's time for the padding
      *
      *    Get the number of blocks that are going to being writted.
      *    As WS-K-VAL is pre-calculated following RFC, it will be
      *    divisible by 8.
      *
           DIVIDE 8                             INTO WS-K-VAL
           GIVING WS-K-BLOCKS.

           SUBTRACT 8                           FROM WS-K-BLOCKS.

      *    First block is special as it has a '1' on first position
           MOVE '10000000'                        TO WS-P2-B(WS-P2-IDX).
           ADD 1                                  TO WS-P2-IDX.

           IF WS-P2-IDX > 8
             MOVE WS-P2-RAW                        TO OUT
             MOVE 1                                TO WS-P2-IDX

             PERFORM WRITE-OUT
           END-IF.

      *    Then, the rest of the blocks
           SUBTRACT 1                            FROM WS-K-BLOCKS.

           PERFORM WS-K-BLOCKS TIMES
             MOVE '00000000'                       TO WS-P2-B(WS-P2-IDX)
             ADD 1                                 TO WS-P2-IDX

             IF WS-P2-IDX > 8
               MOVE WS-P2-RAW                      TO OUT
               MOVE 1                              TO WS-P2-IDX 

               PERFORM WRITE-OUT
             END-IF
           END-PERFORM.

      *    If everything is OK, all the 64-bit buffer will be full,
      *    As K mod 16 = 0, and we will write a number of bits
      *    that is congruent with 16
      *
           PERFORM WRITE-OUT.
           
      *    Finally, write the 128-bit representation of L
           MOVE WS-PADDING-64(1)                 TO OUT.
           PERFORM WRITE-OUT.

           MOVE WS-PADDING-64(2)                 TO OUT.
           PERFORM WRITE-OUT.                 
           
      *    Don't forget to close both files
           PERFORM CLOSE-HASH.
           PERFORM CLOSE-OUT.

			
      *****************************************************************
      *    H A S H I N G   F U N C T I O N S                          *
      *****************************************************************
      *****************************************************************
       HASHING.
      *****************************************************************
      *    As specified on rfc6234:
      *
      *      For i = 1 to N
      *        1. Prepare the message schedule W:
      *          For t = 0 to 15
      *            Wt = M(i)t
      *          For t = 16 to 79
      *            Wt = SSIG1(W(t-2))+W(t-7)+SSIG0(W(t-15))+W(t-16)
      *      
      *        2. Initialize the working variables:
      *          a = H(i-1)0
      *          b = H(i-1)1
      *          c = H(i-1)2
      *          d = H(i-1)3
      *          e = H(i-1)4
      *          f = H(i-1)5
      *          g = H(i-1)6
      *          h = H(i-1)7
      *      
      *        3. Perform the main hash computation:
      *          For t = 0 to 79
      *            T1 = h + BSIG1(e) + CH(e,f,g) + Kt + Wt
      *            T2 = BSIG0(a) + MAJ(a,b,c)
      *            h = g
      *            g = f
      *            f = e
      *            e = d + T1
      *            d = c
      *            c = b
      *            b = a
      *            a = T1 + T2
      *      
      *        4. Compute the intermediate hash value H(i)
      *          H(i)0 = a + H(i-1)0
      *          H(i)1 = b + H(i-1)1
      *          H(i)2 = c + H(i-1)2
      *          H(i)3 = d + H(i-1)3
      *          H(i)4 = e + H(i-1)4
      *          H(i)5 = f + H(i-1)5
      *          H(i)6 = g + H(i-1)6
      *          H(i)7 = h + H(i-1)7
      *
      *    As index "i" is only being used to refer "i" and "i-1", is
      *    not needed to hold a counter for "i". We will just hold
      *    "H(i)" and "H(i-1)".
      *
      *    Each point (1), (2), (3), and (4) will be treated on 
      *    separated functions called sequentially.
      *
      *    (rfc6234: All addition is performed modulo 2^64.)
      *
      
      *    First of all, open the output file PERFORM OPEN-OUT.
           PERFORM OPEN-OUT-R.

      *    Then, initialize "H"
           PERFORM INIT-H.

      *    Until we reach EOF, keep doing
           PERFORM UNTIL SW-OUT-EOF-T
      *      Read the first 16 rows and store it on "M"
             PERFORM READ-OUT-M
             
             IF SW-OUT-EOF-T
      *        If there's EOF means that we treated all file
               CONTINUE
             ELSE
      *        1. Prepare the message schedule W
               PERFORM SCHEDULE
             
      *        2. Initialize the working variables
               PERFORM H-MOVE
             
      *        3. Perform the main hash computation
               PERFORM MAIN-HASH
             
      *        4. Compute the intermediate hash value H(i)
               PERFORM INT-HASH
             END-IF
           END-PERFORM.

           PERFORM CLOSE-OUT.


      *****************************************************************
       INIT-H.
      *****************************************************************
      *    It will perform the initial value assignation to H values
      *
           MOVE '01101010000010011110011001100111' TO WS-HP1(01).
           MOVE '11110011101111001100100100001000' TO WS-HP2(01).
           
           MOVE '10111011011001111010111010000101' TO WS-HP1(02).
           MOVE '10000100110010101010011100111011' TO WS-HP2(02).
           
           MOVE '00111100011011101111001101110010' TO WS-HP1(03).
           MOVE '11111110100101001111100000101011' TO WS-HP2(03).
           
           MOVE '10100101010011111111010100111010' TO WS-HP1(04).
           MOVE '01011111000111010011011011110001' TO WS-HP2(04).
           
           MOVE '01010001000011100101001001111111' TO WS-HP1(05).
           MOVE '10101101111001101000001011010001' TO WS-HP2(05).
           
           MOVE '10011011000001010110100010001100' TO WS-HP1(06).
           MOVE '00101011001111100110110000011111' TO WS-HP2(06).
           
           MOVE '00011111100000111101100110101011' TO WS-HP1(07).
           MOVE '11111011010000011011110101101011' TO WS-HP2(07).
           
           MOVE '01011011111000001100110100011001' TO WS-HP1(08).
           MOVE '00010011011111100010000101111001' TO WS-HP2(08).

      *****************************************************************
       SCHEDULE.
      *****************************************************************
      *    As specified on rfc6234:
      *      1. Prepare the message schedule W:
      *        For t = 0 to 15
      *          Wt = M(i)t
      *        For t = 16 to 79
      *          Wt = SSIG1(W(t-2))+W(t-7)+SSIG0(W(t-15))+W(t-16)
      *
      
      *    The 16 first values of W corresponds to it's relative M.
           MOVE WS-M(01)                         TO WS-W(01).
           MOVE WS-M(02)                         TO WS-W(02).
           MOVE WS-M(03)                         TO WS-W(03).
           MOVE WS-M(04)                         TO WS-W(04).
           MOVE WS-M(05)                         TO WS-W(05).
           MOVE WS-M(06)                         TO WS-W(06).
           MOVE WS-M(07)                         TO WS-W(07).
           MOVE WS-M(08)                         TO WS-W(08).
           MOVE WS-M(09)                         TO WS-W(09).
           MOVE WS-M(10)                         TO WS-W(10).
           MOVE WS-M(11)                         TO WS-W(11).
           MOVE WS-M(12)                         TO WS-W(12).
           MOVE WS-M(13)                         TO WS-W(13).
           MOVE WS-M(14)                         TO WS-W(14).
           MOVE WS-M(15)                         TO WS-W(15).
           MOVE WS-M(16)                         TO WS-W(16).

      *    We start at 17, as COBOL indexes starts by 1 instead of 0.
           PERFORM VARYING WS-WI FROM 17 BY 1
           UNTIL WS-WI > 80
      *      Wt = SSIG1(W(t-2)) + W(t-7) + SSIG0(W(t-15)) + W(t-16)
      *      Wt = SSIG1(W(t-2))
             MOVE WS-W(WS-WI - 2)                TO WS-X

             PERFORM F-SSIG1
             
             MOVE WS-R                           TO WS-W(WS-WI)

      *      Wt = Wt + W(t - 7)
             MOVE WS-W(WS-WI)                    TO WS-SUM-KEY-1
             MOVE WS-W(WS-WI - 7)                TO WS-SUM-KEY-2

             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-W(WS-WI)

      *      Wt = Wt + SSIG0(W(t - 15))
             MOVE WS-W(WS-WI - 15)               TO WS-X

             PERFORM F-SSIG0

             MOVE WS-W(WS-WI)                    TO WS-SUM-KEY-1
             MOVE WS-R                           TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-W(WS-WI)

      *      Wt = Wt + W(t - 16)     
             MOVE WS-W(WS-WI)                    TO WS-SUM-KEY-1
             MOVE WS-W(WS-WI - 16)               TO WS-SUM-KEY-2

             PERFORM F-SUM

             MOVE WS-SUM-RESULT                  TO WS-W(WS-WI)             
           END-PERFORM.
      
      *****************************************************************
       H-MOVE.
      *****************************************************************
      *    As specified on rfc6234:
      *      2. Initialize the working variables:
      *        a = H(i-1)0  (subscript 1)
      *        b = H(i-1)1  (subscript 2)
      *        c = H(i-1)2  (subscript 3)
      *        d = H(i-1)3  (subscript 4)
      *        e = H(i-1)4  (subscript 5)
      *        f = H(i-1)5  (subscript 6)
      *        g = H(i-1)6  (subscript 7)
      *        h = H(i-1)7  (subscript 8)
      *
           MOVE WS-HP(1)                         TO WS-A.
           MOVE WS-HP(2)                         TO WS-B.
           MOVE WS-HP(3)                         TO WS-C.
           MOVE WS-HP(4)                         TO WS-D.
           MOVE WS-HP(5)                         TO WS-E.
           MOVE WS-HP(6)                         TO WS-F.
           MOVE WS-HP(7)                         TO WS-G.
           MOVE WS-HP(8)                         TO WS-H.

      
      *****************************************************************
       MAIN-HASH.
      *****************************************************************
      *    As specified on rfc6234:
      *      3. Perform the main hash computation:
      *        For t = 0 to 79
      *          T1 = h + BSIG1(e) + CH(e,f,g) + Kt + Wt
      *          T2 = BSIG0(a) + MAJ(a,b,c)
      *          h = g
      *          g = f
      *          f = e
      *          e = d + T1
      *          d = c
      *          c = b
      *          b = a
      *          a = T1 + T2
      *
      
           PERFORM VARYING WS-T FROM 1 BY 1
           UNTIL WS-T > 80
      *      T1 = h + BSIG1(e) + CH(e,f,g) + Kt + Wt
      *      T1 = h
             MOVE WS-H                           TO WS-T1
      
      *      T1 = T1 + BSIG1(e)
             MOVE WS-E                           TO WS-X
             
             PERFORM F-BSIG1

             MOVE WS-T1                          TO WS-SUM-KEY-1
             MOVE WS-R                           TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-T1
      
      *      T1 = T1 + CH(e, f, g)
             MOVE WS-E                           TO WS-X
             MOVE WS-F                           TO WS-Y
             MOVE WS-G                           TO WS-Z
             
             PERFORM F-CH

             MOVE WS-T1                          TO WS-SUM-KEY-1
             MOVE WS-R                           TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-T1
      
      *      T1 = T1 + Kt (WS-KS-VAL(WS-T))

             MOVE WS-T1                          TO WS-SUM-KEY-1
             MOVE WS-KS-VAL(WS-T)                TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-T1
      
      *      T1 = T1 + Wt (WS-W(WS-T))

             MOVE WS-T1                          TO WS-SUM-KEY-1
             MOVE WS-W(WS-T)                     TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-T1             
             
      *      T2 = BSIG0(a) + MAJ(a,b,c)
      *      T2 = BSIG0(a)
             MOVE WS-A                           TO WS-X
             
             PERFORM F-BSIG0

             MOVE WS-R                           TO WS-T2
             
      *      T2 = T2 + MAJ(a, b, c)
             MOVE WS-A                           TO WS-X
             MOVE WS-B                           TO WS-Y
             MOVE WS-C                           TO WS-Z
             
             PERFORM F-MAJ

             MOVE WS-T2                          TO WS-SUM-KEY-1
             MOVE WS-R                           TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-T2
      
      *      h = g
             MOVE WS-G                           TO WS-H
      
      *      g = f
             MOVE WS-F                           TO WS-G
             
      *      f = e
             MOVE WS-E                           TO WS-F
      
      *      e = d + T1
             MOVE WS-D                           TO WS-SUM-KEY-1
             MOVE WS-T1                          TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-E
      
      *      d = c
             MOVE WS-C                           TO WS-D
      
      *      c = b
             MOVE WS-B                           TO WS-C
      
      *      b = a
             MOVE WS-A                           TO WS-B
      
      *      a = T1 + T2
             MOVE WS-T1                          TO WS-SUM-KEY-1
             MOVE WS-T2                          TO WS-SUM-KEY-2
             
             PERFORM F-SUM
             
             MOVE WS-SUM-RESULT                  TO WS-A
           END-PERFORM.
      
      *****************************************************************
       INT-HASH.
      *****************************************************************
      *    As specified on rfc6234:
      *      4. Compute the intermediate hash value H(i)
      *        H(i)0 = a + H(i-1)0
      *        H(i)1 = b + H(i-1)1
      *        H(i)2 = c + H(i-1)2
      *        H(i)3 = d + H(i-1)3
      *        H(i)4 = e + H(i-1)4
      *        H(i)5 = f + H(i-1)5
      *        H(i)6 = g + H(i-1)6
      *        H(i)7 = h + H(i-1)7
      *
      
      *    H(i)0 = a + H(i-1)0
           MOVE WS-A                             TO WS-SUM-KEY-1.
           MOVE WS-HP(1)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(1).
           
      *    H(i)1 = b + H(i-1)1
           MOVE WS-B                             TO WS-SUM-KEY-1.
           MOVE WS-HP(2)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(2).
      
      *    H(i)2 = c + H(i-1)2
           MOVE WS-C                             TO WS-SUM-KEY-1.
           MOVE WS-HP(3)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(3).      
      
      *    H(i)3 = d + H(i-1)3
           MOVE WS-D                             TO WS-SUM-KEY-1.
           MOVE WS-HP(4)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(4).      
      
      *    H(i)4 = e + H(i-1)4
           MOVE WS-E                             TO WS-SUM-KEY-1.
           MOVE WS-HP(5)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(5).      
      
      *    H(i)5 = f + H(i-1)5
           MOVE WS-F                             TO WS-SUM-KEY-1.
           MOVE WS-HP(6)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(6).      
      
      *    H(i)6 = g + H(i-1)6
           MOVE WS-G                             TO WS-SUM-KEY-1.
           MOVE WS-HP(7)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(7).      
      
      *    H(i)7 = h + H(i-1)7
           MOVE WS-H                             TO WS-SUM-KEY-1.
           MOVE WS-HP(8)                         TO WS-SUM-KEY-2.
           
           PERFORM F-SUM
           
           MOVE WS-SUM-RESULT                    TO WS-HC(8).     
           
      *    Move HC (Current) to HP (Previous) for next loop
           MOVE WS-HC(1)                         TO WS-HP(1).
           MOVE WS-HC(2)                         TO WS-HP(2).
           MOVE WS-HC(3)                         TO WS-HP(3).
           MOVE WS-HC(4)                         TO WS-HP(4).
           MOVE WS-HC(5)                         TO WS-HP(5).
           MOVE WS-HC(6)                         TO WS-HP(6).
           MOVE WS-HC(7)                         TO WS-HP(7).
           MOVE WS-HC(8)                         TO WS-HP(8).

      
      *****************************************************************
      *    F I L E   F U N C T I O N S                                *
      *****************************************************************
      *****************************************************************
       OPEN-HASH.
      *****************************************************************
      *    It will open file and check for errors
           MOVE LS-FILE-NAME                     TO CNS-FILE-NAME.
           OPEN INPUT R-HASH.
           
           IF FS-HASH-OK
             CONTINUE
           ELSE
             DISPLAY 'Error opening file ' LS-FILE-NAME
             DISPLAY 'File status: ' FS-HASH
             STOP RUN
           END-IF.
       
      *****************************************************************
       READ-HASH.
      *****************************************************************
      *    It will read and check for errors
           SET SW-HASH-EOF-F                     TO TRUE.
           READ R-HASH.
       
           EVALUATE TRUE
             WHEN FS-HASH-OK
               CONTINUE
             WHEN FS-HASH-EOF
               SET SW-HASH-EOF-T                 TO TRUE
             WHEN OTHER
               DISPLAY 'Error reading ' LS-FILE-NAME
               DISPLAY 'File status: ' FS-HASH
               
               STOP RUN
           END-EVALUATE.
           
      *****************************************************************
       CLOSE-HASH.
      *****************************************************************
      *    It will close hash file and check for errors
           CLOSE R-HASH.
           
           IF FS-HASH-OK
             CONTINUE
           ELSE
             DISPLAY 'Error opening file ' LS-FILE-NAME
             DISPLAY 'File status: ' FS-HASH
             STOP RUN
           END-IF.  
           
      *****************************************************************
       OPEN-OUT.
      *****************************************************************
      *    It will open file and check for errors (X_NAME)
           MOVE LS-FILE-NAME                     TO CNS-FILE-OUT(3:).
           MOVE 'X_'                             TO CNS-FILE-OUT(1:2).
           
           OPEN OUTPUT R-OUT.
           
           IF FS-OUT-OK
             CONTINUE
           ELSE
             DISPLAY 'Error opening file ' CNS-FILE-OUT
             DISPLAY 'File status: ' FS-OUT
             STOP RUN
           END-IF.

      *****************************************************************
       OPEN-OUT-R.
      *****************************************************************
           MOVE LS-FILE-NAME                     TO CNS-FILE-OUT(3:).
           MOVE 'X_'                             TO CNS-FILE-OUT(1:2).

           OPEN INPUT R-OUT.

           IF FS-OUT-OK
             CONTINUE
           ELSE
             DISPLAY 'Error opening file ' CNS-FILE-OUT
             DISPLAY 'File status: ' FS-OUT
             STOP RUN
           END-IF.
       
      *****************************************************************
       READ-OUT.
      *****************************************************************
      *    It will read and check for errors
           SET SW-OUT-EOF-F                     TO TRUE
           READ R-OUT.
       
           EVALUATE TRUE
             WHEN FS-OUT-OK
               CONTINUE
             WHEN FS-OUT-EOF
               SET SW-OUT-EOF-T                 TO TRUE
             WHEN OTHER
               DISPLAY 'Error reading ' CNS-FILE-OUT
               DISPLAY 'File status: ' FS-OUT
               
               STOP RUN
           END-EVALUATE.

      *****************************************************************           
       READ-OUT-M.
      *****************************************************************
      *    It will read a block of 16 M-variables
      *
           PERFORM VARYING WS-MI FROM 1 BY 1
           UNTIL WS-MI > 16 OR
                 FS-OUT-EOF
             PERFORM READ-OUT

             MOVE OUT                            TO WS-M(WS-MI)
           END-PERFORM.

      *    If we reached EOF, erase WS-M
      *
           IF FS-OUT-EOF
             PERFORM VARYING WS-MI FROM 1 BY 1
             UNTIL WS-MI > 16
               MOVE ALL '0'                        TO WS-M(WS-MI)
             END-PERFORM
           END-IF.
           
      *****************************************************************
       WRITE-OUT.
      *****************************************************************
      *    It will write and check for errors
           WRITE OUT.
      
           EVALUATE TRUE
             WHEN FS-OUT-OK
               CONTINUE
             WHEN OTHER
               DISPLAY 'Error writting ' CNS-FILE-OUT
               DISPLAY 'File status: ' FS-OUT
               
               STOP RUN
           END-EVALUATE.
           
      *****************************************************************
       CLOSE-OUT.
      *****************************************************************
      *    It will close out file and check for errors
           CLOSE R-OUT.
           
           IF FS-OUT-OK
             CONTINUE
           ELSE
             DISPLAY 'Error opening file ' CNS-FILE-OUT
             DISPLAY 'File status: ' FS-OUT
             STOP RUN
           END-IF.  
           
      *****************************************************************
      *    C O N V E R S I O N   F U N C T I O N S                    *
      *****************************************************************
      *****************************************************************
       BINVALUE.
      *****************************************************************
      *    No loop needed here. The HEX2BIN table is filled in order
      *    That every HEX is in BIN+1 position
      *
           ADD  1                                TO WS-HEX2BIN-INDEX.
           MOVE WS-BIN(WS-HEX2BIN-INDEX)         TO WS-BIN-KEY. 

      *****************************************************************
       HEXVALUE.
      *****************************************************************
      *    No loop needed here. The HEX2BIN table is filled in order
      *    That every HEX is in BIN+1 position
      *
           ADD  1                                TO WS-HEX2BIN-INDEX.
           MOVE WS-HEX(WS-HEX2BIN-INDEX)         TO WS-HEX-KEY.                 

      *****************************************************************
       BIN2HEX.
      *****************************************************************
           MOVE WS-BIN-KEY                       TO WS-BIN-BYTE-FULL.
      
           COMPUTE WS-HEX2BIN-INDEX = (WS-BIN-BYTE(4) * CNS-B1) + 
                                      (WS-BIN-BYTE(3) * CNS-B2) + 
                                      (WS-BIN-BYTE(2) * CNS-B3) +
                                      (WS-BIN-BYTE(1) * CNS-B4).
      
           PERFORM HEXVALUE.           

      *****************************************************************
      *    B I T - L O G I C   F U N C T I O N S                      *
      *****************************************************************
      *****************************************************************
       XOR.
      *****************************************************************
      *    How it works:
      *      For 1 to 64, makes XOR-KEY-1(n) + XOR-KEY-2(n)
      *      IF result = 1, move 1; else, move 0.
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
             MOVE WS-XOR-KEY-1-X(WS-XOR-INDEX)   TO SW-XOR
             ADD  WS-XOR-KEY-2-X(WS-XOR-INDEX)   TO SW-XOR
               
             IF SW-XOR-TRUE
               MOVE '1'                       
               TO WS-XOR-RESULT-X(WS-XOR-INDEX)
             ELSE
               MOVE '0'                        
               TO WS-XOR-RESULT-X(WS-XOR-INDEX)
             END-IF
           END-PERFORM.
     
      *****************************************************************
       F-NOT.
      *****************************************************************
      *    How it works:
      *      For 1 to 64, if NOT-KEY(n) = 1 then move 0;
      *                                          move 1 otherwise.
      *
      *    NOTE: It could be done re-using "-KEY" value, but in order
      *    to maintain "-KEY" and "-RESULT" correlation, I'll use both.
      *
           MOVE SPACES                           TO WS-NOT-RESULT.
      
           PERFORM VARYING WS-NOT-INDEX FROM 1 BY 1
           UNTIL WS-NOT-INDEX > CNS-NOT-MAX
             IF WS-NOT-KEY-X(WS-NOT-INDEX) = '0'
               MOVE '1'                        
               TO WS-NOT-RESULT-X(WS-NOT-INDEX)
             ELSE
               MOVE '0'                        
               TO WS-NOT-RESULT-X(WS-NOT-INDEX)
             END-IF
           END-PERFORM.
      
      *****************************************************************
       F-AND.
      *****************************************************************
      *    How it works:
      *      For 1 to 64, makes AND-KEY-1(n) + AND-KEY-2(n)
      *      If result = 2, move 1; else, move 0.
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
             MOVE WS-AND-KEY-1-X(WS-AND-INDEX)   TO SW-AND
             ADD  WS-AND-KEY-2-X(WS-AND-INDEX)   TO SW-AND
               
             IF SW-AND-TRUE
               MOVE '1'                      
               TO WS-AND-RESULT-X(WS-AND-INDEX)
             ELSE
               MOVE '0'                      
               TO WS-AND-RESULT-X(WS-AND-INDEX)
             END-IF
           END-PERFORM.

      *****************************************************************
       F-OR.
      *****************************************************************
      *    How it works:
      *      For 1 to 64, makes OR-KEY-1(n) + OR-KEY-2(n)
      *      If result = 1 or 2, move 1; else, move 0.
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
             MOVE WS-OR-KEY-1-X(WS-OR-INDEX)     TO SW-OR
             ADD  WS-OR-KEY-2-X(WS-OR-INDEX)     TO SW-OR
               
             IF SW-OR-TRUE
               MOVE '1'                       
               TO WS-OR-RESULT-X(WS-OR-INDEX)
             ELSE
               MOVE '0'                      
               TO WS-OR-RESULT-X(WS-OR-INDEX)
             END-IF
           END-PERFORM.
           
      *****************************************************************
       F-SUM.
      *****************************************************************
      *    How it works:
      *      Convert words X and Y to integer values x and y
      *      (0 <= x < 2^w and 0 <= y < 2^w).
      *
      *      Then calculate z = (x + y) mod 2^w.
      *
      *      Finally convert z to a word Z, and it will be the result.
      *
      *    NOTE: The data will be on binary mode. So, wi will make it
      *        For 1 to 64, makes SUM-KEY-1(n) + SUM-KEY-2(n)
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
      *    We don't need to compute the last digit as its mod w.
      *
           SET SW-ACC-FALSE                      TO TRUE
      
           PERFORM VARYING WS-SUM-INDEX FROM 64 BY -1
           UNTIL WS-SUM-INDEX = 0
             MOVE WS-SUM-KEY-1-X(WS-SUM-INDEX)   TO SW-SUM
             ADD  WS-SUM-KEY-2-X(WS-SUM-INDEX)   TO SW-SUM
      
             IF SW-ACC-TRUE
               ADD 1                             TO SW-SUM
               SET SW-ACC-FALSE                  TO TRUE
             END-IF
      
             IF SW-ACC-ON
               IF SW-SUM = 2
                 MOVE '0'                    
                 TO WS-SUM-RESULT-X(WS-SUM-INDEX)
               ELSE
                 MOVE '1'                   
                 TO WS-SUM-RESULT-X(WS-SUM-INDEX)
               END-IF
      
               SET SW-ACC-TRUE                   TO TRUE
             ELSE
               MOVE SW-SUM                       
               TO WS-SUM-RESULT-X(WS-SUM-INDEX)
               
               SET SW-ACC-FALSE                  TO TRUE
             END-IF
           END-PERFORM.

           
      *****************************************************************
       RIGHT-SPACE.
      *****************************************************************
      *    How it works:
      *      For 1 to 63, moves RS-KEY(n) to RS-KEY(n + 1)
      *      Then, moves 0 to RS-KEY(0)
      *
           MOVE 2                                TO WS-RS-INDEX-2.
      
           PERFORM VARYING WS-RS-INDEX-1 FROM 1 BY 1
           UNTIL WS-RS-INDEX-1 > CNS-RS-MAX - 1
             MOVE WS-RS-KEY-X(WS-RS-INDEX-1)   
             TO WS-RS-RESULT-X(WS-RS-INDEX-2)
                    
             ADD 1                               TO WS-RS-INDEX-2
           END-PERFORM.
           
           MOVE '0'                              TO WS-RS-RESULT-X(1).
           
      *****************************************************************
       LEFT-SHIFT.
      *****************************************************************
      *    How it works:
      *      First, move SL-KEY(1) to SL-KEY(64)
      *      Then, For 2 to 64, moves SL-KEY(n) to SL-KEY(n - 1)
      *
      *    Caution: LEFT-SHIFT and RIGHT-SHIFT share variables.
      *
           MOVE WS-SL-KEY-X(1)                   
           TO WS-SL-RESULT-X(CNS-SL-MAX).
           
           MOVE 1                                TO WS-SL-INDEX-2.
      
           PERFORM VARYING WS-SL-INDEX-1 FROM 2 BY 1
           UNTIL WS-SL-INDEX-1 > CNS-SL-MAX
             MOVE WS-SL-KEY-X(WS-SL-INDEX-1)   
             TO WS-SL-RESULT-X(WS-SL-INDEX-2)
                    
             ADD 1                               TO WS-SL-INDEX-2
           END-PERFORM.
           
      *****************************************************************
       RIGHT-SHIFT.
      *****************************************************************
      *    How it works:
      *      First, move SL-KEY(64) to SL-KEY(1)
      *      Then, For 1 to 63, moves SL-KEY(n) to SL-KEY(n + 1)
      *
      *    Caution: LEFT-SHIFT and RIGHT-SHIFT share variables.
      *
           MOVE WS-SL-KEY-X(CNS-SL-MAX)                   
           TO WS-SL-RESULT-X(1).
           
           MOVE 2                                TO WS-SL-INDEX-2.
      
           PERFORM VARYING WS-SL-INDEX-1 FROM 1 BY 1
           UNTIL WS-SL-INDEX-1 > CNS-SL-MAX - 1
             MOVE WS-SL-KEY-X(WS-SL-INDEX-1)   
             TO WS-SL-RESULT-X(WS-SL-INDEX-2)
                    
             ADD 1                               TO WS-SL-INDEX-2
           END-PERFORM.
       
      *****************************************************************
      *    S H A - S P E C I F I C   F U N C T I O N S                *
      *****************************************************************
      *****************************************************************
       F-CH.       
      *****************************************************************
      *    As defined on rfc6234
      *      CH( x, y, z) = (x AND y) XOR ( (NOT x) AND z)
      *
      *    Result will be stored on WS-R.
      *
      
      *    res = x AND y
           MOVE WS-X                             TO WS-AND-KEY-1.
           MOVE WS-Y                             TO WS-AND-KEY-2.
            
           PERFORM F-AND.
            
           MOVE WS-AND-RESULT                    TO WS-R.
            
            
      *    not x (will store value on mid-table)
           MOVE WS-X                             TO WS-NOT-KEY.
            
           PERFORM F-NOT.
            
      *    (not x) AND z (will store value on mid-table)
           MOVE WS-NOT-RESULT                    TO WS-AND-KEY-1.
           MOVE WS-Z                             TO WS-AND-KEY-2.
            
           PERFORM F-AND.
            
      *    res = res XOR ((not x AND z) 
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-AND-RESULT                    TO WS-XOR-KEY-2.
            
           PERFORM XOR.
            
           MOVE WS-XOR-RESULT                    TO WS-R.
            
      *****************************************************************
       F-MAJ.     
      *****************************************************************
      *    As defined on rfc6234
      *      MAJ( x, y, z) = (x AND y) XOR (x AND z) XOR (y AND z)
      *
      *    Result will be stored on WS-R.
      *

      *    res = x AND y
           MOVE WS-X                             TO WS-AND-KEY-1.
           MOVE WS-Y                             TO WS-AND-KEY-2.
           
           PERFORM F-AND.
           
           MOVE WS-AND-RESULT                    TO WS-R.
      
      *    x AND z (will store value on mid-table)
           MOVE WS-X                             TO WS-AND-KEY-1.
           MOVE WS-Z                             TO WS-AND-KEY-2.
           
           PERFORM F-AND.
           
      *    res = res XOR (x AND z)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-AND-RESULT                    TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
           
      *    y AND z (will store value on mid-table)
           MOVE WS-Y                             TO WS-AND-KEY-1.
           MOVE WS-Z                             TO WS-AND-KEY-2.
           
           PERFORM F-AND.
           
      *    res = res XOR (y AND z)      
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-AND-RESULT                    TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
      
      *****************************************************************
       F-BSIG0.
      *****************************************************************
      *    As defined on rfc6234
      *      BSIG0(x) = ROTR^28(x) XOR ROTR^34(x) XOR ROTR^39(x)
      *
      *    Result will be stored on WS-R.
      *
      
      *    res = ROTR^28(x)
           MOVE WS-X                             TO WS-SL-KEY.
      
           PERFORM 28 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
           
           MOVE WS-SL-RESULT                     TO WS-R.
      
      *    ROTR^34(x) (will store value on mid-table)
      *      As already have done ROTR^28, will perform ROTR^6 (34-28)
           PERFORM 6 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM      
      
      *    res = res XOR ROTR^34(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-SL-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
      
      *    ROTR^39(x) (will store value on mid-table)
      *      As already have done ROTR^34, will perform ROTR^5 (39-34)
           PERFORM 5 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM   
           
      *    res = res XOR ROTR^39(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-SL-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
           
      *****************************************************************
       F-BSIG1.
      *****************************************************************
      *    As defined on rfc6234
      *      BSIG1(x) = ROTR^14(x) XOR ROTR^18(x) XOR ROTR^41(x)
      *
      *    Result will be stored on WS-R.
      *
      
      *    res = ROTR^14(x)
           MOVE WS-X                             TO WS-SL-KEY.
      
           PERFORM 14 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
           
           MOVE WS-SL-RESULT                     TO WS-R.
      
      *    ROTR^18(x) (will store value on mid-table)
      *      As already have done ROTR^14, will perform ROTR^4 (18-14)
           PERFORM 4 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
      
      *    res = res XOR ROTR^18(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-SL-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
      
      *    ROTR^41(x) (will store value on mid-table)
      *      As already have done ROTR^18, will perform ROTR^23 (41-18)
           PERFORM 23 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
      
      *    res = res XOR ROTR^41
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-SL-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
      
      *****************************************************************
       F-SSIG0.
      *****************************************************************
      *    As defined on rfc6234
      *      SSIG0(x) = ROTR^1(x) XOR ROTR^8(x) XOR SHR^7(x)
      *
      *    Result will be stored on WS-R.
      *
      
      *    res = ROTR^1(x)
           MOVE WS-X                             TO WS-SL-KEY.
      
           PERFORM 1 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
           
           MOVE WS-SL-RESULT                     TO WS-R.
      
      *    ROTR^8(x) (will store value on mid-table)
      *      As already have done ROTR^1, will perform ROTR^7 (8-1)
           PERFORM 7 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
      
      *    res = res XOR ROTR^8(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-SL-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
           
      *    SHR^7(x) (will store value on mid-table)
           MOVE WS-X                             TO WS-RS-KEY.
           
           PERFORM 7 TIMES
             PERFORM RIGHT-SPACE
             
             MOVE WS-RS-RESULT                   TO WS-RS-KEY
           END-PERFORM.
      
      *    res = res XOR SHR^7(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-RS-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR
           
           MOVE WS-XOR-RESULT                    TO WS-R.
           
      *****************************************************************
       F-SSIG1.
      *****************************************************************
      *    As defined on rfc6234
      *      SSIG1(x) = ROTR^19(x) XOR ROTR^61(x) XOR SHR^6(x)
      *
      *    Result will be stored on WS-R.
      *
      
      *    res = ROTR^19(x)
           MOVE WS-X                             TO WS-SL-KEY.
      
           PERFORM 19 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
           
           MOVE WS-SL-RESULT                     TO WS-R.
           
      *    ROTR^61(x) (will store value on mid-table)
      *      As already have done ROTR^19, will perform ROTR^42 (61-19)
           PERFORM 42 TIMES
             PERFORM RIGHT-SHIFT
       
             MOVE WS-SL-RESULT                   TO WS-SL-KEY
           END-PERFORM
           
      *    res = res XOR ROTR^61(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-SL-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR.
           
           MOVE WS-XOR-RESULT                    TO WS-R.
           
      *    SHR^6(x) (will store value on mid-table)
           MOVE WS-X                             TO WS-RS-KEY.
           
           PERFORM 6 TIMES
             PERFORM RIGHT-SPACE
             
             MOVE WS-RS-RESULT                   TO WS-RS-KEY
           END-PERFORM.
           
      *    res = res XOR SHR^6(x)
           MOVE WS-R                             TO WS-XOR-KEY-1.
           MOVE WS-RS-RESULT                     TO WS-XOR-KEY-2.
           
           PERFORM XOR
           
           MOVE WS-XOR-RESULT                    TO WS-R.
      
      *****************************************************************
      *    D A T A   F U N C T I O N S                                *
      *****************************************************************
      *****************************************************************
       FILL-TABLES.
      *****************************************************************
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
      
      *    Fill K's table
           MOVE '01000010100010100010111110011000' TO WS-KS-BIN-1(01).
           MOVE '11010111001010001010111000100010' TO WS-KS-BIN-2(01).

           MOVE '01110001001101110100010010010001' TO WS-KS-BIN-1(02).
           MOVE '00100011111011110110010111001101' TO WS-KS-BIN-2(02).

           MOVE '10110101110000001111101111001111' TO WS-KS-BIN-1(03).
           MOVE '11101100010011010011101100101111' TO WS-KS-BIN-2(03).
           
           MOVE '11101001101101011101101110100101' TO WS-KS-BIN-1(04).
           MOVE '10000001100010011101101110111100' TO WS-KS-BIN-2(04).
           
           MOVE '00111001010101101100001001011011' TO WS-KS-BIN-1(05).
           MOVE '11110011010010001011010100111000' TO WS-KS-BIN-2(05).
           
           MOVE '01011001111100010001000111110001' TO WS-KS-BIN-1(06).
           MOVE '10110110000001011101000000011001' TO WS-KS-BIN-2(06).
           
           MOVE '10010010001111111000001010100100' TO WS-KS-BIN-1(07).
           MOVE '10101111000110010100111110011011' TO WS-KS-BIN-2(07).
           
           MOVE '10101011000111000101111011010101' TO WS-KS-BIN-1(08).
           MOVE '11011010011011011000000100011000' TO WS-KS-BIN-2(08).
           
           MOVE '11011000000001111010101010011000' TO WS-KS-BIN-1(09).
           MOVE '10100011000000110000001001000010' TO WS-KS-BIN-2(09).
           
           MOVE '00010010100000110101101100000001' TO WS-KS-BIN-1(10).
           MOVE '01000101011100000110111110111110' TO WS-KS-BIN-2(10).
           
           MOVE '00100100001100011000010110111110' TO WS-KS-BIN-1(11).
           MOVE '01001110111001001011001010001100' TO WS-KS-BIN-2(11).
           
           MOVE '01010101000011000111110111000011' TO WS-KS-BIN-1(12).
           MOVE '11010101111111111011010011100010' TO WS-KS-BIN-2(12).

           MOVE '01110010101111100101110101110100' TO WS-KS-BIN-1(13).
           MOVE '11110010011110111000100101101111' TO WS-KS-BIN-2(13).
           
           MOVE '10000000110111101011000111111110' TO WS-KS-BIN-1(14).
           MOVE '00111011000101101001011010110001' TO WS-KS-BIN-2(14).
           
           MOVE '10011011110111000000011010100111' TO WS-KS-BIN-1(15).
           MOVE '00100101110001110001001000110101' TO WS-KS-BIN-2(15).
           
           MOVE '11000001100110111111000101110100' TO WS-KS-BIN-1(16).
           MOVE '11001111011010010010011010010100' TO WS-KS-BIN-2(16).
           
           MOVE '11100100100110110110100111000001' TO WS-KS-BIN-1(17).
           MOVE '10011110111100010100101011010010' TO WS-KS-BIN-2(17).
           
           MOVE '11101111101111100100011110000110' TO WS-KS-BIN-1(18).
           MOVE '00111000010011110010010111100011' TO WS-KS-BIN-2(18).
           
           MOVE '00001111110000011001110111000110' TO WS-KS-BIN-1(19).
           MOVE '10001011100011001101010110110101' TO WS-KS-BIN-2(19).
           
           MOVE '00100100000011001010000111001100' TO WS-KS-BIN-1(20).
           MOVE '01110111101011001001110001100101' TO WS-KS-BIN-2(20).
           
           MOVE '00101101111010010010110001101111' TO WS-KS-BIN-1(21).
           MOVE '01011001001010110000001001110101' TO WS-KS-BIN-2(21).
           
           MOVE '01001010011101001000010010101010' TO WS-KS-BIN-1(22).
           MOVE '01101110101001101110010010000011' TO WS-KS-BIN-2(22).

           MOVE '01011100101100001010100111011100' TO WS-KS-BIN-1(23).
           MOVE '10111101010000011111101111010100' TO WS-KS-BIN-2(23).
           
           MOVE '01110110111110011000100011011010' TO WS-KS-BIN-1(24).
           MOVE '10000011000100010101001110110101' TO WS-KS-BIN-2(24).
           
           MOVE '10011000001111100101000101010010' TO WS-KS-BIN-1(25).
           MOVE '11101110011001101101111110101011' TO WS-KS-BIN-2(25).
           
           MOVE '10101000001100011100011001101101' TO WS-KS-BIN-1(26).
           MOVE '00101101101101000011001000010000' TO WS-KS-BIN-2(26).
           
           MOVE '10110000000000110010011111001000' TO WS-KS-BIN-1(27).
           MOVE '10011000111110110010000100111111' TO WS-KS-BIN-2(27).
           
           MOVE '10111111010110010111111111000111' TO WS-KS-BIN-1(28).
           MOVE '10111110111011110000111011100100' TO WS-KS-BIN-2(28).
           
           MOVE '11000110111000000000101111110011' TO WS-KS-BIN-1(29).
           MOVE '00111101101010001000111111000010' TO WS-KS-BIN-2(29).
           
           MOVE '11010101101001111001000101000111' TO WS-KS-BIN-1(30).
           MOVE '10010011000010101010011100100101' TO WS-KS-BIN-2(30).
           
           MOVE '00000110110010100110001101010001' TO WS-KS-BIN-1(31).
           MOVE '11100000000000111000001001101111' TO WS-KS-BIN-2(31).
           
           MOVE '00010100001010010010100101100111' TO WS-KS-BIN-1(32).
           MOVE '00001010000011100110111001110000' TO WS-KS-BIN-2(32).

           MOVE '00100111101101110000101010000101' TO WS-KS-BIN-1(33).
           MOVE '01000110110100100010111111111100' TO WS-KS-BIN-2(33).
           
           MOVE '00101110000110110010000100111000' TO WS-KS-BIN-1(34).
           MOVE '01011100001001101100100100100110' TO WS-KS-BIN-2(34).
           
           MOVE '01001101001011000110110111111100' TO WS-KS-BIN-1(35).
           MOVE '01011010110001000010101011101101' TO WS-KS-BIN-2(35).
           
           MOVE '01010011001110000000110100010011' TO WS-KS-BIN-1(36).
           MOVE '10011101100101011011001111011111' TO WS-KS-BIN-2(36).
           
           MOVE '01100101000010100111001101010100' TO WS-KS-BIN-1(37).
           MOVE '10001011101011110110001111011110' TO WS-KS-BIN-2(37).
           
           MOVE '01110110011010100000101010111011' TO WS-KS-BIN-1(38).
           MOVE '00111100011101111011001010101000' TO WS-KS-BIN-2(38).
           
           MOVE '10000001110000101100100100101110' TO WS-KS-BIN-1(39).
           MOVE '01000111111011011010111011100110' TO WS-KS-BIN-2(39).
           
           MOVE '10010010011100100010110010000101' TO WS-KS-BIN-1(40).
           MOVE '00010100100000100011010100111011' TO WS-KS-BIN-2(40).
           
           MOVE '10100010101111111110100010100001' TO WS-KS-BIN-1(41).
           MOVE '01001100111100010000001101100100' TO WS-KS-BIN-2(41).
           
           MOVE '10101000000110100110011001001011' TO WS-KS-BIN-1(42).
           MOVE '10111100010000100011000000000001' TO WS-KS-BIN-2(42).

           MOVE '11000010010010111000101101110000' TO WS-KS-BIN-1(43).
           MOVE '11010000111110001001011110010001' TO WS-KS-BIN-2(43).
           
           MOVE '11000111011011000101000110100011' TO WS-KS-BIN-1(44).
           MOVE '00000110010101001011111000110000' TO WS-KS-BIN-2(44).
           
           MOVE '11010001100100101110100000011001' TO WS-KS-BIN-1(45).
           MOVE '11010110111011110101001000011000' TO WS-KS-BIN-2(45).
           
           MOVE '11010110100110010000011000100100' TO WS-KS-BIN-1(46).
           MOVE '01010101011001011010100100010000' TO WS-KS-BIN-2(46).
           
           MOVE '11110100000011100011010110000101' TO WS-KS-BIN-1(47).
           MOVE '01010111011100010010000000101010' TO WS-KS-BIN-2(47).
           
           MOVE '00010000011010101010000001110000' TO WS-KS-BIN-1(48).
           MOVE '00110010101110111101000110111000' TO WS-KS-BIN-2(48).
           
           MOVE '00011001101001001100000100010110' TO WS-KS-BIN-1(49).
           MOVE '10111000110100101101000011001000' TO WS-KS-BIN-2(49).
           
           MOVE '00011110001101110110110000001000' TO WS-KS-BIN-1(50).
           MOVE '01010001010000011010101101010011' TO WS-KS-BIN-2(50).
           
           MOVE '00100111010010000111011101001100' TO WS-KS-BIN-1(51).
           MOVE '11011111100011101110101110011001' TO WS-KS-BIN-2(51).
           
           MOVE '00110100101100001011110010110101' TO WS-KS-BIN-1(52).
           MOVE '11100001100110110100100010101000' TO WS-KS-BIN-2(52).

           MOVE '00111001000111000000110010110011' TO WS-KS-BIN-1(53).
           MOVE '11000101110010010101101001100011' TO WS-KS-BIN-2(53).
           
           MOVE '01001110110110001010101001001010' TO WS-KS-BIN-1(54).
           MOVE '11100011010000011000101011001011' TO WS-KS-BIN-2(54).
           
           MOVE '01011011100111001100101001001111' TO WS-KS-BIN-1(55).
           MOVE '01110111011000111110001101110011' TO WS-KS-BIN-2(55).
           
           MOVE '01101000001011100110111111110011' TO WS-KS-BIN-1(56).
           MOVE '11010110101100101011100010100011' TO WS-KS-BIN-2(56).
           
           MOVE '01110100100011111000001011101110' TO WS-KS-BIN-1(57).
           MOVE '01011101111011111011001011111100' TO WS-KS-BIN-2(57).
           
           MOVE '01111000101001010110001101101111' TO WS-KS-BIN-1(58).
           MOVE '01000011000101110010111101100000' TO WS-KS-BIN-2(58).
           
           MOVE '10000100110010000111100000010100' TO WS-KS-BIN-1(59).
           MOVE '10100001111100001010101101110010' TO WS-KS-BIN-2(59).
           
           MOVE '10001100110001110000001000001000' TO WS-KS-BIN-1(60).
           MOVE '00011010011001000011100111101100' TO WS-KS-BIN-2(60).
           
           MOVE '10010000101111101111111111111010' TO WS-KS-BIN-1(61).
           MOVE '00100011011000110001111000101000' TO WS-KS-BIN-2(61).
           
           MOVE '10100100010100000110110011101011' TO WS-KS-BIN-1(62).
           MOVE '11011110100000101011110111101001' TO WS-KS-BIN-2(62).

           MOVE '10111110111110011010001111110111' TO WS-KS-BIN-1(63).
           MOVE '10110010110001100111100100010101' TO WS-KS-BIN-2(63).
           
           MOVE '11000110011100010111100011110010' TO WS-KS-BIN-1(64).
           MOVE '11100011011100100101001100101011' TO WS-KS-BIN-2(64).
           
           MOVE '11001010001001110011111011001110' TO WS-KS-BIN-1(65).
           MOVE '11101010001001100110000110011100' TO WS-KS-BIN-2(65).
           
           MOVE '11010001100001101011100011000111' TO WS-KS-BIN-1(66).
           MOVE '00100001110000001100001000000111' TO WS-KS-BIN-2(66).
           
           MOVE '11101010110110100111110111010110' TO WS-KS-BIN-1(67).
           MOVE '11001101111000001110101100011110' TO WS-KS-BIN-2(67).
           
           MOVE '11110101011111010100111101111111' TO WS-KS-BIN-1(68).
           MOVE '11101110011011101101000101111000' TO WS-KS-BIN-2(68).
           
           MOVE '00000110111100000110011110101010' TO WS-KS-BIN-1(69).
           MOVE '01110010000101110110111110111010' TO WS-KS-BIN-2(69).
           
           MOVE '00001010011000110111110111000101' TO WS-KS-BIN-1(70).
           MOVE '10100010110010001001100010100110' TO WS-KS-BIN-2(70).
           
           MOVE '00010001001111111001100000000100' TO WS-KS-BIN-1(71).
           MOVE '10111110111110010000110110101110' TO WS-KS-BIN-2(71).
           
           MOVE '00011011011100010000101100110101' TO WS-KS-BIN-1(72).
           MOVE '00010011000111000100011100011011' TO WS-KS-BIN-2(72).

           MOVE '00101000110110110111011111110101' TO WS-KS-BIN-1(73).
           MOVE '00100011000001000111110110000100' TO WS-KS-BIN-2(73).
           
           MOVE '00110010110010101010101101111011' TO WS-KS-BIN-1(74).
           MOVE '01000000110001110010010010010011' TO WS-KS-BIN-2(74).
           
           MOVE '00111100100111101011111000001010' TO WS-KS-BIN-1(75).
           MOVE '00010101110010011011111010111100' TO WS-KS-BIN-2(75).
           
           MOVE '01000011000111010110011111000100' TO WS-KS-BIN-1(76).
           MOVE '10011100000100000000110101001100' TO WS-KS-BIN-2(76).
           
           MOVE '01001100110001011101010010111110' TO WS-KS-BIN-1(77).
           MOVE '11001011001111100100001010110110' TO WS-KS-BIN-2(77).
           
           MOVE '01011001011111110010100110011100' TO WS-KS-BIN-1(78).
           MOVE '11111100011001010111111000101010' TO WS-KS-BIN-2(78).
           
           MOVE '01011111110010110110111110101011' TO WS-KS-BIN-1(79).
           MOVE '00111010110101101111101011101100' TO WS-KS-BIN-2(79).
           
           MOVE '01101100010001000001100110001100' TO WS-KS-BIN-1(80).
           MOVE '01001010010001110101100000010111' TO WS-KS-BIN-2(80).
