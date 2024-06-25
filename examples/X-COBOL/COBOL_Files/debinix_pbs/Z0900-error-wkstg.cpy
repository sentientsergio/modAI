      *
      *  Working storage data structure for new error routine
      *  Put this file in the /COPYLIB directory.
      *
      *  Include with: 'COPY Z0900-error-wkstg.' in WS.
      *
       01  wc-log-text             PIC X(80)     VALUE SPACE.
       01  w9-space-cnt            PIC S9(4) COMP VALUE ZERO.
       01  wr-error-handler.
           05 wr-program-error-message.
               10 FILLER           PIC X(8)  VALUE 'SQLCODE:'.
               10 wn-msg-sqlcode   PIC -999.
               10 FILLER           PIC X(1)  VALUE '|'.
               10 wc-msg-tblcurs   PIC X(15) VALUE SPACE.
               10 FILLER           PIC X(1)  VALUE '|'.
               10 wc-msg-para      PIC X(30) VALUE SPACE.
               10 FILLER           PIC X(1)  VALUE '|'.
               10 wc-msg-srcfile   PIC X(20) VALUE SPACE.
          05 dsntiar-error-message.
               10 dem-length       PIC S9(4) COMP VALUE +800.
               10 dem-message      PIC X(80) OCCURS 10 TIMES
                                      INDEXED BY dem-index.
          05 dsntiar-line-length   PIC S9(9) COMP VALUE +80.

