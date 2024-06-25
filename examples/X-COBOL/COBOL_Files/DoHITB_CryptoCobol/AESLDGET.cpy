            02 PUT-MESSAGE             PIC X(8).
            02 LDG-TEXT                PIC X(2860).
            02 LDG-STATUS              PIC X(3).
               88 LDGS-OK                       VALUE 'OK '.
               88 LDGS-ERR                      VALUE 'ERR'.
               88 LDGS-EOF                      VALUE 'EOF'.
            02 LDG-INPUT.
               03 LDG-CFILE            PIC X(1).
               03 FILLER               PIC X(1023).
            02 LDG-OUTPUT.
               03 LDG-ISOPEN           PIC X(1).
               03 FILLER               PIC X(1023).
