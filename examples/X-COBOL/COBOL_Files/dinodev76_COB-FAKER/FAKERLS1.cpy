      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       01  L-FORMAT-TABLE-1.
           05  L-FORMAT-ENTRY-CNT-1
                                   PIC S9(4)  COMP.
           05  L-FORMAT-WEIGHT-TOT-1
                                   PIC S99V9(9)
                                              COMP.
           05  L-FORMAT-OCCS-1.
               10  FILLER                          OCCURS 10
                                                   INDEXED L-F-DX-1.
                   15  L-FORMAT-ENTRY-1
                                   PIC X(32).
                   15  L-FORMAT-WEIGHT-1
                                   PIC SV9(9) COMP.

       01  L-FORMAT-TABLE-2.
           05  L-FORMAT-ENTRY-CNT-2
                                   PIC S9(4)  COMP.
           05  L-FORMAT-WEIGHT-TOT-2
                                   PIC S99V9(9)
                                              COMP.
           05  L-FORMAT-OCCS-2.
               10  FILLER                          OCCURS 10
                                                   INDEXED L-F-DX-2.
                   15  L-FORMAT-ENTRY-2
                                   PIC X(32).
                   15  L-FORMAT-WEIGHT-2
                                   PIC SV9(9) COMP.
