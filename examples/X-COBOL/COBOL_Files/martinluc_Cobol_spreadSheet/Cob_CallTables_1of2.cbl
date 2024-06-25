   File  Edit  Edit_Settings  Menu  Utilities  Compilers  Test  Help
 -------------------------------------------------------------------------------
 EDIT       ADS02.ADS0205.SRC(ADSOTP7) - 01.99              Columns 00001 00072
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
 000011       * GESTION DE TABLEAUX VIA UN PROGRAMME EXTERNE.                 *
 000012       *---------------------------------------------------------------*
 000013       *--               HISTORIQUE DES MODIFICATIONS --               *
 000014       *---------------------------------------------------------------*
 000015       * DATE  MODIF   !          NATURE DE LA MODIFICATION            *
 000016       *---------------------------------------------------------------*
 000017       * JJ/MM/SSAA    !                                               *
 000018       *               !                                               *
 000019       *===============================================================*
 000020       *
 000021       *************************
 000022        IDENTIFICATION DIVISION.
 000023       *************************
 000024        PROGRAM-ID.      ADSOTP7.
 000025       *
 000026       *                  ==============================               *
 000027       *=================<  ENVIRONMENT      DIVISION   >==============*
 000028       *                  ==============================               *
 000029       *                                                               *
 000030       *===============================================================*
 000031       *
 000032       **********************
 000033        ENVIRONMENT DIVISION.
 000034       **********************
 000035       *
 000036       *======================
 000037        CONFIGURATION SECTION.
 000038       *======================
 000039       *
 000040       *--------------
 000041        SPECIAL-NAMES.
 000042       *--------------
 000043            DECIMAL-POINT IS COMMA.
 000044       *
 000045       *=====================
 000046        INPUT-OUTPUT SECTION.
 000047       *=====================
 000048       *
 000049       *-------------
 000050        FILE-CONTROL.
 000051       *-------------
 000052       *
 000053       *                  ==============================               *
 000054       *=================<       DATA        DIVISION   >==============*
 000055       *                  ==============================               *
 000056       *                                                               *
 000057       *===============================================================*
 000058       *
 000059       ***************
 000060        DATA DIVISION.
 000061       ***************
 000062       *
 000063       *=============
 000064        FILE SECTION.
 000065       *=============
 000066       *
 000067       *========================
 000068        WORKING-STORAGE SECTION.
 000069       *========================
 000070        01  WS-TABLEAU-1.
 000071            05  FILLER                        OCCURS 10.
 000072                10  FILLER                    OCCURS 10.
 000073                    15  FILLER                OCCURS 10.
 000074                        20  WS-CELL-TAB-1     PIC 9(2).
 000075       *
 000076        01  WS-TABLEAU-3.
 000077            05  FILLER                        OCCURS 100.
 000078                10  WS-CELL.
 000079                    15  WS-CELL-X             PIC 9(2).
 000080                    15  WS-CELL-Y             PIC 9(2).
 000081                    15  WS-CELL-Z             PIC 9(2).
 000082       *
 000083        01  WS-ILIGNE                         PIC 99.
 000084        01  WS-ICOLONNE                       PIC 99.
 000085        01  WS-IHAUTEUR                       PIC 99.
 000086        01  WS-COMPTEUR                       PIC 9(2).
 000087        01  WS-E-ENTRE.
 000088            05  WS-E                          PIC 9(2).
 000089            05  WS-FIN-E  REDEFINES WS-E      PIC X(2).
 000090        01  WS-S                              PIC 9(2).
 000091        01  WS-I-X                            PIC 9(3).
 000092
 000093        01  WS-LEDIT                          PIC X(80).
 000094       *
 000095       *                  ==============================               *
 000096       *=================<   PROCEDURE       DIVISION   >==============*
 000097       *                  ==============================               *
 000098       *                                                               *
 000099       *===============================================================*
 000100       *
 000101        PROCEDURE           DIVISION.
 000102       *
 000103       *===============================================================*
 000104       *    STRUCTURATION DE LA PARTIE ALGORITHMIQUE DU PROGRAMME      *
 000105       *---------------------------------------------------------------*
 000106       *                                                               *
 000107       *    1 : LES COMPOSANTS DU DIAGRAMME SONT CODES A L'AIDE DE     *
 000108       *        DEUX PARAGRAPHES  XXXX-COMPOSANT-DEB                   *
 000109       *                          XXYY-COMPOSANR-FIN                   *
 000110       *                                                               *
 000111       *    2 : XX REPRESENTE LE NIVEAU HIERARCHIQUE                   *
 000112       *        YY DIFFERENCIE LES COMPOSANTS DE MEME NIVEAU           *
 000113       *                                                               *
 000114       *    3 : TOUT COMPOSANT EST PRECEDE D'UN CARTOUCHE DE           *
 000115       *        COMMENTAIRE QUI EXPLICITE LE ROLE DU COMPOSANT         *
 000116       *                                                               *
 000117       *                                                               *
 000118       *===============================================================*
 000119       *===============================================================*
 000120       *
 000121       *
 000122       *---------------------------------------------------------------*
 000123       *               DESCRIPTION DU COMPOSANT PROGRAMME              *
 000124       *               ==================================              *
 000125       *---------------------------------------------------------------*
 000126       *
 000127        0000-PROGRAMME-DEB.
 000128       *
 000129       *
 000130            INITIALIZE WS-TABLEAU-3 WS-S WS-E.
 000131       *---------------------------------------------------------------*
 000132       * OREILETTE DE GAUCHE                                           *
 000133       * ===================                                           *
 000134       *---------------------------------------------------------------*
 000135       *
 000136
 000137            PERFORM 1000-INIT-TABLEAU-1-DEB
 000138               THRU 1000-INIT-TABLEAU-1-FIN
 000139            VARYING WS-ILIGNE FROM 1 BY 1
 000140              UNTIL WS-ILIGNE > 10
 000141
 000142              AFTER WS-ICOLONNE FROM 1 BY 1
 000143              UNTIL WS-ICOLONNE > 10
 000144
 000145              AFTER WS-IHAUTEUR FROM 1 BY 1
 000146              UNTIL WS-IHAUTEUR > 10.
 000147            DISPLAY 'ETAPE 2- TABLEAU-1 GLOBAL :'.
 000148            DISPLAY WS-TABLEAU-1.
 000149            DISPLAY SPACE.
 000150
 000151            ACCEPT WS-E.
 000152
 000153            PERFORM 1010-ITERATION-DEB
 000154               THRU 1010-ITERATION-FIN
 000155              UNTIL WS-FIN-E = '$$'.
 000156       *
 000157            PERFORM  8999-STATISTIQUES-DEB
 000158               THRU  8999-STATISTIQUES-FIN.
 000159       *
 000160            PERFORM  9999-FIN-PROGRAMME-DEB
 000161               THRU  9999-FIN-PROGRAMME-FIN.
 000162       *
 000163        0000-PROGRAMME-FIN.
 000164             EXIT.
 000165       ***************************************************************
 000166       ***************************************************************
 000167       ***************************************************************
 000168        1000-INIT-TABLEAU-1-DEB.
 000169
 000170            ADD WS-ILIGNE WS-ICOLONNE WS-IHAUTEUR
 000171            GIVING WS-CELL-TAB-1( WS-ILIGNE, WS-ICOLONNE, WS-IHAUTEUR).
 000172       *
 000173        1000-INIT-TABLEAU-1-FIN.
 000174            EXIT.
 000175       *
 000176        1010-ITERATION-DEB.
 000177       *
 000178            ADD 1 TO WS-COMPTEUR.
 000179            CALL 'ADSOTP8'
 000180                 USING WS-TABLEAU-1 WS-TABLEAU-3 WS-S WS-E.
 000181       *
 000182            IF RETURN-CODE = 1
 000183               PERFORM 2000-VERIF-E-DEB
 000184                  THRU 2000-VERIF-E-FIN
 000185            END-IF.
 000186       *
 000187            MOVE SPACE TO WS-LEDIT.
 000188            STRING 'ETAPE 2 - VALEUR RECHERCHEE '
 000189                    WS-COMPTEUR
 000190                   ' : '
 000191                    WS-E DELIMITED BY SIZE
 000192            INTO WS-LEDIT.
 000193            DISPLAY WS-LEDIT.
 000194
 000195            MOVE SPACE TO WS-LEDIT.
 000196            STRING 'TROUVEE '
 000197                    WS-S
 000198                   ' FOIS DANS LES POSTES : ' DELIMITED BY SIZE
 000199            INTO WS-LEDIT.
 000200            DISPLAY WS-LEDIT.
 000201            DISPLAY SPACE.
 000202       *
 000203            PERFORM 1020-AFFICH-TAB-3-DEB
 000204               THRU 1020-AFFICH-TAB-3-FIN
 000205            VARYING WS-I-X FROM 1 BY 1
 000206              UNTIL WS-I-X > WS-S.
 000207
 000208            DISPLAY SPACE.
 000209            DISPLAY SPACE.
 000210            ACCEPT WS-E.
 000211
 000212        1010-ITERATION-FIN.
 000213            EXIT.
 000214
 000215        1020-AFFICH-TAB-3-DEB.
 000216                 MOVE SPACE TO WS-LEDIT.
 000217                 STRING WS-CELL-X (WS-I-X)
 000218                   ' , '
 000219                   WS-CELL-Y (WS-I-X)
 000220                   ' , '
 000221                   WS-CELL-Z (WS-I-X)  DELIMITED BY SIZE
 000222                 INTO WS-LEDIT.
 000223
 000224                 DISPLAY WS-LEDIT.
 000225       *
 000226        1020-AFFICH-TAB-3-FIN.
 000227            EXIT.
 000228       *
 000229        2000-VERIF-E-DEB.
 000230       *
 000231       *
 000232             DISPLAY '*==============================================*'
 000233             DISPLAY '*        UNE ANOMALIE A ETE DETECTEE           *'
 000234             DISPLAY '*     FIN ANORMALE DU SOUS PROGRAMME :         *'
 000235             DISPLAY '*     CODE RETURN = 1 / E NON NUMERIQUE        *'
 000236             DISPLAY '*==============================================*'.
 000237       *
 000238        2000-VERIF-E-FIN.
 000239            GOBACK.
 000240       *
 000241       *---------------------------------------------------------------*
 000242       *   8XXX-  : ORDRES DE MANIPULATION DES EDITIONS                *
 000243       *---------------------------------------------------------------*
 000244       *
 000245       *8000-ORDRE-EDITION-DEB.
 000246       *
 000247       *8000-ORDRE-EDITION-FIN.
 000248       *    EXIT.
 000249       *
 000250        8999-STATISTIQUES-DEB.
 000251       *
 000252             DISPLAY '************************************************'
 000253             DISPLAY '*     STATISTIQUES DU PROGRAMME XXXXXXXX       *'
 000254             DISPLAY '*     ==================================       *'
 000255             DISPLAY '************************************************'.
 000256       *
 000257        8999-STATISTIQUES-FIN.
 000258             EXIT.
 000259       *
 000260       *---------------------------------------------------------------*
 000261       *   9XXX-  : ORDRES DE MANIPULATION DES SOUS-PROGRAMMES         *
 000262       *---------------------------------------------------------------*
 000263       *
 000264       *9000-APPEL-SP-DEB.
 000265       *
 000266       *9000-APPEL-SP-FIN.
 000267       *    EXIT.
 000268       *
 000269       *---------------------------------------------------------------*
 000270       *   9999-  : PROTECTION FIN DE PROGRAMME                        *
 000271       *---------------------------------------------------------------*
 000272       *
 000273        9999-FIN-PROGRAMME-DEB.
 000274       *
 000275             DISPLAY '*==============================================*'
 000276             DISPLAY '*     FIN NORMALE DU PROGRAMME XXXXXXXX        *'
 000277             DISPLAY '*==============================================*'.
 000278       *
 000279        9999-FIN-PROGRAMME-FIN.
 000280             GOBACK.
 000281       *
 000282        9999-ERREUR-PROGRAMME-DEB.
 000283       *
 000284             DISPLAY '*==============================================*'
 000285             DISPLAY '*        UNE ANOMALIE A ETE DETECTEE           *'
 000286             DISPLAY '*     FIN ANORMALE DU PROGRAMME XXXXXXXX       *'
 000287             DISPLAY '*==============================================*'.
 000288       *
 000289        9999-ERREUR-PROGRAMME-FIN.
 000290             GOBACK.
 ****** **************************** Bottom of Data ****************************






































 Command ===>                                                  Scroll ===> CSR
  F1=Help      F2=Split     F3=Exit      F5=Rfind     F6=Rchange   F7=Up
  F8=Down      F9=Swap     F10=Left     F11=Right    F12=Cancel
================================================================================
