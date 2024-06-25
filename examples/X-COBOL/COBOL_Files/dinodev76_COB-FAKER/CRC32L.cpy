      *========================== CRC32L.cpy ==========================*
      * Authors: Brian D Pead
      *
      * Description: Linkage parameter for subroutine CRC32 which 
      *              calculates a CRC-32 checksum.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

      *01  CRC32-PATRAMETER.

      **** Input fields:
      ****     CRC-STAGE:
      ****         Stage of the checksum process - use values other than
      ****         'SE' when data to checksum is passed in chunks. 
      ****     CRC-BUFFER:
      ****         Pointer to buffer on which to calculate checksum. 
      ****     CRC-BUFFER-LEN:
      ****         Length of buffer. 

      **** Output field:
      ****     CRC-CHECKSUM:
      ****         Calculated checksum (partial result if processing in
      ****         chunks). 

           05  CRC-STAGE           PIC X(02)       VALUE 'SE'.
               88  CRC-STAGE-START-END             VALUE 'SE'.
               88  CRC-STAGE-START                 VALUE 'ST'.
               88  CRC-STAGE-IN-PROCESS            VALUE 'IP'.
               88  CRC-STAGE-END                   VALUE 'EN'.

           05  CRC-BUFFER-PTR                      POINTER.

           05  CRC-BUFFER-LEN      PIC 9(09)  COMP.

           05  CRC-CHECKSUM        PIC 9(09)  COMP.