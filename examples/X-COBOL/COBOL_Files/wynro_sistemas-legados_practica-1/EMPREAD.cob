       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMPREAD.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CRT STATUS IS CRT-STATUS.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPFILE
               *> Create file definition and assign it to a specific "EMP.DAT"
               ASSIGN TO "files/EMP.DAT"
               *> Exists a field in the file that acts as Key.
               *> That allows sequential or random reading
               ORGANIZATION IS INDEXED
               *> Allows both sequential or random reading of the file
               ACCESS MODE IS DYNAMIC
               *> The field of the file that will index it
               RECORD KEY IS EEMPID
               *> Special variable that will contain the status of the file
               FILE STATUS IS FSE.

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

       FD DESIGNATIONFILE.
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
       77 FSE   PIC XX.
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
       77 DES   PIC X(6).

       77 GR     PIC 99.

       77 CHOICE PIC XX.
       77 STUFF  PIC 9.
       77 FS_MSG PIC X(40).
       77 FS_MSG_AUX PIC X(40).
       77 CRT-STATUS PIC 9(4).

       PROCEDURE DIVISION.
       MAIN-PARA.
           COPY CLEAR-SCREEN..
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
              *> IF CHOICadsfE = '3 ' OR CRT-STATUS = 1003
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
               COPY CLEAR-SCREEN..
               DISPLAY "UNIMPLEMENTED OPTION" AT 1010
               ACCEPT STUFF AT 1110.
           EXIT PROGRAM.

       EMP-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT EMPFILE.
           DISPLAY "ENTER CODE :".
           ACCEPT EEMPID.
           COPY CLEAR-SCREEN.
           READ EMPFILE INVALID KEY GO TO ERROR-EMP-PARA.
           DISPLAY " CODE                 :" EEMPID AT 0101.
           DISPLAY " NAME                 :" EEMPNAME AT 0201.
           DISPLAY " ADDRESS              :" EEMPADDR AT 0301.
           DISPLAY " PHONE                :" EPHONE AT 0401.
           DISPLAY " DATE OF JOIN         :" EDOJ AT 0501.
           DISPLAY " DIPLOMA              :" EDIP AT 0601.
           DISPLAY " UG                   :" EUG AT 0701.
           DISPLAY " PG                   :" EPG AT 0801.
           DISPLAY " PROFESSIONAL QUALITY :" EPROFQ AT 0901.
           DISPLAY" SKILL SET            :" ESKILL AT 1001.
           DISPLAY" GRADE NUMBER         :" EGRDNO AT 1101.
           DISPLAY" BRANCH CODE          :" EBRNID AT 1201.
           DISPLAY" DESIGNATION CODE     :" EDESID AT 1301.
           CLOSE EMPFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       LEAVE-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT LEAVEFILE.
           DISPLAY "ENTER CODE :".
           ACCEPT LEMPID.
           COPY CLEAR-SCREEN.
           READ LEAVEFILE INVALID KEY GO TO ERROR-LEAVE-PARA.
           DISPLAY " CODE           :" LEMPID AT 0101.
           DISPLAY " DATE           :" LFMDATE AT 0201.
           DISPLAY " DATE           :" LTODATE AT 0301.
           DISPLAY " LEAVE CATEGORY :" LLEVCAT AT 0401.
           CLOSE LEAVEFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       DESIGNATION-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT DESIGNATIONFILE.
           DISPLAY "ENTER THE DESIGNATION CODE :".
           ACCEPT DES.
           COPY CLEAR-SCREEN.
           PERFORM DES-READ-PARA UNTIL FSDES = 10.
       DES-READ-PARA.
           READ DESIGNATIONFILE AT END GO TO DES-EXIT-PARA.
           IF DESID = DES
           DISPLAY " DESIGNATION CODE     :" DESID AT 0101.
           DISPLAY " DESIGNATION          :" DESIGN AT 0201.
           DISPLAY " DESIGNATION IN SHORT :" DESHRT AT 0301.
       DES-EXIT-PARA.
           CLOSE DESIGNATIONFILE.
           DISPLAY ' '.
           DISPLAY ' '.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       DEPARTMENT-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT DEPARTMENTFILE.
           DISPLAY "ENTER DEP CODE :".
           ACCEPT DEPCODE.
           COPY CLEAR-SCREEN.
           READ DEPARTMENTFILE INVALID KEY
                     GO TO ERROR-DEPARTMENT-PARA.
           DISPLAY " DEPARTMENT CODE :" DEPCODE AT 0101.
           DISPLAY " DEPARTMENT NAME :" DEPNAME AT 0201.
           CLOSE DEPARTMENTFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       REVISION-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT REVISIONFILE.
           DISPLAY "ENTER REVISION CODE:".
           ACCEPT RREVID.
           COPY CLEAR-SCREEN.
           READ REVISIONFILE INVALID KEY
                    GO TO ERROR-REVISION-PARA.
           DISPLAY " REVISION CODE           :" RREVID AT 0101.
           DISPLAY " EMPLOYEE CODE           :" REMPID AT 0201.
           DISPLAY " DESIGNATION CODE        :" RDESCODE AT 0301.
           DISPLAY " BASIC                   :" RBASIC AT 0401.
           DISPLAY " HRA                     :" RHRA AT 0501.
           DISPLAY " DPA                     :" RDPA AT 0601.
           DISPLAY " PPA                     :" RPPA AT 0701.
           DISPLAY " EDUCATIONAL ALLOWANCE   :" REDUA AT 0801.
           DISPLAY " TECHNICAL JOURNAL       :" RTECHJR AT 0901.
           DISPLAY " LUNCH ALLOWANCE        :" RLUNCHA AT 1001.
           DISPLAY " CONVEYANCE             :" RCONVEY AT 1101.
           DISPLAY " BUSINESS ATTIREMENT    :" RBUSATR AT 1201.
           DISPLAY " LEAVE TRAVEL ALLOWANCE :" RLTA AT 1301.
           DISPLAY " PF                     :" RPF AT 1401.
           DISPLAY " ESI                    :" RESI AT 1501.
           DISPLAY " REVISED DATE           :" RREVDATE AT 1601.
           CLOSE REVISIONFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       PAYMENT-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT PAYMENTFILE.
           DISPLAY "ENTER EMP CODE :".
           ACCEPT PEMPID.
           COPY CLEAR-SCREEN.
           READ PAYMENTFILE INVALID KEY GO TO ERROR-PAYMENT-PARA.
           DISPLAY " EMPLOYEE CODE                  :" PEMPID AT 0101.
           DISPLAY " BASIC                          :" PBASIC AT 0201.
           DISPLAY " DEARNESS ALLOWANCE             :" PDA AT 0301.
           DISPLAY " CITY COMPENSATORY ALLOWANCE    :" PCCA AT 0401.
           DISPLAY " HRA                            :" PHRA AT 0501.
           DISPLAY " DPA                            :" PDPA AT 0601.
           DISPLAY " PPA                            :" PPPA AT 0701.
           DISPLAY " EDUCATIONAL ALLOWANCE          :" PEDUA AT 0801.
           DISPLAY " TECHNICAL JOURNAL              :" PTECHJR AT 0901.
           DISPLAY " LUNCH ALLOWANCE               :" PLUNCHA AT 1001.
           DISPLAY " CONVEYANCE                    :" PCONVEY AT 1101.
           DISPLAY " BUSINESS ATTIREMENT           :" PBUSATR AT 1201.
           DISPLAY " LEAVE TRAVEL ALLOWANCE        :" PLTA AT 1301.
           DISPLAY " PF                            :" PPF AT 1401.
           DISPLAY " ESI                           :" PESI AT 1501.
           DISPLAY " GRATUITY                      :" PGRTY AT 1601.
           DISPLAY " PROFESSIONAL TAX              :" PPTAX AT 1701.
           DISPLAY " INCOME TAX                    :" PITAX AT 1801.
           DISPLAY " LOAN                          :" PLOAN AT 1901.
           DISPLAY " LOAN DEDUCTION AMOUNT         :" PLOANDA AT 2001.
           DISPLAY " OTHER DEDUCTION               :" POTHERD AT 2101.
           DISPLAY " PERFORMANCE INCENTIVE         :" PPERINC AT 2201.
           DISPLAY " MEDICAL REIMBURSEMENT         :" PMEDI AT 2301.
           DISPLAY " BOOK REIMBURSEMENT            :" PBOOK AT 2401.
           COPY CLEAR-SCREEN.
           DISPLAY " ENTERTAINMENT                  :" PENTER AT 0101.
           DISPLAY " PHONE                          :" PTPH AT 0201.
           DISPLAY " HOUSE RELATED                  :" PHOUSE AT 0301.
           DISPLAY " VEHICLE MAINTENANCE            :" PVEHMAN AT 0401.
           DISPLAY " CREDIT CARD                    :" PCREDIT AT 0501.
           DISPLAY " CLUB                           :" PCLUB AT 0601.
           DISPLAY " CASUAL LEAVE                   :" PCL AT 0701.
           DISPLAY " SICK LEAVE                     :" PSL AT 0801.
           DISPLAY " PAID LEAVE                     :" PPF AT 0901.
           DISPLAY " LEAVE LOSS OF PAY             :" PLLOP AT 1001.
           DISPLAY " OTHER LEAVES                  :" POTHERL AT 1101.
           CLOSE PAYMENTFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       CONFIRMATION-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT CONFIRMATIONFILE.
           DISPLAY "ENTER CODE :".
           ACCEPT CCONID.
           COPY CLEAR-SCREEN.
           READ CONFIRMATIONFILE INVALID KEY
                   GO TO ERROR-CONFIRMATION-PARA.
           DISPLAY " CONFIRMATION CODE :" CCONID AT 0101.
           DISPLAY " EMPLOYEE CODE     :" CEMPID AT 0201.
           DISPLAY " CONFIRMATION DATE :" CCDATE AT 0301.
           CLOSE CONFIRMATIONFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       GRADE-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT GRADEFILE.
           DISPLAY "ENTER GRADE NO. :".
           ACCEPT GR.
           COPY CLEAR-SCREEN.
           PERFORM GR-READ-PARA UNTIL FSG = 10.
       GR-READ-PARA.
           READ GRADEFILE AT END GO TO GR-EXIT-PARA.
           IF GGRADE = GR
           DISPLAY " GRADE NO.   :" GGRADE AT 0101.
           DISPLAY " DESIGNATION :" GDESIGN AT 0201.
       GR-EXIT-PARA.
           CLOSE GRADEFILE.
           DISPLAY ' '.
           DISPLAY ' '.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU".
           ACCEPT CHOICE AT 2020.
           GO TO MAIN-PARA.

       TRANSFER-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT TRANSFERFILE.
           DISPLAY "ENTER TRANSFER CODE :".
           ACCEPT TTRFID.
           COPY CLEAR-SCREEN.
           READ TRANSFERFILE INVALID KEY GO TO ERROR-TRANSFER-PARA.
           DISPLAY " TRANSFER CODE     :" TTRFID AT 0101.
           DISPLAY " EMP CODE          :" TEMPID AT 0201.
           DISPLAY " OLD BRANCH CODE   :" TOBRID AT 0301.
           DISPLAY " TRANSFER DATE     :" TTRFDT AT 0401.
           CLOSE TRANSFERFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       EMPPERSONAL-PARA.
           COPY CLEAR-SCREEN.
           OPEN INPUT EMPPERSONALFILE.
           DISPLAY "ENTER EMP CODE :".
           ACCEPT EPEMPID.
           COPY CLEAR-SCREEN.
           READ EMPPERSONALFILE INVALID KEY
                           GO TO ERROR-EMPPERSONAL-PARA.
           DISPLAY " EMPLOYEE CODE     :" EPEMPID AT 0101.
           DISPLAY " TEMPORARY ADDRESS :" EPTADD AT 0201.
           DISPLAY " PHONE             :" EPTPH AT 0301.
           DISPLAY " DOB               :" EPDOB AT 0401.
           DISPLAY " POB               :" EPPOB AT 0501.
           DISPLAY " LANGUAGE KNOWN    :" EPLANG AT 0601.
           DISPLAY " BLOOD GROUP       :" EPBLOOD AT 0701.
           DISPLAY " WEIGHT            :" EPWEIGHT AT 0801.
           DISPLAY " HEIGHT            :" EPHEIGHT AT 0901.
           DISPLAY " VISION           :" EPVISION AT 1001.
           DISPLAY " FATHER'S NAME    :" EPFATHER AT 1101.
           DISPLAY " DOB OF FATHER    :" EPDOBF AT 1201.
           DISPLAY " MOTHER'S NAME    :" EPMOTHER AT 1301.
           DISPLAY " DOB OF MOTHER    :" EPDOBM AT 1401.
           DISPLAY " SPOUSE NAME      :" EPSPOUSE AT 1501.
           DISPLAY " CHILD NAME       :" EPCHILD AT 1601.
           DISPLAY " DOB OF CHILD     :" EPDOBC AT 1701.
           CLOSE EMPPERSONALFILE.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-EMP-PARA.
           CLOSE EMPFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-LEAVE-PARA.
           CLOSE LEAVEFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-BRANCH-PARA.
           CLOSE BRANCHFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-DEPARTMENT-PARA.
           CLOSE DEPARTMENTFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-REVISION-PARA.
           CLOSE REVISIONFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-PAYMENT-PARA.
           CLOSE PAYMENTFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-CONFIRMATION-PARA.
           CLOSE CONFIRMATIONFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-TRANSFER-PARA.
           CLOSE TRANSFERFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       ERROR-EMPPERSONAL-PARA.
           CLOSE EMPPERSONALFILE.
           COPY CLEAR-SCREEN.
           DISPLAY "INVALID CODE" AT 1203.
           DISPLAY "PRESS ENTER TO RETURN TO HRMS READ MENU" AT 2001.
           ACCEPT CHOICE AT 2040.
           GO TO MAIN-PARA.

       BRANCH-PARA.
           COPY CLEAR-SCREEN..
           OPEN INPUT BRANCHFILE.
   *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *>>D                          MSG    BY FS_MSG.
   *>>D    STRING "OPEN INPUT BRANCHFILE.: " FS_MSG INTO FS_MSG_AUX.
   *>>D    DISPLAY FS_MSG_AUX AT 3099.
           DISPLAY "BRANCH CODE: " AT 0101.
           ACCEPT BBRID AT 0114.
           READ BRANCHFILE RECORD
               INTO BRANCHREC
               INVALID KEY GO TO ERROR-BRANCH-PARA.
   *>>D    COPY FS-MSG REPLACING STATUS BY FSB
   *>>D                          MSG    BY FS_MSG.
   *>>D    STRING "READ BRANCHFILE: " FS_MSG INTO FS_MSG_AUX.
   *>>D    DISPLAY FS_MSG_AUX AT 3199.
           COPY CLEAR-SCREEN..
           DISPLAY "   BBRID:" AT 0101
           DISPLAY " BBRNAME:" AT 0201
           DISPLAY "  BBRADD:" AT 0301
           DISPLAY "   BBRPH:" AT 0401
           DISPLAY "  BEMAIL:" AT 0501
           DISPLAY "BMGRNAME:" AT 0601
           DISPLAY BBRID AT 0111
           DISPLAY BBRNAME AT 0211
           DISPLAY BBRADD AT 0311
           DISPLAY BBRPH AT 0411
           DISPLAY BEMAIL AT 0511
           DISPLAY BMGRNAME AT 0611

           CLOSE BRANCHFILE.
           DISPLAY "RETURN" AT 0701
           ACCEPT EEMPID AT 0707.
           ACCEPT CHOICE AT 2020.
           GOBACK.

       END PROGRAM EMPREAD.
