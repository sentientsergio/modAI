       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTS.

       ENVIRONMENT DIVISION.
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

       77 DES      PIC X(6).
       77 FS_MSG   PIC X(40).

       77 CHOICE   PIC 99.
       77 STUFF    PIC X(60).
       77 NUM      PIC 9.

       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 0 TO NUM.
           COPY CLEAR-SCREEN.
           INSPECT "HOLA" TALLYING NUM FOR ALL "HO".
           DISPLAY NUM AT 0201.




   *>         OPEN I-O BRANCHFILE.
   *> *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *> *>>D                          MSG    BY FS_MSG.
   *> *>>D    STRING "OPEN I-O BRANCHFILE.: " FS_MSG INTO STUFF.
   *> *>>D    DISPLAY STUFF AT 3099.
   *>         MOVE '001235' TO BBRID.
   *>         MOVE 'BRANCH1235' TO BBRNAME.
   *>         MOVE 'UNOWN SYMBOL 1235' TO BBRADD.
   *>         MOVE '????1235????' TO BBRPH.
   *>         MOVE 'BR1235@example.com' TO BEMAIL.
   *>         MOVE 'STEVEN MOFFAT No1235' TO BMGRNAME.
   *>         WRITE BRANCHREC.
   *> *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *> *>>D                          MSG    BY FS_MSG.
   *> *>>D    STRING "(1235)WRITE BRANCHREC.: " FS_MSG INTO STUFF.
   *> *>>D    DISPLAY STUFF AT 123599.

   *>         MOVE '001236' TO BBRID.
   *>         MOVE 'BRANCH1236' TO BBRNAME.
   *>         MOVE 'UNOWN SYMBOL 1236' TO BBRADD.
   *>         MOVE '????1236????' TO BBRPH.
   *>         MOVE 'BR1236@example.com' TO BEMAIL.
   *>         MOVE 'STEVEN MOFFAT No1236' TO BMGRNAME.
   *>         WRITE BRANCHREC.
   *> *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *> *>>D                          MSG    BY FS_MSG.
   *> *>>D    STRING "(1236)WRITE BRANCHREC.: " FS_MSG INTO STUFF.
   *> *>>D    DISPLAY STUFF AT 123699.

   *>         CLOSE BRANCHFILE.
   *> *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *> *>>D                          MSG    BY FS_MSG.
   *> *>>D    STRING "CLOSE BRANCHFILE.: " FS_MSG INTO STUFF.
   *> *>>D    DISPLAY STUFF AT 3099.


           DISPLAY "CONTINUE" AT 0101.
           ACCEPT STUFF AT 0109.
           GOBACK.

       END PROGRAM TESTS.
