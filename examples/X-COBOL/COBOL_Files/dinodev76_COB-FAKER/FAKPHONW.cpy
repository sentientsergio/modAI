      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-11  1.0.1    Add TELETELEPHONE numbers
      *================================================================*

       01  TELEPHONE-NUMBER-FORMATS.
           05  TELEPHONE-NUMBER-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 8.
           05  TELEPHONE-NUMBER-FORMAT-OCCS.
      ****     Standard 10-digit TELEPHONE number formats:
               10  FILLER          PIC X(20)       VALUE 
                                                 '%##-%##-####'.
               10  FILLER          PIC X(20)       VALUE 
                                                 '%##-%##-####'.
      ****     Optional 10-digit local TELEPHONE number format
               10  FILLER          PIC X(20)       VALUE 
                                                 '(%##)%##-####'.
               10  FILLER          PIC X(20)       VALUE 
                                                 '(%##)%##-####'.
      ****     Standard 10-digit TELEPHONE number format with extensions:
               10  FILLER          PIC X(20)       VALUE 
                                                 '%##-%##-#### X%##'.
               10  FILLER          PIC X(20)       VALUE 
                                                 '%##-%##-#### X%###'.
      ****     Optional 10-digit local TELEPHONE number format with ext:
               10  FILLER          PIC X(20)       VALUE 
                                                 '(%##)%##-#### X%##'.
               10  FILLER          PIC X(20)       VALUE 
                                                 '(%##)%##-#### X%###'.
           05  FILLER REDEFINES TELEPHONE-NUMBER-FORMAT-OCCS.
               10  FILLER                          OCCURS 8
                                                   INDEXED PN-DX.
                   15  TELEPHONE-NUMBER-FORMAT
                                   PIC X(20).
