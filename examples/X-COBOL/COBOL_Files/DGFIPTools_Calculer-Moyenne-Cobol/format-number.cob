      ******************************************************************
      **  P R O G R A M M E  DEBUT  ------------  DEBUT  S O U R C E  **
      **  ecrit en COBOL-85 sous OpenCobol                            **
      **  format-number.cob                           Version 1.1 PC  **
      ******************************************************************
      **  Formatter un nombre décimal                                 **
      **  ----------------------------------------------------------  **
      **  Objet :                                                     **
      **  - Avoir un affichage plus humain d'un nombre décimal        **
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.                                        format-number.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * ++============================================================++
      * ++===                                donnees de traitement ===++
      * ++============================================================++
        01 NUMBER-CUTTED PIC ZZ.99.
        
        77 DIVIDER PIC X VALUE ",".
        
        01 NUMBER-CUTTED-FORMAT.
           05 ENTIER PIC ZZ.
           05 PIC X.
           05 DECIMAL PIC 99.



       LINKAGE SECTION.
        01 RAW-NUMBER PIC 99V99.
        01 FORMATTED-NUMBER PIC X(5).

       PROCEDURE DIVISION using RAW-NUMBER,FORMATTED-NUMBER.
      * ****************************************************************
      * *****      PROGRAMME                                       *****
      * ****************************************************************



      * Dans un premier temps on retire les zéros inutiles du nombre
          MOVE RAW-NUMBER TO NUMBER-CUTTED
      * puis on découpe celui-ci en un entier et un décimal    
          MOVE NUMBER-CUTTED TO NUMBER-CUTTED-FORMAT
      
      * Si le nombre entier est un zéro on affiche un zéro directement
      * pour avoir un meilleur affichage   
          IF (ENTIER = SPACE)
            STRING " 0" DIVIDER DECIMAL INTO  FORMATTED-NUMBER
      
      * Sinon affichage entier,décimal    
          ELSE
            STRING ENTIER DIVIDER DECIMAL INTO  FORMATTED-NUMBER
		  END-IF
       EXIT PROGRAM.
      ******************************************************************
      **  minmax.cob                                  Version 1.1 PC  **
      **  P R O G R A M M E  FIN  ----------------  FIN  S O U R C E  **
      ******************************************************************
