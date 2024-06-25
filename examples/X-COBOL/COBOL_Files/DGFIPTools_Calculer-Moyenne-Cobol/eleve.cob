      ******************************************************************
      **  P R O G R A M M E  DEBUT  ------------  DEBUT  S O U R C E  **
      **  ecrit en COBOL-85 sous OpenCobol                            **
      **  comm.cob                                    Version 1.1 PC  **
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.                                        ELEVE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT NOTES ASSIGN TO "notes.csv" ORGANIZATION LINE SEQUENTIAL.
       SELECT NIDX ASSIGN TO "notes.idx" ORGANIZATION INDEXED ACCESS
       DYNAMIC RECORD KEY NIDX-MAT ALTERNATE RECORD KEY NIDX-COEFF
       WITH DUPLICATES.


       DATA DIVISION.
       FILE SECTION.

       FD NOTES.
       01 NOTES-ENRG.
         05 N-MOY PIC 99V99.
           88 N-MOY-OK VALUE 00.00 THRU 20.00.
         05 N-COEFF PIC 9.
         05 N-MAT PIC X(50).
         
       FD NIDX.
       01 NIDX-ENRG.
         05 NIDX-MOY PIC 99V99.
           88 NIDX-MOY-OK VALUE 00.00 THRU 20.00.
         05 NIDX-COEFF PIC 9.
         05 NIDX-MAT PIC X(50).

       WORKING-STORAGE SECTION.
      * ++============================================================++
      * ++===                                donnees de traitement ===++
      * ++============================================================++
        77 NOTES-END PIC 9 VALUE 0.
          88 NOTES-END-OK VALUE HIGH-VALUE.
          
        77 PERF-END PIC 9 VALUE 0.
          88 PERF-END-OK VALUE HIGH-VALUE.

      

        77 MENU-CHOIX PIC 9 VALUE 9.
          88 MENU-CHOIX-MOYG VALUE 1.
          88 MENU-CHOIX-MOYD VALUE 2.
          88 MENU-CHOIX-AJOUTER VALUE 3.
          88 MENU-CHOIX-MODIFIER VALUE 4.
          88 MENU-CHOIX-SUPPRIMER VALUE 5.
          88 MENU-CHOIX-CHERCHER VALUE 6.
          88 MENU-CHOIX-ENREGISTRER VALUE 7.
          88 MENU-CHOIX-QUITTER VALUE 8.
          
       01 RECHERCHES.
          05 RECH-MOY PIC 99V99.
            88 RECH-MOY-OK VALUE 00.00 THRU 20.00.
          05 RECH-COEFF PIC 9.
          05 RECH-MAT PIC X(50).

       01 RESULTATS.
          05 RES-MOYC PIC 999V99.
          05 RES-COEFF PIC 9.
          05 RES-MOYG PIC 99v99.
            88 RES-MOYG-OK VALUE 00.00 THRU 20.00.

       01 FORMATTED-NUMBER PIC X(5).


       PROCEDURE DIVISION.
      * ****************************************************************
      * *****      PROGRAMME                                       *****
      * ****************************************************************
       DEB-PGM.
       
       PERFORM INIT-NOTES

       PERFORM UNTIL MENU-CHOIX-QUITTER

         PERFORM AFFICHER-MENU

         EVALUATE TRUE

      

      * *** Affichage de la moyenne générale ***
           WHEN MENU-CHOIX-MOYG
             PERFORM AFFICHER-MOYENNE-GENERALE

      * *** Affichage de toutes les moyennes ***
           WHEN MENU-CHOIX-MOYD
             PERFORM AFFICHER-MOYENNE-DETAILS
             
      * *** Ajouter une matière ***
           WHEN MENU-CHOIX-AJOUTER
             PERFORM  AJOUTER-MATIERE
             
      * *** Modifier une matière ***
           WHEN MENU-CHOIX-MODIFIER
             PERFORM  MODIFIER-MATIERE
             
      * *** Supprimer une matière ***
           WHEN MENU-CHOIX-SUPPRIMER
             PERFORM  SUPPRIMER-MATIERE
             
      * *** Chercher une matière ***
           WHEN MENU-CHOIX-CHERCHER
             PERFORM  CHERCHER-MATIERE
             
      * *** Enregistrer les modifications ***
           WHEN MENU-CHOIX-ENREGISTRER
             PERFORM  ENREGISTRER-MATIERES
             
     

       END-PERFORM


       .
       FIN-PGM.
           STOP RUN.

      * ****************************************************************
      * *****      PROCEDURES                                      *****
      * ****************************************************************


      * *** Procédure affichant le menu général ***
       AFFICHER-MENU.
         DISPLAY " "
         DISPLAY " 1 : Afficher la moyenne generale"
         DISPLAY " 2 : Afficher details des moyennes"
         DISPLAY " 3 : Ajouter une moyenne"
         DISPLAY " 4 : Modifier une moyenne"
         DISPLAY " 5 : Supprimer une moyenne"
         DISPLAY " 6 : Chercher une matiere"
         DISPLAY " 7 : Enregistrer les modifications"
         DISPLAY " 8 : Quitter"

         DISPLAY " "
         DISPLAY "Choix : " WITH NO ADVANCING
         ACCEPT MENU-CHOIX
       .
       
       
      * *** Procédure pour enregistrer une note ***
       ENREGISTRER-NOTES.
       SET RECH-MOY TO 21
       PERFORM UNTIL RECH-MOY-OK
         DISPLAY "Nouvelle Note ?" WITH NO ADVANCING
	     ACCEPT RECH-MOY           
       END-PERFORM
       . 

      * *** Procédure pour charger les notes en mémoire ***
       INIT-NOTES.
       OPEN INPUT NOTES
       OPEN OUTPUT NIDX

       SET PERF-END TO 0
       PERFORM UNTIL PERF-END-OK
         READ NOTES
           AT END
             SET PERF-END-OK TO TRUE
           NOT AT END
             WRITE       NIDX-ENRG           FROM     NOTES-ENRG
                     INVALID KEY
                       DISPLAY "PB ecriture : ix12.idx"
             END-WRITE
         END-READ
       END-PERFORM

       CLOSE NOTES NIDX
       .
       
       
      * *** Procédure pour enregistrer les modifications en mémoire ***
       ENREGISTRER-MATIERES.
       OPEN INPUT NIDX
       OPEN OUTPUT NOTES

       SET PERF-END TO 0
       PERFORM UNTIL PERF-END-OK
         READ NIDX NEXT
           AT END
             SET PERF-END-OK TO TRUE
           NOT AT END
             WRITE NOTES-ENRG FROM NIDX-ENRG
         END-READ
       END-PERFORM

       CLOSE NOTES NIDX
       .


      * *** Procédure pour afficher la moyenne générale ***
       AFFICHER-MOYENNE-DETAILS.

       OPEN I-O NIDX

       SET PERF-END TO 0
       PERFORM UNTIL PERF-END-OK
         READ NIDX NEXT
           AT END
             SET PERF-END-OK TO TRUE
           NOT AT END
             CALL "format-number" USING BY CONTENT NIDX-MOY
             BY REFERENCE FORMATTED-NUMBER

             DISPLAY "Matiere " NIDX-MAT
			 DISPLAY "Moyenne " FORMATTED-NUMBER
			 DISPLAY "Coefficient " NIDX-COEFF
			 DISPLAY " "
         END-READ
       END-PERFORM
       
       CLOSE NIDX
       .
       
      * *** Procédure pour ajouter une matière ***
       AJOUTER-MATIERE.
       DISPLAY "Quelle matiere ?" WITH NO ADVANCING
	   ACCEPT RECH-MAT
	   MOVE FUNCTION UPPER-CASE(RECH-MAT) TO RECH-MAT
	   
	  PERFORM ENREGISTRER-NOTES
	   
	   DISPLAY "Coefficient ?" WITH NO ADVANCING
			   ACCEPT RECH-COEFF
	   
	   OPEN I-O NIDX
	     WRITE NIDX-ENRG FROM RECHERCHES
	   CLOSE NIDX
	   
       .
       
       
      * *** Procédure pour supprimer une matière ***
       SUPPRIMER-MATIERE.
      * Choix de la matière
	   DISPLAY "Quelle matiere ?" WITH NO ADVANCING
	   ACCEPT RECH-MAT
	   MOVE FUNCTION UPPER-CASE(RECH-MAT) TO NIDX-MAT
	   
	   
	   OPEN I-O NIDX
	   
	   START NIDX KEY IS = NIDX-MAT 
	     INVALID KEY
      * la matière n'existe pas
               DISPLAY "La matiere " NIDX-MAT " n'existe pas !"
         NOT INVALID KEY
           SET PERF-END TO 0
      * Si la matière existe, alors on la supprime    
           READ NIDX NEXT
             AT END
               SET PERF-END-OK TO TRUE
             NOT AT END
               DELETE NIDX
           END-READ
           
       END-START
       CLOSE NIDX
       . 
       
      * *** Procédure pour chercher une matière ***
       CHERCHER-MATIERE.

	   DISPLAY "Quelle matiere ?" WITH NO ADVANCING
	   ACCEPT RECH-MAT
	   MOVE FUNCTION UPPER-CASE(RECH-MAT) TO NIDX-MAT
	   
	   OPEN I-O NIDX
	   
	   START NIDX KEY IS = NIDX-MAT 
	     INVALID KEY
               DISPLAY "La matiere " NIDX-MAT " n'existe pas !"
         NOT INVALID KEY
           SET PERF-END TO 0
           PERFORM UNTIL PERF-END-OK
           READ NIDX NEXT
             AT END
               SET PERF-END-OK TO TRUE
             NOT AT END
               CALL "format-number" USING BY CONTENT NIDX-MOY
               BY REFERENCE FORMATTED-NUMBER

               DISPLAY " Matiere " NIDX-MAT
			   DISPLAY " Moyenne " FORMATTED-NUMBER
			   DISPLAY " Coefficient " NIDX-COEFF
			   DISPLAY " "
           END-READ
         END-PERFORM
       END-START
       CLOSE NIDX
       .
       
       
      * *** Procédure pour chercher une matière ***
       MODIFIER-MATIERE.

	   DISPLAY "Quelle matiere ?" WITH NO ADVANCING
	   ACCEPT RECH-MAT
	   MOVE FUNCTION UPPER-CASE(RECH-MAT) TO NIDX-MAT
	   
	   OPEN I-O NIDX
	   
	   START NIDX KEY IS = NIDX-MAT 
	     INVALID KEY
               DISPLAY "La matiere " NIDX-MAT " n'existe pas !"
         NOT INVALID KEY
           
           READ NIDX NEXT
             AT END
               SET PERF-END-OK TO TRUE
             NOT AT END
             
               PERFORM ENREGISTRER-NOTES
             
               MOVE RECH-MOY TO NIDX-MOY
               REWRITE NIDX-ENRG
           END-READ
         
       END-START
       CLOSE NIDX
       .

      * *** Procédure pour afficher la moyenne générale ***
       AFFICHER-MOYENNE-GENERALE.
       
       OPEN INPUT NIDX

       SET RES-MOYC TO 0
       SET RES-COEFF TO 0
       SET PERF-END TO 0
       PERFORM UNTIL PERF-END-OK
         READ NIDX NEXT
           AT END
             SET PERF-END-OK TO TRUE
           NOT AT END
             COMPUTE RES-MOYC = RES-MOYC +
             (NIDX-COEFF * NIDX-MOY )

             ADD NIDX-COEFF TO RES-COEFF
          END-READ
       END-PERFORM
       
       CLOSE NIDX
       .


      * *** Moyenne générale = moyenne coefficienté / valeur
      * *** des coefficients ***
       DIVIDE RES-MOYC BY RES-COEFF GIVING RES-MOYG

       CALL "format-number" USING BY CONTENT RES-MOYG
         BY REFERENCE FORMATTED-NUMBER

       DISPLAY "******"
       DISPLAY "Moyenne Generale : "FORMATTED-NUMBER
       DISPLAY "******"
       .
      ******************************************************************
      **  comm.cob                                    Version 1.1 PC  **
      **  P R O G R A M M E  FIN  ----------------  FIN  S O U R C E  **
      ******************************************************************
