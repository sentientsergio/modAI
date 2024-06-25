      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       01  W-FOUND-DX              PIC S9(4)  COMP.
       01  W-RANDOM-NO             PIC S9(4)V9(9)
                                              COMP.
       01  W-RANDOM-SUB            PIC S9(4)  COMP.
       01  W-SUB-1                 PIC S9(4)  COMP.
       01  W-SUB-1-SAVE            PIC S9(4)  COMP.
       01  W-SUB-2                 PIC S9(4)  COMP.
       01  W-SUB-D                 PIC S9(4)  COMP.
       01  W-DIGIT-CNT             PIC S9(4)  COMP.
       01  W-RANDOM-DIG            PIC 9.
       01  W-TABLE-1               PIC X(30).
       01  W-TABLE-2               PIC X(30)       VALUE SPACES.
       01  W-FAKER-RESULT          PIC X(80).
       01  W-FAKER-FORMAT          PIC X(80).
       01  W-FORMAT-START          PIC X           VALUE '{'.
       01  W-FORMAT-END            PIC X           VALUE '}'.

       01  FILLER                  PIC X(01)       VALUE 'Y'.
           88  W-FIRST-CALL                        VALUE 'Y'.
           88  W-NOT-FIRST-CALL                    VALUE 'N'.

       01  W-COMPILED-DATE.
           05  W-COMPILED-DATE-YYYY
                                   PIC X(04).
           05  W-COMPILED-DATE-MM  PIC X(02).
           05  W-COMPILED-DATE-DD  PIC X(02).
           05  W-COMPILED-TIME-HH  PIC X(02).
           05  W-COMPILED-TIME-MM  PIC X(02).
           05  W-COMPILED-TIME-SS  PIC X(02).
           05  FILLER              PIC X(07).

       01  W-RECURSED-FORMAT.
           05  W-RECURSED-FORMAT-CHAR
                                   PIC X           OCCURS 80
                                                   INDEXED W-RF-DX.
       01  W-RECURSED-FORMAT-REST  PIC X(80).
