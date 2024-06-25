         01 IOCOMM.
            02 IO-ACTION               PIC X(1).
            02 IO-MODE                 PIC X(3).
            02 IO-BITS                 PIC X(3).
            02 IO-TEXT                 PIC X(32).
            02 IO-KEY                  PIC X(64).
            02 IO-KSCH                 PIC X(480).
         01 IOTAB.
            COPY 'AESTAB.cpy'.
         01 IOPUTM                     PIC X(2178).
