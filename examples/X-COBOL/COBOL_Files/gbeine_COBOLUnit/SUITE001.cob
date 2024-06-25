000010*>
000020 IDENTIFICATION DIVISION.
000030 PROGRAM-ID.   SUITE001.
000040 ENVIRONMENT    DIVISION.
000050 CONFIGURATION  SECTION.
000060 DATA DIVISION.
000070 WORKING-STORAGE SECTION.
000090          COPY CBUC0001.
000091          COPY CBUC0002.
000092          01 str1 PIC X(20).
000093          01 str2 PIC X(100).
000094          01 RES PIC 99.
000095 PROCEDURE DIVISION.
000096   INITIALIZE str1 str2.
000097   MOVE "SUITE1" TO str1.
000098   MOVE "DESC SUITE1" TO str2.
000099   CALL CBU-initialize USING CBU-ctx.
000102   CALL CBU-add-suite USING CBU-ctx str1 str2.
000103
000104   INITIALIZE str1 str2.
000105   MOVE "TS000001" TO str1.
000106   MOVE "TEST1 desc" TO str2.
000108   CALL CBU-add-test-next USING CBU-ctx str1 str2.
000109
000121   CALL CBU-run USING CBU-ctx.
000130 END PROGRAM SUITE001.