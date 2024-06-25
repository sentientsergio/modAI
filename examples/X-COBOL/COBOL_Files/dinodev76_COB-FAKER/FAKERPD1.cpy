      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       SUB-2100-FORMAT.
      *----------------

           PERFORM SUB-9700-FIND-RANDOM-FORMAT THRU SUB-9700-EXIT

           MOVE W-FAKER-FORMAT     TO W-RECURSED-FORMAT
           MOVE 1                  TO W-SUB-1

           PERFORM SUB-2110-RECURSE-FORMATS THRU SUB-2110-EXIT
               UNTIL W-SUB-1 > LENGTH OF W-RECURSED-FORMAT
               OR    NOT FAKER-RESPONSE-GOOD
                                    IN L-PARAMETER

           IF      NOT FAKER-RESPONSE-GOOD
                                   IN L-PARAMETER
               GO TO SUB-2100-EXIT
           END-IF

           MOVE SPACES         
             TO FAKER-RESULT       IN L-PARAMETER
           MOVE 1                  TO W-SUB-1
                                      W-SUB-2

           PERFORM SUB-2120-PROCESS-FORMATS THRU SUB-2120-EXIT
               UNTIL W-SUB-1 > LENGTH OF W-RECURSED-FORMAT
               OR    W-SUB-2 > LENGTH OF FAKER-RESULT
                                          IN L-PARAMETER
               OR    W-RECURSED-FORMAT(W-SUB-1 : ) = SPACES
           .
       SUB-2100-EXIT.
           EXIT.
      /
       SUB-2110-RECURSE-FORMATS.
      *-------------------------

           IF      W-RECURSED-FORMAT-CHAR(W-SUB-1) NOT = W-FORMAT-START
               ADD  1              TO W-SUB-1
               GO TO SUB-2110-EXIT
           END-IF

           MOVE W-SUB-1            TO W-SUB-1-SAVE
           ADD  1                  TO W-SUB-1

           UNSTRING W-RECURSED-FORMAT
                            DELIMITED W-FORMAT-END
                                 INTO W-FORMAT-ENTRY
                              POINTER W-SUB-1 

           IF      W-FORMAT-ENTRY-IS-FORMAT
               MOVE W-RECURSED-FORMAT(W-SUB-1 : )
                                   TO W-RECURSED-FORMAT-REST
               MOVE W-SUB-1-SAVE   TO W-SUB-1 

               PERFORM SUB-9000-EXAMINE-FIND-FORMAT THRU SUB-9000-EXIT

               IF      NOT FAKER-RESPONSE-GOOD
                                   IN L-PARAMETER
                   GO TO SUB-2110-EXIT
               END-IF
    
               STRING W-FAKER-FORMAT
                            DELIMITED '  '
                                 INTO W-RECURSED-FORMAT
                              POINTER W-SUB-1-SAVE

               MOVE W-RECURSED-FORMAT-REST
                                   TO W-RECURSED-FORMAT(W-SUB-1-SAVE : )
           END-IF
           .
       SUB-2110-EXIT.
           EXIT.
      /
       SUB-2120-PROCESS-FORMATS.
      *-------------------------

           IF      W-RECURSED-FORMAT-CHAR(W-SUB-1) = W-FORMAT-START
               ADD  1              TO W-SUB-1

               UNSTRING W-RECURSED-FORMAT
                            DELIMITED W-FORMAT-END
                                 INTO W-FORMAT-ENTRY
                              POINTER W-SUB-1 

               PERFORM SUB-9000-EXAMINE-FIND-FORMAT THRU SUB-9000-EXIT

               STRING W-FAKER-RESULT
                            DELIMITED '  '
                                 INTO FAKER-RESULT
                                      IN L-PARAMETER
                              POINTER W-SUB-2
           ELSE
               MOVE W-RECURSED-FORMAT-CHAR(W-SUB-1)
                 TO FAKER-RESULT   IN L-PARAMETER(W-SUB-2 : 1)
               ADD  1              TO W-SUB-1
                                      W-SUB-2
           END-IF
           .
       SUB-2120-EXIT.
           EXIT.
