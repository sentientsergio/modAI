            02 PUT-MESSAGE-LS          PIC X(2178).
            02 PUT-MESSAGE             PIC X(8).
            02 LXP-TEXT                PIC X(32).
            02 LXP-TLENGTH             PIC 9(2).
            02 LXP-STATUS              PIC X(3).
               88 LXPS-OK                       VALUE 'OK '.
               88 LXPS-ERR                      VALUE 'ERR'.
            02 LXP-INPUT.
               03 LXPS-CFILE           PIC X(1).
               03 FILLER               PIC X(1023).
            02 LXP-OUTPUT.
               03 FILLER               PIC X(1024).
