IDENTIFICATION DIVISION.                                          
        ENVIRONMENT DIVISION.                                             
        CONFIGURATION SECTION.                                            
        DATA DIVISION. 
       *
       *    IMS Connector for Java, COBOL Transaction Message Source
       *
       *********************************************************************/ 
       *                                                                   */ 
       * (c) Copyright IBM Corp. 2003                                      */ 
       * All Rights Reserved                                               */ 
       * Licensed Materials - Property of IBM                              */ 
       *                                                                   */ 
       * DISCLAIMER OF WARRANTIES.                                         */ 
       *                                                                   */ 
       * The following (enclosed) code is provided to you solely for the   */ 
       * purpose of assisting you in the development of your applications. */ 
       * The code is provided "AS IS." IBM MAKES NO WARRANTIES, EXPRESS OR */ 
       * IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF   */ 
       * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING   */ 
       * THE FUNCTION OR PERFORMANCE OF THIS CODE.                         */ 
       * IBM shall not be liable for any damages arising out of your use   */ 
       * of the generated code, even if they have been advised of the      */ 
       * possibility of such damages.                                      */ 
       *                                                                   */ 
       * DISTRIBUTION.                                                     */ 
       *                                                                   */ 
       * This generated code can be freely distributed, copied, altered,   */ 
       * and incorporated into other software, provided that:              */ 
       *   - It bears the above Copyright notice and DISCLAIMER intact     */ 
       *   - The software is not for resale                                */ 
       *                                                                   */ 
       *********************************************************************/
       *
        LINKAGE SECTION.
	                                                   
        01  INPUT-MSG.                                                     
            02  IN-LL          PICTURE S9(3) COMP.                         
            02  IN-ZZ          PICTURE S9(3) COMP.                         
            02  IN-TRCD        PICTURE X(10).                               
            02  IN-CMD         PICTURE X(8).
            02  IN-NAME1       PICTURE X(10).
            02  IN-NAME2       PICTURE X(10).
            02  IN-EXTN        PICTURE X(10).
            02  IN-ZIP         PICTURE X(7).	
						  
        01  OUTPUT-MSG.                                                   
            02  OUT-LL       PICTURE S9(3) COMP VALUE +0.                 
            02  OUT-ZZ       PICTURE S9(3) COMP VALUE +0.                  
            02  OUT-MSG      PICTURE X(40) VALUE SPACES.
            02  OUT-CMD      PICTURE X(8) VALUE SPACES.
            02  OUT-NAME1    PICTURE X(10) VALUE SPACES.
            02  OUT-NAME2    PICTURE X(10) VALUE SPACES.
            02  OUT-EXTN     PICTURE X(10) VALUE SPACES.
            02  OUT-ZIP      PICTURE X(7) VALUE SPACES.
            02  OUT-SEGNO    PICTURE X(4) VALUE SPACES.    		
                        
        PROCEDURE DIVISION.       
