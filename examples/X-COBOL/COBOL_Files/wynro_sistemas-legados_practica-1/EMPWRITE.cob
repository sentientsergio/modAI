       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMPWRITE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CRT STATUS IS CRT-STATUS.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           *> PAGE 39
           SELECT EMPFILE
               *> Create file definition and assign it to a
               *> specific path
               ASSIGN TO "files/EMP.DAT"
               *> Exists a field in the file that acts as Key. That
               *> allows sequential or random reading
               ORGANIZATION IS INDEXED
               *> Allows both sequential or random reading of the file
               ACCESS MODE IS DYNAMIC
               *> The field of the file that will index it
               RECORD KEY IS EEMPID
               *> Special variable that will contain the status of the file
               FILE STATUS IS FSO.

           SELECT LEAVEFILE
               ASSIGN TO "files/LEAVE.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS LEMPID
               FILE STATUS IS FSL.

           SELECT BRANCHFILE
               ASSIGN TO "files/BRANCH.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS BBRID
               FILE STATUS IS FSB.

           SELECT DESIGNATIONFILE
               ASSIGN TO "files/DESIG.DAT"
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FSDES.

           SELECT DEPARTMENTFILE
               ASSIGN TO "files/DEPART.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS DEPCODE
               FILE STATUS IS FSDEP.

           SELECT REVISIONFILE
               ASSIGN TO "files/REVISION.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS RREVID
               ALTERNATE RECORD KEY IS REMPID
               FILE STATUS IS FSR.

           SELECT PAYMENTFILE
               ASSIGN TO "files/PAYMENT.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS PEMPID
               FILE STATUS IS FSP.

           SELECT CONFIRMATIONFILE
               ASSIGN TO "files/CONFIRM.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CCONID
               ALTERNATE RECORD KEY IS CEMPID
               FILE STATUS IS FSC.

           SELECT GRADEFILE
               ASSIGN TO "files/GRADE.DAT"
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS FSG.

           SELECT TRANSFERFILE
               ASSIGN TO "files/TRANSFER.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS TTRFID
               FILE STATUS IS FST.

           SELECT EMPPERSONALFILE
               ASSIGN TO "files/EMPPER.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS EPEMPID
               FILE STATUS IS FSEP.

       DATA DIVISION.
       FILE SECTION.
       FD EMPFILE.
       01 EMPREC.
           02 EEMPID    PIC X(6).
           02 EEMPNAME  PIC X(25).
           02 EEMPADDR  PIC X(30).
           02 EPHONE    PIC X(10).
           02 EDOJ      PIC X(10).
           02 EDIP      PIC X(10).
           02 EUG       PIC X(4).
           02 EPG       PIC X(4).
           02 EPROFQ    PIC X(4).
           02 ESKILL    PIC X(10).
           02 EGRDNO    PIC 99.
           02 EBRNID    PIC X(6).
           02 EDESID    PIC X(6).

       FD LEAVEFILE.
       01 LEAVEREC.
           02 LEMPID    PIC X(6).
           02 LFMDATE   PIC X(10).
           02 LTODATE   PIC X(10).
           02 LLEVCAT   PIC X(3).

       FD BRANCHFILE.
       01 BRANCHREC.
           02 BBRID    PIC X(6).
           02 BBRNAME  PIC X(15).
           02 BBRADD   PIC X(30).
           02 BBRPH    PIC X(10).
           02 BEMAIL   PIC X(20).
           02 BMGRNAME PIC X(25).

       fd DESIGNATIONFILE.
       01 DESIGNATIONREC.
           02 DESID    PIC X(6).
           02 DESIGN   PIC X(15).
           02 DESHRT   PIC X(4).

       FD DEPARTMENTFILE.
       01 DEPARTMENTREC.
           02 DEPCODE  PIC X(6).
           02 DEPNAME  PIC X(20).

       FD REVISIONFILE.
       01 REVISIONREC.
           02 RREVID   PIC X(6).
           02 REMPID   PIC X(6).
           02 RDESCODE PIC X(6).
           02 RBASIC   PIC 9(6)V99.
           02 RHRA     PIC 9(6)V99.
           02 RDPA     PIC 9(6)V99.
           02 RPPA     PIC 9(6)V99.
           02 REDUA    PIC 9(6)V99.
           02 RTECHJR  PIC 9(6)V99.
           02 RLUNCHA  PIC 9(6)V99.
           02 RCONVEY  PIC 9(6)V99.
           02 RBUSATR  PIC 9(6)V99.
           02 RLTA     PIC 9(6)V99.
           02 RPF      PIC 9(6)V99.
           02 RESI     PIC 9(6)V99.
           02 RREVDATE PIC X(10).

       FD PAYMENTFILE.
       01 PAYMENTREC.
           02 PEMPID   PIC X(6).
           02 PBASIC   PIC 9(6)V99.
           02 PDA      PIC 9(6)V99.
           02 PCCA     PIC 9(6)V99.
           02 PHRA     PIC 9(6)V99.
           02 PDPA     PIC 9(6)V99.
           02 PPPA     PIC 9(6)V99.
           02 PEDUA    PIC 9(6)V99.
           02 PTECHJR  PIC 9(6)V99.
           02 PLUNCHA  PIC 9(6)V99.
           02 PCONVEY  PIC 9(6)V99.
           02 PBUSATR  PIC 9(6)V99.
           02 PLTA     PIC 9(6)V99.
           02 PPF      PIC 9(6)V99.
           02 PESI     PIC 9(6)V99.
           02 PGRTY    PIC 9(6)V99.
           02 PPTAX    PIC 9(6)V99.
           02 PITAX    PIC 9(6)V99.
           02 PLOAN    PIC 9(8)V99.
           02 PLOANDA  PIC 9(8)V99.
           02 POTHERD  PIC 9(6)V99.
           02 PPERINC  PIC 9(6)V99.
           02 PMEDI    PIC 9(6)V99.
           02 PBOOK    PIC 9(6)V99.
           02 PENTER   PIC 9(6)V99.
           02 PTPH     PIC 9(6)V99.
           02 PHOUSE   PIC 9(6)V99.
           02 PVEHMAN  PIC 9(6)V99.
           02 PCREDIT  PIC 9(6)V99.
           02 PCLUB    PIC 9(6)V99.
           02 PCL      PIC 99.
           02 PSL      PIC 99.
           02 PPL      PIC 99.
           02 PLLOP    PIC 999.
           02 POTHERL  PIC 999.

       FD CONFIRMATIONFILE.
       01 CONFIRMATIONREC.
           02 CCONID   PIC X(6).
           02 CEMPID   PIC X(6).
           02 CCDATE   PIC X(6).

       FD GRADEFILE.
       01 GRADEREC.
           02 GGRADE   PIC 99.
           02 GDESIGN  PIC X(25).

       FD TRANSFERFILE.
       01 TRANSFERREC.
           02 TTRFID   PIC X(6).
           02 TEMPID   PIC X(6).
           02 TOBRID   PIC X(6).
           02 TTRFDT   PIC X(10).

       FD EMPPERSONALFILE.
       01 EMPPERSONALREC.
           02 EPEMPID  PIC X(6).
           02 EPTADD   PIC X(30).
           02 EPTPH    PIC X(10).
           02 EPDOB    PIC X(10).
           02 EPPOB    PIC X(10).
           02 EPLANG   PIC X(15).
           02 EPBLOOD  PIC X(4).
           02 EPWEIGHT PIC 999.
           02 EPHEIGHT PIC 999.
           02 EPVISION PIC X(15).
           02 EPFATHER PIC X(25).
           02 EPDOBF   PIC X(10).
           02 EPMOTHER PIC X(25).
           02 EPDOBM   PIC X(10).
           02 EPSPOUSE PIC X(25).
           02 EPCHILD  PIC X(25).
           02 EPDOBC   PIC X(10).

       WORKING-STORAGE SECTION.

       77 FSO   PIC XX.
       77 FSL   PIC XX.
       77 FSB   PIC XX.
       77 FSDES PIC XX.
       77 FSDEP PIC XX.
       77 FSR   PIC XX.
       77 FSP   PIC XX.
       77 FSC   PIC XX.
       77 FSG   PIC XX.
       77 FST   PIC XX.
       77 FSEP  PIC XX.

       77 DES      PIC X(6).
       77 FS_MSG   PIC X(40).

       77 CHOICE     PIC XX.
       77 STUFF      PIC X(60).
       77 WAITFOR    PIC X.
       77 CRT-STATUS PIC 9(4).

       PROCEDURE DIVISION.
       MAIN-PARA.
           COPY CLEAR-SCREEN.
           DISPLAY "*******************************************"
               AT 0310.
           DISPLAY "     HUMAN RESOURCE MANAGEMENT SYSTEM      "
               AT 0510.
           DISPLAY "*******************************************"
               AT 0710.
           DISPLAY " 1. EMPLOYEE FILE" AT 0920.
           DISPLAY " 2. LEAVE FILE" AT 1020.
           DISPLAY " 3. BRANCH FILE" AT 1120.
           DISPLAY " 4. DESIGNATION FILE" AT 1220.
           DISPLAY " 5. DEPARTMENT FILE" AT 1320.
           DISPLAY " 6. REVISION FILE" AT 1420.
           DISPLAY " 7. PAYMENT FILE" AT 1520.
           DISPLAY " 8. CONFIRMATION FILE" AT 1620.
           DISPLAY " 9. GRADE FILE" AT 1720.
           DISPLAY "10. TRANSFER FILE" AT 1820.
           DISPLAY "11. EMPLOYEE PERSONAL FILE" AT 1920.
           DISPLAY "12. EXIT" AT 2020.
           DISPLAY "ENTER YOUR CHOICE :" AT 2325.
           ACCEPT CHOICE AT 2345.
           IF CHOICE = '1 ' OR CHOICE = '01' OR CRT-STATUS = 1001
              GO TO EMP-PARA
           ELSE
           IF CHOICE = '2 ' OR CHOICE = '02' OR CRT-STATUS = 1002
               GO TO LEAVE-PARA
           ELSE
           IF CHOICE = '3 ' OR CHOICE = '03' OR CRT-STATUS = 1003
               GO TO BRANCH-PARA
           ELSE
           IF CHOICE = '4 ' OR CHOICE = '04' OR CRT-STATUS = 1004
               GO TO DESIGNATION-PARA
           ELSE
           IF CHOICE = '5 ' OR CHOICE = '05' OR CRT-STATUS = 1005
               GO TO DEPARTMENT-PARA
           ELSE
           IF CHOICE = '6 ' OR CHOICE = '06' OR CRT-STATUS = 1006
               GO TO REVISION-PARA
           ELSE
           IF CHOICE = '7 ' OR CHOICE = '07' OR CRT-STATUS = 1007
               GO TO PAYMENT-PARA
           ELSE
           IF CHOICE = '8 ' OR CHOICE = '08' OR CRT-STATUS = 1008
               GO TO CONFIRMATION-PARA
           ELSE
           IF CHOICE = '9 ' OR CHOICE = '09' OR CRT-STATUS = 1009
               GO TO GRADE-PARA
           ELSE
           IF CHOICE = '10' OR CRT-STATUS = 1010
               GO TO TRANSFER-PARA
           ELSE
           IF CHOICE = '11' OR CRT-STATUS = 1011
               GO TO EMPPERSONAL-PARA
           ELSE
               COPY CLEAR-SCREEN.
               DISPLAY "UNIMPLEMENTED OPTION" AT 1010
               ACCEPT STUFF AT 1110
           END-IF
           EXIT PROGRAM.

       BRANCH-PARA.
           COPY CLEAR-SCREEN.

           DISPLAY "****** NEW BRANCH REGISTER ******" AT 0620
           DISPLAY "   ENTER BRANCH CODE: ______" AT 0812
           DISPLAY "   ENTER BRANCH NAME: _______________" AT 0912
           DISPLAY "ENTER BRANCH ADDRESS: _____________________________"
               AT 1012 *> !TODO: Find meaning
           DISPLAY "         ENTER PHONE: __________"
               AT 1112 *> !TODO: Find meaning
           DISPLAY "        ENTER E-MAIL: ____________________"
               AT 1212
           DISPLAY "  ENTER MANAGER NAME: _________________________"
               AT 1312

           ACCEPT BBRID AT 0834 WITH UNDERLINE END-ACCEPT
           ACCEPT BBRNAME AT 0934 WITH UNDERLINE END-ACCEPT
           ACCEPT BBRADD AT 1034 WITH UNDERLINE END-ACCEPT
           ACCEPT BBRPH AT 1134 WITH UNDERLINE END-ACCEPT
           ACCEPT BEMAIL AT 1234 WITH UNDERLINE END-ACCEPT
           ACCEPT BMGRNAME AT 1334 WITH UNDERLINE END-ACCEPT
           *>IF THE FILE DOES NOT EXIST,THIS FAILS !TODO: FIX!
           OPEN I-O BRANCHFILE.
   *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *>>D                          MSG    BY FS_MSG.
   *>>D    STRING "OPEN I-O BRANCHFILE.: " FS_MSG INTO STUFF.
   *>>D    DISPLAY STUFF AT 3099.

           WRITE BRANCHREC.
   *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *>>D                          MSG    BY FS_MSG.
   *>>D    STRING "WRITE BRANCHREC.: " FS_MSG INTO STUFF.
   *>>D    DISPLAY STUFF AT 3199.

           CLOSE BRANCHFILE.
   *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *>>D                          MSG    BY FS_MSG.
   *>>D    STRING "CLOSE BRANCHFILE.: " FS_MSG INTO STUFF.
   *>>D    DISPLAY STUFF AT 3299.

           DISPLAY "CONTINUE" AT 1529.
           ACCEPT WAITFOR AT 1537.
           STOP ' '.
           GOBACK.


       EMP-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O EMPFILE.
           IF FSO = 30
               OPEN OUTPUT EMPFILE
           END-IF
           DISPLAY "ENTER CODE :" AT 0101.
           ACCEPT EEMPID AT 0135.
           DISPLAY "ENTER NAME :" AT 0201.
           ACCEPT EEMPNAME AT 0235.
           DISPLAY "ENTER ADDRESS :" AT 0301.
           ACCEPT EEMPADDR AT 0335.
           DISPLAY "ENTER PHONE :" AT 0401.
           ACCEPT EPHONE AT 0435.
           DISPLAY "ENTER DATE OF JOIN :" AT 0501.
           ACCEPT EDOJ AT 0535.
           DISPLAY "ENTER DIPLOMA :" AT 0601.
           ACCEPT EDIP AT 0635.
           DISPLAY "ENTER UG :" AT 0701.
           ACCEPT EUG AT 0735.
           DISPLAY "ENTER PG :" AT 0801.
           ACCEPT EPG AT 0835.
           DISPLAY "ENTER PROFESSIONAL QUALITY :" AT 0901.
           ACCEPT EPROFQ AT 0935.
           DISPLAY "ENTER SKILL SET :" AT 1001.
           ACCEPT ESKILL AT 1035.
           DISPLAY "ENTER GRADE NUMBER :" AT 1101.
           ACCEPT EGRDNO AT 1135.
           DISPLAY "ENTER BRANCH CODE :" AT 1201.
           ACCEPT EBRNID AT 1235.
           DISPLAY "ENTER DESIGNATION CODE :" AT 1301.
           ACCEPT EDESID AT 1335.
           WRITE EMPREC.
           CLOSE EMPFILE.
           GO TO MAIN-PARA.

       LEAVE-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O LEAVEFILE.
           IF FSL = 30
               OPEN OUTPUT LEAVEFILE
           END-IF
           DISPLAY  "ENTER CODE :" AT 0101.
           ACCEPT LEMPID AT 0135.
           DISPLAY "ENTER FROM DATE :" 0201.
           ACCEPT LFMDATE AT 0235.
           DISPLAY "ENTER TO DATE :" 0301.
           ACCEPT LTODATE AT 0335.
           DISPLAY "ENTER LEAVE CATEGORY :" 0401.
           ACCEPT LLEVCAT AT 0435.
           WRITE LEAVEREC.
           CLOSE LEAVEFILE.
           GO TO MAIN-PARA.

       DESIGNATION-PARA.
           COPY CLEAR-SCREEN.
           OPEN EXTEND DESIGNATIONFILE.
           DISPLAY "ENTER DESIGNATION CODE :" AT 0101.
           ACCEPT DESID AT 0135.
           DISPLAY "ENTER DESIGNATION :" AT 0201.
           ACCEPT DESIGN AT 0235.
           DISPLAY "ENTER DES IN SHORT :" AT 0301.
           ACCEPT DESHRT AT 0335.
           WRITE DESIGNATIONREC.
           CLOSE DESIGNATIONFILE.
           GO TO MAIN-PARA.

       DEPARTMENT-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O DEPARTMENTFILE.
           IF FSDEP = 30
               OPEN OUTPUT DEPARTMENTFILE
           END-IF
           DISPLAY "ENTER DEPARTMENT CODE :" AT 0101.
           ACCEPT DEPCODE AT 0135.
           DISPLAY "ENTER DEPARTMENT NAME :" AT 0201.
           ACCEPT DEPNAME AT 0235.
           WRITE DEPARTMENTREC.
           CLOSE DEPARTMENTFILE.
           GO TO MAIN-PARA.

       REVISION-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O REVISIONFILE.
           IF FSR = 30
               OPEN OUTPUT REVISIONFILE
           END-IF
           DISPLAY "ENTER REVISION CODE :" AT 0101.
           ACCEPT RREVID AT 0135.
           DISPLAY "ENTER EMPLOYEE CODE :" AT 0201.
           ACCEPT REMPID AT 0235.
           DISPLAY "ENTER DESIGNATION CODE :" AT 0301.
           ACCEPT RDESCODE AT 0335.
           DISPLAY "ENTER BASIC :" AT 0401.
           ACCEPT RBASIC AT 0435.
           DISPLAY "ENTER HRA :" AT 0501.
           ACCEPT RHRA AT 0535.
           DISPLAY "ENTER DPA :" AT 0601.
           ACCEPT RDPA AT 0635.
           DISPLAY "ENTER PPA :" AT 0701.
           ACCEPT RPPA AT 0735.
           DISPLAY "ENTER EDUCATIONAL ALLOWANCE :" AT 0801.
           ACCEPT REDUA AT 0835.
           DISPLAY "ENTER TECH. JOURNAL :" AT 0901.
           ACCEPT RTECHJR AT 0935.
           DISPLAY "ENTER LUNCH ALLOWANCE :" AT 1001.
           ACCEPT RLUNCHA AT 3510.
           DISPLAY "ENTER CONVEYANCE :" AT 1101.
           ACCEPT RCONVEY AT 3511.
           DISPLAY "ENTER BUSINESS ATTIREMENT :" AT 1201.
           ACCEPT RBUSATR AT 3512.
           DISPLAY "ENTER LEAVE TRAVEL ALLOWANCE :" AT 1301.
           ACCEPT RLTA AT 3513.
           DISPLAY "ENTER PF :" AT 1401.
           ACCEPT RPF AT 3514.
           DISPLAY "ENTER ESI :" AT 1501.
           ACCEPT RESI AT 3515.
           DISPLAY "ENTER REVISED DATE :" AT 1601.
           ACCEPT RREVDATE AT 3516.
           WRITE REVISIONREC.
           CLOSE REVISIONFILE.
           GO TO MAIN-PARA.

       PAYMENT-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O PAYMENTFILE.
           IF FSP = 30
               OPEN OUTPUT PAYMENTFILE
           END-IF
           DISPLAY "ENTER EMPLOYEE CODE :" AT 0101.
           ACCEPT PEMPID AT 0135.
           DISPLAY "ENTER BASIC :" AT 0201.
           ACCEPT PBASIC AT 0235.
           DISPLAY "ENTER DA :" AT 0301.
           ACCEPT PDA AT 0335.
           DISPLAY "ENTER CCA :" AT 0401.
           ACCEPT PCCA AT 0435.
           DISPLAY "ENTER HRA :" AT 0501.
           ACCEPT PHRA AT 0535.
           DISPLAY "ENTER DPA :" AT 0601.
           ACCEPT PDPA AT 0635.
           DISPLAY "ENTER PPA :" AT 0701.
           ACCEPT PPPA AT 0735.
           DISPLAY "ENTER EDUCATIONAL ALLOWANCE :" AT 0801.
           ACCEPT PEDUA AT 0835.
           DISPLAY "ENTER TECH. JOURNAL :" AT 0901.
           ACCEPT PTECHJR AT 0935.
           DISPLAY "ENTER LUNCH ALLOWANCE :" AT 1001.
           ACCEPT PLUNCHA AT 1035.
           DISPLAY "ENTER CONVEYANCE :" AT 1101.
           ACCEPT PCONVEY AT 1135.
           DISPLAY "ENTER BUSINESS ATTIREMENT :" AT 1201.
           ACCEPT PBUSATR AT 1235.
           DISPLAY "ENTER LEAVE TRAVEL ALLOWANCE :" AT 1301.
           ACCEPT PLTA AT 1335.
           DISPLAY "ENTER PF :" AT 1401.
           ACCEPT PPF AT 1435.
           DISPLAY "ENTER ESI :" AT 1501.
           ACCEPT PESI AT 1535.
           DISPLAY "ENTER GRATUITY :" AT 1601.
           ACCEPT PGRTY AT 1635.
           DISPLAY "ENTER PROFESSIONAL TAX :" AT 1701.
           ACCEPT PPTAX AT 1735.
           DISPLAY "ENTER INCOME TAX :" AT 1801.
           ACCEPT PITAX AT 1835.
           DISPLAY "ENTER LOAN :" AT 1901.
           ACCEPT PLOAN AT 1935.
           DISPLAY "ENTER LOAN DEDUCTION AMOUNT :" AT 2001.
           ACCEPT PLOANDA AT 1035.
           DISPLAY "ENTER OTHER DEDUCTION :" AT 2101.
           ACCEPT POTHERD AT 1135.
           DISPLAY "ENTER PERFORMANCE INCENTIVE :" AT 2201.
           ACCEPT PPERINC AT 1235.
           DISPLAY "ENTER MEDICAL REIMBURSEMENT :" AT 2301.
           ACCEPT PMEDI AT 1335.
           DISPLAY "ENTER BOOK REIMBURSEMENT :" AT 2401.
           ACCEPT PBOOK AT 1435.
           COPY CLEAR-SCREEN.
           DISPLAY "ENTER ENTERTAINMENT :" AT 0101.
           ACCEPT PENTER AT 0135.
           DISPLAY "ENTER PHONE :" AT 0201.
           ACCEPT PTPH AT 0235.
           DISPLAY "ENTER HOUSE RELATED :" AT 0301.
           ACCEPT PHOUSE AT 0335.
           DISPLAY "ENTER VEHICLE MAINTENANCE :" AT 0401.
           ACCEPT PVEHMAN AT 0435.
           DISPLAY "ENTER CREDIT CARD :" AT 0501.
           ACCEPT PCREDIT AT 0535.
           DISPLAY "ENTER CLUB :" AT 0601.
           ACCEPT PCLUB AT 0635.
           DISPLAY "ENTER CLUB :" AT 0701.
           ACCEPT PCLUB AT 0735.
           DISPLAY "ENTER CLUB :" AT 0801.
           ACCEPT PCLUB AT 0835.
           DISPLAY "ENTER CASUAL LEAVE :" AT 0901.
           ACCEPT PCL AT 0935.
           DISPLAY "ENTER SICK LEAVE :" AT 1001.
           ACCEPT PSL AT 1035.
           DISPLAY "ENTER PAID LEAVE :" AT 1101.
           ACCEPT PPL AT 1135.
           DISPLAY "ENTER LEAVE LOSS OF PAY :" AT 1201.
           ACCEPT PLLOP AT 1235.
           DISPLAY "ENTER OTHER LEAVES :" AT 1301.
           ACCEPT POTHERL AT 1335.
           WRITE PAYMENTREC.
           CLOSE PAYMENTFILE.
           GO TO MAIN-PARA.

       CONFIRMATION-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O CONFIRMATIONFILE.
           IF FSC = 30
               OPEN OUTPUT CONFIRMATIONFILE
           END-IF
           DISPLAY "ENTER CONFIRMATION CODE :" AT 0101.
           ACCEPT CCONID AT 0135.
           DISPLAY "ENTER EMP CODE :" AT 0201.
           ACCEPT CEMPID AT 0235.
           DISPLAY "ENTER CONFIRMATION DATE :" AT 0301.
           ACCEPT CCDATE AT 0335.
           WRITE CONFIRMATIONREC.
           CLOSE CONFIRMATIONFILE.
           GO TO MAIN-PARA.

       GRADE-PARA.
           COPY CLEAR-SCREEN.
           OPEN EXTEND GRADEFILE.
           DISPLAY "ENTER GRADE NO. :" AT 0101.
           ACCEPT GGRADE AT 0135.
           DISPLAY "ENTER DESIGNATION :" AT 0201.
           ACCEPT GDESIGN AT 0235.
           WRITE GRADEREC.
           CLOSE GRADEFILE.
           GO TO MAIN-PARA.

       TRANSFER-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O TRANSFERFILE.
           IF FST = 30
               OPEN OUTPUT TRANSFERFILE
           END-IF
           DISPLAY "ENTER TRANSFER CODE :" AT 0101.
           ACCEPT TTRFID AT 0135.
           DISPLAY "ENTER EMP CODE :" AT 0201.
           ACCEPT TEMPID AT 0235.
           DISPLAY "ENTER OLD BRANCH CODE :" AT 0301.
           ACCEPT TOBRID AT 0335.
           DISPLAY "ENTER TRANSFER DATE :" AT 0401.
           ACCEPT TTRFDT AT 0435.
           WRITE TRANSFERREC.
           CLOSE TRANSFERFILE.
           GO TO MAIN-PARA.

       EMPPERSONAL-PARA.
           COPY CLEAR-SCREEN.
           OPEN I-O EMPPERSONALFILE.
           IF FSEP = 30
               OPEN OUTPUT EMPPERSONALFILE
           END-IF
           DISPLAY "ENTER EMP CODE :" AT 0101.
           ACCEPT EPEMPID AT 0135.
           DISPLAY "ENTER TEMP ADDRESS :" AT 0201.
           ACCEPT EPTADD AT 0235.
           DISPLAY "ENTER PHONE :" AT 0301.
           ACCEPT EPTPH AT 0335.
           DISPLAY "ENTER DOB :" AT 0401.
           ACCEPT EPDOB AT 0435.
           DISPLAY "ENTER POB :" AT 0501.
           ACCEPT EPPOB AT 0535.
           DISPLAY "ENTER LANGUAGE KNOWN :" AT 0601.
           ACCEPT EPLANG AT 0635.
           DISPLAY "ENTER BLOOD GROUP :" AT 0701.
           ACCEPT EPBLOOD AT 0735.
           DISPLAY "ENTER WEIGHT :" AT 0801.
           ACCEPT EPWEIGHT AT 0835.
           DISPLAY "ENTER HEIGHT :" AT 0901.
           ACCEPT EPHEIGHT AT 0935.
           DISPLAY "ENTER VISION :" AT 1001.
           ACCEPT EPVISION AT 1035.
           DISPLAY "ENTER FATHER'S NAME :" AT 1101.
           ACCEPT EPFATHER AT 1135.
           DISPLAY "ENTER DOB OF FATHER :" AT 1201.
           ACCEPT EPDOBF AT 1235.
           DISPLAY "ENTER MOTHER'S NAME :" AT 1301.
           ACCEPT EPMOTHER AT 1335.
           DISPLAY "ENTER DOB OF MOTHER :" AT 1401.
           ACCEPT EPDOBM AT 1435.
           DISPLAY "ENTER SPOUSE NAME :" AT 1501.
           ACCEPT EPSPOUSE AT 1535.
           DISPLAY "ENTER CHILD NAME :" AT 1601.
           ACCEPT EPCHILD AT 1635.
           DISPLAY "ENTER DOB OF CHILD :" AT 1701.
           ACCEPT EPDOBC AT 1735.
           WRITE EMPPERSONALREC.
           CLOSE EMPPERSONALFILE.
           GO TO MAIN-PARA.

       END PROGRAM EMPWRITE.
