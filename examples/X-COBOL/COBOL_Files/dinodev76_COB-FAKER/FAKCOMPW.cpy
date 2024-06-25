      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

      **** FORMAT CODES:
      ****     CS = company_suffix
      ****     LN = last_name (from FAKPERSW)

       01  FORMATS-COMPANY.
           05  FORMAT-COMPANY-CNT  PIC S9(4)  COMP VALUE 3.
           05  FORMAT-COMPANY-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-COMPANY-OCCS.
               10  FILLER          PIC X(32)       VALUE '{LN} {CS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.500000000.
               10  FILLER          PIC X(32)       VALUE 
                                                       '{LN}-{LN} {CS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.250000000.
               10  FILLER          PIC X(32)       VALUE
                                              '{LN}, {LN} and {LN} LLC'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.250000000.
           05  FILLER REDEFINES FORMAT-COMPANY-OCCS.
               10  FILLER                          OCCURS 3
                                                   INDEXED FC-DX.
                   15  FORMAT-COMPANY 
                                   PIC X(32).
                   15  FORMAT-COMPANY-WEIGHT
                                   PIC SV9(9) COMP.

       01  COMPANY-SUFFIXES.
           05  COMPANY-SUFFIX-CNT  PIC S9(4)       COMP VALUE 6.
           05  COMPANY-SUFFIX-OCCS.
               10  FILLER          PIC X(14)       VALUE 'Inc'.
               10  FILLER          PIC X(14)       VALUE 'and Sons'.
               10  FILLER          PIC X(14)       VALUE 'LLC'.
               10  FILLER          PIC X(14)       VALUE 'Group'.
               10  FILLER          PIC X(14)       VALUE 'PLC'.
               10  FILLER          PIC X(14)       VALUE 'Ltd'.
           05  FILLER REDEFINES COMPANY-SUFFIX-OCCS.
               10  FILLER                          OCCURS 6
                                                   INDEXED CS-DX.
                   15  COMPANY-SUFFIX PIC X(14).
