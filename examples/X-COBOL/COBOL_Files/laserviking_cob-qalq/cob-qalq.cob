000000* MIT License
      * Copyright (c) 2018 Christer Stig Åke Landstedt
      * 
      * Permission is hereby granted, free of charge, to any person obtaining a copy
      * of this software and associated documentation files (the "Software"), to deal
      * in the Software without restriction, including without limitation the rights
      * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      * copies of the Software, and to permit persons to whom the Software is
      * furnished to do so, subject to the following conditions:
      * 
      * The above copyright notice and this permission notice shall be included in all
      * copies or substantial portions of the Software.
      * 
      * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      * SOFTWARE.
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. cob-qalq.
       AUTHOR.  "Christer Stig Åke Landstedt".

      * ENVIRONMENT DIVISION.
       
       DATA DIVISION.
         LOCAL-STORAGE SECTION.
         01 CALC1 PIC 9(5)V9(2) VALUE ZERO.
         01 CALC2 PIC 9(5)V9(2) VALUE ZERO.
         01 CALCJOB PIC X(1) VALUE "A".
         01 CALCSUM PIC 9(10)V9(2) VALUE ZERO.
         01 USER-SELECTION PIC 9 VALUE ZERO.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
       999-SELECTION0.
       MOVE 0 TO USER-SELECTION.
       DISPLAY "--------------".
       DISPLAY "Cobol Qalq 0.2".
       DISPLAY "--------------".
       PERFORM UNTIL USER-SELECTION>0
         DISPLAY "MENU"
         DISPLAY "------------------------"
         DISPLAY "    ENTER YOUR CHOICE"
         DISPLAY "    1 : Calculate"
         DISPLAY "    2 : Information"
         DISPLAY "    3 : Exit application"
         ACCEPT USER-SELECTION

         EVALUATE USER-SELECTION
           WHEN 1 GO TO 999-SELECTION1
           WHEN 2 GO TO 999-SELECTION2
           WHEN 3 GO TO 999-SELECTION3
           WHEN OTHER GO TO 999-SELECTION0ERROR
         END-EVALUATE
       END-PERFORM.

       999-SELECTION0ERROR.

       DISPLAY " ".
       DISPLAY "!!!ERROR in input".
       GO TO 999-SELECTION0.

       999-SELECTION1ERROR.

       DISPLAY " ".
       DISPLAY "!!!ERROR in input".
       GO TO 999-SELECTION1.

       999-SELECTION1.
       MOVE 0 TO USER-SELECTION.
       MOVE 0 TO CALC1.
       MOVE 0 TO CALC2.
       MOVE "A" TO CALCJOB.
       DISPLAY " ".
       DISPLAY "---------".
       DISPLAY "Calculate".
       DISPLAY "---------".
       DISPLAY "Enter number".
       ACCEPT CALC1.
       DISPLAY "Select calculation: +,-,/,*".
       ACCEPT CALCJOB.
       DISPLAY "Enter number".
       ACCEPT CALC2.

       PERFORM
         EVALUATE CALCJOB
           WHEN "+" COMPUTE CALCSUM = CALC1 + CALC2
           WHEN "-" COMPUTE CALCSUM = CALC1 - CALC2
           WHEN "*" COMPUTE CALCSUM = CALC1 * CALC2
           WHEN "/" COMPUTE CALCSUM = CALC1 / CALC2
           WHEN OTHER GO TO 999-SELECTION1ERROR
         END-EVALUATE
       END-PERFORM.

       DISPLAY "Resault: "CALCSUM.

       PERFORM UNTIL USER-SELECTION>0
         DISPLAY " "
         DISPLAY "MENU"
         DISPLAY "---------------------------"
         DISPLAY "    ENTER YOUR CHOICE"
         DISPLAY "    1 : Calculate again"
         DISPLAY "    2 : Return to main menu"
         DISPLAY "    3 : Exit application"
         ACCEPT USER-SELECTION

         EVALUATE USER-SELECTION
           WHEN 1 GO TO 999-SELECTION1
           WHEN 2 GO TO 999-SELECTION0
           WHEN 3 GO TO 999-SELECTION3
           WHEN OTHER GO TO 999-SELECTION1ERROR
         END-EVALUATE
       END-PERFORM.

       999-SELECTION2.
       MOVE 0 TO USER-SELECTION.
       DISPLAY "-----------------------".
       DISPLAY "Application information".
       DISPLAY "-----------------------".
       DISPLAY "Application: Cobol Qalq 0.2".
       DISPLAY "Made with: Ubuntu 16.04 and GnuCobol(OpenCobol) 2.2".
       DISPLAY "---------------------------------------------------".
       DISPLAY "MIT License".
       DISPLAY "Copyright (c) 2018 Christer Stig Åke Landstedt".
       DISPLAY " ".
       DISPLAY 
        "Permission is hereby granted, free of charge, to any "
        "person obtaining a copy of this software and "
        "associated documentation files (the ""Software""), "
        "to deal in the Software without restriction, "
        "including without limitation the rights "
        "to use, copy, modify, merge, publish, distribute, "
        "sublicense, and/or sell copies of the Software,"
        "and to permit persons to whom the Software is "
        "furnished to do so, subject to the following "
        "conditions:".
       DISPLAY " ".
       DISPLAY 
        "The above copyright notice and this permission notice "
        "shall be included in all copies or substantial "
        "portions of the Software.".
       DISPLAY " ".
       DISPLAY 
        "THE SOFTWARE IS PROVIDED ""AS IS"", WITHOUT WARRANTY "
        "OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT "
        "LIMITED TO THE WARRANTIES OF MERCHANTABILITY, "
        "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. "
        "IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS "
        "BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER "
        "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR "
        "OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION "
        "WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE "
        "SOFTWARE.".
       GO TO 999-SELECTION0.
       

       999-SELECTION3.
       MOVE 0 TO USER-SELECTION.
       STOP-RUN.
