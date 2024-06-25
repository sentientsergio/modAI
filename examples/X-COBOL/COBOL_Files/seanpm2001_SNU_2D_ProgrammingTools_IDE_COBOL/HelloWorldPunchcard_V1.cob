//COBUCLG  JOB (001),'COBOL BASE TEST',                                 00010000
//             CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)                        00020000
//BASETEST EXEC COBUCLG                                                 00030000
//COB.SYSIN DD *                                                        00040000
 00000* VALIDATION OF BASE COBOL INSTALL                                00050000
 01000 IDENTIFICATION DIVISION.                                         00060000
 01100 PROGRAM-ID. 'HELLO'.                                             00070000
 02000 ENVIRONMENT DIVISION.                                            00080000
 02100 CONFIGURATION SECTION.                                           00090000
 02110 SOURCE-COMPUTER.  GNULINUX.                                      00100000
 02120 OBJECT-COMPUTER.  HERCULES.                                      00110000
 02200 SPECIAL-NAMES.                                                   00120000
 02210     CONSOLE IS CONSL.                                            00130000
 03000 DATA DIVISION.                                                   00140000
 04000 PROCEDURE DIVISION.                                              00150000
 04100 00-MAIN.                                                         00160000
 04110     DISPLAY 'HELLO, WORLD' UPON CONSL.                           00170000
 04900     STOP RUN.                                                    00180000
//LKED.SYSLIB DD DSNAME=SYS1.COBLIB,DISP=SHR                            00190000
//            DD DSNAME=SYS1.LINKLIB,DISP=SHR                           00200000
//GO.SYSPRINT DD SYSOUT=A                                               00210000
//                                                                      00220000

