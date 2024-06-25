       IDENTIFICATION DIVISION.
       PROGRAM-ID. BRANCHLIST.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CRT STATUS IS CRT-STATUS.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT BRANCHFILE
               ASSIGN TO "files/BRANCH.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS BBRID
               FILE STATUS IS FSB.

       DATA DIVISION.
       FILE SECTION.

       FD BRANCHFILE.
       01 BRANCHREC.
           02 BBRID    PIC X(6).
           02 BBRNAME  PIC X(15).
           02 BBRADD   PIC X(30).
           02 BBRPH    PIC X(10).
           02 BEMAIL   PIC X(20).
           02 BMGRNAME PIC X(25).

       WORKING-STORAGE SECTION.
       77 FSB   PIC XX.
       77 FSBS  PIC XX.

       77 DES   PIC X(6).

       77 GR     PIC 99.

       77 I           PIC 99.
       77 CITY        PIC X(3).
       77 CITYT       PIC X(4).
       77 NUMCITY     PIC 9.
       77 CHOICE      PIC X.
       77 PAGINATION-DIR       PIC X.
       77 I-INITIAL    PIC 99.
       77 I-FINAL      PIC 99.
       77 CRT-STATUS  PIC 9(4).

       SCREEN SECTION.

       01 HEADER.
           03 BACKGROUND-COLOR 0
              FOREGROUND-COLOR 2 HIGHLIGHT.
           05 LINE 1 COLUMN 1 VALUE  "|  BBRID".
           05 LINE 2 COLUMN 1 VALUE  "|--------".
           05 LINE 1 COLUMN 10 VALUE  "|         BBRNAME".
           05 LINE 2 COLUMN 10 VALUE  "+-----------------".
           05 LINE 1 COLUMN 28 VALUE "|                         BBRADD"
           05 LINE 2 COLUMN 28
              VALUE "+--------------------------------".
           05 LINE 1 COLUMN 61 VALUE "|      BBRPH".
           05 LINE 2 COLUMN 61 VALUE "+------------".
           05 LINE 1 COLUMN 74 VALUE "|               BEMAIL".
           05 LINE 2 COLUMN 74 VALUE "+----------------------".
           05 LINE 1 COLUMN 97 VALUE "|                  BMGRNAME |".
           05 LINE 2 COLUMN 97 VALUE "+---------------------------|".

       01 ROW.
           03 BACKGROUND-COLOR 0
              FOREGROUND-COLOR 2 HIGHLIGHT.
           05            LINE I COLUMN 1 VALUE "|".
           05            LINE I COLUMN 10 VALUE "|".
           05            LINE I COLUMN 28 VALUE "|".
           05            LINE I COLUMN 61 VALUE "|".
           05            LINE I COLUMN 74 VALUE "|".
           05            LINE I COLUMN 97 VALUE "|".
           05            LINE I COLUMN 125 VALUE "|".
           05  PIC X(6)  LINE I COLUMN 3 FROM BBRID.
           05  PIC X(15) LINE I COLUMN 12 FROM BBRNAME.
           05  PIC X(30) LINE I COLUMN 30 FROM BBRADD.
           05  PIC X(10) LINE I COLUMN 63 FROM BBRPH.
           05  PIC X(20) LINE I COLUMN 76 FROM BEMAIL.
           05  PIC X(25) LINE I COLUMN 99 FROM BMGRNAME.

       PROCEDURE DIVISION.
       MAIN-PARA.
           COPY CLEAR-SCREEN.
           MOVE '   ' TO CITY.
           DISPLAY "CITY:" AT 0101.
           ACCEPT CITY AT 0107 WITH UNDERLINE
           OPEN I-O BRANCHFILE.
           *> Start sequential read of the file
           START BRANCHFILE END-START
           COPY CLEAR-SCREEN.

           DISPLAY HEADER END-DISPLAY
           MOVE 3 TO I.
           PERFORM FOREVER
               READ BRANCHFILE NEXT RECORD
                   INTO BRANCHREC
                   AT END EXIT PERFORM
               END-READ

              IF CITY NOT EQUALS '   '
                  MOVE 0 TO NUMCITY
                  STRING ',' CITY INTO CITYT END-STRING
                  INSPECT BBRADD TALLYING NUMCITY FOR ALL CITYT
   *>>D           DISPLAY BBRADD AT 2101
   *>>D           DISPLAY NUMCITY AT 2201
   *>>D           DISPLAY CITYT AT 2301
                  IF NUMCITY EQUALS 0
                      EXIT PERFORM CYCLE
                  END-IF
              END-IF

              DISPLAY ROW END-DISPLAY


              ADD 1 TO I END-ADD
              IF I IS EQUAL TO 13
                  DISPLAY "F1/Enter: NEXT    F2: RETURN"
                      AT 1401 END-DISPLAY
                  ACCEPT CHOICE AT 1501 END-ACCEPT
                  EVALUATE CRT-STATUS
                      WHEN 1001
                          CONTINUE
                      WHEN 1002
                          EXIT PERFORM
                  END-EVALUATE
                  *> CLEAR LINES
                  DISPLAY SPACES AT LINE NUMBER 3
                      WITH ERASE EOS END-DISPLAY
                  MOVE 3 TO I
                  EXIT PERFORM CYCLE
              END-IF
           END-PERFORM
           *> REMEMBER CITADEL
           DISPLAY SPACES AT 1301 WITH ERASE EOL END-DISPLAY
           IF CHOICE NOT = 'Q' AND CHOICE NOT = 'q'
                   AND CRT-STATUS NOT = 1003
               DISPLAY "RETURN TO MAIN MENU" AT 1301 END-DISPLAY
               ACCEPT CHOICE AT 1320 END-ACCEPT
           END-IF
           *> REWIND FILE
           PERFORM FOREVER
               READ BRANCHFILE PREVIOUS RECORD
                   INTO BRANCHREC
                   AT END EXIT PERFORM
           END-PERFORM
           *> REPOSITIONATE CURSOR
           PERFORM 2 TIMES
               READ BRANCHFILE NEXT RECORD
                   INTO BRANCHREC
               END-READ
           END-PERFORM
           CLOSE BRANCHFILE.
           STOP ' '.
       END PROGRAM BRANCHLIST.
