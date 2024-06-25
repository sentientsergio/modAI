      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-11  1.0.1    Add TELETELEPHONE numbers
      *================================================================*

       01  BANK-ACCOUNT-FORMATS.
           05  BANK-ACCOUNT-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 7.
           05  BANK-ACCOUNT-FORMAT-OCCS.
               10  FILLER          PIC X(12)       VALUE '######'.
               10  FILLER          PIC X(12)       VALUE '#######'.
               10  FILLER          PIC X(12)       VALUE '########'.
               10  FILLER          PIC X(12)       VALUE '#########'.
               10  FILLER          PIC X(12)       VALUE '##########'.
               10  FILLER          PIC X(12)       VALUE '###########'.
               10  FILLER          PIC X(12)       VALUE '############'.
           05  FILLER REDEFINES BANK-ACCOUNT-FORMAT-OCCS.
               10  FILLER                          OCCURS 7
                                                   INDEXED BR-DX.
                   15  BANK-ACCOUNT-FORMAT
                                   PIC X(12).

       01  BANK-ROUTING-FORMATS.
           05  BANK-ROUTING-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 1.
           05  BANK-ROUTING-FORMAT-OCCS.
      ****     Standard 8-digit routing number plus check digit:
               10  FILLER          PIC X(10)       VALUE '########C'.
           05  FILLER REDEFINES BANK-ROUTING-FORMAT-OCCS.
               10  FILLER                          OCCURS 1
                                                   INDEXED BR-DX.
                   15  BANK-ROUTING-FORMAT
                                   PIC X(10).
