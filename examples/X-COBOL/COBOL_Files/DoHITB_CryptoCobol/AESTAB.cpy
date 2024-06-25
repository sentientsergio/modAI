          02 M-BOX.
             05 MB-A OCCURS 4.
                10 MB-B OCCURS 256.
                   15 MB-R              PIC X(02).
          02 X-BOX.
             05 XB-A OCCURS 16.
                10 XB-B OCCURS 16.
                   15 XB-R              PIC X(01).
          02 S-BOX.
             05 SB-A OCCURS 16.
                10 SB-BX.
                   15 SB-B OCCURS 16.
                      20 SB-R           PIC X(02).
          02 M-MAP.
             05 MMA OCCURS 4.
                10 MMR                  PIC X(01).
