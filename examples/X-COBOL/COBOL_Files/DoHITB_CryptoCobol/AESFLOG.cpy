          02 MESSAGE-LEVEL               PIC 9(01).
             88 LEVEL-INF                          VALUE 0.
             88 LEVEL-WAR                          VALUE 1.
             88 LEVEL-ERR                          VALUE 2.
             88 LEVEL-MAX                          VALUE 9.
          02 SEP1                        PIC X(01) VALUE '|'.
          02 TST.
             03 DD                       PIC X(02).
             03 TST1                     PIC X(01) VALUE '.'.
             03 MM                       PIC X(02).
             03 TST2                     PIC X(01) VALUE '.'.
             03 YYYY                     PIC X(04).
             03 TST3                     PIC X(01) VALUE ' '.
             03 HH                       PIC X(02).
             03 TST4                     PIC X(01) VALUE ':'.
             03 MN                       PIC X(02).
             03 TST5                     PIC X(01) VALUE ':'.
             03 SS                       PIC X(02).
          02 SEP2                        PIC X(01) VALUE '|'.
          02 RTEXT                       PIC X(128).
