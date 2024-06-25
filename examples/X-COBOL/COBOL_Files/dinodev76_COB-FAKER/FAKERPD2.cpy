      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       SUB-9700-FIND-RANDOM-FORMAT.
      *----------------------------

           PERFORM SUB-9901-CALL-FAKRAND

           IF      W-TABLE-2 = SPACES
               COMPUTE W-RANDOM-NO =  FAKRAND-RANDOM-NO
                                      * L-FORMAT-WEIGHT-TOT-1
           ELSE
               COMPUTE W-RANDOM-NO =  FAKRAND-RANDOM-NO
                                      * (L-FORMAT-WEIGHT-TOT-1 +
                                         L-FORMAT-WEIGHT-TOT-2)
           END-IF

           MOVE W-RANDOM-NO        TO FAKER-RANDOM-NO-SUB
                                        IN L-PARAMETER(FI-DX)
           MOVE 0                  TO W-FOUND-DX

           PERFORM SUB-9710-FIND-FORMAT THRU SUB-9710-EXIT
               VARYING L-F-DX-1 FROM 1 BY 1
                 UNTIL W-FOUND-DX > 0
                 OR    L-F-DX-1 > L-FORMAT-ENTRY-CNT-1

           EVALUATE TRUE
             WHEN W-FOUND-DX > 0
               MOVE L-FORMAT-ENTRY-1(W-FOUND-DX)
                                   TO W-FAKER-FORMAT

             WHEN W-TABLE-2 NOT = SPACES
               ADD  1              
                 TO FAKER-INFO-CNT IN L-PARAMETER
               SET  FI-DX          
                 TO FAKER-INFO-CNT IN L-PARAMETER
               MOVE W-TABLE-2      
                 TO FAKER-TABLE    IN L-PARAMETER(FI-DX)
               MOVE W-RANDOM-NO    
                 TO FAKER-RANDOM-NO-SUB
                                   IN L-PARAMETER(FI-DX)

               MOVE 0              TO W-FOUND-DX

               PERFORM SUB-9720-FIND-FORMAT THRU SUB-9720-EXIT
                   VARYING L-F-DX-2 FROM 1 BY 1
                     UNTIL W-FOUND-DX > 0
                     OR    L-F-DX-2 > L-FORMAT-ENTRY-CNT-2

               IF      W-FOUND-DX > 0
                   MOVE L-FORMAT-ENTRY-2(W-FOUND-DX)
                                   TO W-FAKER-FORMAT
               ELSE
                   MOVE 'Random format not found'
                                   TO W-FAKER-FORMAT
               END-IF

             WHEN OTHER
               MOVE 'Random format not found'
                                   TO W-FAKER-FORMAT
           END-EVALUATE
           .
       SUB-9700-EXIT.
           EXIT.
      /
       SUB-9710-FIND-FORMAT.
      *---------------------
      
           IF      W-RANDOM-NO <= L-FORMAT-WEIGHT-1(L-F-DX-1)
               SET  W-FOUND-DX     TO L-F-DX-1
               MOVE W-FOUND-DX     TO FAKER-TABLE-ENTRY
                                        IN L-PARAMETER(FI-DX)
           ELSE
               SUBTRACT L-FORMAT-WEIGHT-1(L-F-DX-1)
                                 FROM W-RANDOM-NO
           END-IF
           .
       SUB-9710-EXIT.
           EXIT.
      /
       SUB-9720-FIND-FORMAT.
      *---------------------
      
           IF      W-RANDOM-NO <= L-FORMAT-WEIGHT-2(L-F-DX-2)
               SET  W-FOUND-DX     TO L-F-DX-2
               MOVE W-FOUND-DX     TO FAKER-TABLE-ENTRY
                                        IN L-PARAMETER(FI-DX)
           ELSE
               SUBTRACT L-FORMAT-WEIGHT-2(L-F-DX-2)
                                 FROM W-RANDOM-NO
           END-IF
           .
       SUB-9720-EXIT.
           EXIT.
