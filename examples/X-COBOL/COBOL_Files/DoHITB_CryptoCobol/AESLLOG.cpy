          02 LMESSAGE-LEVEL          PIC 9(01).
             88 LLEVEL-INF                     VALUE 0.
             88 LLEVEL-WAR                     VALUE 1.
             88 LLEVEL-ERR                     VALUE 2.
             88 LLEVEL-MAX                     VALUE 9.
          02 LLOG-LEVEL              PIC 9(01).
             88 LLOG-INF                       VALUE 0.
             88 LLOG-WAR                       VALUE 1.
             88 LLOG-ERR                       VALUE 2.
             88 LLOG-MAX                       VALUE 9.
          02 LTEXT                   PIC X(128).
          02 EXTRA-IN.
             03 CFILE                PIC X(01).
             03 FILLER               PIC X(1023).
          02 EXTRA-OUT.
             03 ISOPEN               PIC X(01).
             03 FILLER               PIC X(1023).
