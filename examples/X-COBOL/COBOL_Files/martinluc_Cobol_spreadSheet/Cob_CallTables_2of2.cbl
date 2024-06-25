   File  Edit  Edit_Settings  Menu  Utilities  Compilers  Test  Help
 -------------------------------------------------------------------------------
 EDIT       ADS02.ADS0205.SRC(ADSOTP8) - 01.99              Columns 00001 00072
 ****** ***************************** Top of Data ******************************
 000001       *===============================================================*
 000002       *--                INFORMATIONS GENERALES                     --*
 000003       *---------------------------------------------------------------*
 000004       *  NOM DU PROGRAMME : XXXXXXXX                                  *
 000005       *  NOM DU REDACTEUR : MARTINLUC                                 *
 000006       *---------------------------------------------------------------*
 000007       *  SOCIETE          : XXXXXXXX                                  *
 000008       *  DATE DE CREATION : JJ/MM/SSAA                                *
 000009       *---------------------------------------------------------------*
 000010       *--               OBJECTIFS GENERAUX DU PROGRAMME             --*
 000011       * GESTION DE TABLEAUX, PROGRAMME APPELE.                        *
 000012       *---------------------------------------------------------------*
 000013       *--               HISTORIQUE DES MODIFICATIONS --               *
 000014       *---------------------------------------------------------------*
 000015       * DATE  MODIF   !          NATURE DE LA MODIFICATION            *
 000016       *---------------------------------------------------------------*
 000017       * JJ/MM/SSAA    !                                               *
 000018       *===============================================================*
 000019       *
 000020       *************************
 000021        IDENTIFICATION DIVISION.
 000022       *************************
 000023        PROGRAM-ID.      ADSOTP8.
 000024       *
 000025       *                  ==============================               *
 000026       *=================<  ENVIRONMENT      DIVISION   >==============*
 000027       *                  ==============================               *
 000028       *                                                               *
 000029       *===============================================================*
 000030       *
 000031       **********************
 000032        ENVIRONMENT DIVISION.
 000033       **********************
 000034       *
 000035       *======================
 000036        CONFIGURATION SECTION.
 000037       *======================
 000038       *
 000039       *--------------
 000040        SPECIAL-NAMES.
 000041       *--------------
 000042            DECIMAL-POINT IS COMMA.
 000043       *
 000044       *=====================
 000045        INPUT-OUTPUT SECTION.
 000046       *=====================
 000047       *
 000048       *-------------
 000049        FILE-CONTROL.
 000050       *-------------
 000051       *
 000052       ***************
 000053        DATA DIVISION.
 000054       ***************
 000055       *
 000056       *=============
 000057        FILE SECTION.
 000058       *=============
 000059       *
 000060       *========================
 000061        WORKING-STORAGE SECTION.
 000062       *========================
 000063        01 WS-ILIGNE                          PIC 99.
 000064        01 WS-ICOLONNE                        PIC 99.
 000065        01 WS-IHAUTEUR                        PIC 99.
 000066        01 WS-CPT-CASE                        PIC 9(3).
 000067       *
 000068       *========================
 000069        LINKAGE SECTION.
 000070       *========================
 000071       *
 000072        01  LS-TABLEAU-1.
 000073            05  FILLER                        OCCURS 10.
 000074                10  FILLER                    OCCURS 10.
 000075                    15  FILLER                OCCURS 10.
 000076                        20  LS-CELL-TAB-1     PIC 9(2).
 000077       *
 000078        01  LS-TABLEAU-3.
 000079            05  FILLER                        OCCURS 100.
 000080                10  LS-CELL.
 000081                    15  LS-CELL-X             PIC 99.
 000082                    15  LS-CELL-Y             PIC 99.
 000083                    15  LS-CELL-Z             PIC 99.
 000084       *
 000085        01  LS-S                              PIC 9(2).
 000086        01  LS-E                              PIC 9(2).
 000087       *
 000088       *                  ==============================               *
 000089       *=================<   PROCEDURE       DIVISION   >==============*
 000090       *                  ==============================               *
 000091       *                                                               *
 000092       *===============================================================*
 000093       *
 000094        PROCEDURE           DIVISION
 000095       *
 000096            USING LS-TABLEAU-1 LS-TABLEAU-3 LS-S LS-E.
 000097       *
 000098       *---------------------------------------------------------------*
 000099       *               DESCRIPTION DU COMPOSANT PROGRAMME              *
 000100       *               ==================================              *
 000101       *---------------------------------------------------------------*
 000102       *
 000103
 000104        0000-PROGRAMME-DEB.
 000105       *
 000106            IF LS-E NOT NUMERIC
 000107                     MOVE 1 TO RETURN-CODE
 000108                     GOBACK
 000109            END-IF.
 000110
 000111                INITIALIZE LS-TABLEAU-3 WS-CPT-CASE LS-S.
 000112
 000113                PERFORM 1000-LECTURE-TAB-1-DEB
 000114                   THRU 1000-LECTURE-TAB-1-FIN
 000115                VARYING WS-ILIGNE FROM 1 BY 1
 000116                  UNTIL WS-ILIGNE > 10
 000117
 000118                  AFTER WS-ICOLONNE FROM 1 BY 1
 000119                  UNTIL WS-ICOLONNE > 10
 000120
 000121                  AFTER WS-IHAUTEUR FROM 1 BY 1
 000122                  UNTIL WS-IHAUTEUR > 10.
 000123
 000124
 000125       *
 000126        0000-PROGRAMME-FIN.
 000127             GOBACK.
 000128       *
 000129        1000-LECTURE-TAB-1-DEB.
 000130
 000131            IF LS-E = LS-CELL-TAB-1
 000132                      ( WS-ILIGNE , WS-ICOLONNE , WS-IHAUTEUR )
 000133               ADD 1 TO LS-S
 000134               MOVE WS-ILIGNE TO LS-CELL-X (LS-S)
 000135               MOVE WS-ICOLONNE TO LS-CELL-Y (LS-S)
 000136               MOVE WS-IHAUTEUR TO LS-CELL-Z (LS-S)
 000137            END-IF.
 000138
 000139        1000-LECTURE-TAB-1-FIN.
 000140            EXIT.
 ****** **************************** Bottom of Data ****************************














 Command ===>                                                  Scroll ===> CSR
  F1=Help      F2=Split     F3=Exit      F5=Rfind     F6=Rchange   F7=Up
  F8=Down      F9=Swap     F10=Left     F11=Right    F12=Cancel
================================================================================
   File  Edit  Edit_Settings  Menu  Utilities  Compilers  Test  Help
 -------------------------------------------------------------------------------
 EDIT       ADS02.ADS0205.SRC(ADSOTP8) - 01.99              Columns 00001 00072
 ****** **************************** Bottom of Data ****************************

























 Command ===>                                                  Scroll ===> CSR
  F1=Help      F2=Split     F3=Exit      F5=Rfind     F6=Rchange   F7=Up
  F8=Down      F9=Swap     F10=Left     F11=Right    F12=Cancel
================================================================================
