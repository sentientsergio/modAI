            02 PUT-MESSAGE             PIC X(8).
            02 LXG-TEXT                PIC X(32).
            02 LXG-TLENGTH             PIC 9(02).
            02 LXG-STATUS              PIC X(3).
               88 LXGS-OK                       VALUE 'OK '.
               88 LXGS-ERR                      VALUE 'ERR'.
               88 LXGS-EOF                      VALUE 'EOF'.
               88 LXGS-SKP                      VALUE 'SKP'.
            02 LXG-INPUT.
               03 LXG-CFILE            PIC X(1).
               03 FILLER               PIC X(1023).
            02 LXG-OUTPUT.
               03 LXG-ISOPEN           PIC X(1).
               03 FILLER               PIC X(1023).
